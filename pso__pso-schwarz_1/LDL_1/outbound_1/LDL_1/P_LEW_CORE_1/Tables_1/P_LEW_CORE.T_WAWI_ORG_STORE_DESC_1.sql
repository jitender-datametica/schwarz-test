CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_wawi_org_store_desc_1 (
st_loc_sid BIGNUMERIC(38,0) NOT NULL,
client_id BIGNUMERIC(38,0) NOT NULL,
orig_store_nr BIGNUMERIC(38,0),
store_desc STRING(50) COLLATE 'und:ci',
load_id BIGNUMERIC(38,0) NOT NULL
);