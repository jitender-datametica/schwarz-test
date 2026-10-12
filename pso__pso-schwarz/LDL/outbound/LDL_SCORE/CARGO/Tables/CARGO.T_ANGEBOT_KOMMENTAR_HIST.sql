CREATE TABLE IF NOT EXISTS ldl_score_cargo.t_angebot_kommentar_hist (
angebot_kommentar_id BIGNUMERIC(38,0),
angebot_kommentar_rowid STRING(2000),
angebot_kommentar_lastmoddate TIMESTAMP,
angebot_kommentar_abgangsorte_rowid STRING(2000),
angebot_kommentar_empfangsland_rowid STRING(2000),
angebot_kommentar_anm_einkauf STRING(2000),
angebot_kommentar_anm_intern STRING(2000),
angebot_kommentar_masterrowid STRING(2000),
angebot_kommentar_anm_logistikdienstleister STRING(2000),
angebot_kommentar_logistiktypkontrakt_rowid STRING(2000),
source_extraction_tmsp ARRAY < STRING >,
tech_valid_from TIMESTAMP NOT NULL,
tech_valid_to TIMESTAMP NOT NULL,
snflk_insert_tmsp TIMESTAMP NOT NULL,
snflk_update_tmsp TIMESTAMP NOT NULL
);