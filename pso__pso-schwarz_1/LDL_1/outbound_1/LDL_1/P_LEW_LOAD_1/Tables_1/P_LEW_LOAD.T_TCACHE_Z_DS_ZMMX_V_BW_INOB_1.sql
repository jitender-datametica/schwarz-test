CREATE OR REPLACE TABLE ldl_p_lew_load.t_tcache_z_ds_zmmx_v_bw_inob_1 (
client_id BIGNUMERIC(38) NOT NULL,
bic_zmlila STRING(10),
item_sid NUMERIC(20,0),
objek STRING(100),
cuobj STRING(100),
extraction_dt DATE,
dwh_load_id BIGNUMERIC(38) NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL
);