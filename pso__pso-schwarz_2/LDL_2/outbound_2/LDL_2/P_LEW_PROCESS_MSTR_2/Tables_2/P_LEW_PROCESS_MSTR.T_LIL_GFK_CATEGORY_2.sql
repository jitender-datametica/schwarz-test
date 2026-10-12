CREATE TABLE IF NOT EXISTS ldl_p_lew_process_mstr.t_lil_gfk_category_2 (
client_id BIGNUMERIC(38,0) NOT NULL,
gfk_cat_sid BIGNUMERIC(38,0) NOT NULL,
gfk_cat_id BIGNUMERIC(38,0) NOT NULL,
gfk_cat_name_en STRING(800) COLLATE 'und:ci' NOT NULL,
gfk_cat_name_de STRING(800) COLLATE 'und:ci' NOT NULL,
gfk_cat_short_name STRING(800) COLLATE 'und:ci',
active_fg BIGNUMERIC(38,0),
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created TIMESTAMP NOT NULL,
dwh_updated TIMESTAMP NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);