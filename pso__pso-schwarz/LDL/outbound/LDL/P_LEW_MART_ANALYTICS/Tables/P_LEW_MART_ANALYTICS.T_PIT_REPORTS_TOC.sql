CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_analytics.t_pit_reports_toc (
report_id BIGNUMERIC(38,0) NOT NULL,
dwh_valid_from DATE NOT NULL,
dwh_valid_to DATE NOT NULL,
report_sorting_val BIGNUMERIC(38,0) NOT NULL,
report_name STRING(500) COLLATE 'und:ci',
report_guid STRING(50) COLLATE 'und:ci' NOT NULL,
report_annotation STRING(500) COLLATE 'und:ci',
report_visible_fg BIGNUMERIC(38,0) NOT NULL,
report_teaser_fg BIGNUMERIC(38,0) NOT NULL,
report_type_fg BIGNUMERIC(38,0) NOT NULL,
report_panel_name STRING(50) COLLATE 'und:ci',
report_panel_pskey STRING(50) COLLATE 'und:ci',
report_panel_pkey STRING(50) COLLATE 'und:ci'
);