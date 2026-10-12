CREATE TABLE IF NOT EXISTS ldl_score_cargo.t_palettentyp_hist (
palettentyp_rowid STRING(2000),
palettentyp_lastmoddate TIMESTAMP,
palettentyp_id_extern BIGNUMERIC(38,5),
palettentyp_code STRING(2000),
palettentyp_faktor BIGNUMERIC(38,5),
source_extraction_tmsp ARRAY < STRING >,
tech_valid_from TIMESTAMP NOT NULL,
tech_valid_to TIMESTAMP NOT NULL,
snflk_insert_tmsp TIMESTAMP NOT NULL,
snflk_update_tmsp TIMESTAMP NOT NULL
);