CREATE OR REPLACE VIEW ldl_p_lew_mart_pit_onprem_ac.v_advert_medium_hist_2 AS SELECT client_id,
 adv_medium_sid,
 adv_medium_grp_sid,
 adv_medium_ignore_fg,
 adv_medium_delete_fg,
 dwh_valid_from,
 dwh_valid_to,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_mart_pit_onprem.t_advert_medium_hist_2;