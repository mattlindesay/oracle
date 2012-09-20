/**
 * sp_helptablespace.sql
 *
 * www.oraclebytes.com
 */

set lines 1000 pages 1000 verify off

column "tablespace_name" format a30
column "id"              format 999
column "size_mb"         format 99,999,999
column "used_mb"         format 99,999,999
column "free_mb"         format 99,999,999
column "file_name"       format a80
column "auto"            format a4


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
	   where tablespace_name = '&&1' or '&&1' = '%'
       group by tablespace_name
     union
     select tablespace_name, 
            sum(bytes)/1024/1024 as size_mb
       from dba_temp_files
	   where tablespace_name = '&&1' or '&&1' = '%'
       group by tablespace_name ) b
  where a.tablespace_name(+)=b.tablespace_name
  order by b.tablespace_name;

column status             format a9
column contents           format a9
column logging            format a9
column force_logging      format a13
column extent_management  format a20
column allocation_type    format a20

select status              as "status", 
       contents            as "contents",
       logging             as "logging",
       force_logging       as "force_logging",
       extent_management   as "extent_management",
       allocation_type     as "allocation_type"
  from dba_tablespaces
  where tablespace_name = '&&1';

column "size_mb"         format 99,999
column "used_mb"         format 99,999
column "free_mb"         format 99,999


select b.tablespace_name     as "tablespace_name",
       b.file_id             as "id",
       b.autoextensible      as "auto",
       b.size_mb             as "size_mb",
       b.size_mb - a.free_mb as "used_mb",
       a.free_mb             as "free_mb",
       b.file_name           as "file_name"
  from
    (select tablespace_name, file_id,
            round(sum(bytes)/1024/1024, 0) AS free_mb
       from dba_free_space
       where tablespace_name = '&&1'
       group by tablespace_name, file_id) a,
    (select tablespace_name, file_id, autoextensible,
            sum(bytes)/1024/1024 AS size_mb,
            file_name
       from dba_data_files
       where tablespace_name = '&&1'
       group by tablespace_name, file_id, file_name, autoextensible
     union
     select tablespace_name, file_id, autoextensible,
            sum(bytes)/1024/1024 as size_mb,
            file_name
       from dba_temp_files
       where tablespace_name = '&&1'
       group by tablespace_name, file_id, file_name, autoextensible) b
  where a.tablespace_name(+)=b.tablespace_name
    and a.file_id (+)= b.file_id
  order by b.tablespace_name, b.file_id;



