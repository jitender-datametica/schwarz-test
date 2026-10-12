CREATE OR REPLACE VIEW ldl_p_lew_mart_cs_ac.v_lago_supp_item_wh (client_id, country_iso_cd, wh_id, supplier_id, item_id
, valid_from, valid_until, cs_updated, cs_created, cs_load_id) AS SELECT *
FROM ldl_p_lew_mart_cs.v_lago_supp_item_wh;