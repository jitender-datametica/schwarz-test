CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_pit_onprem.t_advert_period_2 (
adv_period_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL,
adv_period_descr STRING(16777216) COLLATE 'und:ci' DEFAULT 'N/A' NOT NULL,
mstr_related_fg BIGNUMERIC(38,0) NOT NULL,
PRIMARY KEY (adv_period_id) NOT ENFORCED
);