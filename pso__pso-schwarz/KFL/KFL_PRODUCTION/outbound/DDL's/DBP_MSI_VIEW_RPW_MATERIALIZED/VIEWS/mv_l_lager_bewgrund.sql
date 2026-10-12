CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_rpw_materialized.mv_l_lager_bewgrund (
mandant_id INTEGER,
system_id INTEGER,
grund_id STRING(10) COLLATE 'und:ci',
lager_bewart_id STRING(3) COLLATE 'und:ci',
retourenart_id STRING(1) COLLATE 'und:ci'
);