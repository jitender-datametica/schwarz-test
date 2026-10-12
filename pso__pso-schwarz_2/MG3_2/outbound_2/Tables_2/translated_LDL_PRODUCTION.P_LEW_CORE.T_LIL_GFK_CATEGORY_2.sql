DROP TABLE IF EXISTS ldl_production_p_lew_core.t_lil_gfk_category_2;
CREATE OR REPLACE TABLE ldl_production_p_lew_core.t_lil_gfk_category_2 (
client_id INTEGER NOT NULL,
gfk_cat_sid INTEGER NOT NULL,
src_gfk_cat_cd STRING(800) NOT NULL,
gfk_cat_name STRING(800) COLLATE 'und:ci' NOT NULL,
gfk_cat_level INTEGER NOT NULL,
gfk_cat_type_cd STRING(160),
dwh_load_id INTEGER NOT NULL,
dwh_created TIMESTAMP NOT NULL,
dwh_updated TIMESTAMP NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
) CLUSTER BY client_id;