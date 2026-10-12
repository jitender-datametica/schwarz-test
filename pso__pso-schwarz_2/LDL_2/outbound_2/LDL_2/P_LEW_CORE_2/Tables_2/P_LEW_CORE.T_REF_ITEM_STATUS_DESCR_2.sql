CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_item_status_descr_2 (
client_id BIGNUMERIC(38,0) NOT NULL,
lang_sid BIGNUMERIC(38,0) NOT NULL,
lang_cd STRING(2) COLLATE 'und:ci' NOT NULL,
item_status_id BIGNUMERIC(38,0) NOT NULL,
item_status_descr STRING(100) COLLATE 'und:ci',
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL
);