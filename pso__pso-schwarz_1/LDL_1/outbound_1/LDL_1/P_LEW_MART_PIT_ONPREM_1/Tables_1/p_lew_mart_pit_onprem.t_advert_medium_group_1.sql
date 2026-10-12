CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_pit_onprem.t_advert_medium_group_1 (
client_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL,
adv_medium_grp_sid BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL,
adv_medium_grp_descr STRING(16777216) COLLATE 'und:ci' DEFAULT 'N/A' NOT NULL,
adv_medium_grp_sort_val BIGNUMERIC(38,0) DEFAULT 99 NOT NULL,
adv_medium_grp_ignore_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
adv_medium_grp_alw_vis_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
dwh_created DATETIME DEFAULT CAST(CURRENT_TIMESTAMP() AS DATETIME) NOT NULL,
PRIMARY KEY (client_id, adv_medium_grp_sid) NOT ENFORCED
);