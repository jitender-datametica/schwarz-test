CREATE TABLE IF NOT EXISTS ldl_score_cargo.t_angebot_strecke_emission_hist (
angebot_strecke_emission_id BIGNUMERIC(38,0),
angebot_strecke_emission_rowid STRING(2000),
angebot_strecke_emission_masterrowid STRING(2000),
angebot_strecke_emission_lastmoddate TIMESTAMP,
angebot_strecke_emission_co2menge_kg BIGNUMERIC(38,5),
angebot_strecke_emission_ausgeschriebene_emission_rowid STRING(2000),
source_extraction_tmsp ARRAY < STRING >,
tech_valid_from TIMESTAMP NOT NULL,
tech_valid_to TIMESTAMP NOT NULL,
snflk_insert_tmsp TIMESTAMP NOT NULL,
snflk_update_tmsp TIMESTAMP NOT NULL
);