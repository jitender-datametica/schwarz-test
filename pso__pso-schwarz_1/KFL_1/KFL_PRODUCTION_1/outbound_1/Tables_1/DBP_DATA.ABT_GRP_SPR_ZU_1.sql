--==============================================================
-- Table: abt_grp_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: abt_grp_spr_zu_1
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:45 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.abt_grp_spr_zu_1 (
abt_grp_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Abteilungsgruppe (z.B. Markt Gesamt, Markt vergleichbar, Food Frische, etc.)'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache            '),
abt_grp_bez STRING(50) COLLATE 'und:ci',
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (abt_grp_id, mandant_id, spr_id) NOT ENFORCED
) OPTIONS(description='VIS - Abteilungsgruppe Sprachzuordnung');