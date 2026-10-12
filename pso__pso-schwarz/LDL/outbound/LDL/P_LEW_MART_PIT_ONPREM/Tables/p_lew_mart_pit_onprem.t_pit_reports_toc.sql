CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_pit_onprem.t_pit_reports_toc (
report_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL,
dwh_valid_from DATE DEFAULT DATE '1900-01-01' NOT NULL,
dwh_valid_to DATE DEFAULT DATE '9999-12-31' NOT NULL,
report_sorting_val BIGNUMERIC(38,0) DEFAULT 99 NOT NULL,
report_name STRING(16777216),
report_guid STRING(16777216) NOT NULL,
report_annotation STRING(16777216),
report_visible_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
report_teaser_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
report_type_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
report_panel_name STRING(16777216),
report_panel_pskey STRING(16777216),
report_panel_pkey STRING(16777216)
);