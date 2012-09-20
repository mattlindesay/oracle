/**
 * sp_syntax.sql
 *
 * www.oraclebytes.com
 */

set lines 1000 pages 1000 verify off feedback off serveroutput on

begin
    dbms_output.put_line(chr(10) || 'Syntax help');
    dbms_output.put_line('-----------------------------------------------------');

    if '&&1' = '@sp_syntax' then
        dbms_output.put_line('@sp_syntax - Reports syntax of sp commands or list of available');
        dbms_output.put_line(chr(32)||chr(32)||'usage: @sp_syntax @procedure_name          ; Report syntax of a command');
        dbms_output.put_line(chr(32)||chr(32)||'usage: @sp_syntax %                        ; List all commands');

    elsif '&&1' = '@sp_helptablespace' then
        dbms_output.put_line('@sp_helptablespace - Reports information about all tablespaces');
        dbms_output.put_line(chr(32)||chr(32)||'usage: @sp_helptablespace');

    elsif '&&1' = '@sp_helplog' then
        dbms_output.put_line('@sp_helplog - Reports information on redo logs and standby logs');
        dbms_output.put_line(chr(32)||chr(32)||'usage: @sp_helplog');

    elsif '&&1' = '@sp_who' then
        dbms_output.put_line('@sp_who - Reports information about current connections to the database');
        dbms_output.put_line(chr(32)||chr(32)||'usage: @sp_who %                          ; Report all current processes');
        dbms_output.put_line(chr(32)||chr(32)||'usage: @sp_who sid                        ; Report details of sid');

    elsif '&&1' = '@sp_helpfrag' then
        dbms_output.put_line('@sp_helpfrag - Reports on fragmented tables to help identify wasted space');
        dbms_output.put_line(chr(32)||chr(32)||'usage: @sp_helpfrag schema { table_name | % }');

    elsif '&&1' = '@sp_helpdb' then
        dbms_output.put_line('@sp_helpdb - Reports on basic information about the database, including db size');
        dbms_output.put_line(chr(32)||chr(32)||'usage: @sp_helpdb');

    elsif '&&1' = '@sp_helpasm' then
        dbms_output.put_line('@sp_helpasm - Reports on asm disk utilisation');
        dbms_output.put_line(chr(32)||chr(32)||'usage: @sp_helpasm');

    elsif '&&1' = '@sp_helpdatafile' then
        dbms_output.put_line('@sp_helpdatafile - Reports on datafile utilisation');
        dbms_output.put_line(chr(32)||chr(32)||'usage: @sp_helpdatafile { tablespace_name | % }');

    elsif '&&1' = '@sp_helpuser' then
        dbms_output.put_line('@sp_helpuser - Reports on users');
        dbms_output.put_line(chr(32)||chr(32)||'usage: @sp_helpuser');

    elsif '&&1' = '@sp_helptemp' then
        dbms_output.put_line('@sp_helptemp - Reports on temporary tablespace usage');
        dbms_output.put_line(chr(32)||chr(32)||'usage: @sp_helptemp');

    else
        dbms_output.put_line('@sp_syntax         - Reports syntax of sp commands or list of available');
        dbms_output.put_line('@sp_helpasm        - Reports on asm disk utilisation');
        dbms_output.put_line('@sp_helpdatafile   - Reports on datafile utilisation');
        dbms_output.put_line('@sp_helpdb         - Reports on basic information about the database, including db size');
        dbms_output.put_line('@sp_helpfrag       - Reports on fragmented tables to help identify wasted space');
        dbms_output.put_line('@sp_helplog        - Reports information on redo logs and standby logs');
        dbms_output.put_line('@sp_helptablespace - Reports information about all tablespaces');
        dbms_output.put_line('@sp_helptemp       - Reports on temporary tablespace usage');
        dbms_output.put_line('@sp_helpuser       - Reports on users');
        dbms_output.put_line('@sp_who            - Reports information about current connections to the database');
    end if;

    dbms_output.put_line(chr(10));
end;
/
