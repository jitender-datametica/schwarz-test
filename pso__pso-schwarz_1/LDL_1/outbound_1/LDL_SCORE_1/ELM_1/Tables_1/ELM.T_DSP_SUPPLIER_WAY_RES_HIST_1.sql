CREATE TABLE IF NOT EXISTS ldl_score_elm.t_dsp_supplier_way_res_hist_1 (
dispoid BIGNUMERIC(38,0) NOT NULL,
suppliercargowayid BIGNUMERIC(38,0) NOT NULL,
transtypecapacityid BIGNUMERIC(38,0),
minorderval BIGNUMERIC(38,0),
minordertype BIGNUMERIC(38,0),
itemlight BIGNUMERIC(38,0),
elmstatus BIGNUMERIC(38,0),
changedate DATE,
changeuser BIGNUMERIC(38,0),
source_extraction_tmsp ARRAY < STRING >,
tech_valid_from TIMESTAMP NOT NULL,
tech_valid_to TIMESTAMP NOT NULL,
snflk_insert_tmsp TIMESTAMP NOT NULL,
snflk_update_tmsp TIMESTAMP NOT NULL,
PRIMARY KEY (dispoid, suppliercargowayid) NOT ENFORCED
);