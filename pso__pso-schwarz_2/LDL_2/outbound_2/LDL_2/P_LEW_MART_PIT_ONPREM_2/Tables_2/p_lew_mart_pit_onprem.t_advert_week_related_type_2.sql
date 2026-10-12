CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_pit_onprem.t_advert_week_related_type_2 (
adv_week_rltd_type_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL,
adv_week_rltd_type_descr STRING(16777216) COLLATE 'und:ci' NOT NULL,
PRIMARY KEY (adv_week_rltd_type_id) NOT ENFORCED
);