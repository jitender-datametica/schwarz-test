CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_analytics.t_advert_medium_group (
client_id BIGNUMERIC(38,0) NOT NULL,
adv_medium_grp_sid BIGNUMERIC(38,0) NOT NULL,
adv_medium_grp_descr STRING(100) COLLATE 'und:ci' NOT NULL,
adv_medium_grp_sort_val BIGNUMERIC(38,0) NOT NULL,
adv_medium_grp_ignore_fg BIGNUMERIC(38,0) NOT NULL,
adv_medium_grp_alw_vis_fg BIGNUMERIC(38,0) NOT NULL,
dwh_created DATETIME NOT NULL
);