CREATE TABLE IF NOT EXISTS ldl_p_lew_process_mstr.t_ref_meas_blk_rel_2 (
meas_id BIGNUMERIC(38,0) NOT NULL,
blk_id BIGNUMERIC(38,0) NOT NULL,
tot_meas_id BIGNUMERIC(38,0) NOT NULL,
hd_row_ind BIGNUMERIC(38,0) NOT NULL,
blk_meas_ord BIGNUMERIC(38,0) NOT NULL,
blk_meas_titl_text_id BIGNUMERIC(38,0) NOT NULL,
blk_meas_titl2_text_id BIGNUMERIC(38,0) NOT NULL,
deleted_fg BIGNUMERIC(38,0) NOT NULL,
dwh_valid_from DATE NOT NULL,
dwh_valid_to DATE NOT NULL,
dwh_load_id BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL
);