CREATE OR REPLACE TABLE dbp_msi_view_rpw_materialized.mv_letzte_problemmeldung_1 (
last_fg INTEGER,
system_id INTEGER,
mandant_id INTEGER,
problemmeldung_id STRING(50) COLLATE 'und:ci',
beleg_gj INTEGER,
beleg_id INTEGER,
dat DATE,
problemmeldung_ecm_lfd_nr INTEGER,
letzte_problemcode_id STRING(7)
);