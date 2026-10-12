--==============================================================
-- Table: geku_artikel_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: geku_artikel_spr_zu_1
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:42 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.geku_artikel_spr_zu_1 (
geku_artikel_uid INTEGER NOT NULL
OPTIONS(description='Eindeutige ID eines GEKU-Artikels aus workflow_uid. Der GEKU-Artikel_1 besitzt keine Referenz zum Kaufland-Artikel_1'),
spr_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='In diesem Feld werden die Sprachen der DWH Tabelle spr_1 referenziert.'),
geku_artikel_bez STRING(250) COLLATE 'und:ci'
OPTIONS(description='Bezeichnung des GeKu-Artikels aus code_name, z.Bsp. Einkaufswagen'),
quelle_spr_id BIGNUMERIC(38,0)
OPTIONS(description='Fehlende Spracheinträge werden aus einem vorhandenen Eintrag generiert. Hier ist gespeichert, aus welcher Sprache'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (geku_artikel_uid, spr_id) NOT ENFORCED
) OPTIONS(description='GEKU - Sprachabhängige Bezeichnung der GeKu-Artikel_1 aus s1_dwh_workflow_out');