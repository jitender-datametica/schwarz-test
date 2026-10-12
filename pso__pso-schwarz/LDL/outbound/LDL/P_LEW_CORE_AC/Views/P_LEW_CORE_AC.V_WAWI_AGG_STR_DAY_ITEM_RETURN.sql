CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_agg_str_day_item_return (client_id, st_loc_sid, item_sid, dat_formdate,
return_receipttype_id, return_reason_cd_ejr_sfo, qty_return_ejr_sfo, val_return_ejr_sfo, val_return_net_ejr_sfo,
timestamp_mod) AS SELECT client_id,
 st_loc_sid,
 item_sid,
 dat_formdate,
 return_receipttype_id,
 return_reason_cd_ejr_sfo,
 qty_return_ejr_sfo,
 val_return_ejr_sfo,
 val_return_net_ejr_sfo,
 timestamp_mod
FROM ldl_p_lew_core.t_wawi_agg_str_day_item_return;