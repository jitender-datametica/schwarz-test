CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_ref_country_group_2 (country_group_id, country_group_desc, load_id) AS
SELECT country_group_id,
 country_group_desc,
 load_id
FROM ldl_p_lew_core.t_wawi_ref_country_group_2;