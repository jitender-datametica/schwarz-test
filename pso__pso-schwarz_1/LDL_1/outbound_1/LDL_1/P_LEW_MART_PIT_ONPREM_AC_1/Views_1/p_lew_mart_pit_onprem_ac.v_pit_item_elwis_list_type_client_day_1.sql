CREATE OR REPLACE VIEW ldl_p_lew_mart_pit_onprem_ac.v_pit_item_elwis_list_type_client_day_1 (client_id, dwh_cal_dt,
item_sid, list_type_mark, list_type_label) AS SELECT client_id,
 dwh_cal_dt,
 item_sid,
 list_type_mark,
 list_type_label
FROM ldl_p_lew_mart_pit_onprem.t_pit_item_elwis_list_type_client_day_1 AS ELT;