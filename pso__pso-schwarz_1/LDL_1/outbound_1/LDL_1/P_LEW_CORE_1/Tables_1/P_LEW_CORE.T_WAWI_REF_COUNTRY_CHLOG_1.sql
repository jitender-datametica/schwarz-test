CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_wawi_ref_country_chlog_1 (
country_id BIGNUMERIC(38,0) NOT NULL,
dashboard_relevant_fg BIGNUMERIC(38,0) NOT NULL,
requesting_user STRING(128) COLLATE 'und:ci' DEFAULT SESSION_USER() NOT NULL,
timestamp_request DATETIME DEFAULT CAST(CURRENT_TIMESTAMP() AS DATETIME) NOT NULL,
approval_fg BIGNUMERIC(38,0) NOT NULL,
approval_user STRING(128) COLLATE 'und:ci',
timestamp_approval DATETIME
);