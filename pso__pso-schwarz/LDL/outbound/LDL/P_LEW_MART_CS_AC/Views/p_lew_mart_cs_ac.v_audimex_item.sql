CREATE OR REPLACE VIEW ldl_p_lew_mart_cs_ac.v_audimex_item (client_id, country_iso_cd, orig_item_nr, item_descr, plu_nr
, subitemgroup_id, descr_short, ag_reserve, cs_updated, cs_created, cs_load_id) AS SELECT *
FROM ldl_p_lew_mart_cs.v_audimex_item;