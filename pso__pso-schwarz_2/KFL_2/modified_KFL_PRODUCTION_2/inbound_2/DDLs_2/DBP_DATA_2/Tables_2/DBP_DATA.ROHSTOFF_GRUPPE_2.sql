--==============================================================
-- Table: rohstoff_gruppe_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: rohstoff_gruppe_2
   generated from Powerdesigner on Donnerstag, 22. Mai 2025 09:53:25
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ROHSTOFF_GRUPPE_2 (
   rohstoff_gruppe_typ_id              INTEGER     NOT NULL COMMENT 'ID des Gruppierungstyps eines Rohstoffs.',
   rohstoff_gruppe_name                VARCHAR(100)     NOT NULL COMMENT 'Name der Gruppe_2 eines Rohstoffs nach Gruppierungstyp.',
   rohstoff_gruppe_kurz_name           VARCHAR(100)     COMMENT 'Abkürzung der Rohstoffsgruppe name.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ROHSTOFF_GRUPPE PRIMARY KEY (rohstoff_gruppe_typ_id, rohstoff_gruppe_name) NOT ENFORCED
)  COMMENT = 'Gruppe_2 eines Rohstoffs nach Gruppierungstyp.';
