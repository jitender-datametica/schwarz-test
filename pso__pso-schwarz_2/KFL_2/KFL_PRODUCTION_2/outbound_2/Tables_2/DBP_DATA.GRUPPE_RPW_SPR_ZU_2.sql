CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.gruppe_rpw_spr_zu_2 (
system_id BIGNUMERIC(38,0) NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
gruppe_id STRING(20) NOT NULL,
abteilung_id STRING(20) NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
gruppe_rpw_bez STRING(40),
td_insert TIMESTAMP,
td_update TIMESTAMP
);