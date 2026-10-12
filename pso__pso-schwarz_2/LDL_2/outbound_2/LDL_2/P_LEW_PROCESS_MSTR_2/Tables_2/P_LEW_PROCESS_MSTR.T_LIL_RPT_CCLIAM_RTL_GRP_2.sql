CREATE TABLE IF NOT EXISTS ldl_p_lew_process_mstr.t_lil_rpt_ccliam_rtl_grp_2 (
ccliam_rtl_grp_id BIGNUMERIC(38,0) NOT NULL,
ccliam_rtl_grp_desc STRING(800) NOT NULL,
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created TIMESTAMP NOT NULL,
dwh_updated TIMESTAMP NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);