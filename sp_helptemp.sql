/**
 * sp_helptemp.sql
 *
 * www.oraclebytes.com
 */

set lines 1000 pages 1000 

column size_mb         format 9,999,990
column used_mb         format 9,999,990
column free_mb         format 9,999,990
column spid            format a6
column sid             format 9999
column serial          format 9999
column username        format a10
column osuser          format a10
column module          format a30
column program         format a30
column tablespace_name format a10
column id              format 999
column file_name       format a80
column auto            format a4

select ss.tablespace_name                                            as "tablespace_name",
       t.mb_total                                                    as "size_mb",
       sum(ss.used_blocks * t.block_size) / 1024 / 1024              as "used_mb",
       t.mb_total - SUM(ss.used_blocks * t.block_size) / 1024 / 1024 as "free_mb"
  from v$sort_segment ss,
       (
         select ts.name, tf.block_size, sum (tf.bytes) / 1024 / 1024 as mb_total
           from v$tablespace ts, v$tempfile tf
           where ts.ts#= tf.ts#
         group by ts.name, tf.block_size
       ) t
  where ss.tablespace_name = t.name
  group by ss.tablespace_name, t.mb_total;


select P.spid                                        as "spid",
       s.sid                                         as "sid",
       s.serial#                                     as "serial",
       s.username                                    as "username",
       s.osuser                                      as "osuser",
       s.module                                      as "module",
       p.program                                     as "program",
       sum(su.blocks) * ts.block_size / 1024 / 1024  as "used_mb",
       su.tablespace                                 as "tablespace_name",
       count(*) statements
  from v$sort_usage su, v$session s, dba_tablespaces ts, v$process P
  where su.session_addr = s.saddr
    and s.paddr         = p.addr
    and su.tablespace   = ts.tablespace_name
  group by s.sid, s.serial#, s.username, s.osuser, p.spid, s.module, p.program, ts.block_size, su.tablespace
  order by p.spid, s.sid, s.serial#;


select tablespace_name        as "tablespace_name", 
       file_id                as "file_id", 
       autoextensible         as "auto",
       sum(bytes)/1024/1024   as "size_mb",
       file_name              as "file_name"
  from dba_temp_files
  group by tablespace_name, file_id, file_name, autoextensible
  order by 1,2;

