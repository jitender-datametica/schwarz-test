CREATE TABLE IF NOT EXISTS kfl_production_dbp_process.personalkosten_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
wup_id BIGNUMERIC(38,0) NOT NULL,
nb_id BIGNUMERIC(38,0) NOT NULL,
kjmo BIGNUMERIC(38,0) NOT NULL,
kosten_ist NUMERIC(18,4) NOT NULL,
abgr_fg BIGNUMERIC(38,0) DEFAULT 1 NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);