--==============================================================
-- Table: flw_schnitt_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_schnitt_spr_zu_2
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:43 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_schnitt_spr_zu_2 (
schnitt_id INTEGER NOT NULL OPTIONS(description='Eindeutige Nummer des Schnitts aus cutnr'),
sek_schl_typ_id STRING(1) COLLATE 'und:ci' NOT NULL OPTIONS(description='Typ des Sekundärschlüssels aus sctyp'),
sek_schl_id INTEGER NOT NULL OPTIONS(description='ID des Sekundärschlüssels aus sckey'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Eindeutige ID für jede Sprache'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
system_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Spezifiziert das Quellsystem, aus dem die Daten kommen.'),
schnitt_bez STRING(40) COLLATE 'und:ci' NOT NULL OPTIONS(description='Bezeichnung aus txt40'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (schnitt_id, sek_schl_id, spr_id, mandant_id) NOT ENFORCED
) OPTIONS(description='FLW - Schnitt Texte aus cutkt');