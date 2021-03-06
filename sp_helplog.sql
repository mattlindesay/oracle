/**
 * sp_helplog.sql
 *
 * www.oraclebytes.com
 */

alter session set nls_date_format='Mon dd yyyy hh24:mi';

set lines 1000 pages 1000 serveroutput on

column group#                 format 999
column type                   format a7
column member                 format a60
column is_recovery_dest_file  format a20
column dbid                   format a10
column status                 format a16
column first_change#          format 999999999999990
column first_time             format a17
column standby_log_ddl        format a80

select group#                 as "group#",
       thread#                as "thread#",
       sequence#              as "sequence#",
       bytes                  as "bytes",
       members                as "members",
       archived               as "archived",
       status                 as "status",
       first_change#          as "first_change#",
       first_time             as "first_time"
  from v$log;


select group#                 as "group#",
       dbid                   as "dbid",
       thread#                as "thread#",
       sequence#              as "sequence#",
       bytes                  as "bytes",
       used                   as "used",
       archived               as "archived",
       status                 as "status", 
       first_change#          as "first_change#",
       first_time             as "first_time",
       last_change#           as "last_change#",
       last_time              as "last_time"
  from v$standby_log;


select group#                 as "group#",
       status                 as "status",
	   type                   as "type",
	   member                 as "member",
	   is_recovery_dest_file  as "is_recovery_dest_file"
  from v$logfile;


select 'alter database add standby logfile group ' ||
       sl.group# ||
       ' (''' || substr(l.member, 0, instr(l.member, '/')-1) || ''')' ||
       ' size ' ||
       bytes/1024/1024 || 'M;' as "standby_log_ddl"
  from v$standby_log sl join v$logfile l
    on sl.group# = l.group#;


