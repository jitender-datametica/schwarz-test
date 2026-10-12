DROP TABLE IF EXISTS ldl_production_p_lew_core.t_lil_assort_category_2;
CREATE OR REPLACE TABLE ldl_production_p_lew_core.t_lil_assort_category_2 (
client_id INTEGER NOT NULL,
assort_cat_sid INTEGER NOT NULL,
src_assort_parent_cat_cd STRING(800) NOT NULL,
src_assort_cat_cd STRING(2400) NOT NULL,
assort_parent_cat_name STRING(800) NOT NULL,
assort_cat_name STRING(2400) NOT NULL,
assort_cat_level INTEGER NOT NULL,
dwh_load_id INTEGER NOT NULL,
dwh_created TIMESTAMP NOT NULL,
dwh_updated TIMESTAMP NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
) CLUSTER BY client_id;