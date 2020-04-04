/*
|| Student:     Mark Tobler
|| Date:        Apr 2, 2020 
|| File:        insert_instances.sql
|| Description: Inserts 21 object type instances into table for final project.
*/

INSERT INTO tolkien VALUES(tolkien_s.nextval, MAN_T('Boromir'));
INSERT INTO tolkien VALUES(tolkien_s.nextval, MAN_T('Faramir'));
INSERT INTO tolkien VALUES(tolkien_s.nextval, HOBBIT_T('Bilbo'));
INSERT INTO tolkien VALUES(tolkien_s.nextval, HOBBIT_T('Frodo'));
INSERT INTO tolkien VALUES(tolkien_s.nextval, HOBBIT_T('Merry'));
INSERT INTO tolkien VALUES(tolkien_s.nextval, HOBBIT_T('Pippin'));
INSERT INTO tolkien VALUES(tolkien_s.nextval, HOBBIT_T('Samwise'));
INSERT INTO tolkien VALUES(tolkien_s.nextval, DWARF_T('Gimli'));
INSERT INTO tolkien VALUES(tolkien_s.nextval, NOLDOR_T('Feanor'));
INSERT INTO tolkien VALUES(tolkien_s.nextval, SILVAN_T('Tauriel'));
INSERT INTO tolkien VALUES(tolkien_s.nextval, TELERI_T('Earwen'));
INSERT INTO tolkien VALUES(tolkien_s.nextval, TELERI_T('Celeborn'));
INSERT INTO tolkien VALUES(tolkien_s.nextval, SINDAR_T('Thranduil'));
INSERT INTO tolkien VALUES(tolkien_s.nextval, SINDAR_T('Legolas'));
INSERT INTO tolkien VALUES(tolkien_s.nextval, ORC_T('Azog the Defiler'));
INSERT INTO tolkien VALUES(tolkien_s.nextval, ORC_T('Bolg'));
INSERT INTO tolkien VALUES(tolkien_s.nextval, MAIA_T('Gandalf the Grey'));
INSERT INTO tolkien VALUES(tolkien_s.nextval, MAIA_T('Radagast the Brown'));
INSERT INTO tolkien VALUES(tolkien_s.nextval, MAIA_T('Saruman the White'));
INSERT INTO tolkien VALUES(tolkien_s.nextval, GOBLIN_T('The Great Goblin'));
INSERT INTO tolkien VALUES(tolkien_s.nextval, MAN_T('Aragorn'));

QUIT
-- just assumming