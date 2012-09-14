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

    elsif '&&1' = '@sp_who' then
        dbms_output.put_line('@sp_who - Reports information about current connections to the database');
        dbms_output.put_line(chr(32)||chr(32)||'usage: @sp_who');

    elsif '&&1' = '@sp_helpfrag' then
        dbms_output.put_line('@sp_helpfrag - Reports on fragmented tables to help identify wasted space');
        dbms_output.put_line(chr(32)||chr(32)||'usage: @sp_helpfrag schema { table_name | % }');

    elsif '&&1' = '@sp_helpdb' then
        dbms_output.put_line('@sp_helpdb - Reports on basic information about the database, including db size')
        dbms_output.put_line(chr(32)||chr(32)||'usage: @sp_helpdb');

    else
        dbms_output.put_line('@sp_syntax         - Reports syntax of sp commands or list of available');
        dbms_output.put_line('@sp_helpdb         - Reports on basic information about the database, including db size')
        dbms_output.put_line('@sp_helpfrag       - Reports on fragmented tables to help identify wasted space');
        dbms_output.put_line('@sp_helptablespace - Reports information about all tablespaces');
        dbms_output.put_line('@sp_who            - Reports information about current connections to the database');
    end if;

    dbms_output.put_line(chr(10));
end;
/
