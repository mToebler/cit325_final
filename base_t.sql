/*
|| Student:     Mark Tobler
|| Date:        Apr 2, 2020 
|| File:        base_t.sql
|| Description: A base_t object type and type body in a base_t.sql file, 
||              which includes a QUIT; statement. In the to_string() method,
||              I've put a call to get_name(). I tried to think of ways 
||              I could implement the object model more streamlined,
||              but didn't see a way that matched the specifications.
||              It seems that base_t should have a GENUS attribute
||              since all the extending types have it. Alternatively,
||              having a get_genus "abstract" method like get_name
||              would have been handly. Good final project. 
*/

-- conditionally drop the base_t object, sub types and sequence
-- using an implicit cursor in a for loop
--
BEGIN
   FOR i IN (SELECT   object_name
            ,        object_type
            FROM     user_objects
            WHERE    REGEXP_LIKE(object_name,'^base_t.*$','i')
            ORDER BY 2 DESC) LOOP
      IF i.object_type = 'TYPE' THEN
         EXECUTE IMMEDIATE 'DROP TYPE '||i.object_name||' FORCE';
      ELSIF i.object_type = 'SEQUENCE' THEN
         EXECUTE IMMEDIATE 'DROP SEQUENCE '||i.object_name||' ';
      END IF;
   END LOOP;
END;
/

-- CREATE SEQUENCE tolkien_s;

-- based on order_comp from lab directions
-- Keeping equals() in here from example. 
CREATE OR REPLACE
   TYPE base_t IS OBJECT 
   ( oid      NUMBER
   , oname  VARCHAR2(30)
   , CONSTRUCTOR FUNCTION base_t 
      ( oid    NUMBER DEFAULT NULL
      , oname  VARCHAR2 DEFAULT 'BASE_T'
      ) RETURN SELF AS RESULT
   , MEMBER FUNCTION get_oname RETURN VARCHAR2
   , MEMBER PROCEDURE set_oname (oname VARCHAR2)
   , MEMBER FUNCTION get_name RETURN VARCHAR2
   , MEMBER FUNCTION to_string RETURN VARCHAR2
   , MEMBER FUNCTION equals(object base_t) RETURN NUMBER 
   )
   INSTANTIABLE NOT FINAL;
/

-- piggy backing onto the order_comp constructor
CREATE OR REPLACE
   TYPE BODY base_t 
IS
   /* Implement a default constructor. */
   CONSTRUCTOR FUNCTION base_t 
   ( oid    NUMBER DEFAULT NULL
   , oname  VARCHAR2 DEFAULT 'BASE_T'
   ) RETURN SELF AS RESULT
   IS
      oid_val NUMBER;
   BEGIN
      IF oid IS NULL THEN
         -- keeping this from the instructional material
         oid_val := tolkien_s.currval - 1000      
      ELSE   
         oid_val := oid;
      END IF;
      self.oid := oid_val;
      self.oname := oname;
      RETURN;
   END;
 
   /* Implement a get_oname function. */
   MEMBER FUNCTION get_oname RETURN VARCHAR2 
   IS
   BEGIN
      RETURN self.oname;
   END get_oname;
 
   /* Implement a set_oname procedure. */
   MEMBER PROCEDURE set_oname(oname VARCHAR2) 
   IS
   BEGIN
      -- validation? 
      self.oname := oname;
   END set_oname;
 
   /* Implement a stub get_name function. */
   MEMBER FUNCTION get_name
   RETURN VARCHAR2 
   IS
   BEGIN
      RETURN NULL;
   END get_name;

   /* Implement a to_string function. */
   MEMBER FUNCTION to_string
   RETURN VARCHAR2 
   IS
   BEGIN
      -- The idea here is that perhaps using TREAT or the SELF AS
      -- I'll be able to get this to work
      RETURN '['||self.oid||']['||self.get_name||']['||self.oname||']';
   END to_string;

  /* Implement an equals function. */
   MEMBER FUNCTION equals(object base_t) RETURN NUMBER 
   IS
      return_val  NUMBER;
   BEGIN
      -- Compare like values.
      IF self.oname < object.oname THEN
         return_val := 0;
      ELSIF self.oname = object.oname AND NOT self.oid < object.oid THEN
         return_val := 1;
      ELSE
         return_val := 0;
      END IF;
      RETURN return_val;
   END equals;
   -- not putting a base_t at the end of this END as it was causing 
   -- OracleLIVE to fail.
END;
/


QUIT;

-- To test:
