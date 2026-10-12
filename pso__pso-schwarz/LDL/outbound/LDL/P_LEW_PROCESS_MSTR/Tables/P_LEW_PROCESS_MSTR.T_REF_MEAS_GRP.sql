CREATE TABLE IF NOT EXISTS ldl_p_lew_process_mstr.t_ref_meas_grp (
meas_grp_id BIGNUMERIC(38,0) NOT NULL,
meas_grp_desc STRING(250) COLLATE 'und:ci' NOT NULL,
img_meas_url_link STRING(250) COLLATE 'und:ci' NOT NULL,
meas_grp_text_id BIGNUMERIC(38,0) NOT NULL,
deleted_fg BIGNUMERIC(38,0) NOT NULL,
dwh_valid_from DATE NOT NULL,
dwh_valid_to DATE NOT NULL,
dwh_load_id BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL
);