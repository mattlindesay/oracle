/**
 * sp_helpuser.sql
 *
 * www.oraclebytes.com
 */

alter session set nls_date_format='Mon dd yyyy hh24:mi';

set lines 1000 pages 1000

column username                    format a15
column status                      format a16
column ubsdbsec.dbs_dbusers_detail format a40
column default_tablespace          format a20

select u.username           as "username",  
       u.account_status     as "status",
       u.lock_date          as "lock_date",
       u.profile            as "profile",
       u.default_tablespace as "default_tablespace"
    from dba_users u
    order by u.username;
