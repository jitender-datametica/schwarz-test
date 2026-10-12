CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_kunde_auftrag_einteil (
mandant_id BIGNUMERIC(38,0) NOT NULL,
verkaufs_beleg_id INTEGER NOT NULL,
verkaufs_beleg_pos_id BIGNUMERIC(38,0) NOT NULL,
einteil_id BIGNUMERIC(38,0) NOT NULL,
system_id BIGNUMERIC(38,0) NOT NULL,
dat_einteilung DATE NOT NULL,
zeit_einteilung BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);