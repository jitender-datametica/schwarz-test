CREATE OR REPLACE VIEW ldl_p_lew_mart_pit_onprem_ac.v_pit_item_elwis_list_type_store_day_1 (client_id, store_sid,
dwh_cal_dt, item_sid, permissive_fg, list_type_mark, list_type_label, deleted_fg) AS SELECT client_id,
 store_sid,
 dwh_cal_dt,
 item_sid,
 permissive_fg,
 list_type_mark,
 list_type_label,
 deleted_fg
FROM ldl_p_lew_mart_pit_onprem.t_pit_item_elwis_list_type_store_day_1 AS ELT;