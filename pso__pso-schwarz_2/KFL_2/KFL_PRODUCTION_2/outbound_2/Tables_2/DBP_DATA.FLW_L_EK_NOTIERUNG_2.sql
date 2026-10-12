CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_l_ek_notierung_2 (
ek_notierung_id STRING(10) NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
system_id BIGNUMERIC(38,0),
ek_notierung_bez STRING(40) NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);