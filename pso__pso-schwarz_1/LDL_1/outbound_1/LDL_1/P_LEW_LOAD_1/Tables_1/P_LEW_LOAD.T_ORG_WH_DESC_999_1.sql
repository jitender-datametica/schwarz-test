CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_org_wh_desc_999_1 (
client_id BIGNUMERIC(38,0),
wh_loc_sid BIGNUMERIC(38,0),
wh_desc STRING(50) COLLATE 'und:ci',
language_id BIGNUMERIC(38,0),
load_id BIGNUMERIC(38,0)
) OPTIONS(description='Gesellschaften Bezeichnung - WORKTABLE 999');