--==============================================================
-- Table: filialebene_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: filialebene_spr_zu_2
   generated from Powerdesigner on Monday, March 4, 2024 12:59:39 PM_2
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.filialebene_spr_zu_2 (
filialebene_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Bandbreiten'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
filialebene_bez STRING(80) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Bandbreiten  (defensiv, offensiv und neutral)'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (filialebene_id, spr_id, mandant_id) NOT ENFORCED
)
OPTIONS(description='VIS: Sprachabhängige Bezeichnung der Bandbreiten von Defensive Umsatzplanung (Bandbreite IST Umsatz zu Plan HL_2 auf Filialebene)');