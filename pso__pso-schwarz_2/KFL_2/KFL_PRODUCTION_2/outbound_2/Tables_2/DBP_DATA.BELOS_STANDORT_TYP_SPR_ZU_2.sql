--==============================================================
-- Table: belos_standort_typ_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: belos_standort_typ_spr_zu_2
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:30 PM_2
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.belos_standort_typ_spr_zu_2 (
belos_standort_typ_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID des Belos_standorttyps. Wird im DWH vergeben'),
spr_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='In diesem Feld werden die Sprachen der DWH Tabelle spr_2 referenziert.'),
belos_standort_typ_bez STRING(30) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Bezeichnung des Belos-Standorttyps, z.Bsp. Palettenhändler'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (belos_standort_typ_id, spr_id) NOT ENFORCED
)
OPTIONS(description='LIS - Sprachabhängige Bezeichnung der Standorttypen. Manuell befüllte Tabelle, ohne SST zu Vorsystem');