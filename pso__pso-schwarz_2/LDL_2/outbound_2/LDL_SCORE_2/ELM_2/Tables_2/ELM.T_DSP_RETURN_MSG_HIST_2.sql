CREATE TABLE IF NOT EXISTS ldl_score_elm.t_dsp_return_msg_hist_2 (
returnid BIGNUMERIC(38,0) NOT NULL,
daywhid BIGNUMERIC(38,0) NOT NULL,
locationid BIGNUMERIC(38,0) NOT NULL,
suppliercargowayid BIGNUMERIC(38,0) NOT NULL,
lorryno BIGNUMERIC(38,0) NOT NULL,
latestreturndate DATE,
shippingdate DATE,
importdate DATE,
importuser BIGNUMERIC(38,0),
reasonid BIGNUMERIC(38,0),
source_extraction_tmsp ARRAY < STRING >,
tech_valid_from TIMESTAMP NOT NULL,
tech_valid_to TIMESTAMP NOT NULL,
snflk_insert_tmsp TIMESTAMP NOT NULL,
snflk_update_tmsp TIMESTAMP NOT NULL,
PRIMARY KEY (returnid, daywhid, locationid, suppliercargowayid, lorryno) NOT ENFORCED
);