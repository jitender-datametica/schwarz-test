CREATE OR REPLACE TABLE dbp_msi_view_rpw_materialized.mv_besch_faktura_1 (
mandant_id INTEGER,
faktura_beleg_id INTEGER,
wrg_id STRING(3) COLLATE 'und:ci',
dat_faktura DATE,
fakturaart_id STRING(4) COLLATE 'und:ci',
faktura_status_id STRING(1) COLLATE 'und:ci',
verkaufsorganisation_id STRING(4) COLLATE 'und:ci',
kalk_schema_id STRING(7) COLLATE 'und:ci',
auftraggeber_id STRING(10),
storno_fg INTEGER,
dat_erstellung DATE,
system_id INTEGER
);