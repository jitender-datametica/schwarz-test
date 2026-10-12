CREATE OR REPLACE VIEW ldl_p_lew_bil.v_aji_deliv_store_wh_1 AS SELECT client_id,
 loc_sid_store,
 loc_sid_wh_asis,
 loc_sid_wh_aspect1_asis,
 loc_sid_wh_aspect2_asis
FROM ldl_p_lew_bil.t_agg_deliv_base_1 AS A
GROUP BY client_id,
 loc_sid_store,
 loc_sid_wh_asis,
 loc_sid_wh_aspect1_asis,
 loc_sid_wh_aspect2_asis;