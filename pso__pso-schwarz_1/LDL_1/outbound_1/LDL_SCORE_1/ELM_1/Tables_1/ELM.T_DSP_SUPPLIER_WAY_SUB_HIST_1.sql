CREATE TABLE IF NOT EXISTS ldl_score_elm.t_dsp_supplier_way_sub_hist_1 (
dispoid BIGNUMERIC(38,0) NOT NULL,
suppliercargowayid BIGNUMERIC(38,0) NOT NULL,
logisticsubid BIGNUMERIC(38,0),
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