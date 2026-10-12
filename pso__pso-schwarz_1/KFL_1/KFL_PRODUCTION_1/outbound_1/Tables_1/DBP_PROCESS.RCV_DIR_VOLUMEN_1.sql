CREATE TABLE IF NOT EXISTS kfl_production_dbp_process.rcv_dir_volumen_1 (
myid1 BIGNUMERIC(38,0) NOT NULL,
datum DATE,
dir STRING(150) COLLATE 'und:ci' NOT NULL,
volumen BIGNUMERIC(38,0),
td_update TIMESTAMP,
td_insert TIMESTAMP
);