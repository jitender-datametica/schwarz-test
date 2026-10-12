--==============================================================
-- Table: berichts_pos_inv_grp_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: berichts_pos_inv_grp_spr_zu_1
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:14 PM_1
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.berichts_pos_inv_grp_spr_zu_1 (
berichts_pos_invest_grp_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Die Berichtsposition- Gruppierung  wird direkt im DWH gepflegt '),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Eindeutige ID für jede Sprache'),
berichts_pos_invest_grp_bez STRING(80) COLLATE 'und:ci'
OPTIONS(description='Bezeichnung der Gruppierung für Berichtspositionen. Initial versorgt/manuelle Pflege'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (berichts_pos_invest_grp_id, spr_id) NOT ENFORCED
)
OPTIONS(description='IMS - Sprachabhängige Bezeichnungen der Berichtspositionen- Gruppierungen für Investitionen. Wird im DWH gepflegt');