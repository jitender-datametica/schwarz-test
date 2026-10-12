CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.ker_mo_periode_zu_1 (
kj BIGNUMERIC(38,0) NOT NULL,
ker_mo_id BIGNUMERIC(38,0) NOT NULL,
gj BIGNUMERIC(38,0) NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
krk_id STRING(4) COLLATE 'und:ci' NOT NULL,
buchungsperiode_id BIGNUMERIC(38,0) NOT NULL,
system_id BIGNUMERIC(38,0) NOT NULL,
kj_ker_mo_id BIGNUMERIC(38,0),
kjmo BIGNUMERIC(38,0),
td_insert TIMESTAMP,
td_update TIMESTAMP
);