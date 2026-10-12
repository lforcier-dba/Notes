to get sql statement:

set long 50000
select sql_fulltext from gv$sql where sql_id = '4y6ptwbpq1wcv' and rownum = 1;

SELECT * FROM table(DBMS_XPLAN.DISPLAY_CURSOR(sql_id=>'16xp72w81pytd'));
