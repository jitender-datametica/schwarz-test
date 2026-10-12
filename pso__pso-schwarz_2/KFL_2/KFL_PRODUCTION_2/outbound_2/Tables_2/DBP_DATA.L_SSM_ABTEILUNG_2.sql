CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_ssm_abteilung_2 (
wup_abt_id BIGNUMERIC(38,0) NOT NULL,
wup_bereich_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);