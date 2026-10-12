CREATE OR REPLACE VIEW ldl_p_lew_mart_cs_ac.v_lago_supplier_2 (client_id, country_iso_cd, orig_supplier_nr, supplier_id,
cs_updated, cs_created, cs_load_id) AS SELECT *
FROM ldl_p_lew_mart_cs.v_lago_supplier_2;