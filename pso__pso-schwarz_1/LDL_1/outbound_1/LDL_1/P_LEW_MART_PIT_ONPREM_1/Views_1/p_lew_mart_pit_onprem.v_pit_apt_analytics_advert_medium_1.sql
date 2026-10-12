CREATE OR REPLACE VIEW ldl_p_lew_mart_pit_onprem.v_pit_apt_analytics_advert_medium_1 (client_id, anl_advert_medium_sid,
advert_medium, advert_medium_sort_val, advert_medium_group_sid, advert_medium_group, advert_medium_group_sort_val,
advert_medium_ignore_fg, advert_medium_delete_fg) AS SELECT MED.client_id,
 MED.adv_medium_sid AS anl_advert_medium_sid,
 COALESCE(MED.adv_medium_descr, 'Sonstige') AS advert_medium,
 MED.adv_medium_sort_val AS advert_medium_sort_val,
 MEDHIST.adv_medium_grp_sid AS advert_medium_group_sid,
 MEDGROUP.adv_medium_grp_descr AS advert_medium_group,
 MEDGROUP.adv_medium_grp_sort_val AS advert_medium_group_sort_val,
 MEDHIST.adv_medium_ignore_fg AS advert_medium_ignore_fg,
 MEDHIST.adv_medium_delete_fg AS advert_medium_delete_fg
FROM ldl_p_lew_mart_pit_onprem.t_advert_medium_1 AS MED
 INNER JOIN ldl_p_lew_mart_pit_onprem.t_advert_medium_hist_1 AS MEDHIST ON MED.client_id = MEDHIST.client_id AND MED.adv_medium_sid
     = MEDHIST.adv_medium_sid AND CURRENT_DATE BETWEEN MEDHIST.dwh_valid_from AND MEDHIST.dwh_valid_to
 INNER JOIN ldl_p_lew_mart_pit_onprem.t_advert_medium_group_1 AS MEDGROUP ON MEDHIST.client_id = MEDGROUP.client_id AND
   MEDHIST.adv_medium_grp_sid = MEDGROUP.adv_medium_grp_sid;