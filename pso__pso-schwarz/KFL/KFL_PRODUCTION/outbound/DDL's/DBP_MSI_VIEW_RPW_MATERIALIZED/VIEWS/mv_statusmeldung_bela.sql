CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_rpw_materialized.mv_statusmeldung_bela (
ecm_vorgang INTEGER,
mandant_id INTEGER,
system_id INTEGER,
belegklasse_id STRING(5) COLLATE 'und:ci',
statuscode_id INTEGER,
gp_id INTEGER,
zeitstempel DATETIME,
dat DATE,
laufzeit_tage BIGNUMERIC(38,11),
anzahl_ek INTEGER,
anzahl_mahnung INTEGER
);