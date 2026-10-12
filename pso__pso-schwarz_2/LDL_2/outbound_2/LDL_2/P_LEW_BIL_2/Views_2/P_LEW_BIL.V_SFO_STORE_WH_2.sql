CREATE OR REPLACE VIEW ldl_p_lew_bil.v_sfo_store_wh_2 AS SELECT client_id,
 loc_sid_store,
 loc_sid_wh_aspect1_asis,
 loc_sid_wh_aspect2_asis,
 loc_sid_wh_asis
FROM ldl_p_lew_bil.t_agg_store_day_item_sfo_2 AS A
GROUP BY client_id,
 loc_sid_store,
 loc_sid_wh_aspect1_asis,
 loc_sid_wh_aspect2_asis,
 loc_sid_wh_asis;