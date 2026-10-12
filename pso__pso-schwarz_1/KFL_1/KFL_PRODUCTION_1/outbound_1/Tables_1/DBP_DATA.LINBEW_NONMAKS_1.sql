CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.linbew_nonmaks_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
lin_kurs_id STRING(10) COLLATE 'und:ci' NOT NULL,
hr_objekt_id INTEGER NOT NULL,
dat DATE NOT NULL,
wup_id BIGNUMERIC(38,0) NOT NULL,
unternehmens_bereich_id STRING(2) COLLATE 'und:ci' NOT NULL,
anzahl_kurse_gesamt BIGNUMERIC(38,0) NOT NULL,
anzahl_kurse_abgeschlossen BIGNUMERIC(38,0) NOT NULL,
ki_fg BIGNUMERIC(38,0) NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);