CREATE TABLE IF NOT EXISTS ldl_score_cargo.t_ausschreibung_kontrakt_runde_hist_2 (
ausschreibung_kontrakt_runde_id BIGNUMERIC(38,0),
ausschreibung_kontrakt_runde_rowid STRING(2000),
ausschreibung_kontrakt_runde_lastmoddate TIMESTAMP,
ausschreibung_kontrakt_runde_nummer BIGNUMERIC(38,5),
ausschreibung_kontrakt_runde_abgabefrist TIMESTAMP,
ausschreibung_kontrakt_runde_frist_reminder_angebotsabgabe_h BIGNUMERIC(38,5),
ausschreibung_kontrakt_runde_statuscodeangebote STRING(2000),
ausschreibung_kontrakt_runde_masterrowid STRING(2000),
ausschreibung_kontrakt_runde_status_bezeichnung STRING(2000),
ausschreibung_kontrakt_runde_isactiveround BIGNUMERIC(38,0),
source_extraction_tmsp ARRAY < STRING >,
tech_valid_from TIMESTAMP NOT NULL,
tech_valid_to TIMESTAMP NOT NULL,
snflk_insert_tmsp TIMESTAMP NOT NULL,
snflk_update_tmsp TIMESTAMP NOT NULL
);