--[OK] statement is translated correctly (syntax and type checks are fine)


DROP TABLE IF EXISTS dbp_etl.ods_bon_agg_15min_umsatz_2;


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


CREATE TABLE IF NOT EXISTS dbp_etl.ods_bon_agg_15min_umsatz_2 (
    dat DATE NOT NULL,
    zeit_stunde INTEGER NOT NULL,
    zeit_15min INTEGER NOT NULL,
    mandant_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    kassensystem_name STRING(10),
    kasse_nr INTEGER NOT NULL,
    kasse_typ_id INTEGER NOT NULL,
    umsatz_brutto NUMERIC(29, 4) DEFAULT 0.0000 NOT NULL,
    umsatz_netto NUMERIC(29, 4) DEFAULT 0.0000 NOT NULL,
    anz_artikel INTEGER NOT NULL,
    anz_kunden INTEGER NOT NULL,
    bonanzahl_sug INTEGER NOT NULL
);


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


INSERT INTO dbp_etl.ods_bon_agg_15min_umsatz_2 (
    dat, zeit_stunde, zeit_15min, mandant_id, wup_id,
    kassensystem_name,
    kasse_nr,
    kasse_typ_id,
    umsatz_brutto,
    umsatz_netto,
    anz_artikel,
    anz_kunden,
    bonanzahl_sug
)
(
    SELECT
        bon_dat,
        CASE
            WHEN
                EXTRACT(HOUR FROM bon_beginn) = 23
                AND EXTRACT(HOUR FROM bon_ende) = 0
                THEN 23
            ELSE EXTRACT(HOUR FROM bon_ende)
        END AS zeit_stunde,
        CASE
            WHEN
                EXTRACT(HOUR FROM bon_beginn) = 23
                AND EXTRACT(HOUR FROM bon_ende) = 0
                THEN 45
            WHEN EXTRACT(MINUTE FROM bon_ende) < 15
                THEN 0
            WHEN EXTRACT(MINUTE FROM bon_ende) < 30
                THEN 15
            WHEN EXTRACT(MINUTE FROM bon_ende) < 45
                THEN 30
            ELSE 45
        END AS zeit_minute,
        mandant_id,
        wup_id,
        kassensystem_name,
        kasse_nr,
        kasse_typ_id,
        SUM(umsatz_brutto) AS ums_brutto,
        SUM(umsatz_brutto * 100 / (100 + mwst)) AS umsatz_netto,
        SUM(track_artikel) + COUNT(DISTINCT CASE
            WHEN talon IS NOT NULL
                THEN talon
            ELSE NULL
        END) AS anz_artikel,
        COUNT(DISTINCT kunde_bon_nr) AS anz_kunden,
        SUM(0) AS bonanzahl_sug
    FROM (
        SELECT
            K.wup_id,
            K.bon_dat,
            K.bon_beginn,
            K.bon_ende,
            K.mandant_id,
            T.kassensystem_name,
            K.kasse_nr,
            K.kasse_typ_id,
            CASE
                WHEN K.kunde_fg = 1
                    THEN K.bon_id
                ELSE NULL
            END AS kunde_bon_nr,
            V.kl_art_id,
            V.wg_id,
            V.umsatz_brutto,
            COALESCE(M.mwst, 0) AS mwst,
            V.einh_id,
            CASE
                WHEN
                    V.talon_id <> 0
                    AND T.kassensystem_name IN ('KPOS', 'POSITION')
                    AND V.mandant_id > 1
                    THEN V.talon_id
                ELSE NULL
            END AS talon,
            CASE
                WHEN
                    V.wg_id = 980
                    AND T.kassensystem_name IN ('KPOS', 'POSITION')
                    AND V.umsatz_brutto > 0
                    AND V.mandant_id > 1
                    OR V.einh_id = 'PND' OR V.talon_id <> 0 AND T.kassensystem_name IN ('KPOS', 'POSITION') AND V.mandant_id > 1
                    THEN 0
                ELSE 1
            END AS track_artikel
        FROM dbp_ods.ods_bon_kopf_2 AS K
        LEFT JOIN dbp_ods.ods_bon_transaction_2 AS T
            ON
                K.bon_id = T.bon_id AND K.wup_id = T.wup_id AND K.mandant_id
                = T.mandant_id AND K.bon_dat = T.bon_dat
        INNER JOIN dbp_ods.ods_bon_verkauf_2 AS V
            ON
                K.mandant_id = V.mandant_id AND K.wup_id = V.wup_id AND K
                .bon_id = V.bon_id AND K.bon_dat = V.bon_dat
        INNER JOIN dbp_data.mwst_per_2 AS M
            ON
                V.mandant_id = M.mandant_id AND K.bon_dat BETWEEN M.dat_von AND
                M.dat_bis AND V.mwst_id = M.mwst_id
        WHERE
            K.bon_dat BETWEEN DATE_SUB(
                CURRENT_DATE("Europe/Berlin"), INTERVAL 15 DAY
            ) AND (DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 1 DAY))
            AND T.bon_dat BETWEEN DATE_SUB(
                CURRENT_DATE("Europe/Berlin"), INTERVAL 15 DAY
            ) AND (DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 1 DAY))
            AND V.bon_dat BETWEEN DATE_SUB(
                CURRENT_DATE("Europe/Berlin"), INTERVAL 15 DAY
            ) AND (DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 1 DAY))
            AND K.turnover_fg = 1
            AND (
                K.mandant_id,
                K.wup_id,
                T.kassensystem_name,
                K.kasse_nr,
                K.bon_dat
            ) IN (SELECT (
                mandant_id, wup_id,
                kassensystem_name, kasse_nr, bon_dat
            )
            FROM dbp_etl.bon_agg_kassenberichte_2)
            AND (
                K.bon_id, K.wup_id) NOT IN (
                SELECT (bon_id, wup_id)
                FROM dbp_ods.ods_bon_storno_2
            )
        UNION ALL
        SELECT
            K.wup_id,
            K.bon_dat,
            K.bon_beginn,
            K.bon_ende,
            K.mandant_id,
            T.kassensystem_name,
            K.kasse_nr,
            K.kasse_typ_id,
            CASE
                WHEN K.kunde_fg = 1
                    THEN K.bon_id
                ELSE NULL
            END AS kunde_bon_nr,
            V.kl_art_id,
            V.wg_id,
            V.umsatz_brutto,
            COALESCE(M.mwst, 0) AS mwst,
            V.einh_id,
            CASE
                WHEN
                    V.talon_id <> 0
                    AND T.kassensystem_name IN ('KPOS', 'POSITION')
                    AND V.mandant_id > 1
                    THEN V.talon_id
                ELSE NULL
            END AS talon,
            CASE
                WHEN
                    V.wg_id = 980
                    AND T.kassensystem_name IN ('KPOS', 'POSITION')
                    AND V.umsatz_brutto > 0
                    AND V.mandant_id > 1
                    OR V.einh_id = 'PND' OR V.talon_id <> 0 AND T.kassensystem_name IN ('KPOS', 'POSITION') AND V.mandant_id > 1
                    THEN 0
                ELSE 1
            END AS track_artikel
        FROM dbp_ods.ods_bon_kopf_2 AS K
        LEFT JOIN dbp_ods.ods_bon_transaction_2 AS T
            ON
                K.bon_id = T.bon_id AND K.wup_id = T.wup_id AND K.mandant_id
                = T.mandant_id AND K.bon_dat = T.bon_dat
        INNER JOIN dbp_ods.ods_bon_retoure_2 AS V
            ON
                K.mandant_id = V.mandant_id AND K.wup_id = V.wup_id AND K
                .bon_id = V.bon_id AND K.bon_dat = V.bon_dat
        INNER JOIN dbp_data.mwst_per_2 AS M
            ON
                V.mandant_id = M.mandant_id AND K.bon_dat BETWEEN M.dat_von AND
                M.dat_bis AND V.mwst_id = M.mwst_id
        WHERE
            K.bon_dat BETWEEN DATE_SUB(
                CURRENT_DATE("Europe/Berlin"), INTERVAL 15 DAY
            ) AND (DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 1 DAY))
            AND T.bon_dat BETWEEN DATE_SUB(
                CURRENT_DATE("Europe/Berlin"), INTERVAL 15 DAY
            ) AND (DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 1 DAY))
            AND V.bon_dat BETWEEN DATE_SUB(
                CURRENT_DATE("Europe/Berlin"), INTERVAL 15 DAY
            ) AND (DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 1 DAY))
            AND K.turnover_fg = 1
            AND (
                K.mandant_id,
                K.wup_id,
                T.kassensystem_name,
                K.kasse_nr,
                K.bon_dat
            ) IN (SELECT (
                mandant_id, wup_id,
                kassensystem_name, kasse_nr, bon_dat
            )
            FROM dbp_etl.bon_agg_kassenberichte_2)
            AND (
                K.bon_id, K.bon_dat) NOT IN (
                SELECT (bon_id, bon_dat)
                FROM dbp_ods.ods_bon_storno_2
            )
    ) AS t1_2
    GROUP BY
        bon_dat,
        zeit_stunde,
        zeit_minute,
        wup_id,
        mandant_id,
        kassensystem_name,
        kasse_nr,
        kasse_typ_id
);


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


