--==============================================================
-- Table: l_rohstoff_gruppe_zuordnungstyp_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_rohstoff_gruppe_zuordnungstyp_2
   generated from Powerdesigner on Mittwoch, 1. Oktober 2025 10:58:42
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.L_ROHSTOFF_GRUPPE_ZUORDNUNGSTYP_2 (
   rohstoff_gruppe_zuordnungstyp_id    INTEGER     NOT NULL COMMENT 'ID der Zurodnungstyp zwischen Rohstoffgruppen.',
   rohstoff_gruppe_zuordnungstyp_bez   VARCHAR(200)     NOT NULL COMMENT 'Bezeichnung des Zuordnungstyps zwischen Rohstoffgruppen.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_L_ROHSTOFF_GRUPPE_ZUORDNUNGSTYP PRIMARY KEY (rohstoff_gruppe_zuordnungstyp_id) NOT ENFORCED
)  COMMENT = 'Lookup Tabelle für Zurodnungstyp zwischen Rohstoffgruppen.(ZB: Zuordnung zwischen KFL Kategorie und KFL Subkategorie..)';
