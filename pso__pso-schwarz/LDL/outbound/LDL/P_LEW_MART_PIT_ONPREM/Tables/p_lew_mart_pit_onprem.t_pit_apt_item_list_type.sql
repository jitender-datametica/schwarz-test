CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_pit_onprem.t_pit_apt_item_list_type (
item_list_type_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL,
item_list_type STRING(16777216) COLLATE 'und:ci' NOT NULL,
PRIMARY KEY (item_list_type_id) NOT ENFORCED
);