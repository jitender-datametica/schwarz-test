CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_wawi_org_all_store_reloc_act_1 (
move_to_st_loc_sid BIGNUMERIC(38,0) NOT NULL,
st_loc_sid BIGNUMERIC(38,0) NOT NULL,
store_desc STRING(50) COLLATE 'und:ci',
client_id BIGNUMERIC(38,0) NOT NULL,
orig_store_nr BIGNUMERIC(38,0) NOT NULL,
move_fg BIGNUMERIC(38,0) NOT NULL
);