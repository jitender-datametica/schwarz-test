DROP TABLE IF EXISTS dbp_etl.zlf_auslfel_zwischenspeicher;

CREATE TABLE IF NOT EXISTS dbp_etl.zlf_auslfel_zwischenspeicher (
    mandant_id INTEGER,
    auslieferungsgruppe_id STRING(4) COLLATE 'und:ci',
    wg_id INTEGER,
    sortimentslistenart_id STRING(1) COLLATE 'und:ci',
    td_insert TIMESTAMP
);


INSERT INTO dbp_etl.zlf_auslfel_zwischenspeicher
(SELECT
    mandant_id,
    auslieferungsgruppe_id,
    wg_id,
    sortimentslistenart_id,
    CURRENT_TIMESTAMP()
FROM ${TEMP_TABLE});
