CREATE TABLE IF NOT EXISTS ldl_score_elm.t_prg_turnstile_capacity_hist_1 (
turnstileid BIGNUMERIC(38,0) NOT NULL,
logistictypeid BIGNUMERIC(38,0) NOT NULL,
capacity BIGNUMERIC(38,0),
reserve BIGNUMERIC(38,0),
source_extraction_tmsp ARRAY < STRING >,
tech_valid_from TIMESTAMP NOT NULL,
tech_valid_to TIMESTAMP NOT NULL,
snflk_insert_tmsp TIMESTAMP NOT NULL,
snflk_update_tmsp TIMESTAMP NOT NULL,
PRIMARY KEY (turnstileid, logistictypeid) NOT ENFORCED
);