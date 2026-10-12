CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.lief_einteilung (
mandant_id BIGNUMERIC(38,0) NOT NULL,
best_beleg_id INTEGER NOT NULL,
best_beleg_pos_id BIGNUMERIC(38,0) NOT NULL,
einteil_id BIGNUMERIC(38,0) NOT NULL,
menge_einteil NUMERIC(18,3) NOT NULL,
dat_lief_wunsch DATE NOT NULL,
dat_lief_bewertung DATE,
mahnung_anz BIGNUMERIC(38,0) NOT NULL,
system_id BIGNUMERIC(38,0) DEFAULT 7 NOT NULL,
flw_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
) CLUSTER BY mandant_id, dat_lief_wunsch;