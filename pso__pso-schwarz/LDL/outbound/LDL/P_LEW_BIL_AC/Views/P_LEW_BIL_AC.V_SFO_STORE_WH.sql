CREATE OR REPLACE VIEW ldl_p_lew_bil_ac.v_sfo_store_wh (client_id, loc_sid_store, loc_sid_wh_aspect1_asis,
loc_sid_wh_aspect2_asis, loc_sid_wh_asis) AS SELECT *
FROM ldl_p_lew_bil.v_sfo_store_wh;