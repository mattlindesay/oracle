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
To execute a script, use the @ symbol, passing any parameters after the script name. As sqlplus doesn't allow for optional parameters, % is used for this purpose.

## @sp_syntax
To get a list of all available scripts:
```
SQL:myserver1:(MYDB1):PRIMARY> @sp_syntax %
```

To check the syntax for a particular script:
```
SQL:myserver1:(MYDB1):PRIMARY> @sp_syntax sp_help
Syntax help
-----------
@sp_help - Reports information about a database object
  @sp_help schema { object_name | % }
```

## @sp_help
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

Alternate Usage
===============
Sometimes it's not convenient to cd to the directory where the scripts are located. For this reason you could set up an environment variable as follows:

```
$ export s=~/oracle
$ sqlplus /
SQL:myserver1:(MYDB1):PRIMARY> @$s/sp_syntax %
```

It's a bit ugly, but does the job (that's what she said :-)).

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


