CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_analytics.t_pit_advert_medium_grp_map_input (
client_id BIGNUMERIC(38,0) NOT NULL,
advert_medium_descr STRING(100) COLLATE 'und:ci',
adv_medium_disp_order_nbr BIGNUMERIC(38,0) DEFAULT - 1,
adv_medium_ignore_fg BIGNUMERIC(38,0) DEFAULT 0,
adv_medium_delete_fg BIGNUMERIC(38,0) DEFAULT 0,
adv_medium_grp_lidlplus_fg BIGNUMERIC(38,0) DEFAULT 0,
advert_medium_grp_descr STRING(100) COLLATE 'und:ci',
adv_medium_grp_disp_order_nbr BIGNUMERIC(38,0) DEFAULT - 1,
dwh_created DATETIME DEFAULT CAST(CURRENT_TIMESTAMP() AS DATETIME) NOT NULL
);