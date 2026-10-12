CREATE TABLE IF NOT EXISTS kfl_production_dbp_process.besch_faktura_wup_id_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
faktura_beleg_id INTEGER NOT NULL,
faktura_beleg_pos_id BIGNUMERIC(38,0) NOT NULL,
wup_id BIGNUMERIC(38,0) NOT NULL,
load_date DATE NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);