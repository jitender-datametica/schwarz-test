DROP TABLE IF EXISTS dbp_etl.zlf_auslfel_1;


CREATE TABLE IF NOT EXISTS dbp_etl.zlf_auslfel_1 (
    mandant_id INTEGER,
    auslieferungsgruppe_id STRING(4) COLLATE 'und:ci',
    wg_id INTEGER,
    sortimentslistenart_id STRING(1) COLLATE 'und:ci',
    td_insert TIMESTAMP
);
