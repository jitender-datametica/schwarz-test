CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_pit_onprem.t_advert_theme_2 (
client_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL,
adv_theme_sid BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL,
adv_theme_descr STRING(16777216) COLLATE 'und:ci' DEFAULT 'N/A' NOT NULL,
dwh_created DATETIME DEFAULT CAST(CURRENT_TIMESTAMP() AS DATETIME) NOT NULL,
PRIMARY KEY (client_id, adv_theme_sid) NOT ENFORCED
);