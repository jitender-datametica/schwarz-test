CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.in_lief_einteilung_2 (
best_beleg_id INTEGER NOT NULL,
best_beleg_pos_id BIGNUMERIC(38,0) NOT NULL,
einteil_id BIGNUMERIC(38,0) DEFAULT 1 NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
dat_lief_statistisch DATE NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);