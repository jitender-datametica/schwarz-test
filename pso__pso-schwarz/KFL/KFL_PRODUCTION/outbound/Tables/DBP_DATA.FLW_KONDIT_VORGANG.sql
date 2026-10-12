CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_kondit_vorgang (
mandant_id BIGNUMERIC(38,0) NOT NULL,
beleg_kondition_id INTEGER NOT NULL,
beleg_kondition_pos_id BIGNUMERIC(38,0) NOT NULL,
betrag_beleg_kondition NUMERIC(18,4) DEFAULT 0 NOT NULL,
wrg_id STRING(3) COLLATE 'und:ci' NOT NULL,
kondition_preis_einh_id BIGNUMERIC(38,0) DEFAULT 1 NOT NULL,
system_id BIGNUMERIC(38,0) NOT NULL,
beleg_konditionsart_id STRING(4) COLLATE 'und:ci' DEFAULT '    ' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);