CREATE TABLE IF NOT EXISTS ldl_score_elm.t_prg_supplocshortdesc_hist (
supplierlocationid BIGNUMERIC(38,0) NOT NULL,
supplocshortdesc STRING(250),
source_extraction_tmsp ARRAY < STRING >,
tech_valid_from TIMESTAMP NOT NULL,
tech_valid_to TIMESTAMP NOT NULL,
snflk_insert_tmsp TIMESTAMP NOT NULL,
snflk_update_tmsp TIMESTAMP NOT NULL,
PRIMARY KEY (supplierlocationid) NOT ENFORCED
);