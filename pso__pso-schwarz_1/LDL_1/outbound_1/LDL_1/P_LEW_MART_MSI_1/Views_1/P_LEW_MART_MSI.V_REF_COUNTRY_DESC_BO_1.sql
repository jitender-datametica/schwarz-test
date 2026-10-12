CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_ref_country_desc_bo_1 AS SELECT country_id,
 language_id,
 country_desc
FROM ldl_p_lew_core_ac.v_wawi_ref_country_desc_1 AS A;