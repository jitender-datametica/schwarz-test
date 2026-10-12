CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_lil_assort_category_1 (
client_id BIGNUMERIC(38,0) NOT NULL,
assort_cat_sid BIGNUMERIC(38,0) NOT NULL,
src_assort_parent_cat_cd STRING(800) NOT NULL,
src_assort_cat_cd STRING(2400) NOT NULL,
assort_parent_cat_name STRING(800) NOT NULL,
assort_cat_name STRING(2400) NOT NULL,
assort_cat_level BIGNUMERIC(38,0) NOT NULL,
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created TIMESTAMP NOT NULL,
dwh_updated TIMESTAMP NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
) CLUSTER BY client_id;