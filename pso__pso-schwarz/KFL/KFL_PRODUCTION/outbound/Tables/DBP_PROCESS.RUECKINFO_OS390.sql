CREATE TABLE IF NOT EXISTS kfl_production_dbp_process.rueckinfo_os390 (
sapbelegnummer INTEGER,
sapbelegjahr INTEGER,
sapmandant STRING(3) COLLATE 'und:ci' NOT NULL,
info_teilabrech STRING(6) COLLATE 'und:ci' NOT NULL,
wewa_id_os390 INTEGER,
td_update TIMESTAMP,
td_insert TIMESTAMP
);