CREATE TABLE IF NOT EXISTS ldl_score_cargo.t_rahmenvertrag_hist_2 (
rahmenvertrag_id BIGNUMERIC(38,0),
rahmenvertrag_bezeichnung STRING(2000),
rahmenvertrag_logistikdienstleister_rowid STRING(2000),
rahmenvertrag_gueltig_von TIMESTAMP,
rahmenvertrag_gueltig_bis TIMESTAMP,
rahmenvertrag_bereich_code STRING(2000),
rahmenvertrag_bereich_bezeichnung STRING(2000),
rahmenvertrag_lastmoddate TIMESTAMP,
rahmenvertrag_rowid STRING(2000),
rahmenvertrag_unternehmen_rowid STRING(2000),
source_extraction_tmsp ARRAY < STRING >,
tech_valid_from TIMESTAMP NOT NULL,
tech_valid_to TIMESTAMP NOT NULL,
snflk_insert_tmsp TIMESTAMP NOT NULL,
snflk_update_tmsp TIMESTAMP NOT NULL
);