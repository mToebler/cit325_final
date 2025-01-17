/*
|| Student:     Mark Tobler
|| Author:      Michael McLaughlin
|| Date:        Apr 2, 2020 
|| File:        query_instances.sql
|| Description: Verifies the inserts of 21 valid instance inserts 
||              in the tolkien table.
*/
/* Set environment variables. */
SET PAGESIZE 999

/* Write to log file. */
SPOOL query_instances.txt

/* Format and query results. */
COLUMN objectid         FORMAT 9999 HEADING "Object ID"
COLUMN name             FORMAT A20  HEADING "Name"
COLUMN description      FORMAT A40  HEADING "Description"
SELECT   t.tolkien_id AS objectid
,        TREAT(t.tolkien_character AS base_t).get_name() AS name
,        TREAT(t.tolkien_character AS base_t).to_string() AS description
FROM     tolkien t
ORDER BY 1, TREAT(t.tolkien_character AS base_t).get_name();

/* Close log file. */
SPOOL OFF

/* Close connection. */
QUIT