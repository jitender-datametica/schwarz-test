CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_ek_notierung_1 (
flw_art_id STRING(10) NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
dat DATE NOT NULL,
plan_fg BIGNUMERIC(38,0) NOT NULL,
system_id BIGNUMERIC(38,0) NOT NULL,
pjwo BIGNUMERIC(38,0) NOT NULL,
betrag NUMERIC(9,2) NOT NULL,
wrg_id STRING(3) NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);