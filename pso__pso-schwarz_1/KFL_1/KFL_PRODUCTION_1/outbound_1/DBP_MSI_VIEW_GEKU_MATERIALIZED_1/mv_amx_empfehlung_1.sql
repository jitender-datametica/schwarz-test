CREATE OR REPLACE TABLE dbp_msi_view_geku_materialized.mv_amx_empfehlung_1 (
empfehlung_id INTEGER,
amx_system_id INTEGER,
empfehlung_nr STRING(10) COLLATE 'und:ci',
feststellung_id INTEGER,
dat_soll DATE,
dat_abschluss DATE,
zustand_id INTEGER
);