CREATE OR REPLACE TABLE dbp_msi_view_rpw_materialized.mv_letzte_statusmeldung_1 (
last_fg INTEGER,
system_id INTEGER,
mandant_id INTEGER,
statusmeldung_id STRING(50) COLLATE 'und:ci',
beleg_gj INTEGER,
beleg_id INTEGER,
zeitstempel DATETIME,
dat DATE,
statusmeldung_ecm_lfd_nr INTEGER,
letzte_statuscode_id INTEGER,
ersteller_id INTEGER
);