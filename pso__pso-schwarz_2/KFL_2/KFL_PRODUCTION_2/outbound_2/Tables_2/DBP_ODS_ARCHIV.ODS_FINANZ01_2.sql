CREATE TABLE IF NOT EXISTS kfl_production_dbp_ods_archiv.ods_finanz01_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
wup_id BIGNUMERIC(38,0) NOT NULL,
fin_booking DATETIME NOT NULL,
buchungsart_id STRING(1) COLLATE 'und:ci' NOT NULL,
buchungsschluessel_id BIGNUMERIC(38,0) NOT NULL,
zahlungsmittel_id BIGNUMERIC(38,0) NOT NULL,
beleg_lfd_nr BIGNUMERIC(38,0) NOT NULL,
dat_booking DATE NOT NULL,
betrag NUMERIC(18,4),
bemerkung2 STRING(30) COLLATE 'und:ci',
td_update TIMESTAMP,
td_insert TIMESTAMP
);