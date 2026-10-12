CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_pit_onprem.t_pit_apt_advert_medium_client (
client_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL,
advert_medium_sid BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL,
anl_advert_medium_sid BIGNUMERIC(38,0) DEFAULT - 1,
advert_medium STRING(16777216) COLLATE 'und:ci' NOT NULL,
advert_medium_sort_val BIGNUMERIC(38,0) DEFAULT - 1,
advert_medium_group_sid BIGNUMERIC(38,0) DEFAULT - 1,
advert_medium_group STRING(16777216) COLLATE 'und:ci',
advert_medium_group_sort_val BIGNUMERIC(38,0) DEFAULT - 1,
advert_medium_ignore_fg BIGNUMERIC(38,0) DEFAULT 0,
advert_medium_delete_fg BIGNUMERIC(38,0) DEFAULT 0,
deleted_fg BIGNUMERIC(38,0) DEFAULT 0,
dwh_created DATETIME DEFAULT CAST(CURRENT_TIMESTAMP() AS DATETIME) NOT NULL,
PRIMARY KEY (client_id, advert_medium_sid) NOT ENFORCED
);