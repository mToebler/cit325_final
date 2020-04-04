/*
|| Student:     Mark Tobler
|| Date:        Apr 2, 2020 
|| File:        noldor_t.sql
|| Description: Sub-type of elf_t
*/

-- Define noldor_t type
CREATE OR REPLACE
   TYPE noldor_t UNDER elf_t
   ( elfkind    VARCHAR2(30)
   , CONSTRUCTOR FUNCTION noldor_t
     ( name    VARCHAR2  
     , elfkind VARCHAR2 DEFAULT 'Noldor'
     ) RETURN SELF AS RESULT
   , MEMBER FUNCTION get_elfkind RETURN VARCHAR2
   , MEMBER PROCEDURE set_elfkind(elfkind VARCHAR2)
   , OVERRIDING MEMBER FUNCTION to_string RETURN VARCHAR2 
   ) INSTANTIABLE NOT FINAL;
/

-- using base_t as a template:
CREATE OR REPLACE
   TYPE BODY noldor_t 
IS
   /* Implement a default constructor. */
   CONSTRUCTOR FUNCTION noldor_t
     ( name    VARCHAR2  
     , elfkind VARCHAR2 DEFAULT 'Noldor'
     ) RETURN SELF AS RESULT
   IS
   BEGIN
      self.oid     := tolkien_s.currval - 1000      
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
   OVERRIDING MEMBER FUNCTION to_string RETURN VARCHAR2 
   IS
   BEGIN
      RETURN (self AS base_t).to_string||'['||self.get_elfkind||']';
   END to_string;
END;
/

QUIT;

-- To test:
-- SELECT TREAT(noldor_t('Bobby') AS noldor_t).to_string() AS "Identity" from dual;