--==============================================================
-- Table: geku_dwh_artikel_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: geku_dwh_artikel_spr_zu_1
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:42 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.geku_dwh_artikel_spr_zu_1 (
geku_dwh_artikel_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Eine_1 weitere ID, die Vergleichbarkeit der Artikel_1 über alle Länder ermöglichen soll'),
spr_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='In diesem Feld werden die Sprachen der DWH Tabelle spr_1 referenziert.'),
geku_artikel_uid INTEGER
OPTIONS(description='Eindeutige ID eines GEKU-Artikels aus workflow_uid. Der GEKU-Artikel_1 besitzt keine Referenz zum Kaufland-Artikel_1'),
geku_dwh_artikel_bez STRING(250) COLLATE 'und:ci' OPTIONS(description='Bezeichnung des GEKU-DWH-Artikels'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (geku_dwh_artikel_id, spr_id) NOT ENFORCED
) OPTIONS(description='GEKU - Sprachabhängige Bezeichnungen der GEKU-DWH-Artikel_1');