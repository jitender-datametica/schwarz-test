CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_kunde_auftrag_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
verkaufs_beleg_id INTEGER NOT NULL,
flw_vw_id BIGNUMERIC(38,0) NOT NULL,
system_id BIGNUMERIC(38,0) NOT NULL,
dat_erstellung DATE NOT NULL,
best_beleg_id_kunde STRING(20) COLLATE 'und:ci' DEFAULT '-1' NOT NULL,
auftragsart_id STRING(4) COLLATE 'und:ci' DEFAULT '    ' NOT NULL,
flw_verkaufsorganisation_id STRING(4) COLLATE 'und:ci' DEFAULT '    ' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);