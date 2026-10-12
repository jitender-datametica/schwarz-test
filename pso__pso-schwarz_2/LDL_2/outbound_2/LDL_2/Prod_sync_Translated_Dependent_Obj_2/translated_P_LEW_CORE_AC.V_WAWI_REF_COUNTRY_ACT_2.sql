CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_ref_country_act_2 (int_id, country_id, country_iso_cd, cluster_id,
sorting_order, country_desc, language_id, dashboard_relevant_fg) AS SELECT *
FROM ldl_p_lew_core.t_wawi_ref_country_act_2;