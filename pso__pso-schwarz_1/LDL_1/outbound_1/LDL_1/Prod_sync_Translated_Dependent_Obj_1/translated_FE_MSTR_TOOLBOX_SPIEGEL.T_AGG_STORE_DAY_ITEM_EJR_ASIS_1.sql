CREATE OR REPLACE TABLE ldl_fe_mstr_toolbox_spiegel.t_agg_store_day_item_ejr_asis_1 (
client_id INTEGER,
currency_iso_cd STRING(3) COLLATE 'und:ci',
store_id INTEGER,
item_id INTEGER,
dat_formdate DATE,
qty_ejr_asis NUMERIC(29,5),
val_net_ejr_asis BIGNUMERIC(38,11),
move_to_store_id INTEGER
);