CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_ios_materialized.mv_rpm_stammdaten_ios_1 (
projekt_id STRING(32),
ims_projekt_typ_id STRING(1) COLLATE 'und:ci',
in_projekt_id_char STRING(30) COLLATE 'und:ci',
besitzverhaeltnis_id STRING(3) COLLATE 'und:ci',
rpm_projekt_typ_id STRING(20) COLLATE 'und:ci',
rpm_phase_id STRING(20) COLLATE 'und:ci',
rpm_hierarchie_id STRING(32) COLLATE 'und:ci',
rpm_status_id INTEGER
);