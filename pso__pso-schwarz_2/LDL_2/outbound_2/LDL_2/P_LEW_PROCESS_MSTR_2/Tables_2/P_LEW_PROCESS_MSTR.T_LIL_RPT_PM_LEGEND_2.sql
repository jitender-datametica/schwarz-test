CREATE TABLE IF NOT EXISTS ldl_p_lew_process_mstr.t_lil_rpt_pm_legend_2 (
legend_id BIGNUMERIC(38,0),
rate_coverage BIGNUMERIC(38,0),
desc_coverage STRING(160),
rate_trend BIGNUMERIC(38,0),
desc_trend STRING(160),
rate_direction BIGNUMERIC(38,0),
desc_direction STRING(160),
rate_trend_dev BIGNUMERIC(38,0),
desc_trend_dev STRING(200),
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created TIMESTAMP NOT NULL,
dwh_updated TIMESTAMP NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);