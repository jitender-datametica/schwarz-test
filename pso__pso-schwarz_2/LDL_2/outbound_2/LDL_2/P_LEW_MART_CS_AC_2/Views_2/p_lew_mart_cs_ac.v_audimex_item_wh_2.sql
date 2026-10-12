CREATE OR REPLACE VIEW ldl_p_lew_mart_cs_ac.v_audimex_item_wh_2 (client_id, country_iso_cd, wh_id, orig_item_nr, case_size
, item_status_id, cs_updated, cs_created, cs_load_id) AS SELECT *
FROM ldl_p_lew_mart_cs.v_audimex_item_wh_2;