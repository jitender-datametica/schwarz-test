CREATE TABLE IF NOT EXISTS kfl_production_dbp_ods.ods_finanz01_1 (
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
td_insert TIMESTAMP,
td_update TIMESTAMP
) CLUSTER BY mandant_id, wup_id;