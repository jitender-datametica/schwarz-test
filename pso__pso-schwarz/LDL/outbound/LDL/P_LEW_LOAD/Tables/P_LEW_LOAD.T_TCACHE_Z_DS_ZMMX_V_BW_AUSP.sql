CREATE OR REPLACE TABLE ldl_p_lew_load.t_tcache_z_ds_zmmx_v_bw_ausp (
client_id BIGNUMERIC(38) NOT NULL,
bic_zmlila STRING(10),
item_property_sid INTEGER,
objek STRING(100),
atinn INTEGER,
atwrt STRING(60),
extraction_dt DATE,
dwh_load_id BIGNUMERIC(38) NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL
);