CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_ref_country_group AS SELECT country_group_id,
 country_group_desc,
 1 AS int_id
FROM ldl_p_lew_core_ac.v_wawi_ref_country_group;