CREATE TABLE IF NOT EXISTS ldl_p_lew_process_mstr.t_lil_retailer_group_change_1 (
retailer_group_change_id BIGNUMERIC(38,0) NOT NULL,
src_retailer_grp_cd STRING(100),
src_retailer_chld_cd STRING(100),
src_retailer_chg_cd STRING(100),
active_fg BIGNUMERIC(38,0),
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL
);