CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_analytics.t_advert_medium_2 (
client_id BIGNUMERIC(38,0) NOT NULL,
adv_medium_sid BIGNUMERIC(38,0) NOT NULL,
adv_medium_descr STRING(100) COLLATE 'und:ci' NOT NULL,
adv_medium_sort_val BIGNUMERIC(38,0) NOT NULL,
dwh_created DATETIME NOT NULL
);