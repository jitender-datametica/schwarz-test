CREATE TABLE IF NOT EXISTS ldl_score_elm.t_dsp_logisticroute_hist (
dispoid BIGNUMERIC(38,0) NOT NULL,
logisticrouteid BIGNUMERIC(38,0) NOT NULL,
logisticcategoryid BIGNUMERIC(38,0),
locationgroupid BIGNUMERIC(38,0),
supplierid BIGNUMERIC(38,0),
supplierlocationid BIGNUMERIC(38,0),
logisticroutedesc STRING(250),
changedate DATE,
changeuser BIGNUMERIC(38,0),
source_extraction_tmsp ARRAY < STRING >,
tech_valid_from TIMESTAMP NOT NULL,
tech_valid_to TIMESTAMP NOT NULL,
snflk_insert_tmsp TIMESTAMP NOT NULL,
snflk_update_tmsp TIMESTAMP NOT NULL,
PRIMARY KEY (dispoid, logisticrouteid) NOT ENFORCED
);