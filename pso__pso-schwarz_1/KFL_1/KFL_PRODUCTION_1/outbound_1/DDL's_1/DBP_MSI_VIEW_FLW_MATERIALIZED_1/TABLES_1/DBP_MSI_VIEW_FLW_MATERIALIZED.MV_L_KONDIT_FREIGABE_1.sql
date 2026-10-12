CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_flw_materialized.mv_l_kondit_freigabe_1 (
mandant_id INTEGER,
kondition_id INTEGER,
in_verkaufsorganisation_id STRING(4) COLLATE 'und:ci',
in_vw_id INTEGER,
in_art_id INTEGER,
konditionsart_id STRING(4) COLLATE 'und:ci',
applikation_id STRING(2) COLLATE 'und:ci',
preisliste_typ_id STRING(2) COLLATE 'und:ci',
wrg_id STRING(3) COLLATE 'und:ci',
freigabe_status_id STRING(1) COLLATE 'und:ci',
dat_von DATE,
dat_bis DATE,
bearbeitung_status_id STRING(2) COLLATE 'und:ci'
);