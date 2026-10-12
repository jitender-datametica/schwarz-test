CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_ref_country (country_id, country_iso_cd, cluster_id, sorting_order,
dashboard_relevant_fg, load_id) AS SELECT country_id,
 country_iso_cd,
 cluster_id,
 sorting_order,
 dashboard_relevant_fg,
 load_id
FROM ldl_p_lew_core.t_wawi_ref_country;