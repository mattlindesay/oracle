/**
 * sp_helpdatafile.sql
 *
 * www.oraclebytes.com
 */

set lines 1000 pages 1000 verify off

column "tablespace_name" format A30
column "id"              format 999
column "size_mb"         format 99,999
column "used_mb"         format 99,999
column "free_mb"         format 99,999
column "file_name"       format A80
column "auto"            format A4

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
	   where (tablespace_name = '&&1' or '&&1' = '%')
	   group by tablespace_name, file_id) a,
    (select tablespace_name, file_id, autoextensible,
            sum(bytes)/1024/1024 AS size_mb,
            file_name
       from dba_data_files
	   where (tablespace_name = '&&1' or '&&1' = '%')
       group by tablespace_name, file_id, file_name, autoextensible
     union
     select tablespace_name, file_id, autoextensible,
            sum(bytes)/1024/1024 as size_mb,
            file_name
       from dba_temp_files
	   where (tablespace_name = '&&1' or '&&1' = '%')
       group by tablespace_name, file_id, file_name, autoextensible) b
  where a.tablespace_name(+)=b.tablespace_name
    and a.file_id (+)= b.file_id
  order by b.tablespace_name, b.file_id;

