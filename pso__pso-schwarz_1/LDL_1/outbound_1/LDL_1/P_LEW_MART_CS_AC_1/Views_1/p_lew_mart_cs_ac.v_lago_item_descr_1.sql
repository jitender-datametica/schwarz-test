CREATE OR REPLACE VIEW ldl_p_lew_mart_cs_ac.v_lago_item_descr_1 (client_id, item_id, orig_item_nr, item_descr, language_id
, valid_from, valid_until, cs_updated, cs_created, cs_load_id) AS SELECT *
FROM ldl_p_lew_mart_cs.v_lago_item_descr_1 AS A;