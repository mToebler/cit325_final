/*
|| Student:     Mark Tobler
|| Date:        Apr 2, 2020 
|| File:        silvan_t.sql
|| Description: Sub-type of elf_t
*/

-- Define silvan_t type
CREATE OR REPLACE
   TYPE silvan_t UNDER elf_t
   ( elfkind    VARCHAR2(30)
   , CONSTRUCTOR FUNCTION silvan_t
     ( name    VARCHAR2  
     , elfkind VARCHAR2 DEFAULT 'Silvan'
     ) RETURN SELF AS RESULT
   , MEMBER FUNCTION get_elfkind RETURN VARCHAR2
   , MEMBER PROCEDURE set_elfkind(elfkind VARCHAR2)
   ) INSTANTIABLE NOT FINAL;
/

-- using base_t as a template:
CREATE OR REPLACE
   TYPE BODY silvan_t 
IS
   /* Implement a default constructor. */
   CONSTRUCTOR FUNCTION silvan_t
     ( name    VARCHAR2  
     , elfkind VARCHAR2 DEFAULT 'Silvan'
     ) RETURN SELF AS RESULT
   IS
   BEGIN
      self.oid := tolkien_s.currval - 1000;      
      (self AS base_t).set_oname('Elf');
      self.name    := name;
      (self AS  elf_t).set_genus('Elves');
      self.elfkind := elfkind;
      RETURN;
   END;
 
   /* implement sub-type accessor*/
   MEMBER FUNCTION get_elfkind RETURN VARCHAR2
   IS
   BEGIN
     RETURN self.elfkind;
   END get_elfkind;

   /* implement sub-type mutator */
   MEMBER PROCEDURE set_elfkind (elfkind VARCHAR2)
   IS
   BEGIN
      self.elfkind := elfkind;
   END set_elfkind;

   /* Using to_string() method in base_t*/
   
END;
/

QUIT;

-- To test:
-- SELECT TREAT(silvan_t('Bobby') AS silvan_t).to_string() AS "Identity" from dual;