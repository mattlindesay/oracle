/**
 * sp_who.sql
 *
 * www.oraclebytes.com
 */

set lines 10000 pages 10000 verify off feedback off

column sid         format 9999
column serial#     format 99999
column spid        format a8
column blocked_by  format 99999
column lockwait    format a10
column username    format a15
column schemaname  format a15
column machine     format a15
column program     format a35
column osuser      format a15
column logon_time  format a20

select s.sid         as "sid",
       s.serial#     as "serial#",
       p.spid        as "spid",
       s.username    as "username",
       s.schemaname  as "schemaname",
       substr(s.machine,1,instr(s.machine||'.','.',1,1)-1) as "machine",
       s.program     as "program",
       s.status      as "status",
	   to_char(s.logon_time,'DD-Mon-YY HH24:mi:ss')  as "logon_time",
       s.osuser      as "osuser"
  from gv$session s
    join gv$process p 
      on p.addr = s.paddr 
        and p.inst_id = s.inst_id
        and (s.username = '&&1' or '&&1' = '%' or to_char(s.sid) = '&&1')
        and s.username != 'SID'
  order by 1,2,3;

