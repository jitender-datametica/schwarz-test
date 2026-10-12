CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_lil_gfk_category_2 (
client_id BIGNUMERIC(38,0) NOT NULL,
gfk_cat_sid BIGNUMERIC(38,0) NOT NULL,
src_gfk_cat_cd STRING(800) NOT NULL,
gfk_cat_name STRING(800) COLLATE 'und:ci' NOT NULL,
gfk_cat_level BIGNUMERIC(38,0) NOT NULL,
gfk_cat_type_cd STRING(160),
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created TIMESTAMP NOT NULL,
dwh_updated TIMESTAMP NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
) CLUSTER BY client_id;