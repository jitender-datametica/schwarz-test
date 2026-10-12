CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.in_besch_best_kontierung_1 (
best_beleg_id INTEGER NOT NULL,
best_beleg_pos_id BIGNUMERIC(38,0) NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
kontierung_pos_id BIGNUMERIC(38,0) NOT NULL,
psp_id BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
geschaeftsbereich_id STRING(4) COLLATE 'und:ci' DEFAULT '-1  ' NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);