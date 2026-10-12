CREATE TABLE IF NOT EXISTS ldl_score_elm.t_prg_holiday_hist (
importid BIGNUMERIC(38,0) NOT NULL,
importdate DATE,
importuser BIGNUMERIC(38,0),
holidayyear BIGNUMERIC(38,0),
source_extraction_tmsp ARRAY < STRING >,
tech_valid_from TIMESTAMP NOT NULL,
tech_valid_to TIMESTAMP NOT NULL,
snflk_insert_tmsp TIMESTAMP NOT NULL,
snflk_update_tmsp TIMESTAMP NOT NULL,
PRIMARY KEY (importid) NOT ENFORCED
);