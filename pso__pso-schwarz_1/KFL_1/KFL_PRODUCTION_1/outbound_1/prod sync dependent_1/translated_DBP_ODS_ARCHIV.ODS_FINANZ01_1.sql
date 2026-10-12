CREATE OR REPLACE TABLE kfl_production_dbp_ods_archiv.ods_finanz01_1 (
mandant_id INTEGER NOT NULL,
wup_id INTEGER NOT NULL,
fin_booking DATETIME NOT NULL,
buchungsart_id STRING(1) COLLATE 'und:ci' NOT NULL,
buchungsschluessel_id INTEGER NOT NULL,
zahlungsmittel_id INTEGER NOT NULL,
beleg_lfd_nr INTEGER NOT NULL,
dat_booking DATE NOT NULL,
betrag NUMERIC(29,4),
bemerkung2 STRING(30) COLLATE 'und:ci',
td_update TIMESTAMP,
td_insert TIMESTAMP
);