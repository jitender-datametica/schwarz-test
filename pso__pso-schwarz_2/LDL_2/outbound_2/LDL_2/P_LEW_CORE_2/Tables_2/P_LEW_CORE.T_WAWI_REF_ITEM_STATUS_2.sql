CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_wawi_ref_item_status_2 (
client_id BIGNUMERIC(38,0) NOT NULL,
item_status BIGNUMERIC(38,0) NOT NULL,
item_status_desc STRING(50) COLLATE 'und:ci' NOT NULL,
language_id BIGNUMERIC(38,0) NOT NULL,
load_id BIGNUMERIC(38,0) NOT NULL
);