/*
|| Student:     Mark Tobler
|| Date:        Apr 2, 2020 
|| File:        elf_t.sql
|| Description: Sub-type of base_t
*/

-- Now using dwarf_t.sql as template
CREATE OR REPLACE
   TYPE elf_t UNDER base_t
   ( name   VARCHAR2(30)
   , genus  VARCHAR2(30)
   , CONSTRUCTOR FUNCTION elf_t
      ( name   VARCHAR2  
      , genus  VARCHAR2 DEFAULT 'Elves'
      ) RETURN SELF AS RESULT
   , OVERRIDING MEMBER FUNCTION get_name RETURN VARCHAR2
   , MEMBER FUNCTION get_genus RETURN VARCHAR2
   , MEMBER PROCEDURE set_genus (genus VARCHAR2)
   ) INSTANTIABLE NOT FINAL;
/

-- using base_t as a template:
CREATE OR REPLACE
   TYPE BODY elf_t 
IS
   /* Implement a default constructor. */
   CONSTRUCTOR FUNCTION elf_t
   ( name   VARCHAR2  
   , genus  VARCHAR2 DEFAULT 'Elves'
   ) RETURN SELF AS RESULT
   IS
   BEGIN
      self.oid := tolkien_s.currval - 1000      
      (self as base_t).set_oname('Elf');
      self.name := name;
      self.genus := genus;
      RETURN;
   END;
 
   /* override the stub get_name method. */
   OVERRIDING MEMBER FUNCTION get_name RETURN VARCHAR2
   IS
   BEGIN
      RETURN self.name;
   END get_name;
   
   /* implement sub-type accessor*/
   MEMBER FUNCTION get_genus RETURN VARCHAR2
   IS
   BEGIN
     RETURN self.genus;
   END get_genus;

   /* implement sub-type mutator */
   MEMBER PROCEDURE set_genus (genus VARCHAR2)
   IS
   BEGIN
      self.genus := genus;
   END set_genus;

   /* Using to_string() method in base_t*/
   
END;
/

QUIT;

-- To test:
-- SELECT TREAT(elf_t('Bobby') AS elf_t).to_string() AS "Identity" from dual;