CREATE TABLE IF NOT EXISTS ldl_score_cargo.t_transportmitteltyp_hist_1 (
transportmitteltyp_rowid STRING(2000),
transportmitteltyp_lastmoddate TIMESTAMP,
transportmitteltyp_id_extern BIGNUMERIC(38,5),
transportmitteltyp_bezeichnung STRING(2000),
source_extraction_tmsp ARRAY < STRING >,
tech_valid_from TIMESTAMP NOT NULL,
tech_valid_to TIMESTAMP NOT NULL,
snflk_insert_tmsp TIMESTAMP NOT NULL,
snflk_update_tmsp TIMESTAMP NOT NULL
);