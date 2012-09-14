/**
 * sp_helpfrag.sql
 *
 * www.oraclebytes.com
 */

set pages 1000 lines 1000 verify off

column owner      format a20
column table_name format a30
column blocks     format 999,999,999
column num_rows   format 99,999,999,999
column reserved   format 999,999,999
column data       format 999,999,999
column unused     format 999,999,999

select owner as "owner",
       table_name as "table_name",
       blocks as "blocks",
       num_rows as "num_rows",
       round(((blocks*8/1024))) "reserved",
       round((num_rows*avg_row_len/1024/1024)) "data",
       round(((blocks*8/1024)-(num_rows*avg_row_len/1024/1024))) "unused",
       to_char(last_analyzed, 'YYYY-MM-DD HH:mm:ss') As "last_analyzed"
from dba_tables 
where round(((blocks*8/1024)-(num_rows*avg_row_len/1024/1024))) > 100 
  and owner = '&&1'
  and (table_name = '&&2' or '&&2' = '%')
order by 7 desc;

