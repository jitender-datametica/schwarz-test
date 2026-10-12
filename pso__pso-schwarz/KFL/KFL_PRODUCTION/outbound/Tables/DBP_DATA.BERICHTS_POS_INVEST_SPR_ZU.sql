--==============================================================
-- Table: berichts_pos_invest_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: berichts_pos_invest_spr_zu
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:14 PM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.berichts_pos_invest_spr_zu (
berichts_position_invest_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Die Berichtsposition für Investitionen wird direkt im DWH gepflegt '),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Eindeutige ID für jede Sprache'),
berichts_position_invest_bez STRING(80) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Bezeichnung der Berichtsposition'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (berichts_position_invest_id, spr_id) NOT ENFORCED
)
OPTIONS(description='IMS - Sprachabhängige Bezeichnungen der Berichtspositionen für Investitionen  Wird im DWH gepflegt');