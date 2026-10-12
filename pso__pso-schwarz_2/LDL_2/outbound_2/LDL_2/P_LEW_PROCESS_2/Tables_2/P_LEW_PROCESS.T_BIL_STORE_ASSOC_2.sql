CREATE TABLE IF NOT EXISTS ldl_p_lew_process.t_bil_store_assoc_2 (
client_id BIGNUMERIC(38,0) NOT NULL,
move_to_loc_sid BIGNUMERIC(38,0) NOT NULL,
move_from_loc_sid BIGNUMERIC(38,0) NOT NULL,
main_store_sid BIGNUMERIC(38,0) NOT NULL,
opening_dt DATE,
move_fg BIGNUMERIC(38,0),
reloc_level BIGNUMERIC(38,0),
reloc_path_rev STRING(100) COLLATE 'und:ci'
);