CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_ref_country_desc (country_id, language_id, country_desc, load_id) AS
SELECT country_id,
 language_id,
 country_desc,
 load_id
FROM ldl_p_lew_core.t_wawi_ref_country_desc;