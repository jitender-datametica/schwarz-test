CREATE TABLE IF NOT EXISTS ldl_p_lew_process_mstr.t_ref_org_lvl_meas_div (
meas_id BIGNUMERIC(38,0) NOT NULL,
curr_tot_id BIGNUMERIC(38,0),
currency_iso_cd STRING(3) COLLATE 'und:ci' NOT NULL,
divsr NUMERIC(18,5) NOT NULL,
org_lvl_id_from BIGNUMERIC(38,0) NOT NULL,
org_lvl_id_to BIGNUMERIC(38,0) NOT NULL,
unit_text_id BIGNUMERIC(38,0) NOT NULL,
deleted_fg BIGNUMERIC(38,0) NOT NULL,
dwh_valid_from DATE NOT NULL,
dwh_valid_to DATE NOT NULL,
dwh_load_id BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL
);