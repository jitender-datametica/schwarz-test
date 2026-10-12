CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_ref_country_group (country_group_id, country_group_desc) AS SELECT
 country_group_id,
 country_group_desc
FROM ldl_p_lew_core_ac.v_wawi_ref_country_group;