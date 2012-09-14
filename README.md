Oracle System Procedures
========================

A collection of scripts for Oracle developers and administrators, similar to the sp stored procedures available in Sybase and MS SQL Server.

The scripts are intended to be run from sqlplus (Oracle command line tool) and have been tested in Linux. They should work on any platform that supports sqlplus.

Unless otherwise mentioned, all scripts are designed for Oracle 10g and 11g.

Installation
============

Download the scripts into a directory on your workstation.

Usage
=====
Change to the installation directory before starting sqlplus.
```
$ cd ~/oracle
$ sqlplus /
```
To execute a script, use the @ symbol, passing any parameters after the script name

```
SQL:myserver1:(MYDB1):PRIMARY> @sp_syntax sp_help
Syntax help
-----------
@sp_help - Reports information about a database object
  @sp_help schema { object_name | % }
```

```
SQL:myserver1:(MYDB1):PRIMARY> @sp_help HR %
object_name                    object_type
------------------------------ ------------------------------
COUNTRIES                      TABLE
DEPARTMENTS                    TABLE
EMPLOYEES                      TABLE
JOBS                           TABLE
JOB_HISTORY                    TABLE
LOCATIONS                      TABLE
PLAN_TABLE                     TABLE
REGIONS                        TABLE
EMP_DETAILS_VIEW               VIEW
DEPARTMENTS_SEQ                SEQUENCE
EMPLOYEES_SEQ                  SEQUENCE
LOCATIONS_SEQ                  SEQUENCE

```

Other Resources
===============
For a complete list of Oracle commands and syntax, refer to www.oraclebytes.com/reference

Contributing
============
1. Fork it.
2. Create a branch (```git checkout -b oracle```)
3. Commit your changes (```git commit -am "Added sp_helpsomething"```)
4. Push to the branch (```git push origin oracle```)
5. Open a Pull Request

Or if that doesn't make any sense to you, just add a suggestion on the github Issues page. 


