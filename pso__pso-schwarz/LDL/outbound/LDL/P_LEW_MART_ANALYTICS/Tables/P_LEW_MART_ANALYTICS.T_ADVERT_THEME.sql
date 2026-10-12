CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_analytics.t_advert_theme (
client_id BIGNUMERIC(38,0) NOT NULL,
adv_theme_sid BIGNUMERIC(38,0) NOT NULL,
adv_theme_descr STRING(100) COLLATE 'und:ci' NOT NULL,
dwh_created DATETIME NOT NULL
);