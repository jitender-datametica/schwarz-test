CREATE TABLE IF NOT EXISTS ldl_score_cargo.t_kontrakt_strecken_emission_hist (
kontrakt_strecken_emission_id BIGNUMERIC(38,0),
kontrakt_strecken_emission_gueltig_von TIMESTAMP,
kontrakt_strecken_emission_gueltig_bis TIMESTAMP,
kontrakt_strecken_emission_lastmoddate TIMESTAMP,
kontrakt_strecken_emission_rowid STRING(2000),
kontrakt_strecken_emission_co2menge_kg BIGNUMERIC(38,5),
kontrakt_strecken_emission_masterrowid STRING(2000),
source_extraction_tmsp ARRAY < STRING >,
tech_valid_from TIMESTAMP NOT NULL,
tech_valid_to TIMESTAMP NOT NULL,
snflk_insert_tmsp TIMESTAMP NOT NULL,
snflk_update_tmsp TIMESTAMP NOT NULL
);