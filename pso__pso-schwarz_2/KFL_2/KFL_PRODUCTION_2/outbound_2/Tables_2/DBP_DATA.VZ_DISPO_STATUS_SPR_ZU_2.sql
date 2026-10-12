CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.vz_dispo_status_spr_zu_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
vz_dispo_status_id BIGNUMERIC(38,0) NOT NULL,
vz_dispo_status_bez STRING(60),
td_update TIMESTAMP,
td_insert TIMESTAMP
);