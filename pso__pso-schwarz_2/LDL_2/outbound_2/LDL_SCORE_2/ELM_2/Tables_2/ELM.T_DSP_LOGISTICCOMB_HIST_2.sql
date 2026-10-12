CREATE TABLE IF NOT EXISTS ldl_score_elm.t_dsp_logisticcomb_hist_2 (
dispoid BIGNUMERIC(38,0) NOT NULL,
logisticcombid BIGNUMERIC(38,0) NOT NULL,
logistictypeid BIGNUMERIC(38,0),
logisticsubid1 BIGNUMERIC(38,0),
minorderval1 BIGNUMERIC(38,0),
logisticsubid2 BIGNUMERIC(38,0),
minorderval2 BIGNUMERIC(38,0),
minorderval BIGNUMERIC(38,0),
transverseload BIGNUMERIC(38,0),
changedate DATE,
changeuser BIGNUMERIC(38,0),
source_extraction_tmsp ARRAY < STRING >,
tech_valid_from TIMESTAMP NOT NULL,
tech_valid_to TIMESTAMP NOT NULL,
snflk_insert_tmsp TIMESTAMP NOT NULL,
snflk_update_tmsp TIMESTAMP NOT NULL,
PRIMARY KEY (dispoid, logisticcombid) NOT ENFORCED
);