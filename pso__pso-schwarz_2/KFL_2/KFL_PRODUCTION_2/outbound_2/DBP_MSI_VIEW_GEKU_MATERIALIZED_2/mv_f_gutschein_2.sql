CREATE OR REPLACE TABLE dbp_msi_view_geku_materialized.mv_f_gutschein_2 (
gutschein_id INTEGER,
mandant_id INTEGER,
ausgeber_id STRING(10) COLLATE 'und:ci',
kostenstelle_id STRING(10) COLLATE 'und:ci',
zeitstempel DATETIME,
dat STRING(16777216),
uhrzeit TIME,
betrag_gutschein NUMERIC(29,2),
wrg_id STRING(3) COLLATE 'und:ci',
geku_ticket_id INTEGER
);