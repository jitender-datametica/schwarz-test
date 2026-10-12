CREATE OR REPLACE TABLE dbp_msi_view_rpw_materialized.mv_wbnk_gruppe_zu_1 (
system_id INTEGER,
mandant_id INTEGER,
wbnkart_id STRING(4) COLLATE 'und:ci',
row_grund_id STRING(4) COLLATE 'und:ci',
konditionsart_id STRING(4) COLLATE 'und:ci',
wbnk_gruppe_id INTEGER,
wbnk_gruppe_bez STRING(40) COLLATE 'und:ci',
wbnk_bez STRING(40) COLLATE 'und:ci'
);