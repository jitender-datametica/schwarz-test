CREATE TABLE IF NOT EXISTS ldl_score_elm.t_prg_holidaydeliverytyp_hist (
deliverytypid BIGNUMERIC(38,0) NOT NULL,
deliverydesc STRING(250),
delivery BIGNUMERIC(38,0),
source_extraction_tmsp ARRAY < STRING >,
tech_valid_from TIMESTAMP NOT NULL,
tech_valid_to TIMESTAMP NOT NULL,
snflk_insert_tmsp TIMESTAMP NOT NULL,
snflk_update_tmsp TIMESTAMP NOT NULL,
PRIMARY KEY (deliverytypid) NOT ENFORCED
);