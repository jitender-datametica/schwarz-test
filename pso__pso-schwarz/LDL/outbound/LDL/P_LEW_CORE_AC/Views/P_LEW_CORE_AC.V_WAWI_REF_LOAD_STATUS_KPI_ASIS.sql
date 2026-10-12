CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_ref_load_status_kpi_asis (kpi_id, kpi_group_id, kpi_desc, kpi_short_desc
, kpi_level_cd, kpi_source_id, kpi_sort_rank, language_id, mod_tmsp) AS SELECT kpi_id,
 kpi_group_id,
 kpi_desc,
 kpi_short_desc,
 kpi_level_cd,
 kpi_source_id,
 kpi_sort_rank,
 language_id,
 mod_tmsp
FROM ldl_p_lew_core.t_wawi_ref_load_status_kpi_asis;