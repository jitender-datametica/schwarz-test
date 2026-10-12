CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_lil_gfk_cat_type_2 (
gfk_cat_type_cd STRING(160) NOT NULL,
gfk_cat_type_name STRING(160) NOT NULL,
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created TIMESTAMP NOT NULL,
dwh_updated TIMESTAMP NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);