UPDATE dbp_etl.ods_bon_agg_15min_umsatz_2 AS ods_bon_agg_15min_umsatz1 SET
    bonanzahl_sug = b.bonanzahl_sug FROM (
    SELECT
        s.mandant_id,
        s.wup_id,
        s.bon_dat,
        s.zeit_stunde,
        MAX(s.zeit_minute) AS zeit_minute,
        s.kasse_nr,
        W.kundenfaktor,
        s.kasse_typ_id,
        CAST(SUM(CEIL(s.bonanzahl_sug)) AS INTEGER) AS bonanzahl_sug
    FROM (
        SELECT
            K.bon_dat,
            CASE
                WHEN
                    EXTRACT(HOUR FROM K.bon_beginn) = 23
                    AND EXTRACT(HOUR FROM K.bon_ende) = 0
                    THEN 23
                ELSE EXTRACT(HOUR FROM K.bon_beginn)
            END AS zeit_stunde,
            CASE
                WHEN
                    EXTRACT(HOUR FROM K.bon_beginn) = 23
                    AND EXTRACT(HOUR FROM K.bon_ende) = 0
                    THEN 45
                WHEN EXTRACT(MINUTE FROM K.bon_ende) < 15
                    THEN 0
                WHEN EXTRACT(MINUTE FROM K.bon_ende) < 30
                    THEN 15
                WHEN EXTRACT(MINUTE FROM K.bon_ende) < 45
                    THEN 30
                ELSE 45
            END AS zeit_minute,
            K.mandant_id,
            K.wup_id,
            K.kasse_nr,
            K.kasse_typ_id,
            COUNT(DISTINCT CAST(K.kasse_nr AS STRING) || K.bon_id)
                AS bonanzahl_sug
        FROM dbp_ods.ods_bon_kopf_2 AS K
        INNER JOIN dbp_ods.ods_bon_verkauf_2 AS V
            ON
                K.mandant_id = V.mandant_id AND K.wup_id = V.wup_id AND K
                .bon_id = V.bon_id AND K.bon_dat = V.bon_dat
        WHERE
            K.kunde_fg = 1
            AND V.umsatz_brutto > 0
            AND K.bon_dat BETWEEN DATE_SUB(
                CURRENT_DATE("Europe/Berlin"), INTERVAL 15 DAY
            ) AND (DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 1 DAY))
            AND V.bon_dat BETWEEN DATE_SUB(
                CURRENT_DATE("Europe/Berlin"), INTERVAL 15 DAY
            ) AND (DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 1 DAY))
            AND (
                K.mandant_id, K.bon_dat) IN (
                SELECT (mandant_id, dat)
                FROM dbp_etl.ods_bon_agg_15min_umsatz_2
            )
            AND (
                V.mandant_id, V.bon_dat) IN (
                SELECT (mandant_id, dat)
                FROM dbp_etl.ods_bon_agg_15min_umsatz_2
            )
            AND (
                K.mandant_id IN (1, 4, 6)
                OR K.mandant_id IN (2, 5, 7, 8)
                AND CAST(K.kassierer_nr AS INTEGER) NOT BETWEEN 800
                AND 900
                OR K.mandant_id = 3
                AND CAST(K.kassierer_nr AS INTEGER) NOT BETWEEN 700 AND 900
            )
            AND K.kasse_typ_id <> 5
            AND (
                K.mandant_id, K.bon_id, K.wup_id) NOT IN (
                SELECT (mandant_id, bon_id, wup_id)
                FROM dbp_ods.ods_bon_storno_2
            )
        GROUP BY
            K.bon_dat,
            zeit_stunde,
            zeit_minute,
            K.mandant_id,
            K.wup_id,
            K.kasse_nr,
            K.kasse_typ_id
    ) AS s
    LEFT JOIN
        dbp_data.wup_2 AS W
        ON s.mandant_id = W.mandant_id AND s.wup_id = W.wup_id
    GROUP BY
        s.mandant_id,
        s.wup_id,
        s.bon_dat,
        s.zeit_stunde,
        s.kasse_nr,
        W.kundenfaktor,
        s.kasse_typ_id
) AS b
WHERE
    ods_bon_agg_15min_umsatz1.dat = b.bon_dat
    AND ods_bon_agg_15min_umsatz1.mandant_id = b.mandant_id
    AND ods_bon_agg_15min_umsatz1.zeit_stunde = b.zeit_stunde AND ods_bon_agg_15min_umsatz1.zeit_15min = b.zeit_minute
    AND ods_bon_agg_15min_umsatz1.wup_id = b.wup_id AND ods_bon_agg_15min_umsatz1.kasse_nr = b.kasse_nr
    AND ods_bon_agg_15min_umsatz1.kasse_typ_id = b.kasse_typ_id;
