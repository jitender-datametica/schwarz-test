CREATE TABLE IF NOT EXISTS ldl_p_lew_process_mstr.t_ref_meas (
meas_id BIGNUMERIC(38,0) NOT NULL,
meas_desc STRING(250) COLLATE 'und:ci',
meas_type_id BIGNUMERIC(38,0) NOT NULL,
meas_grp_id BIGNUMERIC(38,0) NOT NULL,
curr_meas_fg BIGNUMERIC(38,0) NOT NULL,
mstr_mtrc_guid STRING(32) COLLATE 'und:ci' NOT NULL,
meas_fmt_id BIGNUMERIC(38,0) NOT NULL,
unit_text_id BIGNUMERIC(38,0) NOT NULL,
tot_fl BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
avg_fl BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
deleted_fg BIGNUMERIC(38,0) NOT NULL,
dwh_valid_from DATE NOT NULL,
dwh_valid_to DATE NOT NULL,
dwh_load_id BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL
);