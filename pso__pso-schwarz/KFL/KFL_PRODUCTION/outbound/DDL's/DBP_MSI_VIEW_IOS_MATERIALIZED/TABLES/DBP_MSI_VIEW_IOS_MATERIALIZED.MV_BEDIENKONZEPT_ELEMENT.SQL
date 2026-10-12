CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_ios_materialized.mv_bedienkonzept_element (
rpm_hierarchie_id STRING(32) COLLATE 'und:ci',
dat_von DATE,
dat_bis DATE,
bedienkonzept_id INTEGER,
bedienkonzept_bez STRING(50) COLLATE 'und:ci',
dat_bedienkonzept DATE,
bedienkonzept_auspr_id INTEGER
);