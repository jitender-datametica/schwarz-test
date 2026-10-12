CREATE OR REPLACE TABLE dbp_msi_view_rpw_materialized.mv_mwst_per_1 (
dat_von DATE,
mwst_id INTEGER,
mwst NUMERIC(29,2),
dat_bis DATE,
mwst_bez STRING(20) COLLATE 'und:ci',
mandant_id INTEGER,
system_id INTEGER
);