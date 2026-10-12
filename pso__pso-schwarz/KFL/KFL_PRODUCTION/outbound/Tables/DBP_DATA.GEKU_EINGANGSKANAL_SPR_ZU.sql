--==============================================================
-- Table: geku_eingangskanal_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: geku_eingangskanal_spr_zu
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:42 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.geku_eingangskanal_spr_zu (
geku_eingangskanal_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='GeKu Eingangskanal, z.Bsp. Fax, Telefon'),
spr_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='In diesem Feld werden die Sprachen der DWH Tabelle spr referenziert.'),
geku_eingangskanal_bez STRING(60) COLLATE 'und:ci'
OPTIONS(description='Bezeichnung des GeKu-Eingangskanals, z.Bsp. Brief; Fax'),
quelle_spr_id BIGNUMERIC(38,0)
OPTIONS(description='Fehlende Spracheinträge werden aus einem vorhandenen Eintrag generiert. Hier ist gespeichert, aus welcher Sprache'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (geku_eingangskanal_id, spr_id) NOT ENFORCED
) OPTIONS(description='GEKU - Sprachabhängige Bezeichnungen der Eingangskanäle');