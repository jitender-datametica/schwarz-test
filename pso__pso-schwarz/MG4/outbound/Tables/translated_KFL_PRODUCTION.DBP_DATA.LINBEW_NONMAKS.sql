CREATE OR REPLACE TABLE kfl_production_dbp_data.linbew_nonmaks (
mandant_id INTEGER NOT NULL,
lin_kurs_id STRING(10) COLLATE 'und:ci' NOT NULL,
hr_objekt_id INTEGER NOT NULL,
dat DATE NOT NULL,
wup_id INTEGER NOT NULL,
unternehmens_bereich_id STRING(2) COLLATE 'und:ci' NOT NULL,
anzahl_kurse_gesamt INTEGER NOT NULL,
anzahl_kurse_abgeschlossen INTEGER NOT NULL,
ki_fg INTEGER NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);