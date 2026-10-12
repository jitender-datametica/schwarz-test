CREATE TABLE IF NOT EXISTS ldl_score_elm.t_prg_holidaylocationtext_hist_2 (
holidayid BIGNUMERIC(38,0) NOT NULL,
supplierlocationid BIGNUMERIC(38,0) NOT NULL,
deliverytypid BIGNUMERIC(38,0),
deliverycomment STRING(250),
source_extraction_tmsp ARRAY < STRING >,
tech_valid_from TIMESTAMP NOT NULL,
tech_valid_to TIMESTAMP NOT NULL,
snflk_insert_tmsp TIMESTAMP NOT NULL,
snflk_update_tmsp TIMESTAMP NOT NULL,
PRIMARY KEY (holidayid, supplierlocationid) NOT ENFORCED
);