CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.ivs_l_flaeche_status (
mandant_id BIGNUMERIC(38,0) NOT NULL,
flaeche_status_id BIGNUMERIC(38,0) NOT NULL,
flaeche_status_bez STRING(50),
spr_id BIGNUMERIC(38,0),
td_insert TIMESTAMP,
td_update TIMESTAMP
);