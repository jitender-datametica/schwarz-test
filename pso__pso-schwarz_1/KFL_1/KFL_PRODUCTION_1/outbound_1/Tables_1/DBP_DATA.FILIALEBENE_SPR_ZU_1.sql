--==============================================================
-- Table: filialebene_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: filialebene_spr_zu_1
   generated from Powerdesigner on Monday, March 4, 2024 12:59:39 PM_1
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.filialebene_spr_zu_1 (
filialebene_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Bandbreiten'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
filialebene_bez STRING(80) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Bandbreiten  (defensiv, offensiv und neutral)'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (filialebene_id, spr_id, mandant_id) NOT ENFORCED
)
OPTIONS(description='VIS: Sprachabhängige Bezeichnung der Bandbreiten von Defensive Umsatzplanung (Bandbreite IST Umsatz zu Plan HL_1 auf Filialebene)');