CREATE OR REPLACE TABLE ldl_data_production_eval.fixed_t_wawi_itm_item_1 (
client_id INTEGER,
item_sid INTEGER,
country_cd STRING(3) COLLATE 'und:ci',
dat_rec_start DATE,
dat_rec_end DATE,
status_id_hq INTEGER,
case_size INTEGER,
not_exist_flag INTEGER
);