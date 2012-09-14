/**
 * sp_helpdb.sql
 *
 * www.oraclebytes.com
 */

set lines 1000 pages 1000 

column startup_time format a20
column version      format a20
column psu_applied  format a20

select d.name                                           as "name", 
       to_char(
         (select round(sum(bytes)/1024/1024/1024, 0) 
            from dba_data_files)
         , '999,999') || ' GB'                          as "db_size",
       d.log_mode                                       as "log_mode", 
       d.open_mode                                      as "open_mode",
       to_char(i.startup_time,'DD-MON-YYYY HH24:MI:SS') as "startup_time",
       i.version                                        as "version",
       (select max(version) 
          from sys.dba_registry_history 
          where bundle_series = 'PSU' 
            and action = 'APPLY')                       as "psu_applied"
  from v$database d, 
       gv$instance i;
