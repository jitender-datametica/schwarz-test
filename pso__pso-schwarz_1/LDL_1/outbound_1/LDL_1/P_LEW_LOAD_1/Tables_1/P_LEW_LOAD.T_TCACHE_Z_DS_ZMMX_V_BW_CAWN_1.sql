CREATE OR REPLACE TABLE ldl_p_lew_load.t_tcache_z_ds_zmmx_v_bw_cawn_1 (
client_id BIGNUMERIC(38) NOT NULL,
bic_zmlila STRING(40) COLLATE 'und:ci',
atwrt STRING(50) COLLATE 'und:ci',
atinn BIGNUMERIC(38) NOT NULL,
extraction_dt DATE,
dwh_load_id BIGNUMERIC(38) NOT NULL,
dwh_created DATETIME,
dwh_updated DATETIME
);