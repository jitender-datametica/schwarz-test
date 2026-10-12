CREATE TABLE IF NOT EXISTS kfl_production_dbp_ods.ods_wpufib_2 (
wup_id BIGNUMERIC(38,0) NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
dat_booking DATE NOT NULL,
zahlungsmittel_id STRING(4) COLLATE 'und:ci' NOT NULL,
buchungsschluessel_id STRING(10) COLLATE 'und:ci' NOT NULL,
aggr_nr BIGNUMERIC(38,0) NOT NULL,
group_nr BIGNUMERIC(38,0) NOT NULL,
record_nr BIGNUMERIC(38,0) NOT NULL,
wrg_id STRING(3) COLLATE 'und:ci' NOT NULL,
betrag NUMERIC(18,2) DEFAULT 0 NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);