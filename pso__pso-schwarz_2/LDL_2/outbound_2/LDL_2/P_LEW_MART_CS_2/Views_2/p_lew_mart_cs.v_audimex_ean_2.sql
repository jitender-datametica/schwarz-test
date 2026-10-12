CREATE OR REPLACE VIEW ldl_p_lew_mart_cs.v_audimex_ean_2 (client_id, country_iso_cd, orig_item_nr, case_size, ean_code,
cs_updated, cs_created, cs_load_id) AS SELECT client_id,
 country_iso_cd,
 orig_item_nr,
 case_size,
 ean_code,
 cs_updated,
 cs_created,
 cs_load_id
FROM ldl_p_lew_mart_cs.t_audimex_ean_2 AS EAN_2;