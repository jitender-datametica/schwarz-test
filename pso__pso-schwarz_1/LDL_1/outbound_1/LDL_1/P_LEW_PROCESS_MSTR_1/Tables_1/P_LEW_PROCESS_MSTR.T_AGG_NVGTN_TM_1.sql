CREATE TABLE IF NOT EXISTS ldl_p_lew_process_mstr.t_agg_nvgtn_tm_1 (
cy_month BIGNUMERIC(38,0) NOT NULL,
cy_week BIGNUMERIC(38,0) NOT NULL,
byr BIGNUMERIC(38,0) NOT NULL,
tm_lvl_id BIGNUMERIC(38,0) NOT NULL,
tm_ele_link STRING(2000) NOT NULL,
tm_brdcrum STRING(255) NOT NULL,
load_id BIGNUMERIC(38,0) NOT NULL,
dwh_inserted DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL
);