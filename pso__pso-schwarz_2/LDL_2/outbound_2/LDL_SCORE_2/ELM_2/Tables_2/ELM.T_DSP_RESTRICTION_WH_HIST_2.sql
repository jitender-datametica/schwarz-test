CREATE TABLE IF NOT EXISTS ldl_score_elm.t_dsp_restriction_wh_hist_2 (
dispoid BIGNUMERIC(38,0) NOT NULL,
restrictionid BIGNUMERIC(38,0) NOT NULL,
locationid BIGNUMERIC(38,0) NOT NULL,
elmstatus BIGNUMERIC(38,0),
changedate DATE,
changeuser BIGNUMERIC(38,0),
source_extraction_tmsp ARRAY < STRING >,
tech_valid_from TIMESTAMP NOT NULL,
tech_valid_to TIMESTAMP NOT NULL,
snflk_insert_tmsp TIMESTAMP NOT NULL,
snflk_update_tmsp TIMESTAMP NOT NULL,
PRIMARY KEY (dispoid, restrictionid, locationid) NOT ENFORCED
);