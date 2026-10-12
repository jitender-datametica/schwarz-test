CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_wawi_item_wh_ref_status_999_1 (
client_id BIGNUMERIC(38) NOT NULL,
item_status BIGNUMERIC(38) NOT NULL,
item_status_desc STRING(50) COLLATE 'und:ci' NOT NULL,
language_id BIGNUMERIC(38) NOT NULL,
load_id BIGNUMERIC(38) NOT NULL
);