CREATE OR REPLACE TABLE ldl_production_p_lew_process_mstr.t_lil_gfk_category (
client_id INTEGER NOT NULL,
gfk_cat_sid INTEGER NOT NULL,
gfk_cat_id INTEGER NOT NULL,
gfk_cat_name_en STRING(800) COLLATE 'und:ci' NOT NULL,
gfk_cat_name_de STRING(800) COLLATE 'und:ci' NOT NULL,
gfk_cat_short_name STRING(800) COLLATE 'und:ci',
active_fg INTEGER,
dwh_load_id INTEGER NOT NULL,
dwh_created TIMESTAMP NOT NULL,
dwh_updated TIMESTAMP NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);