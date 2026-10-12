DROP TABLE IF EXISTS DBP_ETL.zlf_auslfel_zwischenspeicher_2;

CREATE TABLE DBP_ETL.zlf_auslfel_zwischenspeicher_2 (
      mandant_id INTEGER,
      auslieferungsgruppe_id VARCHAR(4) COLLATE 'en-ci',
      wg_id SMALLINT,
      sortimentslistenart_id VARCHAR(1) COLLATE 'en-ci',
      td_insert TIMESTAMP_LTZ(9)
);

INSERT INTO DBP_ETL.zlf_auslfel_zwischenspeicher_2
SELECT mandant_id,
       auslieferungsgruppe_id,
       wg_id,
       sortimentslistenart_id,
       CURRENT_TIMESTAMP
FROM ${TEMP_TABLE}
;
