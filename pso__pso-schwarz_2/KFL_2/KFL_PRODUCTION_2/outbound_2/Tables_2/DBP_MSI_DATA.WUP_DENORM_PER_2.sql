CREATE TABLE IF NOT EXISTS kfl_production_dbp_msi_data.wup_denorm_per_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
wup_id BIGNUMERIC(38,0) NOT NULL,
dat_von_bis STRING(29) NOT NULL OPTIONS(description='PERIOD(DATE)'),
gf_gbl_vertrieb_id BIGNUMERIC(38,0) NOT NULL,
vkl_id BIGNUMERIC(38,0) NOT NULL,
hausleiter_id BIGNUMERIC(38,0) NOT NULL,
frische_manager_id BIGNUMERIC(38,0) NOT NULL,
glv_land_id BIGNUMERIC(38,0) NOT NULL,
gl_vertrieb_id BIGNUMERIC(38,0) NOT NULL,
hausleiter_sperr_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
vkl_sperr_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
gf_gbl_vertrieb_sperr_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);