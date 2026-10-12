DROP TABLE IF EXISTS dbp_etl.dra_wup_tag_tmp_2;


CREATE TABLE IF NOT EXISTS dbp_etl.dra_wup_tag_tmp_2 LIKE dbp_data.dra_wup_tag_2;


CREATE OR REPLACE TABLE dbp_etl.dra_wup_tag_dat_2 (
    bon_dat DATE NOT NULL
);


INSERT INTO dbp_etl.dra_wup_tag_dat_2 (bon_dat)
(
    SELECT K.bon_dat
    FROM dbp_ods.ods_bon_kopf_2 AS K
    INNER JOIN dbp_ods.ods_bon_financial_2 AS F
        ON
            K.bon_id = F.bon_id AND K.mandant_id = F.mandant_id AND K
            .wup_id = F.wup_id AND K.bon_dat = F.bon_dat
    INNER JOIN dbp_ods.ods_bon_transaction_2 AS T
        ON
            K.bon_id = T.bon_id AND K.mandant_id = T.mandant_id
            AND K.wup_id = T.wup_id AND K.bon_dat = T.bon_dat
    INNER JOIN
        dbp_ods.bon_load_status_2 AS B
        ON T.datei_name = B.xml_name AND B.artbew_fg = 0
    WHERE
        K.bon_dat <= DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 1 DAY)
        AND K.mandant_id = 1
        AND B.parsebon_time
        <= CAST(
            TIMESTAMP_SUB(CURRENT_TIMESTAMP(), INTERVAL 10 MINUTE) AS DATETIME
        )
        AND F.financial_grund_id = 112
        AND (
            K.bon_id, K.bon_dat) NOT IN (
            SELECT (bon_id, bon_dat)
            FROM dbp_ods.ods_bon_storno_2
        )
    GROUP BY K.bon_dat
);


INSERT INTO dbp_etl.dra_wup_tag_tmp_2 (
    mandant_id, wup_id, dat, betrag_dra, anz_bon, wrg_id
)
(
    SELECT
        K.mandant_id AS `_mandant_id`,
        K.wup_id AS `_wup_id`,
        K.bon_dat AS `_dat`,
        V.umsatz_brutto / V.menge AS `_betrag_dra`,
        CAST(SUM(V.menge) AS INTEGER) AS `_anz_bon`,
        K.wrg_id
    FROM dbp_ods.ods_bon_kopf_2 AS K
    INNER JOIN dbp_ods.ods_bon_verkauf_2 AS V
        ON
            K.mandant_id = V.mandant_id AND K.wup_id = V.wup_id AND K.bon_id
            = V.bon_id AND K.bon_dat = V.bon_dat
    INNER JOIN dbp_ods.ods_bon_transaction_2 AS T
        ON
            K.bon_id = T.bon_id AND K.mandant_id = T.mandant_id
            AND K.wup_id = T.wup_id AND K.bon_dat = T.bon_dat
    INNER JOIN dbp_ods.bon_load_status_2 AS B ON T.datei_name = B.xml_name
    WHERE
        K.mandant_id = 1
        AND K.turnover_fg = 1
        AND K.bon_dat IN (
            SELECT bon_dat
            FROM dbp_etl.dra_wup_tag_dat_2
        )
        AND B.parsebon_time
        <= CAST(
            TIMESTAMP_SUB(CURRENT_TIMESTAMP(), INTERVAL 10 MINUTE) AS DATETIME
        )
        AND (
            V.mandant_id, V.wg_id) IN (
            SELECT (mandant_id, wg_id)
            FROM dbp_data.wg_filter_zu_2
            WHERE
                arthiertyp_id = 2
                AND wg_filter_id = 9
        )
        AND K.kasse_nr NOT IN (100, 101)
        AND (
            K.bon_id, K.bon_dat) NOT IN (
            SELECT (bon_id, bon_dat)
            FROM dbp_ods.ods_bon_storno_2
        )
    GROUP BY
        `_mandant_id`,
        `_wup_id`,
        `_dat`,
        `_betrag_dra`,
        K.wrg_id
);


