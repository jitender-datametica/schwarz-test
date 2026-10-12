CREATE TABLE IF NOT EXISTS ldl_score_cargo.t_fahrzeugart_hist_1 (
fahrzeugart_rowid STRING(2000),
fahrzeugart_lastmoddate TIMESTAMP,
fahrzeugart_id_extern BIGNUMERIC(38,5),
fahrzeugart_bezeichnung STRING(2000),
fahrzeugart_transportmitteltyp_rowid STRING(2000),
fahrzeugart_anz_pal BIGNUMERIC(38,5),
fahrzeugart_equipment_rowid STRING(2000),
fahrzeugart_ladekapazitaet_epstpl_trm BIGNUMERIC(38,5),
source_extraction_tmsp ARRAY < STRING >,
tech_valid_from TIMESTAMP NOT NULL,
tech_valid_to TIMESTAMP NOT NULL,
snflk_insert_tmsp TIMESTAMP NOT NULL,
snflk_update_tmsp TIMESTAMP NOT NULL
);