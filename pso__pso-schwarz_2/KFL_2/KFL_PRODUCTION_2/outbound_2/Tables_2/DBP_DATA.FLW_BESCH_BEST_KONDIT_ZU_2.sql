CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_besch_best_kondit_zu_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
best_beleg_id INTEGER NOT NULL,
best_beleg_pos_id BIGNUMERIC(38,0) NOT NULL,
beleg_kondition_id INTEGER NOT NULL,
beleg_konditionsart_id STRING(4) COLLATE 'und:ci' DEFAULT '    ' NOT NULL,
system_id BIGNUMERIC(38,0),
td_insert TIMESTAMP,
td_update TIMESTAMP
);