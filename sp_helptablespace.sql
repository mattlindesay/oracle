/**
 * sp_helptablespace.sql
 *
 * www.oraclebytes.com
 */

set lines 1000 pages 1000 

column "tablespace_name" format a30
column "size_mb"         format 99,999,999
column "used_mb"         format 99,999,999
column "free_mb"         format 99,999,999

select b.tablespace_name      as "tablespace_name", 
       b.size_mb              as "size_mb", 
       (b.size_mb-a.free_mb)  as "used_mb", 
       a.free_mb              as "free_mb",
	   case when a.free_mb is null then '' 
	        else to_char(100 * (b.size_mb - a.free_mb) 
			     / size_mb, '990') || '%' 
			end  as "used%"
  from 
    (select tablespace_name, 
            round(sum(bytes)/1024/1024, 0) as free_mb 
       from dba_free_space group by tablespace_name) a, 
    (select tablespace_name, 
            sum(bytes)/1024/1024 as size_mb
       from dba_data_files 
       group by tablespace_name
     union
     select tablespace_name, 
            sum(bytes)/1024/1024 as size_mb
       from dba_temp_files
       group by tablespace_name ) b
  where a.tablespace_name(+)=b.tablespace_name
  order by b.tablespace_name;
