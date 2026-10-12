CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_lead.t_ref_prog_2 (
prog_sid BIGNUMERIC(38,0) NOT NULL,
prog_name STRING(100) COLLATE 'und:ci' NOT NULL,
prog_desc STRING(1000) COLLATE 'und:ci' NOT NULL,
prog_start_tmsp DATETIME NOT NULL,
prog_end_tmsp DATETIME NOT NULL,
load_id BIGNUMERIC(38,0) NOT NULL,
dwh_inserted DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL
);