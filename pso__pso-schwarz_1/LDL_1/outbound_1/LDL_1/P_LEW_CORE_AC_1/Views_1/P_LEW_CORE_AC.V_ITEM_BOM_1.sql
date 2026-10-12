CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_item_bom_1 (client_id, item_bom_sid, src_matnr, src_werks, src_stlnr, src_stlan
, src_stlal, item_sid, bom_alternative_cd_act, version_counter_act, active_from_dt_act, deleted_fg, dwh_load_id,
dwh_created, dwh_updated) AS SELECT client_id,
 item_bom_sid,
 src_matnr,
 src_werks,
 src_stlnr,
 src_stlan,
 src_stlal,
 item_sid,
 bom_alternative_cd_act,
 version_counter_act,
 active_from_dt_act,
 deleted_fg,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_item_bom_1;