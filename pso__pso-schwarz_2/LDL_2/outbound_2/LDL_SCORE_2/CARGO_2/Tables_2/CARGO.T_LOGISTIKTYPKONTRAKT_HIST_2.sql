CREATE TABLE IF NOT EXISTS ldl_score_cargo.t_logistiktypkontrakt_hist_2 (
logistiktypkontrakt_rowid STRING(2000),
logistiktypkontrakt_lastmoddate TIMESTAMP,
logistiktypkontrakt_id_extern BIGNUMERIC(38,5),
logistiktypkontrakt_code STRING(2000),
logistiktypkontrakt_sortierung BIGNUMERIC(38,5),
logistiktypkontrakt_bezeichnung STRING(2000),
logistiktypkontrakt_logistiktyp_rowid STRING(2000),
logistiktypkontrakt_transporttyp_rowid STRING(2000),
source_extraction_tmsp ARRAY < STRING >,
tech_valid_from TIMESTAMP NOT NULL,
tech_valid_to TIMESTAMP NOT NULL,
snflk_insert_tmsp TIMESTAMP NOT NULL,
snflk_update_tmsp TIMESTAMP NOT NULL
);