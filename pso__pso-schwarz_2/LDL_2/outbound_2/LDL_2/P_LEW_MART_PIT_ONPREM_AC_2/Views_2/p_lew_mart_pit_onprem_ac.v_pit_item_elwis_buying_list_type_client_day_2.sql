CREATE OR REPLACE VIEW ldl_p_lew_mart_pit_onprem_ac.v_pit_item_elwis_buying_list_type_client_day_2 (client_id, dwh_cal_dt
, item_sid, list_type_mark, list_type_label, brand_sid, brand_type_mark, brand_type_label, buying_list_type_id,
buying_list_type_descr) AS SELECT client_id,
 dwh_cal_dt,
 item_sid,
 list_type_mark,
 list_type_label,
 brand_sid,
 brand_type_mark,
 brand_type_label,
 buying_list_type_id,
 buying_list_type_descr
FROM ldl_p_lew_mart_pit_onprem.t_pit_item_elwis_buying_list_type_client_day_2 AS BLT;