CREATE OR REPLACE TABLE dbp_msi_view_immo_materialized.mv_immo_mietvertrag_intreno (
mandant_id INTEGER,
mv_intreno STRING(20) COLLATE 'und:ci',
mietvertrag_nr STRING(20) COLLATE 'und:ci',
partner_id STRING(10) COLLATE 'und:ci',
konzessionaer_id STRING(10) COLLATE 'und:ci',
dat_von DATE,
dat_bis DATE
);