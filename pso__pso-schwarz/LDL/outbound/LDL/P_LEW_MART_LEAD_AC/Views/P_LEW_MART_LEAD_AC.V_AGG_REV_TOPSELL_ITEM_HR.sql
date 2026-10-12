CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_agg_rev_topsell_item_hr AS SELECT client_id,
 dat_formdate,
 item_sid,
 loc_sid_store_move_to,
 wh_loc_sid,
 wh_id,
 cy_week,
 currency_iso_cd,
 time_hour_id,
 qty_piece_ejr,
 qty_weight_ejr,
 qty_sold,
 val_retail_net_ejr
FROM ldl_p_lew_mart_lead.v_agg_rev_topsell_item_hr AS HRL;