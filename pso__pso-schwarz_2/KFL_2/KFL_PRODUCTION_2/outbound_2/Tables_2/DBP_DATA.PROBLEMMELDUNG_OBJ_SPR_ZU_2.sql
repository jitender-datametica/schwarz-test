CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.problemmeldung_obj_spr_zu_2 (
system_id BIGNUMERIC(38,0) NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
zus_obj_id STRING(30) NOT NULL,
zus_obj_bez STRING(40),
td_update TIMESTAMP,
td_insert TIMESTAMP
);