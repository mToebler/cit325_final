/* Set environment variables. */
SET PAGESIZE 999

/* Write to log file. */
SPOOL create_tolkien.txt
-- I had already put this together during the middle_earth_race_t.sql 
-- portion. It's an NDS block that takes care of deleting the table and
-- sequence objects if they exist.  Adapted from material earlier in 
-- semester.
BEGIN
   FOR i IN (SELECT   object_name
            ,         object_type
            FROM     user_objects
            WHERE    REGEXP_LIKE(object_name,'^tolkien.*$','i')
            ORDER BY 2 DESC) LOOP
      IF i.object_type = 'TABLE' THEN
         EXECUTE IMMEDIATE 'DROP TABLE '||i.object_name||' FORCE';
      ELSIF i.object_type = 'SEQUENCE' THEN
         EXECUTE IMMEDIATE 'DROP SEQUENCE '||i.object_name||' ';
      END IF;
   END LOOP;
END;
/

/* Drop the tolkien table. */
-- DROP TABLE tolkien;

/* Create the tolkien table. */
CREATE TABLE tolkien
( tolkien_id NUMBER
, tolkien_character base_t);

/* Drop and create a tolkien_s sequence. */
-- DROP SEQUENCE tolkien_s;
CREATE SEQUENCE tolkien_s START WITH 1001;

/* Close log file. */
SPOOL OFF

/* Exit the connection. */
QUIT