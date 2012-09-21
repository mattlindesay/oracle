set lines 10000
set pages 10000

column undo_gb for 999,990.00
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
       where tablespace_name in (select tablespace_name from dba_undo_extents)
       group by tablespace_name ) b
  where a.tablespace_name(+)=b.tablespace_name
  order by b.tablespace_name;


select tablespace_name as "tablespace_name", 
       status          as "status",
	   round(sum(blocks) * 8192/1024/1024/1024,2) as "undo_gb" 
  from dba_undo_extents 
  group by tablespace_name, status
  order by 1;

SELECT c.sid as "sid", 
       c.serial# as "serial#", 
	   c.username as "username", 
	   round(a.value/1024/1024/1024, 2) as "undo_gb"
  FROM (SELECT * FROM 
         (SELECT * FROM v$sesstat WHERE statistic# = 176 ORDER BY value DESC) WHERE rownum <= 20) a, 
       v$statname b, 
       v$session c
  WHERE a.statistic# = b.statistic#
    AND a.sid = c.sid
  ORDER BY a.value DESC;
