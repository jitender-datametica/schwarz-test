CREATE OR REPLACE VIEW ldl_p_lew_mart_pit_onprem_ac.v_pit_apt_advert_medium_client_2 (client_id, advert_medium_sid,
anl_advert_medium_sid, advert_medium, advert_medium_sort_val, advert_medium_group_sid, advert_medium_group,
advert_medium_group_sort_val, advert_medium_ignore_fg, advert_medium_delete_fg, deleted_fg, dwh_created) AS SELECT
 client_id,
 advert_medium_sid,
 anl_advert_medium_sid AS advert_medium_sid0,
 advert_medium,
 advert_medium_sort_val,
 advert_medium_group_sid,
 advert_medium_group,
 advert_medium_group_sort_val,
 advert_medium_ignore_fg,
 advert_medium_delete_fg,
 deleted_fg,
 dwh_created
FROM ldl_p_lew_mart_pit_onprem.t_pit_apt_advert_medium_client_2 AS APT;