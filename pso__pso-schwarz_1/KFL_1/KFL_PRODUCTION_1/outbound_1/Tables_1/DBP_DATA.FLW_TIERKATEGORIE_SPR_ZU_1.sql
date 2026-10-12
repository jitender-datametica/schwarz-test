CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_tierkategorie_spr_zu_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
werk_id BIGNUMERIC(38,0) NOT NULL,
tierkategorie_id BIGNUMERIC(38,0) NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
tierkategorie_bez STRING(40) DEFAULT '0' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);