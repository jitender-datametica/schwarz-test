CREATE TABLE IF NOT EXISTS ldl_score_cargo.t_projekt_strecken_emission_hist_1 (
projekt_strecken_emission_id BIGNUMERIC(38,0),
projekt_strecken_emission_gueltig_von TIMESTAMP,
projekt_strecken_emission_gueltig_bis TIMESTAMP,
projekt_strecken_emission_lastmoddate TIMESTAMP,
projekt_strecken_emission_rowid STRING(2000),
projekt_strecken_emission_co2menge_kg BIGNUMERIC(38,5),
projekt_strecken_emission_masterrowid STRING(2000),
source_extraction_tmsp ARRAY < STRING >,
tech_valid_from TIMESTAMP NOT NULL,
tech_valid_to TIMESTAMP NOT NULL,
snflk_insert_tmsp TIMESTAMP NOT NULL,
snflk_update_tmsp TIMESTAMP NOT NULL
);