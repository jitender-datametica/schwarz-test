CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_lead.t_client_prog_hist (
client_id BIGNUMERIC(38,0) NOT NULL,
prog_sid BIGNUMERIC(38,0) NOT NULL,
prog_start_tmsp DATETIME NOT NULL,
prog_end_tmsp DATETIME NOT NULL,
full_client_start_tmsp DATETIME NOT NULL,
full_client_end_tmsp DATETIME NOT NULL,
client_repo_start_tmsp DATETIME NOT NULL,
load_id BIGNUMERIC(38,0) NOT NULL,
dwh_inserted DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL
);