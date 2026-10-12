CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_msi.t_msi_ejr_lp_approval_fg_desc (
approval_fg BIGNUMERIC(38,0) NOT NULL,
approval_fg_desc STRING(128) COLLATE 'und:ci' DEFAULT SESSION_USER() NOT NULL
);