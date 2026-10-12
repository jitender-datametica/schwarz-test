CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_flw_materialized.mv_flw_transport_det_2 (
mandant_id INTEGER,
tour_id INTEGER,
komm_bereich_id STRING(3) COLLATE 'und:ci',
kunde_grp_id STRING(10) COLLATE 'und:ci',
in_kunde_id INTEGER,
lkw_postyp_id STRING(4) COLLATE 'und:ci',
anz_stellplatz_ist NUMERIC(29,2)
);