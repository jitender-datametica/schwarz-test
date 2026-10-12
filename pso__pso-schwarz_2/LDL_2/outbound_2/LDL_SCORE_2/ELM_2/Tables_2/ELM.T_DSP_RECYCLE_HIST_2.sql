CREATE TABLE IF NOT EXISTS ldl_score_elm.t_dsp_recycle_hist_2 (
dispoid BIGNUMERIC(38,0) NOT NULL,
oldid BIGNUMERIC(38,0) NOT NULL,
source_extraction_tmsp ARRAY < STRING >,
tech_valid_from TIMESTAMP NOT NULL,
tech_valid_to TIMESTAMP NOT NULL,
snflk_insert_tmsp TIMESTAMP NOT NULL,
snflk_update_tmsp TIMESTAMP NOT NULL,
PRIMARY KEY (dispoid, oldid) NOT ENFORCED
);