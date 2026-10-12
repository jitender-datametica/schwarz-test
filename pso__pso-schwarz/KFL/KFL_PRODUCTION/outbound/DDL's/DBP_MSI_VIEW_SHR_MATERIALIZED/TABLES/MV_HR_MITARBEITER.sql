CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_shr_materialized.mv_hr_mitarbeiter (
mandant_id INTEGER,
mitarbeiter_id STRING(20),
dat_geburtstag DATE,
land_id STRING(2) COLLATE 'und:ci',
dat_uebernahme_azubi DATE
);