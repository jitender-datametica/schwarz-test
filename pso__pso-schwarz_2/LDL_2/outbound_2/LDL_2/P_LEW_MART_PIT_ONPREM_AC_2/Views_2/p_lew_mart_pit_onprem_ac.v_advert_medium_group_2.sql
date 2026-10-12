CREATE OR REPLACE VIEW ldl_p_lew_mart_pit_onprem_ac.v_advert_medium_group_2 AS SELECT client_id,
 adv_medium_grp_sid,
 adv_medium_grp_descr,
 adv_medium_grp_sort_val,
 adv_medium_grp_ignore_fg,
 adv_medium_grp_alw_vis_fg,
 dwh_created
FROM ldl_p_lew_mart_pit_onprem.t_advert_medium_group_2;