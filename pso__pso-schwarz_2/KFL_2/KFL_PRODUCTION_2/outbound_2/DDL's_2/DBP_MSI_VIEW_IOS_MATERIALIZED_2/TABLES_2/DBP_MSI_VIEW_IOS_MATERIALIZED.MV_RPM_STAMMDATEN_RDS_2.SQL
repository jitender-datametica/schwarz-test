CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_ios_materialized.mv_rpm_stammdaten_rds_2 (
projekt_id STRING(32) COLLATE 'und:ci',
ims_projekt_typ_id STRING(1) COLLATE 'und:ci',
in_projekt_id_char STRING(30) COLLATE 'und:ci',
mandant_id INTEGER,
besitzverhaeltnis_id STRING(3) COLLATE 'und:ci',
rpm_projekt_typ_id STRING(20) COLLATE 'und:ci',
rpm_phase_id STRING(20) COLLATE 'und:ci',
rpm_hierarchie_id STRING(32) COLLATE 'und:ci',
rpm_status_id INTEGER,
objekt_planer_name STRING(30) COLLATE 'und:ci',
wup_standort STRING(40) COLLATE 'und:ci',
wup_id INTEGER,
techn_platz_id STRING(30) COLLATE 'und:ci'
);