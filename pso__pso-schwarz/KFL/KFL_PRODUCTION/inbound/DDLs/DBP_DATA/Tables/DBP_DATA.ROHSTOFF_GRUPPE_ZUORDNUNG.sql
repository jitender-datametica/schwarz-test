--==============================================================
-- Table: rohstoff_gruppe_zuordnung
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: rohstoff_gruppe_zuordnung
   generated from Powerdesigner on Mittwoch, 1. Oktober 2025 11:01:55
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ROHSTOFF_GRUPPE_ZUORDNUNG (
   rohstoff_gruppe_typ_id              NUMBER(38,0)     NOT NULL COMMENT 'ID des Gruppierungstyps eines Rohstoffs.',
   rohstoff_gruppe_name                VARCHAR(100)     NOT NULL COMMENT 'Name der Gruppe eines Rohstoffs nach Gruppierungstyp.',
   zugeordnete_rohstoff_gruppe_typ_id  NUMBER(38,0)     NOT NULL COMMENT 'ID der zugeordnete Rohstoffgruppe.',
   zugeordnete_rohstoff_gruppe_name    VARCHAR(100)     NOT NULL COMMENT 'Name der zugeordneten Rohstoffsgruppe.',
   rohstoff_gruppe_zuordnungstyp_id    NUMBER(38,0)     NOT NULL COMMENT 'ID der Zurodnungstyp zwischen Rohstoffgruppen.',
   dat_gueltig_von                     DATE             COMMENT 'Gibt an, ab welchem Datum die Zuordnung zwischen den Rohstoffengruppen in die Rohstoffberichte gültig ist.',
   dat_gueltig_bis                     DATE             COMMENT 'Gibt an, bis zu welchem Datum die Zuordnung zwischen den Rohstoffengruppen in die Rohstoffberichte gültig ist.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ROHSTOFF_GRUPPE_ZUORDNUNG PRIMARY KEY (rohstoff_gruppe_typ_id, rohstoff_gruppe_name, rohstoff_gruppe_zuordnungstyp_id, zugeordnete_rohstoff_gruppe_typ_id, zugeordnete_rohstoff_gruppe_name) NOT ENFORCED
)  COMMENT = 'Zuordnungstabelle zwischen Rohstoffsgruppen.';
