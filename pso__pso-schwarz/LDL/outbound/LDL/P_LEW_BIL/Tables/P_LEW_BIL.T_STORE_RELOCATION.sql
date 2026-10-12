CREATE TABLE IF NOT EXISTS ldl_p_lew_bil.t_store_relocation (
client_id BIGNUMERIC(38,0),
loc_sid_store_move_to BIGNUMERIC(38,0),
loc_sid_store BIGNUMERIC(38,0),
loc_name STRING(100) COLLATE 'und:ci',
src_orig_store_nr BIGNUMERIC(38,0),
move_fg BIGNUMERIC(38,0)
);