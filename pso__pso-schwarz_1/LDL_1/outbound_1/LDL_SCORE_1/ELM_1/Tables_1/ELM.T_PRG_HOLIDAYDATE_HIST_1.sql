CREATE TABLE IF NOT EXISTS ldl_score_elm.t_prg_holidaydate_hist_1 (
importid BIGNUMERIC(38,0),
holidayid BIGNUMERIC(38,0) NOT NULL,
holidaydate DATE,
holidaydesc STRING(250),
source_extraction_tmsp ARRAY < STRING >,
tech_valid_from TIMESTAMP NOT NULL,
tech_valid_to TIMESTAMP NOT NULL,
snflk_insert_tmsp TIMESTAMP NOT NULL,
snflk_update_tmsp TIMESTAMP NOT NULL,
PRIMARY KEY (holidayid) NOT ENFORCED
);