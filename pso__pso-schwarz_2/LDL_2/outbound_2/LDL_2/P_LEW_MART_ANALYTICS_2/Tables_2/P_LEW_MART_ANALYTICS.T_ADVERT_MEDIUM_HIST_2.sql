CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_analytics.t_advert_medium_hist_2 (
client_id BIGNUMERIC(38,0) NOT NULL,
adv_medium_sid BIGNUMERIC(38,0) NOT NULL,
adv_medium_grp_sid BIGNUMERIC(38,0) NOT NULL,
adv_medium_ignore_fg BIGNUMERIC(38,0) NOT NULL,
adv_medium_delete_fg BIGNUMERIC(38,0) NOT NULL,
dwh_valid_from DATE NOT NULL,
dwh_valid_to DATE NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL
);