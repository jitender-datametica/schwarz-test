--==============================================================
-- Table: berichts_pos_it_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: berichts_pos_it_spr_zu_2
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:14 PM_2
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.berichts_pos_it_spr_zu_2 (
berichts_position_it_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Die Berichtsposition für Kostenarten Quelle Z_KL_TRANSACTION_CLASS - Lookup_id wird im DWH durch eine_2 fortlaufende Nummer ersetzt'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Eindeutige ID für jede Sprache'),
berichts_position_it_bez STRING(80) COLLATE 'und:ci' NOT NULL OPTIONS(description='Bezeichnung der Berichtsposition'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (berichts_position_it_id, spr_id) NOT ENFORCED
)
OPTIONS(description='IMS - Sprachabhängige Bezeichnungen der Berichtspositionen für IT-Projekte - Quelle Z_KL_TRANSACTION_CLASS - Lookup_id wird im DWH durch eine_2 fortlaufende Nummer ersetzt');