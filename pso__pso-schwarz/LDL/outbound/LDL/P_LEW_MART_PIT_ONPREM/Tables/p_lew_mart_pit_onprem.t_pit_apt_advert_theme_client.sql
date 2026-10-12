CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_pit_onprem.t_pit_apt_advert_theme_client (
client_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL,
advert_theme_sid BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL,
advert_theme STRING(16777216) COLLATE 'und:ci',
deleted_fg BIGNUMERIC(38,0) DEFAULT 0,
excluded_fg BIGNUMERIC(38,0) DEFAULT 0,
dwh_created DATETIME DEFAULT CAST(CURRENT_TIMESTAMP() AS DATETIME),
PRIMARY KEY (client_id, advert_theme_sid) NOT ENFORCED
);