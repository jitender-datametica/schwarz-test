CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_wawi_ref_load_status_kpi_asis (
kpi_id BIGNUMERIC(38,0) NOT NULL,
kpi_group_id BIGNUMERIC(38,0) NOT NULL,
kpi_desc STRING(60) COLLATE 'und:ci' NOT NULL,
kpi_short_desc STRING(30) COLLATE 'und:ci' NOT NULL,
kpi_level_cd BIGNUMERIC(38,0) NOT NULL,
kpi_source_id BIGNUMERIC(38,0) NOT NULL,
kpi_sort_rank BIGNUMERIC(38,0) NOT NULL,
language_id BIGNUMERIC(38,0) NOT NULL,
mod_tmsp DATETIME NOT NULL
);