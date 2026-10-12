CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_flw_materialized.mv_l_in_kunde (
in_kunde_id INTEGER,
mandant_id INTEGER,
kunde_nr STRING(10) COLLATE 'und:ci',
kunde_name STRING(40) COLLATE 'und:ci',
kreistyp_gruppe_id STRING(16) COLLATE 'und:ci',
frueh_spaet_kz STRING(1) COLLATE 'und:ci',
kunde_land STRING(2) COLLATE 'und:ci',
kunde_plz STRING(10) COLLATE 'und:ci',
kunde_ort STRING(40) COLLATE 'und:ci'
);