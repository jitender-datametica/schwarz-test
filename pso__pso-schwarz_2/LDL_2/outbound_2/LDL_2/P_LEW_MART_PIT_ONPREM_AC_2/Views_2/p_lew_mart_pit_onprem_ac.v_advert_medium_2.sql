CREATE OR REPLACE VIEW ldl_p_lew_mart_pit_onprem_ac.v_advert_medium_2 AS SELECT client_id,
 adv_medium_sid,
 adv_medium_descr,
 adv_medium_sort_val,
 dwh_created
FROM ldl_p_lew_mart_pit_onprem.t_advert_medium_2;