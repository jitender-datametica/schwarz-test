CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_pit_onprem.t_advert_medium (
client_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL,
adv_medium_sid BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL,
adv_medium_descr STRING(16777216) COLLATE 'und:ci' DEFAULT 'N/A' NOT NULL,
adv_medium_sort_val BIGNUMERIC(38,0) DEFAULT 127 NOT NULL,
dwh_created DATETIME DEFAULT CAST(CURRENT_TIMESTAMP() AS DATETIME) NOT NULL,
PRIMARY KEY (client_id, adv_medium_sid) NOT ENFORCED
);