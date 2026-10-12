CREATE TABLE IF NOT EXISTS ldl_score_etl_process.t_supplierlocation_lkp_hist_1 (
supplierlocationid_in BIGNUMERIC(38,0) NOT NULL,
supplierlocationdesc_in STRING(100),
supplierlocationid_out BIGNUMERIC(38,0),
supplierlocationdesc_out STRING(100),
source_extraction_tmsp ARRAY < STRING >,
tech_valid_from TIMESTAMP NOT NULL,
tech_valid_to TIMESTAMP NOT NULL,
snflk_insert_tmsp TIMESTAMP NOT NULL,
snflk_update_tmsp TIMESTAMP NOT NULL,
PRIMARY KEY (supplierlocationid_in) NOT ENFORCED
);