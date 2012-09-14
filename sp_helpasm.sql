/**
 * sp_helpasm.sql
 *
 * www.oraclebytes.com
 */

set lines 1000 pages 1000

column name     format a20
column total_mb format 99,999,999
column used_mb  format 99,999,999
column free_mb  format 99,999,999

select name                                          as "name",
	   total_mb                                      as "total_mb",
	   total_mb - free_mb                            as "used_mb",
       free_mb                                       as "free_mb",
	   case when free_mb is null 
	        then '' 
			else to_char(100 * (total_mb - free_mb) 
			     / total_mb, '990') || '%' 
			end                                      as "used%"
  from v$asm_diskgroup;
