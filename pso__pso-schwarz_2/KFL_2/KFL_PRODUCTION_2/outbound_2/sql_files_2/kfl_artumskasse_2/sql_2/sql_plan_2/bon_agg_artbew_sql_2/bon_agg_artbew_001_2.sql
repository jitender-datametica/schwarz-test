CREATE OR REPLACE TABLE dbp_etl.bon_agg_artbew_tmp_2 (
    wup_id INTEGER NOT NULL,
    mandant_id INTEGER NOT NULL,
    bon_dat DATE NOT NULL,
    xml_name STRING(255)
);


CREATE OR REPLACE TABLE dbp_etl.bon_artbew_tgl_delta_2 (
    wup_id INTEGER NOT NULL,
    mandant_id INTEGER NOT NULL,
    dat DATE NOT NULL
);


INSERT INTO dbp_etl.bon_agg_artbew_tmp_2 (wup_id, mandant_id, bon_dat, xml_name)
(
    SELECT
        wup_id,
        mandant_id,
        bon_dat,
        datei_name
    FROM dbp_ods.ods_bon_transaction_2 AS T2
    WHERE
        mandant_id = 1
        AND bon_dat BETWEEN DATE '2024-07-01' AND DATE '2024-09-30'
);


INSERT INTO dbp_etl.bon_artbew_tgl_delta_2 (wup_id, mandant_id, dat)
(
    SELECT
        wup_id,
        mandant_id,
        bon_dat
    FROM dbp_etl.bon_agg_artbew_tmp_2
    WHERE (
        mandant_id, wup_id, bon_dat) NOT IN (
        SELECT (mandant_id, wup_id, dat)
        FROM dbp_etl.bon_artbew_tgl_delta_2
    )
    GROUP BY
        wup_id,
        mandant_id,
        bon_dat
);


UPDATE dbp_ods.bon_load_status_2 SET
    artbew_fg = 1
WHERE xml_name IN (
    SELECT xml_name
    FROM dbp_etl.bon_agg_artbew_tmp_2
);
