CREATE OR REPLACE TABLE dbp_msi_view_immo_materialized.mv_l_wirtschaftseinheit_2 (
mandant_id INTEGER,
we_intreno STRING(20) COLLATE 'und:ci',
wirtschaftseinheit_id STRING(11) COLLATE 'und:ci',
wirtschaftseinheit_bez STRING(40) COLLATE 'und:ci',
we_objekt_nr STRING(30) COLLATE 'und:ci',
dat_eroeffnung DATE
);