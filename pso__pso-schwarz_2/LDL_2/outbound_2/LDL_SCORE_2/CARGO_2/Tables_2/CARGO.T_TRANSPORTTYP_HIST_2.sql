CREATE TABLE IF NOT EXISTS ldl_score_cargo.t_transporttyp_hist_2 (
transporttyp_rowid STRING(2000),
transporttyp_lastmoddate TIMESTAMP,
transporttyp_id_extern BIGNUMERIC(38,5),
transporttyp_code STRING(2000),
transporttyp_sortierung BIGNUMERIC(38,5),
transporttyp_bezeichnung STRING(2000),
source_extraction_tmsp ARRAY < STRING >,
tech_valid_from TIMESTAMP NOT NULL,
tech_valid_to TIMESTAMP NOT NULL,
snflk_insert_tmsp TIMESTAMP NOT NULL,
snflk_update_tmsp TIMESTAMP NOT NULL
);