INSERT INTO dbp_etl.dra_wup_tag_tmp_2 (
    mandant_id, wup_id, dat, betrag_dra, anz_bon, wrg_id
)
(
    SELECT
        K.mandant_id AS `_mandant_id`,
        K.wup_id AS `_wup_id`,
        K.bon_dat AS `_dat`,
        V.umsatz_brutto / V.menge AS `_betrag_dra`,
        CAST(SUM(V.menge) AS INTEGER) AS `_anz_bon`,
        K.wrg_id AS `_wrg_id`
    FROM dbp_ods.ods_bon_kopf_2 AS K
    INNER JOIN dbp_ods.ods_bon_retoure_2 AS V
        ON
            K.mandant_id = V.mandant_id AND K.wup_id = V.wup_id AND K.bon_id
            = V.bon_id AND K.bon_dat = V.bon_dat
    INNER JOIN dbp_ods.ods_bon_transaction_2 AS T
        ON
            K.bon_id = T.bon_id AND K.mandant_id = T.mandant_id
            AND K.wup_id = T.wup_id AND K.bon_dat = T.bon_dat
    INNER JOIN dbp_ods.bon_load_status_2 AS B ON T.datei_name = B.xml_name
    WHERE
        K.mandant_id = 1
        AND K.turnover_fg = 1
        AND K.bon_dat IN (
            SELECT bon_dat
            FROM dbp_etl.dra_wup_tag_dat_2
        )
        AND B.parsebon_time
        <= CAST(
            TIMESTAMP_SUB(CURRENT_TIMESTAMP(), INTERVAL 10 MINUTE) AS DATETIME
        )
        AND (
            V.mandant_id, V.wg_id) IN (
            SELECT (mandant_id, wg_id)
            FROM dbp_data.wg_filter_zu_2
            WHERE
                arthiertyp_id = 2
                AND wg_filter_id = 9
        )
        AND K.kasse_nr NOT IN (100, 101)
        AND (
            K.bon_id, K.bon_dat) NOT IN (
            SELECT (bon_id, bon_dat)
            FROM dbp_ods.ods_bon_storno_2
        )
    GROUP BY
        `_mandant_id`,
        `_wup_id`,
        `_dat`,
        `_betrag_dra`,
        `_wrg_id`
);


INSERT INTO dbp_etl.dra_wup_tag_tmp_2 (
    mandant_id, wup_id, dat, betrag_dra, anz_bon, wrg_id
)
(
    SELECT
        K.mandant_id AS `_mandant_id`,
        K.wup_id AS `_wup_id`,
        K.bon_dat AS `_dat`,
        F.umsatz_brutto AS `_betrag_dra`,
        COUNT(*) AS `_anz_bon`,
        K.wrg_id AS `_wrg_id`
    FROM dbp_ods.ods_bon_kopf_2 AS K
    INNER JOIN dbp_ods.ods_bon_financial_2 AS F
        ON
            K.bon_id = F.bon_id AND K.mandant_id = F.mandant_id AND K
            .wup_id = F.wup_id AND K.bon_dat = F.bon_dat
    INNER JOIN dbp_ods.ods_bon_transaction_2 AS T
        ON
            K.bon_id = T.bon_id AND K.mandant_id = T.mandant_id
            AND K.wup_id = T.wup_id AND K.bon_dat = T.bon_dat
    INNER JOIN dbp_ods.bon_load_status_2 AS B ON T.datei_name = B.xml_name
    WHERE
        K.bon_dat IN (
            SELECT bon_dat
            FROM dbp_etl.dra_wup_tag_dat_2
        )
        AND K.mandant_id = 1
        AND K.turnover_fg = 1
        AND B.parsebon_time
        <= CAST(
            TIMESTAMP_SUB(CURRENT_TIMESTAMP(), INTERVAL 10 MINUTE) AS DATETIME
        )
        AND F.financial_grund_id = 112
        AND (
            K.bon_id, K.bon_dat) NOT IN (
            SELECT (bon_id, bon_dat)
            FROM dbp_ods.ods_bon_storno_2
        )
    GROUP BY
        `_mandant_id`,
        `_wup_id`,
        `_dat`,
        `_betrag_dra`,
        `_wrg_id`
);


DELETE FROM dbp_data.dra_wup_tag_2
WHERE dat IN (
    SELECT DISTINCT dat
    FROM dbp_etl.dra_wup_tag_tmp_2
);


INSERT INTO dbp_data.dra_wup_tag_2 (
    mandant_id, wup_id, dat, betrag_dra, anz_bon, wrg_id, td_update,
    td_insert
)
(
    SELECT
        mandant_id,
        wup_id,
        dat,
        betrag_dra,
        SUM(anz_bon),
        wrg_id,
        CURRENT_TIMESTAMP(),
        CURRENT_TIMESTAMP()
    FROM dbp_etl.dra_wup_tag_tmp_2
    GROUP BY
        mandant_id,
        wup_id,
        dat,
        betrag_dra,
        wrg_id
);
