CREATE TABLE IF NOT EXISTS ldl_score_cargo.t_leistungsart_hist (
leistungsart_rowid STRING(2000),
leistungsart_lastmoddate TIMESTAMP,
leistungsart_klassifizierung_code STRING(2000),
leistungsart_klassifizierung_bezeichnung STRING(2000),
leistungsart_code STRING(2000),
leistungsart_bezeichnung STRING(2000),
leistungsart_beschreibung STRING(2000),
source_extraction_tmsp ARRAY < STRING >,
tech_valid_from TIMESTAMP NOT NULL,
tech_valid_to TIMESTAMP NOT NULL,
snflk_insert_tmsp TIMESTAMP NOT NULL,
snflk_update_tmsp TIMESTAMP NOT NULL
);