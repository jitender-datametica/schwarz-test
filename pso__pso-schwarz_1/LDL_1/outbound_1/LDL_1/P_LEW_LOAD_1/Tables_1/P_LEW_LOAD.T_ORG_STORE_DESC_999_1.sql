CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_org_store_desc_999_1 (
st_loc_sid BIGNUMERIC(38,0),
client_id BIGNUMERIC(38,0),
orig_store_nr BIGNUMERIC(38,0),
store_desc STRING(50) COLLATE 'und:ci',
load_id BIGNUMERIC(38,0)
) OPTIONS(description='Filiale Bezeichnung - WORKTABLE 999');