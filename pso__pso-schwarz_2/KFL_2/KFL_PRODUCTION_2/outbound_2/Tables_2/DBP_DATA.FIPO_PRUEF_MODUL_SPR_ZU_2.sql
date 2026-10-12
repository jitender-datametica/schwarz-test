--==============================================================
-- Table: fipo_pruef_modul_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: fipo_pruef_modul_spr_zu_2
   generated from Powerdesigner on Monday, March 4, 2024 12:59:41 PM_2
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.fipo_pruef_modul_spr_zu_2 (
fipo_pruef_modul_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='eindeutige ID des FIPO-Prüfmoduls aus dem Quellfeld pmo_id'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache            '),
fipo_pruef_modul_bez STRING(30) COLLATE 'und:ci' DEFAULT ' ' NOT NULL
OPTIONS(description='Bezeichnung des Prüfmoduls, z.Bsp. Revision. Aus dem Quellfeld pmi_text'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (fipo_pruef_modul_id, spr_id) NOT ENFORCED
) OPTIONS(description='FIPO - Sprachabhängige Bezeichnung der Prüfmodule');