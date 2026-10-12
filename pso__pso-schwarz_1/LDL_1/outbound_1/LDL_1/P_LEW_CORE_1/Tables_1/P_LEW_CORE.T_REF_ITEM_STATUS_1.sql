CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_item_status_1 (
client_id BIGNUMERIC(38,0) NOT NULL,
item_status_id BIGNUMERIC(38,0) NOT NULL,
item_status_descr STRING(100) COLLATE 'und:ci' NOT NULL,
hq_level_fg BIGNUMERIC(38,0) NOT NULL,
wh_level_fg BIGNUMERIC(38,0) NOT NULL,
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL
);