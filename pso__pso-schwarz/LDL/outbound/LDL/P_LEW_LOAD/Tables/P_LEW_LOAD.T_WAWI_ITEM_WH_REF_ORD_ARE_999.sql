CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_wawi_item_wh_ref_ord_are_999 (
client_id BIGNUMERIC(38) NOT NULL,
order_area_cd STRING(5) COLLATE 'und:ci' NOT NULL,
order_area_desc STRING(50) COLLATE 'und:ci' NOT NULL,
language_id BIGNUMERIC(38) NOT NULL,
load_id BIGNUMERIC(38) NOT NULL
);