CREATE TABLE IF NOT EXISTS ldl_score_elm.t_dsp_return_reason_hist (
dispoid BIGNUMERIC(38,0) NOT NULL,
reasonid BIGNUMERIC(38,0) NOT NULL,
reasondesc STRING(250),
visibleflag BIGNUMERIC(38,0),
groupid BIGNUMERIC(38,0),
changedate DATE,
changeuser BIGNUMERIC(38,0),
source_extraction_tmsp ARRAY < STRING >,
tech_valid_from TIMESTAMP NOT NULL,
tech_valid_to TIMESTAMP NOT NULL,
snflk_insert_tmsp TIMESTAMP NOT NULL,
snflk_update_tmsp TIMESTAMP NOT NULL,
PRIMARY KEY (dispoid, reasonid) NOT ENFORCED
);