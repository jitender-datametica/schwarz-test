CREATE TABLE IF NOT EXISTS ldl_score_elm.t_dsp_return_date_hist (
returnid BIGNUMERIC(38,0) NOT NULL,
returndate DATE NOT NULL,
imported BIGNUMERIC(38,0),
total BIGNUMERIC(38,0),
source_extraction_tmsp ARRAY < STRING >,
tech_valid_from TIMESTAMP NOT NULL,
tech_valid_to TIMESTAMP NOT NULL,
snflk_insert_tmsp TIMESTAMP NOT NULL,
snflk_update_tmsp TIMESTAMP NOT NULL,
PRIMARY KEY (returnid, returndate) NOT ENFORCED
);