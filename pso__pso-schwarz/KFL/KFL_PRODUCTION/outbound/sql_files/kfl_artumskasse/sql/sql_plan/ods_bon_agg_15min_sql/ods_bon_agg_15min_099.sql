CREATE OR REPLACE TABLE dbp_etl.bon_agg_kassenberichte_tmp (
    bon_id STRING(25) NOT NULL,
    bon_dat DATE NOT NULL,
    wup_id INTEGER NOT NULL,
    wrg_id STRING(3) NOT NULL,
    mandant_id INTEGER NOT NULL,
    kassensystem_name STRING(10),
    kasse_nr INTEGER NOT NULL,
    xml_name STRING(255)
);


INSERT INTO dbp_etl.bon_agg_kassenberichte_tmp (
    bon_id, bon_dat, wup_id, wrg_id, mandant_id,
    kassensystem_name, kasse_nr, xml_name
)
(
    SELECT
        T2.bon_id,
        T2.bon_dat,
        T2.wup_id,
        COALESCE(K.wrg_id, MWZP.wrg_id) AS k_wrg_id_mwzp_wrg_id,
        T2.mandant_id,
        T2.kassensystem_name,
        T2.kasse_nr,
        T2.datei_name AS xml_name
    FROM dbp_ods.ods_bon_transaction AS T2
    INNER JOIN dbp_data.mandant_wrg_zu_per AS MWZP
        ON
            T2.mandant_id = MWZP.mandant_id AND T2.bon_dat
            BETWEEN MWZP.dat_von AND MWZP.dat_bis AND T2.training_fg <> 1
    LEFT JOIN dbp_ods.ods_bon_kopf AS K
        ON
            T2.bon_id = K.bon_id AND T2.wup_id = K.wup_id AND T2.mandant_id
            = K.mandant_id
    WHERE T2.bon_dat BETWEEN DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL ${days} DAY) AND (DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 1 DAY))
);


CREATE OR REPLACE TABLE dbp_etl.bon_agg_kassenberichte (
    wup_id INTEGER NOT NULL,
    wrg_id STRING(3) NOT NULL,
    mandant_id INTEGER NOT NULL,
    kassensystem_name STRING(10),
    kasse_nr INTEGER NOT NULL,
    bon_dat DATE NOT NULL
);


INSERT INTO dbp_etl.bon_agg_kassenberichte (
    wup_id, wrg_id, mandant_id, kassensystem_name, kasse_nr,
    bon_dat
)
(
    SELECT
        wup_id,
        wrg_id,
        mandant_id,
        kassensystem_name,
        kasse_nr,
        bon_dat
    FROM dbp_etl.bon_agg_kassenberichte_tmp AS T1
    GROUP BY
        bon_dat,
        wup_id,
        wrg_id,
        mandant_id,
        kassensystem_name,
        kasse_nr
);


CREATE OR REPLACE TABLE dbp_etl.ods_bon_sign_on_off (
    bon_dat DATE NOT NULL,
    wup_id INTEGER NOT NULL,
    wrg_id STRING(3) NOT NULL,
    mandant_id INTEGER NOT NULL,
    kassensystem_name STRING(10),
    kasse_nr INTEGER,
    kasse_typ_id INTEGER,
    transaction_name STRING(30) COLLATE 'und:ci',
    bon_ende DATETIME NOT NULL,
    bon_nr INTEGER NOT NULL
);


INSERT INTO dbp_etl.ods_bon_sign_on_off (
    bon_dat, wup_id, wrg_id, mandant_id, kassensystem_name, kasse_nr,
    kasse_typ_id, transaction_name, bon_ende, bon_nr
)
(
    SELECT
        T.bon_dat,
        T.wup_id,
        COALESCE(K.wrg_id, MWZP.wrg_id) AS k_wrg_id_mwzp_wrg_id,
        T.mandant_id,
        T.kassensystem_name,
        T.kasse_nr,
        T.kasse_typ_id,
        CASE
            WHEN T.transaction_name = 'OperatorLock'
                THEN 'SignOffTransaction'
            WHEN T.transaction_name = 'OperatorUnlock'
                THEN 'SignOnTransaction'
            WHEN T.transaction_name = 'PosLockTransaction'
                THEN 'SignOffTransaction'
            WHEN T.transaction_name = 'PosUnlockTransaction'
                THEN 'SignOnTransaction'
            ELSE T.transaction_name
        END AS transaction_name,
        T.bon_ende,
        T.bon_nr
    FROM dbp_ods.ods_bon_transaction AS T
    INNER JOIN dbp_data.mandant_wrg_zu_per AS MWZP
        ON
            T.mandant_id = MWZP.mandant_id AND T.bon_dat BETWEEN
            MWZP.dat_von AND MWZP.dat_bis AND T.training_fg <> 1
    LEFT JOIN dbp_ods.ods_bon_kopf AS K ON T.bon_id = K.bon_id AND T.wup_id = K.wup_id AND T.mandant_id = K.mandant_id
    WHERE
        T.transaction_name IN (
            'SignOffTransaction', 'SignOnTransaction', 'OperatorLock', 'OperatorUnlock',
            'PosUnlockTransaction', 'PosLockTransaction'
        )
        AND (T.mandant_id, T.wup_id, T.kassensystem_name, T.kasse_nr, T.bon_dat) IN (SELECT (
            mandant_id, wup_id,
            kassensystem_name, kasse_nr, bon_dat
        )
        FROM dbp_etl.bon_agg_kassenberichte)
        AND T.kassensystem_name NOT IN ('KPOS')
);


INSERT INTO dbp_etl.ods_bon_sign_on_off (
    bon_dat, wup_id, wrg_id, mandant_id, kassensystem_name, kasse_nr,
    kasse_typ_id, transaction_name, bon_ende, bon_nr
)
(
    SELECT
        T.bon_dat,
        T.wup_id,
        COALESCE(K.wrg_id, MWZP.wrg_id) AS k_wrg_id_mwzp_wrg_id,
        T.mandant_id,
        T.kassensystem_name,
        T.kasse_nr,
        T.kasse_typ_id,
        CASE
            WHEN T.transaction_name = 'OperatorLock'
                THEN 'SignOffTransaction'
            WHEN T.transaction_name = 'OperatorUnlock'
                THEN 'SignOnTransaction'
            WHEN T.transaction_name = 'PosLockTransaction'
                THEN 'SignOffTransaction'
            WHEN T.transaction_name = 'PosUnlockTransaction'
                THEN 'SignOnTransaction'
            ELSE T.transaction_name
        END AS transaction_name_,
        T.bon_ende,
        ROW_NUMBER() OVER (
            PARTITION BY
                T.wup_id, T.kasse_nr, T.bon_dat ORDER BY
                T.wup_id IS NULL, T.wup_id, T.kasse_nr
                IS NULL, T.kasse_nr, T.bon_ende IS NULL, T.bon_ende, CASE
                    WHEN T.transaction_name = 'OperatorLock'
                        THEN 'SignOffTransaction'
                    WHEN T.transaction_name = 'OperatorUnlock'
                        THEN 'SignOnTransaction'
                    WHEN T.transaction_name = 'PosLockTransaction'
                        THEN 'SignOffTransaction'
                    WHEN T.transaction_name = 'PosUnlockTransaction'
                        THEN 'SignOnTransaction'
                    ELSE T.transaction_name
                END IS NULL DESC, CASE
                    WHEN T.transaction_name = 'OperatorLock'
                        THEN 'SignOffTransaction'
                    WHEN T.transaction_name = 'OperatorUnlock'
                        THEN 'SignOnTransaction'
                    WHEN T.transaction_name = 'PosLockTransaction'
                        THEN 'SignOffTransaction'
                    WHEN T.transaction_name = 'PosUnlockTransaction'
                        THEN 'SignOnTransaction'
                    ELSE T.transaction_name
                END DESC
        ) AS bon_nr
    FROM dbp_ods.ods_bon_transaction AS T
    INNER JOIN dbp_data.mandant_wrg_zu_per AS MWZP
        ON
            T.mandant_id = MWZP.mandant_id AND T.bon_dat BETWEEN
            MWZP.dat_von AND MWZP.dat_bis AND T.training_fg <> 1
    LEFT JOIN dbp_ods.ods_bon_kopf AS K ON T.bon_id = K.bon_id AND T.wup_id = K.wup_id AND T.mandant_id = K.mandant_id
    WHERE
        T.transaction_name IN (
            'SignOffTransaction', 'SignOnTransaction', 'OperatorLock', 'OperatorUnlock',
            'PosUnlockTransaction', 'PosLockTransaction'
        )
        AND (T.mandant_id, T.wup_id, T.kassensystem_name, T.kasse_nr, T.bon_dat) IN (SELECT (
            mandant_id, wup_id,
            kassensystem_name, kasse_nr, bon_dat
        )
        FROM dbp_etl.bon_agg_kassenberichte)
        AND T.kassensystem_name IN ('KPOS')
);


CREATE OR REPLACE TABLE dbp_etl.`_fake_entries_${TRANSIENT_TABLE_SUFFIX}` AS
SELECT
    bon_dat,
    wup_id,
    wrg_id,
    mandant_id,
    kassensystem_name,
    kasse_nr,
    kasse_typ_id,
    'SignOnTransaction' AS transaction_name,
    PARSE_DATETIME('%F %H:%M:%S', SUBSTR(CAST(DATE(bon_ende) AS STRING), 1, 20)) AS bon_ende,
    bon_nr - 1 AS bon_nr
FROM dbp_etl.ods_bon_sign_on_off
WHERE (mandant_id, wup_id, wrg_id, kassensystem_name, kasse_nr, bon_dat, bon_nr) IN (SELECT (
    mandant_id, wup_id, wrg_id,
    kassensystem_name, kasse_nr, bon_dat, MIN(bon_nr)
)
FROM dbp_etl.ods_bon_sign_on_off
GROUP BY mandant_id,
wup_id,
wrg_id,
kassensystem_name,
kasse_nr,
bon_dat)
AND transaction_name IN ('SignOffTransaction', 'OperatorLock', 'PosLockTransaction');


CREATE OR REPLACE TABLE dbp_etl.`_not_applicable_${TRANSIENT_TABLE_SUFFIX}` AS
SELECT
    DATE_ADD(A.bon_dat, INTERVAL 1 DAY) AS bon_dat,
    A.wup_id,
    A.wrg_id,
    A.mandant_id,
    A.kassensystem_name,
    A.kasse_nr,
    A.kasse_typ_id,
    A.transaction_name,
    A.bon_ende,
    A.bon_nr
FROM dbp_etl.ods_bon_sign_on_off AS A
INNER JOIN (
    SELECT
        mandant_id,
        wup_id,
        wrg_id,
        kassensystem_name,
        kasse_nr,
        bon_dat,
        MAX(bon_nr) AS min_bon_nr
    FROM dbp_etl.ods_bon_sign_on_off
    GROUP BY
        bon_dat,
        wup_id,
        wrg_id,
        mandant_id,
        kassensystem_name,
        kasse_nr
) AS t0
    ON
        A.mandant_id = t0.mandant_id AND A.wup_id = t0.wup_id AND A.wrg_id = t0.wrg_id AND A.kassensystem_name
        = t0.kassensystem_name AND A.kasse_nr = t0.kasse_nr AND A.bon_dat = t0.bon_dat AND A.bon_nr = t0.min_bon_nr
WHERE A.transaction_name = 'SignOffTransaction';


DELETE FROM dbp_etl.`_fake_entries_${TRANSIENT_TABLE_SUFFIX}`
WHERE (mandant_id, wup_id, wrg_id, kassensystem_name, kasse_nr, bon_dat) IN (SELECT (
    mandant_id, wup_id, wrg_id,
    kassensystem_name, kasse_nr, bon_dat
)
FROM dbp_etl.`_not_applicable_${TRANSIENT_TABLE_SUFFIX}`);


INSERT INTO dbp_etl.ods_bon_sign_on_off (
    bon_dat, wup_id, wrg_id, mandant_id, kassensystem_name, kasse_nr,
    kasse_typ_id, transaction_name, bon_ende, bon_nr
)
(
    SELECT *
    FROM dbp_etl.`_fake_entries_${TRANSIENT_TABLE_SUFFIX}`
);


DROP TABLE IF EXISTS dbp_etl.`_fake_entries_${TRANSIENT_TABLE_SUFFIX}`;


DROP TABLE IF EXISTS dbp_etl.`_not_applicable_${TRANSIENT_TABLE_SUFFIX}`;


CREATE OR REPLACE TABLE dbp_etl.ods_bon_sign_on_off_time (
    wup_id INTEGER NOT NULL,
    wrg_id STRING(3) NOT NULL,
    mandant_id INTEGER NOT NULL,
    kassensystem_name STRING(10),
    kasse_nr INTEGER,
    kasse_typ_id INTEGER,
    start_time DATETIME NOT NULL,
    end_time DATETIME NOT NULL
);


INSERT INTO dbp_etl.ods_bon_sign_on_off_time (
    wup_id, wrg_id, mandant_id, kassensystem_name, kasse_nr,
    kasse_typ_id, start_time, end_time
)
(
    SELECT
        t1.wup_id,
        t1.wrg_id,
        t1.mandant_id,
        t1.kassensystem_name,
        t1.kasse_nr,
        t1.kasse_typ_id,
        t1.bon_ende AS start_time,
        MAX(COALESCE(
            t2.bon_ende, t3.bon_ende, PARSE_DATETIME('%F %H:%M:%S', CAST(DATE(t1.bon_ende) AS STRING) || ' 23:59:59'
            )
        )) AS end_time
    FROM (SELECT
        wup_id,
        wrg_id,
        bon_dat,
        mandant_id,
        kassensystem_name,
        kasse_nr,
        kasse_typ_id,
        bon_ende,
        bon_nr,
        LAG(
            bon_nr) OVER (PARTITION BY wup_id, mandant_id, kasse_nr, bon_dat ORDER BY bon_nr IS NULL DESC, bon_nr DESC) AS
        folgebon,
        CASE
            WHEN (LAG(bon_nr) OVER (
                PARTITION BY
                    wup_id, mandant_id, kasse_nr, bon_dat ORDER BY
                    bon_nr IS NULL DESC, bon_nr
                    DESC
            )) IS NULL
                THEN 99999999
            ELSE LAG(
                bon_nr) OVER (PARTITION BY wup_id, mandant_id, kasse_nr, bon_dat ORDER BY bon_nr IS NULL DESC, bon_nr DESC
            )
        END AS folge_bon_nr
    FROM dbp_etl.ods_bon_sign_on_off
    WHERE transaction_name IN ('SignOnTransaction')) AS t1
    LEFT JOIN (
        SELECT *
        FROM dbp_etl.ods_bon_sign_on_off
        WHERE transaction_name IN ('SignOffTransaction')
    ) AS t2
        ON
            t1.wup_id = t2.wup_id AND t1.wrg_id = t2.wrg_id AND t1.mandant_id
            = t2.mandant_id AND t1.kassensystem_name = t2.kassensystem_name AND t1.kasse_nr = t2.kasse_nr AND t2.bon_nr
            BETWEEN t1.bon_nr AND t1.folge_bon_nr AND t1.bon_dat = t2.bon_dat
    LEFT JOIN (
        SELECT *
        FROM dbp_etl.ods_bon_sign_on_off
        WHERE transaction_name IN ('SignOnTransaction')
    ) AS t3
        ON
            t1.wup_id = t3.wup_id AND t1.wrg_id = t3.wrg_id AND t1.mandant_id
            = t3.mandant_id AND t1.kassensystem_name = t3.kassensystem_name AND t1.kasse_nr = t3.kasse_nr AND t1.folge_bon_nr
            = t3.bon_nr AND t1.bon_dat = t3.bon_dat
    GROUP BY
        t1.mandant_id,
        t1.wup_id,
        t1.wrg_id,
        t1.kassensystem_name,
        t1.kasse_nr,
        t1.kasse_typ_id,
        start_time
);


CREATE OR REPLACE TABLE dbp_etl.`_kill_zombies_${TRANSIENT_TABLE_SUFFIX}` AS
SELECT
    wup_id,
    mandant_id,
    kasse_nr,
    DATE(start_time) AS dat
FROM dbp_etl.ods_bon_sign_on_off_time
WHERE LPAD(
    CAST(EXTRACT(HOUR FROM start_time) AS STRING), 2, '0') || ':' || LPAD(
    CAST(EXTRACT(MINUTE FROM start_time) AS STRING),
    2, '0'
) || ':' || LPAD(CAST(EXTRACT(SECOND FROM start_time) AS STRING), 2, '0'
) = '00:00:00'
AND LPAD(
    CAST(EXTRACT(HOUR FROM end_time) AS STRING), 2, '0') || ':' || LPAD(
    CAST(EXTRACT(MINUTE FROM end_time) AS STRING),
    2, '0'
) || ':' || LPAD(CAST(EXTRACT(SECOND FROM end_time) AS STRING), 2, '0'
) = '23:59:59';


CREATE OR REPLACE TABLE dbp_etl.ods_bon_agg_15min_kassierzeit (
    dat DATE NOT NULL,
    zeit_stunde INTEGER NOT NULL,
    zeit_15min INTEGER NOT NULL,
    mandant_id INTEGER NOT NULL,
    kassensystem_name STRING(10),
    wup_id INTEGER NOT NULL,
    wrg_id STRING(3) NOT NULL,
    kasse_nr INTEGER NOT NULL,
    kasse_typ_id INTEGER NOT NULL,
    kassierzeit INTEGER NOT NULL
);


CREATE OR REPLACE TABLE dbp_etl.`_track_it_${TRANSIENT_TABLE_SUFFIX}` AS
SELECT
    T1.mandant_id,
    T1.kassensystem_name,
    T1.wup_id,
    T1.wrg_id,
    T1.kasse_nr,
    T1.kasse_typ_id,
    t2.zeit_stunde,
    t2.zeit_minute,
    DATE(T1.start_time) AS bon_dat,
    PARSE_DATETIME('%F %H:%M:%S', CAST(DATE(T1.start_time) AS STRING) || ' ' || t2.start_time) AS zeit_scheibe_start,
    DATETIME_ADD(
        PARSE_DATETIME('%F %H:%M:%S', CAST(DATE(T1.start_time) AS STRING) || ' ' || t2.end_time), INTERVAL 1
        SECOND
    ) AS zeit_scheibe_ende,
    T1.start_time,
    T1.end_time
FROM dbp_etl.ods_bon_sign_on_off_time AS T1
INNER JOIN (SELECT
    zeit_stunde,
    zeit_minute,
    CASE
        WHEN zeit_stunde < 10
            THEN '0' || TRIM(SUBSTR(CAST(zeit_stunde AS STRING), 1, 10))
        ELSE TRIM(SUBSTR(CAST(zeit_stunde AS STRING), 1, 10))
    END || ':' || CASE
        WHEN zeit_minute < 10
            THEN '0' || TRIM(SUBSTR(CAST(zeit_minute AS STRING), 1, 10))
        ELSE TRIM(SUBSTR(CAST(zeit_minute AS STRING), 1, 10))
    END || ':00' AS start_time,
    CASE
        WHEN zeit_stunde < 10
            THEN '0' || TRIM(SUBSTR(CAST(zeit_stunde AS STRING), 1, 10))
        ELSE TRIM(SUBSTR(CAST(zeit_stunde AS STRING), 1, 10))
    END || ':' || CASE
        WHEN zeit_minute = 0
            THEN '14:59'
        WHEN zeit_minute = 15
            THEN '29:59'
        WHEN zeit_minute = 30
            THEN '44:59'
        WHEN zeit_minute = 45
            THEN '59:59'
        ELSE NULL
    END AS end_time
FROM dbp_data.zeit) AS t2 ON DATETIME_ADD(PARSE_DATETIME(
    '%F %H:%M:%S', CAST(DATE(T1.start_time) AS STRING)
    || ' ' || t2.end_time
), INTERVAL 1 SECOND) >= T1.start_time AND PARSE_DATETIME('%F %H:%M:%S', CAST(DATE(T1.start_time) AS STRING
)
|| ' ' || t2.start_time) <= T1.end_time;


CREATE OR REPLACE TABLE dbp_etl.ods_bon_agg_15min_umsatz (
    dat DATE NOT NULL,
    zeit_stunde INTEGER NOT NULL,
    zeit_15min INTEGER NOT NULL,
    mandant_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    wrg_id STRING(3) NOT NULL,
    kassensystem_name STRING(10),
    kasse_nr INTEGER NOT NULL,
    kasse_typ_id INTEGER NOT NULL,
    umsatz_brutto NUMERIC(29, 4) DEFAULT 0.0000 NOT NULL,
    umsatz_netto NUMERIC(29, 4) DEFAULT 0.0000 NOT NULL,
    anz_artikel INTEGER NOT NULL,
    anz_kunden INTEGER NOT NULL,
    bonanzahl_sug INTEGER NOT NULL
);


INSERT INTO dbp_etl.ods_bon_agg_15min_umsatz (
    dat, zeit_stunde, zeit_15min, mandant_id, wup_id, wrg_id,
    kassensystem_name, kasse_nr, kasse_typ_id, umsatz_brutto, umsatz_netto, anz_artikel, anz_kunden, bonanzahl_sug
)
(
    SELECT
        bon_dat,
        CASE
            WHEN EXTRACT(HOUR FROM bon_beginn) = 23 AND EXTRACT(HOUR FROM bon_ende) = 0
                THEN 23
            ELSE CAST(EXTRACT(HOUR FROM bon_ende) AS INTEGER)
        END AS zeit_stunde,
        CASE
            WHEN EXTRACT(HOUR FROM bon_beginn) = 23 AND EXTRACT(HOUR FROM bon_ende) = 0
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
        wrg_id,
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
            COALESCE(K.wrg_id, MWZP.wrg_id) AS wrg_id,
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
                WHEN V.talon_id <> 0 AND T.kassensystem_name IN ('KPOS', 'POSITION') AND V.mandant_id > 1
                    THEN V.talon_id
                ELSE NULL
            END AS talon,
            CASE
                WHEN
                    V.wg_id = 980 AND T.kassensystem_name IN ('KPOS', 'POSITION') AND V.umsatz_brutto > 0 OR V.einh_id = 'PND' OR
                    V.talon_id <> 0 AND T.kassensystem_name IN ('KPOS', 'POSITION') AND V.mandant_id > 1
                    THEN 0
                ELSE 1
            END AS track_artikel
        FROM dbp_ods.ods_bon_kopf AS K
        INNER JOIN dbp_data.mandant_wrg_zu_per AS MWZP
            ON
                K.mandant_id = MWZP.mandant_id AND K.bon_dat
                BETWEEN MWZP.dat_von AND MWZP.dat_bis
        LEFT JOIN dbp_ods.ods_bon_transaction AS T
            ON
                K.bon_id = T.bon_id AND K.wup_id = T.wup_id AND K.mandant_id
                = T.mandant_id AND K.bon_dat = T.bon_dat
        INNER JOIN dbp_ods.ods_bon_verkauf AS V ON K.mandant_id = V.mandant_id AND K.wup_id = V.wup_id AND K.bon_id = V.bon_id AND K.bon_dat = V.bon_dat
        INNER JOIN dbp_data.mwst_per AS M
            ON
                V.mandant_id = M.mandant_id AND K.bon_dat BETWEEN M.dat_von AND
                M.dat_bis AND V.mwst_id = M.mwst_id
        WHERE
            K.bon_dat BETWEEN DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL ${days} + 1 DAY) AND (DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 1 DAY))
            AND T.bon_dat BETWEEN DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL ${days} + 1 DAY) AND (DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 1 DAY))
            AND V.bon_dat BETWEEN DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL ${days} + 1 DAY) AND (DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 1 DAY))
            AND K.turnover_fg = 1
            AND (K.mandant_id, K.wup_id, T.kassensystem_name, K.kasse_nr, K.bon_dat) IN (SELECT (
                mandant_id, wup_id,
                kassensystem_name, kasse_nr, bon_dat
            )
            FROM dbp_etl.bon_agg_kassenberichte)
            AND (
                K.bon_id, K.wup_id) NOT IN (
                SELECT (bon_id, wup_id)
                FROM dbp_ods.ods_bon_storno
            )
        UNION ALL
        SELECT
            K.wup_id,
            COALESCE(K.wrg_id, MWZP.wrg_id) AS wrg_id,
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
                WHEN V.talon_id <> 0 AND T.kassensystem_name IN ('KPOS', 'POSITION') AND V.mandant_id > 1
                    THEN V.talon_id
                ELSE NULL
            END AS talon,
            CASE
                WHEN
                    V.wg_id = 980 AND T.kassensystem_name IN ('KPOS', 'POSITION') AND V.umsatz_brutto > 0 AND V.mandant_id > 1 OR
                    V.einh_id = 'PND' OR V.talon_id <> 0 AND T.kassensystem_name IN ('KPOS', 'POSITION') AND V.mandant_id > 1
                    THEN 0
                ELSE 1
            END AS track_artikel
        FROM dbp_ods.ods_bon_kopf AS K
        INNER JOIN dbp_data.mandant_wrg_zu_per AS MWZP
            ON
                K.mandant_id = MWZP.mandant_id AND K.bon_dat
                BETWEEN MWZP.dat_von AND MWZP.dat_bis
        LEFT JOIN dbp_ods.ods_bon_transaction AS T
            ON
                K.bon_id = T.bon_id AND K.wup_id = T.wup_id AND K.mandant_id
                = T.mandant_id AND K.bon_dat = T.bon_dat
        INNER JOIN dbp_ods.ods_bon_retoure AS V ON K.mandant_id = V.mandant_id AND K.wup_id = V.wup_id AND K.bon_id = V.bon_id AND K.bon_dat = V.bon_dat
        INNER JOIN dbp_data.mwst_per AS M
            ON
                V.mandant_id = M.mandant_id AND K.bon_dat BETWEEN M.dat_von AND
                M.dat_bis AND V.mwst_id = M.mwst_id
        WHERE
            K.bon_dat BETWEEN DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL ${days} DAY) AND (DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 1 DAY))
            AND T.bon_dat BETWEEN DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL ${days} DAY) AND (DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 1 DAY))
            AND V.bon_dat BETWEEN DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL ${days} DAY) AND (DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 1 DAY))
            AND K.turnover_fg = 1
            AND (K.mandant_id, K.wup_id, T.kassensystem_name, K.kasse_nr, K.bon_dat) IN (SELECT (
                mandant_id, wup_id,
                kassensystem_name, kasse_nr, bon_dat
            )
            FROM dbp_etl.bon_agg_kassenberichte)
            AND (
                K.bon_id, K.bon_dat) NOT IN (
                SELECT (bon_id, bon_dat)
                FROM dbp_ods.ods_bon_storno
            )
    ) AS t1
    GROUP BY
        bon_dat,
        zeit_stunde,
        zeit_minute,
        wup_id,
        wrg_id,
        mandant_id,
        kassensystem_name,
        kasse_nr,
        kasse_typ_id
);


UPDATE dbp_etl.ods_bon_agg_15min_umsatz AS ods_bon_agg_15min_umsatz1 SET
    bonanzahl_sug = cast(b.bonanzahl_sug as int64) FROM (
    SELECT
        s.mandant_id,
        s.wup_id,
        s.wrg_id,
        s.bon_dat,
        s.zeit_stunde,
        MAX(s.zeit_minute) AS zeit_minute,
        s.kasse_nr,
        W.kundenfaktor,
        s.kasse_typ_id,
        SUM(CEIL(s.bonanzahl_sug)) AS bonanzahl_sug
    FROM (
        SELECT
            K.bon_dat,
            CASE
                WHEN EXTRACT(HOUR FROM K.bon_beginn) = 23 AND EXTRACT(HOUR FROM K.bon_ende) = 0
                    THEN 23
                ELSE CAST(EXTRACT(HOUR FROM K.bon_beginn) AS INTEGER)
            END AS zeit_stunde,
            CASE
                WHEN EXTRACT(HOUR FROM K.bon_beginn) = 23 AND EXTRACT(HOUR FROM K.bon_ende) = 0
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
            K.wrg_id,
            K.kasse_nr,
            K.kasse_typ_id,
            COUNT(DISTINCT CAST(K.kasse_nr AS STRING) || K.bon_id) AS bonanzahl_sug
        FROM dbp_ods.ods_bon_kopf AS K
        INNER JOIN dbp_ods.ods_bon_verkauf AS V ON K.mandant_id = V.mandant_id AND K.wup_id = V.wup_id AND K.bon_id = V.bon_id AND K.bon_dat = V.bon_dat
        WHERE
            K.kunde_fg = 1
            AND V.umsatz_brutto > 0
            AND K.bon_dat BETWEEN DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL ${days} DAY) AND (DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 1 DAY))
            AND V.bon_dat BETWEEN DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL ${days} DAY) AND (DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 1 DAY))
            AND (
                K.mandant_id, K.bon_dat) IN (
                SELECT (mandant_id, dat)
                FROM dbp_etl.ods_bon_agg_15min_umsatz
            )
            AND (
                V.mandant_id, V.bon_dat) IN (
                SELECT (mandant_id, dat)
                FROM dbp_etl.ods_bon_agg_15min_umsatz
            )
            AND (
                K.mandant_id IN (1, 4, 6) OR K.mandant_id IN (2, 5, 7, 8) AND CAST(K.kassierer_nr AS INTEGER) NOT BETWEEN 800
                AND 900 OR K.mandant_id = 3 AND CAST(K.kassierer_nr AS INTEGER) NOT BETWEEN 700 AND 900
            )
            AND K.kasse_typ_id <> 5
            AND (
                K.mandant_id, K.bon_id, K.wup_id) NOT IN (
                SELECT (mandant_id, bon_id, wup_id)
                FROM dbp_ods.ods_bon_storno
            )
        GROUP BY
            K.bon_dat,
            zeit_stunde,
            zeit_minute,
            K.mandant_id,
            K.wup_id,
            K.wrg_id,
            K.kasse_nr,
            K.kasse_typ_id
    ) AS s
    LEFT JOIN dbp_data.wup AS W ON s.mandant_id = W.mandant_id AND s.wup_id = W.wup_id
    GROUP BY
        s.mandant_id,
        s.wup_id,
        s.wrg_id,
        s.bon_dat,
        s.zeit_stunde,
        s.kasse_nr,
        W.kundenfaktor,
        s.kasse_typ_id
) AS b
WHERE
    ods_bon_agg_15min_umsatz1.dat = b.bon_dat AND ods_bon_agg_15min_umsatz1.mandant_id = b.mandant_id AND
    ods_bon_agg_15min_umsatz1.zeit_stunde = b.zeit_stunde AND ods_bon_agg_15min_umsatz1.zeit_15min = b.zeit_minute AND
    ods_bon_agg_15min_umsatz1.wup_id = b.wup_id AND ods_bon_agg_15min_umsatz1.kasse_nr = b.kasse_nr AND
    ods_bon_agg_15min_umsatz1.kasse_typ_id = b.kasse_typ_id;


DELETE FROM dbp_etl.`_track_it_${TRANSIENT_TABLE_SUFFIX}`
WHERE LPAD(
    CAST(EXTRACT(HOUR FROM end_time) AS STRING), 2, '0') || ':' || LPAD(CAST(EXTRACT(MINUTE FROM end_time) AS STRING),
2, '0') || ':' || LPAD(CAST(EXTRACT(SECOND FROM end_time) AS STRING), 2, '0') = '23:59:59' AND (mandant_id,
wup_id, kasse_nr, kasse_typ_id, zeit_stunde, zeit_minute) NOT IN (
    SELECT (
        mandant_id, wup_id, kasse_nr, kasse_typ_id,
        zeit_stunde, zeit_15min
    )
    FROM dbp_etl.ods_bon_agg_15min_umsatz
    WHERE umsatz_brutto <> 0
);


CREATE OR REPLACE TABLE dbp_etl.ods_bon_agg_15min_umsatz_zeilenstorno (
    dat DATE NOT NULL,
    zeit_stunde INTEGER NOT NULL,
    zeit_15min INTEGER NOT NULL,
    mandant_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    wrg_id STRING(3) NOT NULL,
    kassensystem_name STRING(10),
    kasse_nr INTEGER NOT NULL,
    kasse_typ_id INTEGER NOT NULL,
    umsatz_brutto NUMERIC(29, 4) DEFAULT 0.0000 NOT NULL,
    umsatz_netto NUMERIC(29, 4) DEFAULT 0.0000 NOT NULL,
    anz_artikel INTEGER NOT NULL,
    anz_kunden INTEGER NOT NULL,
    bonanzahl_sug INTEGER NOT NULL,
    anz_zeilenstorno INTEGER DEFAULT 0 NOT NULL,
    umsatz_brutto_zeilenstorno NUMERIC(29, 4) DEFAULT 0.0000 NOT NULL,
    umsatz_netto_zeilenstorno NUMERIC(29, 4) DEFAULT 0.0000 NOT NULL,
    anz_bonabbruch_suspended INTEGER DEFAULT 0 NOT NULL,
    anz_bon_zeilenstorno INTEGER DEFAULT 0 NOT NULL,
    anz_bon_kscan INTEGER DEFAULT 0 NOT NULL,
    anz_zeilen_kscan INTEGER DEFAULT 0 NOT NULL,
    umsatz_netto_bonabbruch_suspended NUMERIC(29, 4) DEFAULT 0.0000 NOT NULL,
    umsatz_netto_kscan NUMERIC(29, 4) DEFAULT 0.0000 NOT NULL
);


INSERT INTO dbp_etl.ods_bon_agg_15min_umsatz_zeilenstorno (
    dat, zeit_stunde, zeit_15min, mandant_id,
    wup_id, wrg_id, kassensystem_name, kasse_nr, kasse_typ_id, umsatz_brutto, umsatz_netto, anz_artikel, anz_kunden,
    bonanzahl_sug, anz_zeilenstorno, umsatz_brutto_zeilenstorno, umsatz_netto_zeilenstorno, anz_bonabbruch_suspended,
    anz_bon_zeilenstorno, anz_bon_kscan, anz_zeilen_kscan, umsatz_netto_bonabbruch_suspended, umsatz_netto_kscan
)
(
    SELECT
        K.bon_dat,
        CASE
            WHEN EXTRACT(HOUR FROM K.bon_beginn) = 23 AND EXTRACT(HOUR FROM K.bon_ende) = 0
                THEN 23
            ELSE CAST(EXTRACT(HOUR FROM K.bon_ende) AS INTEGER)
        END AS zeit_stunde,
        CASE
            WHEN EXTRACT(HOUR FROM K.bon_beginn) = 23 AND EXTRACT(HOUR FROM K.bon_ende) = 0
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
        COALESCE(K.wrg_id, MWZP.wrg_id) AS wrg_id,
        T.kassensystem_name,
        K.kasse_nr,
        K.kasse_typ_id,
        0 AS umsatz_brutto,
        0 AS umsatz_netto,
        0 AS anz_artikel,
        0 AS anz_kunden,
        0 AS bonanzahl_sug,
        COUNT(*) AS anz_zeilenstorno,
        SUM(V.umsatz_brutto) AS umsatz_brutto_zeilenstorno,
        SUM(V.umsatz_brutto * 100 / (100 + COALESCE(M.mwst, 0))) AS umsatz_netto_zeilenstorno,
        0 AS anz_bonabbruch_suspended,
        COUNT(DISTINCT K.bon_id) AS anz_bon_zeilenstorno,
        0 AS anz_bon_kscan,
        0 AS anz_zeilen_kscan,
        0 AS umsatz_netto_bonabbruch_suspended,
        0 AS umsatz_netto_kscan
    FROM dbp_ods.ods_bon_kopf AS K
    INNER JOIN dbp_data.mandant_wrg_zu_per AS MWZP
        ON
            K.mandant_id = MWZP.mandant_id AND K.bon_dat BETWEEN
            MWZP.dat_von AND MWZP.dat_bis
    INNER JOIN dbp_ods.ods_bon_transaction AS T
        ON
            K.bon_id = T.bon_id AND K.wup_id = T.wup_id AND K.mandant_id
            = T.mandant_id AND K.bon_dat = T.bon_dat
    INNER JOIN dbp_ods.ods_bon_verkauf AS V
        ON
            K.mandant_id = V.mandant_id AND K.wup_id = V.wup_id AND K.bon_id
            = V.bon_id AND K.bon_dat = V.bon_dat
    INNER JOIN dbp_data.mwst_per AS M ON V.mandant_id = M.mandant_id AND K.bon_dat BETWEEN M.dat_von AND M.dat_bis AND V.mwst_id = M.mwst_id
    WHERE
        K.bon_dat BETWEEN DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL ${days} DAY) AND (DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 1 DAY))
        AND T.bon_dat BETWEEN DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL ${days} DAY) AND (DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 1 DAY))
        AND K.turnover_fg = 1
        AND V.zeilenstorno_fg = 1
        AND EXISTS (
            SELECT 1
            FROM dbp_etl.bon_agg_kassenberichte AS BAK
            WHERE
                mandant_id = K.mandant_id
                AND wup_id = K.wup_id
                AND kassensystem_name = T.kassensystem_name
                AND kasse_nr = K.kasse_nr
                AND bon_dat = K.bon_dat
        )
        AND NOT EXISTS (
            SELECT 1
            FROM dbp_ods.ods_bon_storno AS S
            WHERE
                bon_id = K.bon_id
                AND wup_id = K.wup_id
                AND mandant_id = K.mandant_id
                AND bon_dat = K.bon_dat
        )
    GROUP BY
        K.bon_dat,
        zeit_stunde,
        zeit_minute,
        K.wup_id,
        wrg_id,
        K.mandant_id,
        T.kassensystem_name,
        K.kasse_nr,
        K.kasse_typ_id,
        umsatz_brutto,
        umsatz_netto,
        anz_artikel,
        anz_kunden,
        bonanzahl_sug,
        anz_bonabbruch_suspended,
        anz_bon_kscan,
        anz_zeilen_kscan,
        umsatz_netto_bonabbruch_suspended,
        umsatz_netto_kscan
);


CREATE OR REPLACE TABLE dbp_etl.ods_bon_agg_15min_umsatz_bonstorno (
    dat DATE NOT NULL,
    zeit_stunde INTEGER NOT NULL,
    zeit_15min INTEGER NOT NULL,
    mandant_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    wrg_id STRING(3) NOT NULL,
    kassensystem_name STRING(10),
    kasse_nr INTEGER NOT NULL,
    kasse_typ_id INTEGER NOT NULL,
    umsatz_brutto NUMERIC(29, 4) DEFAULT 0.0000 NOT NULL,
    umsatz_netto NUMERIC(29, 4) DEFAULT 0.0000 NOT NULL,
    anz_artikel INTEGER NOT NULL,
    anz_kunden INTEGER NOT NULL,
    bonanzahl_sug INTEGER NOT NULL,
    anz_bonstorno INTEGER DEFAULT 0 NOT NULL,
    umsatz_brutto_bonstorno NUMERIC(29, 4) DEFAULT 0.0000 NOT NULL,
    umsatz_netto_bonstorno NUMERIC(29, 4) DEFAULT 0.0000 NOT NULL,
    anz_bonabbruch_suspended INTEGER DEFAULT 0 NOT NULL,
    anz_bon_zeilenstorno INTEGER DEFAULT 0 NOT NULL,
    anz_bon_kscan INTEGER DEFAULT 0 NOT NULL,
    anz_zeilen_kscan INTEGER DEFAULT 0 NOT NULL,
    umsatz_netto_bonabbruch_suspended NUMERIC(29, 4) DEFAULT 0.0000 NOT NULL,
    umsatz_netto_kscan NUMERIC(29, 4) DEFAULT 0.0000 NOT NULL
);


INSERT INTO dbp_etl.ods_bon_agg_15min_umsatz_bonstorno (
    dat, zeit_stunde, zeit_15min, mandant_id, wup_id,
    wrg_id, kassensystem_name, kasse_nr, kasse_typ_id, umsatz_brutto, umsatz_netto, anz_artikel, anz_kunden,
    bonanzahl_sug, anz_bonstorno, umsatz_brutto_bonstorno, umsatz_netto_bonstorno, anz_bonabbruch_suspended,
    anz_bon_zeilenstorno, anz_bon_kscan, anz_zeilen_kscan, umsatz_netto_bonabbruch_suspended, umsatz_netto_kscan
)
(
    SELECT
        K.bon_dat,
        CASE
            WHEN EXTRACT(HOUR FROM K.bon_beginn) = 23 AND EXTRACT(HOUR FROM K.bon_ende) = 0
                THEN 23
            ELSE CAST(EXTRACT(HOUR FROM K.bon_ende) AS INTEGER)
        END AS zeit_stunde,
        CASE
            WHEN EXTRACT(HOUR FROM K.bon_beginn) = 23 AND EXTRACT(HOUR FROM K.bon_ende) = 0
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
        COALESCE(K.wrg_id, MWZP.wrg_id) AS wrg_id,
        T.kassensystem_name,
        K.kasse_nr,
        K.kasse_typ_id,
        0 AS umsatz_brutto,
        0 AS umsatz_netto,
        0 AS anz_artikel,
        0 AS anz_kunden,
        0 AS bonanzahl_sug,
        COUNT(DISTINCT K.bon_id) AS anz_bonstorno,
        SUM(V.umsatz_brutto) AS umsatz_brutto_bonstorno,
        SUM(V.umsatz_brutto * 100 / (100 + COALESCE(M.mwst, 0))) AS umsatz_netto_bonstorno,
        0 AS anz_bonabbruch_suspended,
        0 AS anz_bon_zeilenstorno,
        0 AS anz_bon_kscan,
        0 AS anz_zeilen_kscan,
        0 AS umsatz_netto_bonabbruch_suspended,
        0 AS umsatz_netto_kscan
    FROM dbp_ods.ods_bon_kopf AS K
    INNER JOIN dbp_data.mandant_wrg_zu_per AS MWZP
        ON
            K.mandant_id = MWZP.mandant_id AND K.bon_dat BETWEEN
            MWZP.dat_von AND MWZP.dat_bis
    LEFT JOIN dbp_ods.ods_bon_transaction AS T
        ON
            K.bon_id = T.bon_id AND K.wup_id = T.wup_id AND K.mandant_id
            = T.mandant_id AND K.bon_dat = T.bon_dat
    INNER JOIN dbp_ods.ods_bon_verkauf AS V
        ON
            K.mandant_id = V.mandant_id AND K.wup_id = V.wup_id AND K.bon_id
            = V.bon_id AND K.bon_dat = V.bon_dat
    INNER JOIN dbp_data.mwst_per AS M ON V.mandant_id = M.mandant_id AND K.bon_dat BETWEEN M.dat_von AND M.dat_bis AND V.mwst_id = M.mwst_id
    INNER JOIN dbp_ods.ods_bon_storno AS S
        ON
            K.mandant_id = S.mandant_id AND K.wup_id = S.wup_id AND K.bon_id
            = S.bon_id AND K.bon_dat = S.bon_dat
    WHERE
        K.bon_dat BETWEEN DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL ${days} DAY) AND (DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 1 DAY))
        AND T.bon_dat BETWEEN DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL ${days} DAY) AND (DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 1 DAY))
        AND V.bon_dat BETWEEN DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL ${days} DAY) AND (DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 1 DAY))
        AND (K.mandant_id, K.wup_id, T.kassensystem_name, K.kasse_nr, K.bon_dat) IN (SELECT (
            mandant_id, wup_id,
            kassensystem_name, kasse_nr, bon_dat
        )
        FROM dbp_etl.bon_agg_kassenberichte)
    GROUP BY
        K.bon_dat,
        zeit_stunde,
        zeit_minute,
        K.wup_id,
        wrg_id,
        K.mandant_id,
        T.kassensystem_name,
        K.kasse_nr,
        K.kasse_typ_id
);


CREATE OR REPLACE TABLE dbp_etl.ods_bon_agg_15min_umsatz_bonabbruch (
    dat DATE NOT NULL,
    zeit_stunde INTEGER NOT NULL,
    zeit_15min INTEGER NOT NULL,
    mandant_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    wrg_id STRING(3) NOT NULL,
    kassensystem_name STRING(10),
    kasse_nr INTEGER NOT NULL,
    kasse_typ_id INTEGER NOT NULL,
    umsatz_brutto NUMERIC(29, 4) DEFAULT 0.0000 NOT NULL,
    umsatz_netto NUMERIC(29, 4) DEFAULT 0.0000 NOT NULL,
    anz_artikel INTEGER NOT NULL,
    anz_kunden INTEGER NOT NULL,
    bonanzahl_sug INTEGER NOT NULL,
    anz_bonabbruch INTEGER DEFAULT 0 NOT NULL,
    umsatz_brutto_bonabbruch NUMERIC(29, 4) DEFAULT 0.0000 NOT NULL,
    umsatz_netto_bonabbruch NUMERIC(29, 4) DEFAULT 0.0000 NOT NULL,
    anz_bonabbruch_suspended INTEGER DEFAULT 0 NOT NULL,
    anz_bon_zeilenstorno INTEGER DEFAULT 0 NOT NULL,
    anz_bon_kscan INTEGER DEFAULT 0 NOT NULL,
    anz_zeilen_kscan INTEGER DEFAULT 0 NOT NULL,
    umsatz_netto_bonabbruch_suspended NUMERIC(29, 4) DEFAULT 0.0000 NOT NULL,
    umsatz_netto_kscan NUMERIC(29, 4) DEFAULT 0.0000 NOT NULL
);


INSERT INTO dbp_etl.ods_bon_agg_15min_umsatz_bonabbruch (
    dat, zeit_stunde, zeit_15min, mandant_id, wup_id,
    wrg_id, kassensystem_name, kasse_nr, kasse_typ_id, umsatz_brutto, umsatz_netto, anz_artikel, anz_kunden,
    bonanzahl_sug, anz_bonabbruch, umsatz_brutto_bonabbruch, umsatz_netto_bonabbruch, anz_bonabbruch_suspended,
    anz_bon_zeilenstorno, anz_bon_kscan, anz_zeilen_kscan, umsatz_netto_bonabbruch_suspended, umsatz_netto_kscan
)
(
    SELECT
        K.bon_dat,
        CASE
            WHEN EXTRACT(HOUR FROM K.bon_beginn) = 23 AND EXTRACT(HOUR FROM K.bon_ende) = 0
                THEN 23
            ELSE CAST(EXTRACT(HOUR FROM K.bon_ende) AS INTEGER)
        END AS zeit_stunde,
        CASE
            WHEN EXTRACT(HOUR FROM K.bon_beginn) = 23 AND EXTRACT(HOUR FROM K.bon_ende) = 0
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
        COALESCE(K.wrg_id, MWZP.wrg_id) AS wrg_id,
        T.kassensystem_name,
        K.kasse_nr,
        K.kasse_typ_id,
        0 AS ums_brutto,
        0 AS umsatz_netto,
        0 AS anz_artikel,
        0 AS anz_kunden,
        0 AS bonanzahl_sug,
        COUNT(DISTINCT K.bon_id) AS anz_bonabbruch,
        CAST(COALESCE(SUM(V.umsatz_brutto) * -1, 0) AS NUMERIC) AS umsatz_brutto_bonabbruch,
        COALESCE(SUM(V.umsatz_brutto * 100 / (100 + COALESCE(M.mwst, 0))) * -1, 0) AS umsatz_netto_bonabbruch,
        0 AS anz_bonabbruch_suspended,
        0 AS anz_bon_zeilenstorno,
        0 AS anz_bon_kscan,
        0 AS anz_zeilen_kscan,
        0 AS umsatz_netto_bonabbruch_suspended,
        0 AS umsatz_netto_kscan
    FROM dbp_ods.ods_bon_kopf AS K
    INNER JOIN dbp_data.mandant_wrg_zu_per AS MWZP
        ON
            K.mandant_id = MWZP.mandant_id AND K.bon_dat BETWEEN
            MWZP.dat_von AND MWZP.dat_bis
    INNER JOIN dbp_ods.ods_bon_transaction AS T
        ON
            K.bon_id = T.bon_id AND K.wup_id = T.wup_id AND K.mandant_id
            = T.mandant_id AND K.bon_dat = T.bon_dat
    LEFT JOIN dbp_ods.ods_bon_verkauf AS V
        ON
            K.mandant_id = V.mandant_id AND K.wup_id = V.wup_id AND K.bon_id
            = V.bon_id AND K.bon_dat = V.bon_dat
    LEFT JOIN dbp_data.mwst_per AS M
        ON
            V.mandant_id = M.mandant_id AND K.bon_dat BETWEEN M.dat_von AND M.dat_bis
            AND V.mwst_id = M.mwst_id
    WHERE
        K.bon_dat BETWEEN DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL ${days} DAY) AND (DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 1 DAY))
        AND T.bon_dat BETWEEN DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL ${days} DAY) AND (DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 1 DAY))
        AND K.turnover_fg = 0
        AND (
            LOWER(T.bon_abbruch_grund_txt) IN ('manual receipt escape') OR LOWER(T.bon_abbruch_grund_txt) LIKE
            'automatic receipt escape%'
        )
        AND EXISTS (
            SELECT 1
            FROM dbp_etl.bon_agg_kassenberichte AS BAK
            WHERE
                mandant_id = K.mandant_id
                AND wup_id = K.wup_id
                AND kassensystem_name = T.kassensystem_name
                AND kasse_nr = K.kasse_nr
                AND bon_dat = K.bon_dat
        )
    GROUP BY
        K.bon_dat,
        zeit_stunde,
        zeit_minute,
        K.wup_id,
        wrg_id,
        K.mandant_id,
        T.kassensystem_name,
        K.kasse_nr,
        K.kasse_typ_id
);


CREATE OR REPLACE TABLE dbp_etl.ods_bon_agg_15min_umsatz_bonabbruch_suspended (
    dat DATE NOT NULL,
    zeit_stunde INTEGER NOT NULL,
    zeit_15min INTEGER NOT NULL,
    mandant_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    wrg_id STRING(3) NOT NULL,
    kassensystem_name STRING(10),
    kasse_nr INTEGER NOT NULL,
    kasse_typ_id INTEGER NOT NULL,
    umsatz_brutto NUMERIC(29, 4) DEFAULT 0.0000 NOT NULL,
    umsatz_netto NUMERIC(29, 4) DEFAULT 0.0000 NOT NULL,
    anz_artikel INTEGER NOT NULL,
    anz_kunden INTEGER NOT NULL,
    bonanzahl_sug INTEGER NOT NULL,
    anz_bonabbruch INTEGER DEFAULT 0 NOT NULL,
    umsatz_brutto_bonabbruch NUMERIC(29, 4) DEFAULT 0.0000 NOT NULL,
    umsatz_netto_bonabbruch NUMERIC(29, 4) DEFAULT 0.0000 NOT NULL,
    anz_bonabbruch_suspended INTEGER DEFAULT 0 NOT NULL,
    anz_bon_zeilenstorno INTEGER DEFAULT 0 NOT NULL,
    anz_bon_kscan INTEGER DEFAULT 0 NOT NULL,
    anz_zeilen_kscan INTEGER DEFAULT 0 NOT NULL,
    umsatz_netto_bonabbruch_suspended NUMERIC(29, 4) DEFAULT 0.0000 NOT NULL,
    umsatz_netto_kscan NUMERIC(29, 4) DEFAULT 0.0000 NOT NULL
);


INSERT INTO dbp_etl.ods_bon_agg_15min_umsatz_bonabbruch_suspended (
    dat, zeit_stunde, zeit_15min,
    mandant_id, wup_id, wrg_id, kassensystem_name, kasse_nr, kasse_typ_id, umsatz_brutto, umsatz_netto, anz_artikel,
    anz_kunden, bonanzahl_sug, anz_bonabbruch, umsatz_brutto_bonabbruch, umsatz_netto_bonabbruch, anz_bonabbruch_suspended,
    anz_bon_zeilenstorno, anz_bon_kscan, anz_zeilen_kscan, umsatz_netto_bonabbruch_suspended, umsatz_netto_kscan
)
(
    SELECT
        K.bon_dat,
        CASE
            WHEN EXTRACT(HOUR FROM K.bon_beginn) = 23 AND EXTRACT(HOUR FROM K.bon_ende) = 0
                THEN 23
            ELSE CAST(EXTRACT(HOUR FROM K.bon_ende) AS INTEGER)
        END AS zeit_stunde,
        CASE
            WHEN EXTRACT(HOUR FROM K.bon_beginn) = 23 AND EXTRACT(HOUR FROM K.bon_ende) = 0
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
        COALESCE(K.wrg_id, MWZP.wrg_id) AS wrg_id,
        T.kassensystem_name,
        K.kasse_nr,
        K.kasse_typ_id,
        0 AS ums_brutto,
        0 AS umsatz_netto,
        0 AS anz_artikel,
        0 AS anz_kunden,
        0 AS bonanzahl_sug,
        0 AS anz_bonabbruch,
        0 AS umsatz_brutto_bonabbruch,
        0 AS umsatz_netto_bonabbruch,
        COUNT(DISTINCT K.bon_id) AS anz_bonabbruch_suspended,
        0 AS anz_bon_zeilenstorno,
        0 AS anz_bon_kscan,
        0 AS anz_zeilen_kscan,
        COALESCE(SUM(V.umsatz_brutto * 100 / (100 + COALESCE(M.mwst, 0))) * -1, 0) AS umsatz_netto_bonabbruch_suspended,
        0 AS umsatz_netto_kscan
    FROM dbp_ods.ods_bon_kopf AS K
    INNER JOIN dbp_ods.ods_bon_transaction AS T
        ON
            K.bon_id = T.bon_id AND K.wup_id = T.wup_id AND K.mandant_id
            = T.mandant_id AND K.bon_dat = T.bon_dat
    INNER JOIN dbp_data.mandant_wrg_zu_per AS MWZP
        ON
            K.mandant_id = MWZP.mandant_id AND K.bon_dat BETWEEN
            MWZP.dat_von AND MWZP.dat_bis
    LEFT JOIN dbp_ods.ods_bon_verkauf AS V
        ON
            K.mandant_id = V.mandant_id AND K.wup_id = V.wup_id AND K.bon_id
            = V.bon_id AND K.bon_dat = V.bon_dat
    LEFT JOIN dbp_data.mwst_per AS M
        ON
            V.mandant_id = M.mandant_id AND K.bon_dat BETWEEN M.dat_von AND M.dat_bis
            AND V.mwst_id = M.mwst_id
    WHERE
        K.bon_dat BETWEEN DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL ${days} DAY) AND (DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 1 DAY))
        AND T.bon_dat BETWEEN DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL ${days} DAY) AND (DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 1 DAY))
        AND K.turnover_fg = 0
        AND T.cancel_fg <> 0
        AND LOWER(T.bon_abbruch_grund_txt) LIKE 'automatic receipt escape%'
        AND NOT EXISTS (
            SELECT 1
            FROM dbp_ods.ods_bon_storno AS S
            WHERE
                bon_id = K.bon_id
                AND wup_id = K.wup_id
                AND mandant_id = K.mandant_id
                AND bon_dat = K.bon_dat
        )
    GROUP BY
        K.bon_dat,
        zeit_stunde,
        zeit_minute,
        K.wup_id,
        wrg_id,
        K.mandant_id,
        T.kassensystem_name,
        K.kasse_nr,
        K.kasse_typ_id,
        ums_brutto,
        umsatz_netto,
        anz_artikel,
        anz_kunden,
        bonanzahl_sug,
        anz_bonabbruch,
        umsatz_brutto_bonabbruch,
        umsatz_netto_bonabbruch,
        anz_bon_zeilenstorno,
        anz_bon_kscan,
        anz_zeilen_kscan,
        umsatz_netto_kscan
);


CREATE OR REPLACE TABLE dbp_etl.ods_bon_agg_15min_umsatz_kscan (
    dat DATE NOT NULL,
    zeit_stunde INTEGER NOT NULL,
    zeit_15min INTEGER NOT NULL,
    mandant_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    wrg_id STRING(3) NOT NULL,
    kassensystem_name STRING(10),
    kasse_nr INTEGER NOT NULL,
    kasse_typ_id INTEGER NOT NULL,
    umsatz_brutto NUMERIC(29, 4) DEFAULT 0.0000 NOT NULL,
    umsatz_netto NUMERIC(29, 4) DEFAULT 0.0000 NOT NULL,
    anz_artikel INTEGER NOT NULL,
    anz_kunden INTEGER NOT NULL,
    bonanzahl_sug INTEGER NOT NULL,
    anz_zeilenstorno INTEGER DEFAULT 0 NOT NULL,
    umsatz_brutto_zeilenstorno NUMERIC(29, 4) DEFAULT 0.0000 NOT NULL,
    umsatz_netto_zeilenstorno NUMERIC(29, 4) DEFAULT 0.0000 NOT NULL,
    anz_bonabbruch_suspended INTEGER DEFAULT 0 NOT NULL,
    anz_bon_zeilenstorno INTEGER DEFAULT 0 NOT NULL,
    anz_bon_kscan INTEGER DEFAULT 0 NOT NULL,
    anz_zeilen_kscan INTEGER DEFAULT 0 NOT NULL,
    umsatz_netto_bonabbruch_suspended NUMERIC(29, 4) DEFAULT 0.0000 NOT NULL,
    umsatz_netto_kscan NUMERIC(29, 4) DEFAULT 0.0000 NOT NULL
);


INSERT INTO dbp_etl.ods_bon_agg_15min_umsatz_kscan (
    dat, zeit_stunde, zeit_15min, mandant_id, wup_id,
    wrg_id, kassensystem_name, kasse_nr, kasse_typ_id, umsatz_brutto, umsatz_netto, anz_artikel, anz_kunden, bonanzahl_sug,
    anz_zeilenstorno, umsatz_brutto_zeilenstorno, umsatz_netto_zeilenstorno, anz_bonabbruch_suspended,
    anz_bon_zeilenstorno, anz_bon_kscan, anz_zeilen_kscan, umsatz_netto_bonabbruch_suspended, umsatz_netto_kscan
)
(
    SELECT
        K.bon_dat,
        CASE
            WHEN EXTRACT(HOUR FROM K.bon_beginn) = 23 AND EXTRACT(HOUR FROM K.bon_ende) = 0
                THEN 23
            ELSE CAST(EXTRACT(HOUR FROM K.bon_ende) AS INTEGER)
        END AS zeit_stunde,
        CASE
            WHEN EXTRACT(HOUR FROM K.bon_beginn) = 23 AND EXTRACT(HOUR FROM K.bon_ende) = 0
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
        COALESCE(K.wrg_id, MWZP.wrg_id) AS wrg_id,
        T.kassensystem_name,
        K.kasse_nr,
        K.kasse_typ_id,
        SUM(0) AS umsatz_brutto,
        SUM(0) AS umsatz_netto,
        SUM(0) AS anz_artikel,
        SUM(0) AS anz_kunden,
        SUM(0) AS bonanzahl_sug,
        SUM(0) AS anz_zeilenstorno,
        SUM(0) AS umsatz_brutto_zeilenstorno,
        SUM(0) AS umsatz_netto_zeilenstorno,
        SUM(0) AS anz_bonabbruch_suspended,
        SUM(0) AS anz_bon_zeilenstorno,
        COUNT(DISTINCT K.bon_id) AS anz_bon_kscan,
        COUNT(V.bon_zeile) AS anz_zeilen_kscan,
        SUM(0) AS umsatz_netto_bonabbruch_suspended,
        SUM(V.umsatz_brutto * 100 / (100 + COALESCE(M.mwst, 0))) AS umsatz_netto_kscan
    FROM dbp_ods.ods_bon_kopf AS K
    INNER JOIN dbp_data.mandant_wrg_zu_per AS MWZP
        ON
            K.mandant_id = MWZP.mandant_id AND K.bon_dat BETWEEN
            MWZP.dat_von AND MWZP.dat_bis
    LEFT JOIN dbp_ods.ods_bon_transaction AS T
        ON
            K.bon_id = T.bon_id AND K.wup_id = T.wup_id AND K.mandant_id
            = T.mandant_id AND K.bon_dat = T.bon_dat
    INNER JOIN dbp_ods.ods_bon_verkauf AS V
        ON
            K.mandant_id = V.mandant_id AND K.wup_id = V.wup_id AND K.bon_id
            = V.bon_id AND K.bon_dat = V.bon_dat
    INNER JOIN dbp_data.mwst_per AS M ON V.mandant_id = M.mandant_id AND K.bon_dat BETWEEN M.dat_von AND M.dat_bis AND V.mwst_id = M.mwst_id
    WHERE
        K.bon_dat BETWEEN DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL ${days} DAY) AND (DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 1 DAY))
        AND T.bon_dat BETWEEN DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL ${days} DAY) AND (DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 1 DAY))
        AND V.bon_dat BETWEEN DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL ${days} DAY) AND (DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 1 DAY))
        AND K.turnover_fg = 1
        AND (K.mandant_id, K.wup_id, T.kassensystem_name, K.kasse_nr, K.bon_dat) IN (SELECT (
            mandant_id, wup_id,
            kassensystem_name, kasse_nr, bon_dat
        )
        FROM dbp_etl.bon_agg_kassenberichte)
        AND V.kpos_erfassung_id = 'MOBILE_S_SCANN'
        AND (
            K.bon_id, K.wup_id) NOT IN (
            SELECT (bon_id, wup_id)
            FROM dbp_ods.ods_bon_storno
        )
    GROUP BY
        K.bon_dat,
        zeit_stunde,
        zeit_minute,
        K.wup_id,
        wrg_id,
        K.mandant_id,
        T.kassensystem_name,
        K.kasse_nr,
        K.kasse_typ_id
);


INSERT INTO dbp_etl.ods_bon_agg_15min_kassierzeit (
    dat, zeit_stunde, zeit_15min, mandant_id,
    kassensystem_name, wup_id, wrg_id, kasse_nr, kasse_typ_id, kassierzeit
)
(
    SELECT
        bon_dat,
        zeit_stunde,
        zeit_minute,
        mandant_id,
        kassensystem_name,
        wup_id,
        wrg_id,
        kasse_nr,
        kasse_typ_id,
        SUM(TIMESTAMP_DIFF(CASE
            WHEN zeit_scheibe_ende <= end_time
                THEN zeit_scheibe_ende
            ELSE end_time
        END, CASE
            WHEN zeit_scheibe_start >= start_time
                THEN zeit_scheibe_start
            ELSE start_time
        END, SECOND)) AS kassierzeit
    FROM dbp_etl.`_track_it_${TRANSIENT_TABLE_SUFFIX}`
    GROUP BY
        bon_dat,
        zeit_stunde,
        zeit_minute,
        mandant_id,
        kassensystem_name,
        wup_id,
        wrg_id,
        kasse_nr,
        kasse_typ_id
);


CREATE OR REPLACE TABLE dbp_etl.bon_agg_kassierzeiten (
    mandant_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    wrg_id STRING(3) NOT NULL,
    kassensystem_name STRING(10),
    kasse_nr INTEGER NOT NULL,
    kasse_typ_id INTEGER,
    bon_dat DATE NOT NULL,
    bon_beginn DATETIME,
    bon_ende DATETIME,
    scan_ende DATETIME
);


INSERT INTO dbp_etl.bon_agg_kassierzeiten (
    mandant_id, wup_id, wrg_id, kassensystem_name, kasse_nr,
    kasse_typ_id, bon_dat, bon_beginn, bon_ende, scan_ende
)
(SELECT
    t3.mandant_id,
    t3.wup_id,
    t3.b2,
    t3.kassensystem_name,
    t3.kasse_nr,
    t3.kasse_typ_id,
    t3.bon_dat,
    t3.bon_beginn,
    t3.bon_ende,
    t3.scan_ende
FROM (
    SELECT
        K.mandant_id,
        K.wup_id,
        COALESCE(K.wrg_id, MWZP.wrg_id) AS b2,
        T.kassensystem_name,
        K.kasse_nr,
        K.kasse_typ_id,
        K.bon_dat,
        CAST(K.bon_beginn AS DATETIME) AS bon_beginn,
        CAST(K.bon_ende AS DATETIME) AS bon_ende,
        MAX(COALESCE(COALESCE(COALESCE(V.start_bon_zeile, R.start_bon_zeile), F.start_bon_zeile), K.bon_beginn))
            AS
            scan_ende
    FROM dbp_ods.ods_bon_kopf AS K
    INNER JOIN dbp_data.mandant_wrg_zu_per AS MWZP
        ON
            K.mandant_id = MWZP.mandant_id AND K.bon_dat
            BETWEEN MWZP.dat_von AND MWZP.dat_bis
    LEFT JOIN dbp_ods.ods_bon_transaction AS T
        ON
            K.bon_id = T.bon_id AND K.wup_id = T.wup_id AND K.mandant_id
            = T.mandant_id
    LEFT JOIN dbp_ods.ods_bon_verkauf AS V
        ON
            K.bon_id = V.bon_id AND K.wup_id = V.wup_id AND K.mandant_id
            = V.mandant_id
    LEFT JOIN dbp_ods.ods_bon_retoure AS R
        ON
            K.bon_id = R.bon_id AND K.wup_id = R.wup_id AND K.mandant_id
            = R.mandant_id
    LEFT JOIN dbp_ods.ods_bon_financial AS F
        ON
            K.bon_id = F.bon_id AND K.wup_id = F.wup_id AND K.mandant_id
            = F.mandant_id
    WHERE
        K.reactivated_fg = 0
        AND K.bon_dat BETWEEN DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL ${days} DAY) AND (DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 1 DAY))
        AND V.bon_dat BETWEEN DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL ${days} DAY) AND (DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 1 DAY))
        AND T.bon_dat BETWEEN DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL ${days} DAY) AND (DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 1 DAY))
        AND (K.mandant_id, K.wup_id, T.kassensystem_name, K.kasse_nr, K.bon_dat) IN (SELECT (
            mandant_id, wup_id,
            kassensystem_name, kasse_nr, bon_dat
        )
        FROM dbp_etl.bon_agg_kassenberichte)
    GROUP BY
        K.mandant_id,
        K.wup_id,
        b2,
        T.kassensystem_name,
        K.kasse_nr,
        K.kasse_typ_id,
        K.bon_dat,
        bon_beginn,
        bon_ende
) AS t3);


INSERT INTO dbp_etl.bon_agg_kassierzeiten (
    mandant_id, wup_id, wrg_id, kassensystem_name, kasse_nr,
    kasse_typ_id, bon_dat, bon_beginn, bon_ende, scan_ende
)
(SELECT
    mandant_id,
    wup_id,
    wrg_id,
    kassensystem_name,
    kasse_nr,
    kasse_typ_id,
    bon_dat,
    bon_beginn,
    bon_ende,
    scan_ende
FROM (SELECT
    mandant_id,
    wup_id,
    wrg_id,
    kassensystem_name,
    kasse_nr,
    kasse_typ_id,
    bon_dat,
    bon_beginn,
    PARSE_DATETIME('%F %H:%M:%S', FORMAT_DATETIME('%F', bon_beginn) || ' 23:59:59') AS scan_ende,
    bon_ende
FROM dbp_etl.bon_agg_kassierzeiten
WHERE DATE(scan_ende) > DATE(bon_beginn)
UNION ALL
SELECT
    mandant_id,
    wup_id,
    wrg_id,
    kassensystem_name,
    kasse_nr,
    kasse_typ_id,
    bon_dat,
    PARSE_DATETIME('%F %H:%M:%S', FORMAT_DATETIME('%F', scan_ende) || ' 00:00:00') AS bon_beginn,
    scan_ende,
    bon_ende
FROM dbp_etl.bon_agg_kassierzeiten
WHERE DATE(scan_ende) > DATE(bon_beginn)
UNION ALL
SELECT
    mandant_id,
    wup_id,
    wrg_id,
    kassensystem_name,
    kasse_nr,
    kasse_typ_id,
    bon_dat,
    bon_beginn,
    scan_ende,
    PARSE_DATETIME('%F %H:%M:%S', FORMAT_DATETIME('%F', scan_ende) || ' 23:59:59') AS bon_ende
FROM dbp_etl.bon_agg_kassierzeiten
WHERE DATE(scan_ende) < DATE(bon_ende)
UNION ALL
SELECT
    mandant_id,
    wup_id,
    wrg_id,
    kassensystem_name,
    kasse_nr,
    kasse_typ_id,
    bon_dat,
    bon_beginn,
    PARSE_DATETIME('%F %H:%M:%S', FORMAT_DATETIME('%F', bon_ende) || ' 00:00:00') AS scan_ende,
    bon_ende
FROM dbp_etl.bon_agg_kassierzeiten
WHERE DATE(scan_ende) < DATE(bon_ende)) AS t7);


CREATE OR REPLACE TABLE dbp_etl.`_zeit_${TRANSIENT_TABLE_SUFFIX}` AS
SELECT
    zeit_stunde,
    zeit_minute,
    CASE
        WHEN zeit_stunde < 10
            THEN '0' || TRIM(SUBSTR(CAST(zeit_stunde AS STRING), 1, 10))
        ELSE TRIM(SUBSTR(CAST(zeit_stunde AS STRING), 1, 10))
    END || ':' || CASE
        WHEN zeit_minute < 10
            THEN '0' || TRIM(SUBSTR(CAST(zeit_minute AS STRING), 1, 10))
        ELSE TRIM(SUBSTR(CAST(zeit_minute AS STRING), 1, 10))
    END || ':00' AS start_time,
    CASE
        WHEN zeit_stunde < 10
            THEN '0' || TRIM(SUBSTR(CAST(zeit_stunde AS STRING), 1, 10))
        ELSE TRIM(SUBSTR(CAST(zeit_stunde AS STRING), 1, 10))
    END || ':' || CASE
        WHEN zeit_minute = 0
            THEN '14:59'
        WHEN zeit_minute = 15
            THEN '29:59'
        WHEN zeit_minute = 30
            THEN '44:59'
        WHEN zeit_minute = 45
            THEN '59:59'
        ELSE NULL
    END AS end_time
FROM dbp_data.zeit;


CREATE OR REPLACE TABLE dbp_etl.ods_bon_agg_15min_scanzeit (
    dat DATE NOT NULL,
    zeit_stunde INTEGER NOT NULL,
    zeit_15min INTEGER NOT NULL,
    mandant_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    wrg_id STRING(3) NOT NULL,
    kassensystem_name STRING(10),
    kasse_nr INTEGER NOT NULL,
    kasse_typ_id INTEGER NOT NULL,
    scanzeit INTEGER NOT NULL
);


INSERT INTO dbp_etl.ods_bon_agg_15min_scanzeit (
    dat, zeit_stunde, zeit_15min, mandant_id, wup_id, wrg_id,
    kassensystem_name, kasse_nr, kasse_typ_id, scanzeit
)
(
    SELECT
        DATE(t1.bon_beginn) AS bon_dat,
        T2.zeit_stunde,
        T2.zeit_minute,
        t1.mandant_id,
        t1.wup_id,
        t1.wrg_id,
        t1.kassensystem_name,
        t1.kasse_nr,
        t1.kasse_typ_id,
        SUM(TIMESTAMP_DIFF(CASE
            WHEN
                DATETIME_ADD(
                    PARSE_DATETIME('%F %H:%M:%S', FORMAT_DATE('%F', t1.scan_ende) || ' ' || T2.end_time || ':00'),
                    INTERVAL 1 SECOND
                ) <= CAST(SUBSTR(CAST(t1.scan_ende AS STRING), 1, 19) AS DATETIME
                )
                THEN DATETIME_ADD(
                    PARSE_DATETIME('%F %H:%M:%S', FORMAT_DATE('%F', t1.scan_ende) || ' ' || T2.end_time || ':00'),
                    INTERVAL 1 SECOND
                )
            ELSE CAST(SUBSTR(CAST(t1.scan_ende AS STRING), 1, 19) AS DATETIME)
        END, CASE
            WHEN
                PARSE_DATETIME('%F %H:%M:%S', FORMAT_DATE(
                    '%F', t1.scan_ende) || ' ' || T2.start_time || ':00') >= CAST(SUBSTR(
                    CAST(t1.bon_beginn AS STRING),
                    1, 19
                ) AS DATETIME)
                THEN PARSE_DATETIME('%F %H:%M:%S', FORMAT_DATE('%F', t1.scan_ende) || ' ' || T2.start_time || ':00')
            ELSE CAST(SUBSTR(CAST(t1.bon_beginn AS STRING), 1, 19) AS DATETIME)
        END, SECOND)) AS scanzeit
    FROM (
        SELECT
            mandant_id,
            wup_id,
            wrg_id,
            kassensystem_name,
            kasse_nr,
            kasse_typ_id,
            bon_dat,
            bon_beginn,
            scan_ende,
            bon_ende
        FROM dbp_etl.bon_agg_kassierzeiten
        WHERE
            DATE(bon_beginn) = DATE(scan_ende)
            AND bon_beginn < scan_ende
    ) AS t1
    INNER JOIN dbp_etl.`_zeit_${TRANSIENT_TABLE_SUFFIX}` AS T2
        ON DATETIME_ADD(PARSE_DATETIME(
            '%F %H:%M:%S',
            FORMAT_DATETIME('%F', t1.scan_ende) || ' ' || T2.end_time
        ), INTERVAL 1 SECOND) >= t1.scan_ende AND
        PARSE_DATETIME('%F %H:%M:%S', FORMAT_DATETIME('%F', t1.bon_beginn) || ' ' || T2.start_time) <= t1.scan_ende OR
        DATETIME_ADD(
            PARSE_DATETIME('%F %H:%M:%S', FORMAT_DATETIME('%F', t1.scan_ende) || ' ' || T2.end_time), INTERVAL 1
            SECOND
        ) >= t1.bon_beginn AND PARSE_DATETIME('%F %H:%M:%S', FORMAT_DATETIME('%F', t1.bon_beginn) || ' ' || T2.start_time
        ) <= t1.bon_beginn
    WHERE T2.start_time < T2.end_time
    GROUP BY
        bon_dat,
        T2.zeit_stunde,
        T2.zeit_minute,
        t1.mandant_id,
        t1.wup_id,
        t1.wrg_id,
        t1.kassensystem_name,
        t1.kasse_nr,
        t1.kasse_typ_id
);

CREATE OR REPLACE TABLE dbp_etl.ods_bon_agg_15min_zahlzeit (
    dat DATE NOT NULL,
    zeit_stunde INTEGER NOT NULL,
    zeit_15min INTEGER NOT NULL,
    mandant_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    wrg_id STRING(3) NOT NULL,
    kassensystem_name STRING(10),
    kasse_nr INTEGER NOT NULL,
    kasse_typ_id INTEGER NOT NULL,
    zahlzeit INTEGER NOT NULL
);


INSERT INTO dbp_etl.ods_bon_agg_15min_zahlzeit (
    dat, zeit_stunde, zeit_15min, mandant_id, wup_id, wrg_id,
    kassensystem_name, kasse_nr, kasse_typ_id, zahlzeit
)
(
    SELECT
        DATE(t1.bon_ende) AS bon_dat,
        T2.zeit_stunde,
        T2.zeit_minute,
        t1.mandant_id,
        t1.wup_id,
        t1.wrg_id,
        t1.kassensystem_name,
        t1.kasse_nr,
        t1.kasse_typ_id,
        SUM(TIMESTAMP_DIFF(CASE
            WHEN
                DATETIME_ADD(
                    PARSE_DATETIME('%F %H:%M:%S', FORMAT_DATE('%F', t1.bon_ende) || ' ' || T2.end_time || ':00'), INTERVAL
                    1 SECOND
                ) <= CAST(SUBSTR(CAST(t1.bon_ende AS STRING), 1, 19) AS DATETIME
                )
                THEN DATETIME_ADD(
                    PARSE_DATETIME('%F %H:%M:%S', FORMAT_DATE('%F', t1.bon_ende) || ' ' || T2.end_time || ':00'), INTERVAL
                    1 SECOND
                )
            ELSE CAST(SUBSTR(CAST(t1.bon_ende AS STRING), 1, 19) AS DATETIME)
        END, CASE
            WHEN
                PARSE_DATETIME('%F %H:%M:%S', FORMAT_DATE(
                    '%F', t1.bon_ende) || ' ' || T2.start_time || ':00') >= CAST(SUBSTR(
                    CAST(t1.scan_ende AS STRING),
                    1, 19
                ) AS DATETIME)
                THEN PARSE_DATETIME('%F %H:%M:%S', FORMAT_DATE('%F', t1.bon_ende) || ' ' || T2.start_time || ':00')
            ELSE CAST(SUBSTR(CAST(t1.scan_ende AS STRING), 1, 19) AS DATETIME)
        END, SECOND)) AS scanzeit
    FROM (SELECT
        mandant_id,
        wup_id,
        wrg_id,
        kassensystem_name,
        kasse_nr,
        kasse_typ_id,
        bon_dat,
        bon_beginn,
        scan_ende,
        bon_ende
    FROM dbp_etl.bon_agg_kassierzeiten
    WHERE DATE(bon_ende) = DATE(scan_ende)) AS t1
    INNER JOIN dbp_etl.`_zeit_${TRANSIENT_TABLE_SUFFIX}` AS T2
        ON DATETIME_ADD(PARSE_DATETIME(
            '%F %H:%M:%S',
            FORMAT_DATETIME('%F', t1.bon_ende) || ' ' || T2.end_time
        ), INTERVAL 1 SECOND) >= t1.bon_ende AND PARSE_DATETIME('%F %H:%M:%S',
        FORMAT_DATETIME(
            '%F', t1.scan_ende) || ' ' || T2.start_time) <= t1.bon_ende OR DATETIME_ADD(PARSE_DATETIME(
            '%F %H:%M:%S',
            FORMAT_DATETIME('%F', t1.bon_ende) || ' ' || T2.end_time
        ), INTERVAL 1 SECOND) >= t1.scan_ende AND
        PARSE_DATETIME('%F %H:%M:%S', FORMAT_DATETIME('%F', t1.scan_ende) || ' ' || T2.start_time) <= t1.scan_ende
    WHERE
        CAST(
            SUBSTR(CAST(t1.scan_ende AS STRING), 1, 19) AS DATETIME) < CAST(
            SUBSTR(CAST(t1.bon_ende AS STRING), 1, 19)
            AS DATETIME
        )
    GROUP BY
        bon_dat,
        T2.zeit_stunde,
        T2.zeit_minute,
        t1.mandant_id,
        t1.wup_id,
        t1.wrg_id,
        t1.kassensystem_name,
        t1.kasse_nr,
        t1.kasse_typ_id
);


CREATE OR REPLACE TABLE dbp_etl.ods_bon_agg_15min (
    dat DATE NOT NULL,
    zeit_stunde INTEGER NOT NULL,
    zeit_15min INTEGER NOT NULL,
    mandant_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    wrg_id STRING(3) NOT NULL,
    kassensystem_name STRING(10),
    kasse_nr INTEGER NOT NULL,
    kasse_typ_id INTEGER NOT NULL,
    umsatz_brutto NUMERIC(29, 4) DEFAULT 0.0000 NOT NULL,
    umsatz_netto NUMERIC(29, 4) DEFAULT 0.0000 NOT NULL,
    anz_artikel INTEGER NOT NULL,
    anz_kunden INTEGER NOT NULL,
    kassierzeit INTEGER NOT NULL,
    registrierzeit INTEGER NOT NULL,
    zahlzeit INTEGER NOT NULL,
    bonanzahl_sug INTEGER NOT NULL,
    umsatz_brutto_zeilenstorno NUMERIC(29, 4) DEFAULT 0.0000 NOT NULL,
    umsatz_netto_zeilenstorno NUMERIC(29, 4) DEFAULT 0.0000 NOT NULL,
    anz_zeilenstorno INTEGER DEFAULT 0 NOT NULL,
    anz_bonstorno INTEGER DEFAULT 0 NOT NULL,
    umsatz_brutto_bonstorno NUMERIC(29, 4) DEFAULT 0.0000 NOT NULL,
    umsatz_netto_bonstorno NUMERIC(29, 4) DEFAULT 0.0000 NOT NULL,
    anz_bonabbruch INTEGER DEFAULT 0 NOT NULL,
    umsatz_brutto_bonabbruch NUMERIC(29, 4) DEFAULT 0.0000 NOT NULL,
    umsatz_netto_bonabbruch NUMERIC(29, 4) DEFAULT 0.0000 NOT NULL,
    anz_bonabbruch_suspended INTEGER DEFAULT 0 NOT NULL,
    anz_bon_zeilenstorno INTEGER DEFAULT 0 NOT NULL,
    anz_bon_kscan INTEGER DEFAULT 0 NOT NULL,
    anz_zeilen_kscan INTEGER DEFAULT 0 NOT NULL,
    umsatz_netto_bonabbruch_suspended NUMERIC(29, 4) DEFAULT 0.0000 NOT NULL,
    umsatz_netto_kscan NUMERIC(29, 4) DEFAULT 0.0000 NOT NULL
);


INSERT INTO dbp_etl.ods_bon_agg_15min (
    dat, zeit_stunde, zeit_15min, mandant_id, wup_id, wrg_id,
    kassensystem_name, kasse_nr, kasse_typ_id, umsatz_brutto, umsatz_netto, anz_artikel, anz_kunden, kassierzeit,
    registrierzeit, zahlzeit, bonanzahl_sug, umsatz_brutto_zeilenstorno, umsatz_netto_zeilenstorno, anz_zeilenstorno,
    anz_bonstorno, umsatz_brutto_bonstorno, umsatz_netto_bonstorno, anz_bonabbruch, umsatz_brutto_bonabbruch,
    umsatz_netto_bonabbruch, anz_bonabbruch_suspended, anz_bon_zeilenstorno, anz_bon_kscan, anz_zeilen_kscan,
    umsatz_netto_bonabbruch_suspended, umsatz_netto_kscan
)
(SELECT
    dat,
    zeit_stunde,
    zeit_15min,
    mandant_id,
    wup_id,
    wrg_id,
    kassensystem_name,
    kasse_nr,
    kasse_typ_id,
    umsatz_brutto,
    umsatz_netto,
    anz_artikel,
    anz_kunden,
    0 AS kassierzeit,
    0 AS registrierzeit,
    0 AS zahlzeit,
    bonanzahl_sug,
    0 AS umsatz_brutto_zeilenstorno,
    0 AS umsatz_netto_zeilenstorno,
    0 AS anz_zeilenstorno,
    0 AS anz_bonstorno,
    0 AS umsatz_brutto_bonstorno,
    0 AS umsatz_netto_bonstorno,
    0 AS anz_bonabbruch,
    0 AS umsatz_brutto_bonabbruch,
    0 AS umsatz_netto_bonabbruch,
    0 AS anz_bonabbruch_suspended,
    0 AS anz_bon_zeilenstorno,
    0 AS anz_bon_kscan,
    0 AS anz_zeilen_kscan,
    0 AS umsatz_netto_bonabbruch_suspended,
    0 AS umsatz_netto_kscan
FROM dbp_etl.ods_bon_agg_15min_umsatz AS T1);


INSERT INTO dbp_etl.ods_bon_agg_15min (
    dat, zeit_stunde, zeit_15min, mandant_id, wup_id, wrg_id,
    kassensystem_name, kasse_nr, kasse_typ_id, umsatz_brutto, umsatz_netto, anz_artikel, anz_kunden, kassierzeit,
    registrierzeit, zahlzeit, bonanzahl_sug, umsatz_brutto_zeilenstorno, umsatz_netto_zeilenstorno, anz_zeilenstorno,
    anz_bonstorno, umsatz_brutto_bonstorno, umsatz_netto_bonstorno, anz_bonabbruch, umsatz_brutto_bonabbruch,
    umsatz_netto_bonabbruch, anz_bonabbruch_suspended, anz_bon_zeilenstorno, anz_bon_kscan, anz_zeilen_kscan,
    umsatz_netto_bonabbruch_suspended, umsatz_netto_kscan
)
(SELECT
    dat,
    zeit_stunde,
    zeit_15min,
    mandant_id,
    wup_id,
    wrg_id,
    kassensystem_name,
    kasse_nr,
    kasse_typ_id,
    0 AS umsatz_brutto,
    0 AS umsatz_netto,
    0 AS anz_artikel,
    0 AS anz_kunden,
    0 AS kassierzeit,
    0 AS registrierzeit,
    0 AS zahlzeit,
    0 AS bonanzahl_sug,
    umsatz_brutto_zeilenstorno,
    umsatz_netto_zeilenstorno,
    anz_zeilenstorno,
    0 AS anz_bonstorno,
    0 AS umsatz_brutto_bonstorno,
    0 AS umsatz_netto_bonstorno,
    0 AS anz_bonabbruch,
    0 AS umsatz_brutto_bonabbruch,
    0 AS umsatz_netto_bonabbruch,
    0 AS anz_bonabbruch_suspended,
    anz_bon_zeilenstorno,
    0 AS anz_bon_kscan,
    0 AS anz_zeilen_kscan,
    0 AS umsatz_netto_bonabbruch_suspended,
    0 AS umsatz_netto_kscan
FROM dbp_etl.ods_bon_agg_15min_umsatz_zeilenstorno AS T1);


INSERT INTO dbp_etl.ods_bon_agg_15min (
    dat, zeit_stunde, zeit_15min, mandant_id, wup_id, wrg_id,
    kassensystem_name, kasse_nr, kasse_typ_id, umsatz_brutto, umsatz_netto, anz_artikel, anz_kunden, kassierzeit,
    registrierzeit, zahlzeit, bonanzahl_sug, umsatz_brutto_zeilenstorno, umsatz_netto_zeilenstorno, anz_zeilenstorno,
    anz_bonstorno, umsatz_brutto_bonstorno, umsatz_netto_bonstorno, anz_bonabbruch, umsatz_brutto_bonabbruch,
    umsatz_netto_bonabbruch, anz_bonabbruch_suspended, anz_bon_zeilenstorno, anz_bon_kscan, anz_zeilen_kscan,
    umsatz_netto_bonabbruch_suspended, umsatz_netto_kscan
)
(SELECT
    dat,
    zeit_stunde,
    zeit_15min,
    mandant_id,
    wup_id,
    wrg_id,
    kassensystem_name,
    kasse_nr,
    kasse_typ_id,
    0 AS umsatz_brutto,
    0 AS umsatz_netto,
    0 AS anz_artikel,
    0 AS anz_kunden,
    0 AS kassierzeit,
    0 AS registrierzeit,
    0 AS zahlzeit,
    0 AS bonanzahl_sug,
    0 AS umsatz_brutto_zeilenstorno,
    0 AS umsatz_netto_zeilenstorno,
    0 AS anz_zeilenstorno,
    anz_bonstorno,
    umsatz_brutto_bonstorno,
    umsatz_netto_bonstorno,
    0 AS anz_bonabbruch,
    0 AS umsatz_brutto_bonabbruch,
    0 AS umsatz_netto_bonabbruch,
    0 AS anz_bonabbruch_suspended,
    0 AS anz_bon_zeilenstorno,
    0 AS anz_bon_kscan,
    0 AS anz_zeilen_kscan,
    0 AS umsatz_netto_bonabbruch_suspended,
    0 AS umsatz_netto_kscan
FROM dbp_etl.ods_bon_agg_15min_umsatz_bonstorno AS T1);


INSERT INTO dbp_etl.ods_bon_agg_15min (
    dat, zeit_stunde, zeit_15min, mandant_id, wup_id, wrg_id,
    kassensystem_name, kasse_nr, kasse_typ_id, umsatz_brutto, umsatz_netto, anz_artikel, anz_kunden, kassierzeit,
    registrierzeit, zahlzeit, bonanzahl_sug, umsatz_brutto_zeilenstorno, umsatz_netto_zeilenstorno, anz_zeilenstorno,
    anz_bonstorno, umsatz_brutto_bonstorno, umsatz_netto_bonstorno, anz_bonabbruch, umsatz_brutto_bonabbruch,
    umsatz_netto_bonabbruch, anz_bonabbruch_suspended, anz_bon_zeilenstorno, anz_bon_kscan, anz_zeilen_kscan,
    umsatz_netto_bonabbruch_suspended, umsatz_netto_kscan
)
(SELECT
    dat,
    zeit_stunde,
    zeit_15min,
    mandant_id,
    wup_id,
    wrg_id,
    kassensystem_name,
    kasse_nr,
    kasse_typ_id,
    0 AS umsatz_brutto,
    0 AS umsatz_netto,
    0 AS anz_artikel,
    0 AS anz_kunden,
    0 AS kassierzeit,
    0 AS registrierzeit,
    0 AS zahlzeit,
    0 AS bonanzahl_sug,
    0 AS umsatz_brutto_zeilenstorno,
    0 AS umsatz_netto_zeilenstorno,
    0 AS anz_zeilenstorno,
    0 AS anz_bonstorno,
    0 AS umsatz_brutto_bonstorno,
    0 AS umsatz_netto_bonstorno,
    anz_bonabbruch,
    umsatz_brutto_bonabbruch,
    umsatz_netto_bonabbruch,
    0 AS anz_bonabbruch_suspended,
    0 AS anz_bon_zeilenstorno,
    0 AS anz_bon_kscan,
    0 AS anz_zeilen_kscan,
    0 AS umsatz_netto_bonabbruch_suspended,
    0 AS umsatz_netto_kscan
FROM dbp_etl.ods_bon_agg_15min_umsatz_bonabbruch AS T1);


INSERT INTO dbp_etl.ods_bon_agg_15min (
    dat, zeit_stunde, zeit_15min, mandant_id, wup_id, wrg_id,
    kassensystem_name, kasse_nr, kasse_typ_id, umsatz_brutto, umsatz_netto, anz_artikel, anz_kunden, kassierzeit,
    registrierzeit, zahlzeit, bonanzahl_sug, umsatz_brutto_zeilenstorno, umsatz_netto_zeilenstorno, anz_zeilenstorno,
    anz_bonstorno, umsatz_brutto_bonstorno, umsatz_netto_bonstorno, anz_bonabbruch, umsatz_brutto_bonabbruch,
    umsatz_netto_bonabbruch, anz_bonabbruch_suspended, anz_bon_zeilenstorno, anz_bon_kscan, anz_zeilen_kscan,
    umsatz_netto_bonabbruch_suspended, umsatz_netto_kscan
)
(SELECT
    dat,
    zeit_stunde,
    zeit_15min,
    mandant_id,
    wup_id,
    wrg_id,
    kassensystem_name,
    kasse_nr,
    kasse_typ_id,
    0 AS umsatz_brutto,
    0 AS umsatz_netto,
    0 AS anz_artikel,
    0 AS anz_kunden,
    0 AS kassierzeit,
    0 AS registrierzeit,
    0 AS zahlzeit,
    0 AS bonanzahl_sug,
    0 AS umsatz_brutto_zeilenstorno,
    0 AS umsatz_netto_zeilenstorno,
    0 AS anz_zeilenstorno,
    0 AS anz_bonstorno,
    0 AS umsatz_brutto_bonstorno,
    0 AS umsatz_netto_bonstorno,
    0 AS anz_bonabbruch,
    0 AS umsatz_brutto_bonabbruch,
    0 AS umsatz_netto_bonabbruch,
    anz_bonabbruch_suspended,
    0 AS anz_bon_zeilenstorno,
    0 AS anz_bon_kscan,
    0 AS anz_zeilen_kscan,
    umsatz_netto_bonabbruch_suspended,
    0 AS umsatz_netto_kscan
FROM dbp_etl.ods_bon_agg_15min_umsatz_bonabbruch_suspended AS T1);


INSERT INTO dbp_etl.ods_bon_agg_15min (
    dat, zeit_stunde, zeit_15min, mandant_id, wup_id, wrg_id,
    kassensystem_name, kasse_nr, kasse_typ_id, umsatz_brutto, umsatz_netto, anz_artikel, anz_kunden, kassierzeit,
    registrierzeit, zahlzeit, bonanzahl_sug, umsatz_brutto_zeilenstorno, umsatz_netto_zeilenstorno, anz_zeilenstorno,
    anz_bonstorno, umsatz_brutto_bonstorno, umsatz_netto_bonstorno, anz_bonabbruch, umsatz_brutto_bonabbruch,
    umsatz_netto_bonabbruch, anz_bonabbruch_suspended, anz_bon_zeilenstorno, anz_bon_kscan, anz_zeilen_kscan,
    umsatz_netto_bonabbruch_suspended, umsatz_netto_kscan
)
(SELECT
    dat,
    zeit_stunde,
    zeit_15min,
    mandant_id,
    wup_id,
    wrg_id,
    kassensystem_name,
    kasse_nr,
    kasse_typ_id,
    0 AS umsatz_brutto,
    0 AS umsatz_netto,
    0 AS anz_artikel,
    0 AS anz_kunden,
    0 AS kassierzeit,
    0 AS registrierzeit,
    0 AS zahlzeit,
    0 AS bonanzahl_sug,
    0 AS umsatz_brutto_zeilenstorno,
    0 AS umsatz_netto_zeilenstorno,
    0 AS anz_zeilenstorno,
    0 AS anz_bonstorno,
    0 AS umsatz_brutto_bonstorno,
    0 AS umsatz_netto_bonstorno,
    0 AS anz_bonabbruch,
    0 AS umsatz_brutto_bonabbruch,
    0 AS umsatz_netto_bonabbruch,
    0 AS anz_bonabbruch_suspended,
    0 AS anz_bon_zeilenstorno,
    anz_bon_kscan,
    anz_zeilen_kscan,
    0 AS umsatz_netto_bonabbruch_suspended,
    umsatz_netto_kscan
FROM dbp_etl.ods_bon_agg_15min_umsatz_kscan AS T1);


INSERT INTO dbp_etl.ods_bon_agg_15min (
    dat, zeit_stunde, zeit_15min, mandant_id, wup_id, wrg_id,
    kassensystem_name, kasse_nr, kasse_typ_id, umsatz_brutto, umsatz_netto, anz_artikel, anz_kunden, kassierzeit,
    registrierzeit, zahlzeit, bonanzahl_sug, umsatz_brutto_zeilenstorno, umsatz_netto_zeilenstorno, anz_zeilenstorno,
    anz_bonstorno, umsatz_brutto_bonstorno, umsatz_netto_bonstorno, anz_bonabbruch, umsatz_brutto_bonabbruch,
    umsatz_netto_bonabbruch, anz_bonabbruch_suspended, anz_bon_zeilenstorno, anz_bon_kscan, anz_zeilen_kscan,
    umsatz_netto_bonabbruch_suspended, umsatz_netto_kscan
)
(SELECT
    dat,
    zeit_stunde,
    zeit_15min,
    mandant_id,
    wup_id,
    wrg_id,
    kassensystem_name,
    kasse_nr,
    kasse_typ_id,
    0 AS umsatz_brutto,
    0 AS umsatz_netto,
    0 AS anz_artikel,
    0 AS anz_kunden,
    kassierzeit,
    0 AS registrierzeit,
    0 AS zahlzeit,
    0 AS bonanzahl_sug,
    0 AS umsatz_brutto_zeilenstorno,
    0 AS umsatz_netto_zeilenstorno,
    0 AS anz_zeilenstorno,
    0 AS anz_bonstorno,
    0 AS umsatz_brutto_bonstorno,
    0 AS umsatz_netto_bonstorno,
    0 AS anz_bonabbruch,
    0 AS umsatz_brutto_bonabbruch,
    0 AS umsatz_netto_bonabbruch,
    0 AS anz_bonabbruch_suspended,
    0 AS anz_bon_zeilenstorno,
    0 AS anz_bon_kscan,
    0 AS anz_zeilen_kscan,
    0 AS umsatz_netto_bonabbruch_suspended,
    0 AS umsatz_netto_kscan
FROM dbp_etl.ods_bon_agg_15min_kassierzeit AS T1);


INSERT INTO dbp_etl.ods_bon_agg_15min (
    dat, zeit_stunde, zeit_15min, mandant_id, wup_id, wrg_id,
    kassensystem_name, kasse_nr, kasse_typ_id, umsatz_brutto, umsatz_netto, anz_artikel, anz_kunden, kassierzeit,
    registrierzeit, zahlzeit, bonanzahl_sug, umsatz_brutto_zeilenstorno, umsatz_netto_zeilenstorno, anz_zeilenstorno,
    anz_bonstorno, umsatz_brutto_bonstorno, umsatz_netto_bonstorno, anz_bonabbruch, umsatz_brutto_bonabbruch,
    umsatz_netto_bonabbruch, anz_bonabbruch_suspended, anz_bon_zeilenstorno, anz_bon_kscan, anz_zeilen_kscan,
    umsatz_netto_bonabbruch_suspended, umsatz_netto_kscan
)
(SELECT
    dat,
    zeit_stunde,
    zeit_15min,
    mandant_id,
    wup_id,
    wrg_id,
    kassensystem_name,
    kasse_nr,
    kasse_typ_id,
    0 AS umsatz_brutto,
    0 AS umsatz_netto,
    0 AS anz_artikel,
    0 AS anz_kunden,
    0 AS kassierzeit,
    scanzeit AS registrierzeit,
    0 AS zahlzeit,
    0 AS bonanzahl_sug,
    0 AS umsatz_brutto_zeilenstorno,
    0 AS umsatz_netto_zeilenstorno,
    0 AS anz_zeilenstorno,
    0 AS anz_bonstorno,
    0 AS umsatz_brutto_bonstorno,
    0 AS umsatz_netto_bonstorno,
    0 AS anz_bonabbruch,
    0 AS umsatz_brutto_bonabbruch,
    0 AS umsatz_netto_bonabbruch,
    0 AS anz_bonabbruch_suspended,
    0 AS anz_bon_zeilenstorno,
    0 AS anz_bon_kscan,
    0 AS anz_zeilen_kscan,
    0 AS umsatz_netto_bonabbruch_suspended,
    0 AS umsatz_netto_kscan
FROM dbp_etl.ods_bon_agg_15min_scanzeit AS T1);


INSERT INTO dbp_etl.ods_bon_agg_15min (
    dat, zeit_stunde, zeit_15min, mandant_id, wup_id, wrg_id,
    kassensystem_name, kasse_nr, kasse_typ_id, umsatz_brutto, umsatz_netto, anz_artikel, anz_kunden, kassierzeit,
    registrierzeit, zahlzeit, bonanzahl_sug, umsatz_brutto_zeilenstorno, umsatz_netto_zeilenstorno, anz_zeilenstorno,
    anz_bonstorno, umsatz_brutto_bonstorno, umsatz_netto_bonstorno, anz_bonabbruch, umsatz_brutto_bonabbruch,
    umsatz_netto_bonabbruch, anz_bonabbruch_suspended, anz_bon_zeilenstorno, anz_bon_kscan, anz_zeilen_kscan,
    umsatz_netto_bonabbruch_suspended, umsatz_netto_kscan
)
(SELECT
    dat,
    zeit_stunde,
    zeit_15min,
    mandant_id,
    wup_id,
    wrg_id,
    kassensystem_name,
    kasse_nr,
    kasse_typ_id,
    0 AS umsatz_brutto,
    0 AS umsatz_netto,
    0 AS anz_artikel,
    0 AS anz_kunden,
    0 AS kassierzeit,
    0 AS registrierzeit,
    zahlzeit,
    0 AS bonanzahl_sug,
    0 AS umsatz_brutto_zeilenstorno,
    0 AS umsatz_netto_zeilenstorno,
    0 AS anz_zeilenstorno,
    0 AS anz_bonstorno,
    0 AS umsatz_brutto_bonstorno,
    0 AS umsatz_netto_bonstorno,
    0 AS anz_bonabbruch,
    0 AS umsatz_brutto_bonabbruch,
    0 AS umsatz_netto_bonabbruch,
    0 AS anz_bonabbruch_suspended,
    0 AS anz_bon_zeilenstorno,
    0 AS anz_bon_kscan,
    0 AS anz_zeilen_kscan,
    0 AS umsatz_netto_bonabbruch_suspended,
    0 AS umsatz_netto_kscan
FROM dbp_etl.ods_bon_agg_15min_zahlzeit AS T1);


CREATE OR REPLACE TABLE dbp_etl.`_kasse_track_1_${TRANSIENT_TABLE_SUFFIX}` AS
SELECT
    t0.mandant_id,
    t0.wup_id,
    t0.dat,
    t0.kasse_nr,
    t0.kasse_typ_id,
    t0.dfl,
    COUNT(t0.kasse_typ_id) OVER (PARTITION BY t0.mandant_id, t0.wup_id, t0.dat, t0.kasse_nr ORDER BY
        t0.mandant_id IS NULL,
        t0.mandant_id, t0.wup_id IS NULL, t0.wup_id, t0.dat IS NULL, t0.dat, t0.kasse_nr IS NULL, t0.kasse_nr
    RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS anz_kt,
    t0.anz_bons,
    DENSE_RANK() OVER (
        PARTITION BY
            t0.mandant_id, t0.wup_id, t0.dat, t0.kasse_nr ORDER BY
            t0.anz_bons IS NULL DESC, t0.anz_bons
            DESC
    ) AS rang_anz_bons,
    DENSE_RANK() OVER (PARTITION BY t0.mandant_id, t0.wup_id, t0.dat, t0.kasse_nr ORDER BY t0.dfl IS NULL, t0.dfl)
        AS
        rang_anz_dfl
FROM (
    SELECT
        A.mandant_id,
        A.wup_id,
        A.dat,
        A.kasse_nr,
        A.kasse_typ_id,
        COALESCE(B.durchfalllogik_id, 99) AS dfl,
        SUM(A.bonanzahl_sug) AS anz_bons
    FROM dbp_etl.ods_bon_agg_15min AS A
    LEFT JOIN dbp_ods.l_kasse_typ AS B ON A.kasse_typ_id = B.kasse_typ_id
    GROUP BY
        A.mandant_id,
        A.wup_id,
        A.dat,
        A.kasse_nr,
        A.kasse_typ_id,
        dfl
) AS t0;


CREATE OR REPLACE TABLE dbp_etl.`_kasse_track_step1_${TRANSIENT_TABLE_SUFFIX}` AS
SELECT
    mandant_id,
    wup_id,
    dat,
    kasse_nr,
    kasse_typ_id
FROM dbp_etl.`_kasse_track_1_${TRANSIENT_TABLE_SUFFIX}`
WHERE
    anz_kt = 1
    OR anz_kt > 1 AND kasse_typ_id = 2;


DELETE FROM dbp_etl.`_kasse_track_1_${TRANSIENT_TABLE_SUFFIX}`
WHERE (
    mandant_id, wup_id, dat, kasse_nr) IN (
    SELECT (mandant_id, wup_id, dat, kasse_nr)
    FROM dbp_etl.`_kasse_track_step1_${TRANSIENT_TABLE_SUFFIX}`
);


CREATE OR REPLACE TABLE dbp_etl.`_kasse_track_step2_${TRANSIENT_TABLE_SUFFIX}` AS
SELECT
    mandant_id,
    wup_id,
    dat,
    kasse_nr,
    kasse_typ_id
FROM dbp_etl.`_kasse_track_1_${TRANSIENT_TABLE_SUFFIX}`
WHERE
    anz_kt > 1
    AND rang_anz_bons = 1
GROUP BY
    mandant_id,
    wup_id,
    dat,
    kasse_nr,
    kasse_typ_id;


DELETE FROM dbp_etl.`_kasse_track_1_${TRANSIENT_TABLE_SUFFIX}`
WHERE (
    mandant_id, wup_id, dat, kasse_nr) IN (
    SELECT (mandant_id, wup_id, dat, kasse_nr)
    FROM dbp_etl.`_kasse_track_step2_${TRANSIENT_TABLE_SUFFIX}`
    GROUP BY
        mandant_id,
        wup_id,
        dat,
        kasse_nr
    HAVING COUNT(*) = 1
);


CREATE OR REPLACE TABLE dbp_etl.`_kasse_track_step3_${TRANSIENT_TABLE_SUFFIX}` AS
SELECT
    mandant_id,
    wup_id,
    dat,
    kasse_nr,
    kasse_typ_id
FROM dbp_etl.`_kasse_track_1_${TRANSIENT_TABLE_SUFFIX}`
WHERE
    anz_kt > 1
    AND rang_anz_bons = 1
    AND rang_anz_dfl = 1
GROUP BY
    mandant_id,
    wup_id,
    dat,
    kasse_nr,
    kasse_typ_id;


DELETE FROM dbp_etl.`_kasse_track_step2_${TRANSIENT_TABLE_SUFFIX}`
WHERE (
    mandant_id, wup_id, dat, kasse_nr) IN (
    SELECT (mandant_id, wup_id, dat, kasse_nr)
    FROM dbp_etl.`_kasse_track_step3_${TRANSIENT_TABLE_SUFFIX}`
);


CREATE OR REPLACE TABLE dbp_etl.`_kasse_track_final_${TRANSIENT_TABLE_SUFFIX}` AS
(
    SELECT *
    FROM dbp_etl.`_kasse_track_step1_${TRANSIENT_TABLE_SUFFIX}`
    UNION DISTINCT
    SELECT *
    FROM dbp_etl.`_kasse_track_step2_${TRANSIENT_TABLE_SUFFIX}`
)
UNION DISTINCT
SELECT *
FROM dbp_etl.`_kasse_track_step3_${TRANSIENT_TABLE_SUFFIX}`;


UPDATE dbp_etl.ods_bon_agg_15min AS O SET
    wrg_id = M.wrg_id,
    umsatz_brutto = O.umsatz_brutto / M.umrechnungskurs,
    umsatz_netto = O.umsatz_netto / M.umrechnungskurs
FROM dbp_data.mandant_wrg_zu_per AS M
WHERE
    M.mandant_id = O.mandant_id AND CURRENT_DATE("Europe/Berlin") BETWEEN M.dat_von AND M.dat_bis AND O.wrg_id <> M.wrg_id AND M.umrechnungskurs
    IS NOT NULL;


DROP TABLE IF EXISTS dbp_etl.ods_bon_15min_agg;


CREATE OR REPLACE TABLE dbp_etl.ods_bon_15min_agg (
    dat DATE NOT NULL,
    zeit_stunde INTEGER NOT NULL,
    zeit_15min INTEGER NOT NULL,
    mandant_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    wrg_id STRING(3) NOT NULL,
    kasse_nr INTEGER NOT NULL,
    kasse_typ_id INTEGER NOT NULL,
    umsatz_brutto NUMERIC(29, 4) DEFAULT 0.0000 NOT NULL,
    umsatz_netto NUMERIC(29, 4) DEFAULT 0.0000 NOT NULL,
    anz_artikel INTEGER NOT NULL,
    anz_kunden INTEGER NOT NULL,
    kassierzeit INTEGER NOT NULL,
    registrierzeit INTEGER NOT NULL,
    zahlzeit INTEGER NOT NULL,
    bonanzahl_sug INTEGER NOT NULL,
    anz_zeilenstorno INTEGER DEFAULT 0 NOT NULL,
    umsatz_brutto_zeilenstorno NUMERIC(29, 4) DEFAULT 0.0000 NOT NULL,
    umsatz_netto_zeilenstorno NUMERIC(29, 4) DEFAULT 0.0000 NOT NULL,
    anz_bonstorno INTEGER DEFAULT 0 NOT NULL,
    umsatz_brutto_bonstorno NUMERIC(29, 4) DEFAULT 0.0000 NOT NULL,
    umsatz_netto_bonstorno NUMERIC(29, 4) DEFAULT 0.0000 NOT NULL,
    anz_bonabbruch INTEGER DEFAULT 0 NOT NULL,
    umsatz_brutto_bonabbruch NUMERIC(29, 4) DEFAULT 0.0000 NOT NULL,
    umsatz_netto_bonabbruch NUMERIC(29, 4) DEFAULT 0.0000 NOT NULL,
    anz_bonabbruch_suspended INTEGER DEFAULT 0 NOT NULL,
    anz_bon_zeilenstorno INTEGER DEFAULT 0 NOT NULL,
    anz_bon_kscan INTEGER DEFAULT 0 NOT NULL,
    anz_zeilen_kscan INTEGER DEFAULT 0 NOT NULL,
    umsatz_netto_bonabbruch_suspended NUMERIC(29, 4) DEFAULT 0.0000 NOT NULL,
    umsatz_netto_kscan NUMERIC(29, 4) DEFAULT 0.0000 NOT NULL
);


INSERT INTO dbp_etl.ods_bon_15min_agg (
    dat, zeit_stunde, zeit_15min, mandant_id, wup_id, wrg_id, kasse_nr,
    kasse_typ_id, umsatz_brutto, umsatz_netto, anz_artikel, anz_kunden, kassierzeit, registrierzeit, zahlzeit,
    bonanzahl_sug, anz_zeilenstorno, umsatz_brutto_zeilenstorno, umsatz_netto_zeilenstorno, anz_bonstorno,
    umsatz_brutto_bonstorno, umsatz_netto_bonstorno, anz_bonabbruch, umsatz_brutto_bonabbruch, umsatz_netto_bonabbruch,
    anz_bonabbruch_suspended, anz_bon_zeilenstorno, anz_bon_kscan, anz_zeilen_kscan, umsatz_netto_bonabbruch_suspended,
    umsatz_netto_kscan
)
(
    SELECT
        dat,
        zeit_stunde,
        zeit_15min,
        mandant_id,
        wup_id,
        wrg_id,
        kasse_nr,
        kasse_typ_id,
        SUM(umsatz_brutto) AS umsatz_brutto,
        SUM(umsatz_netto) AS umsatz_netto,
        SUM(anz_artikel) AS anz_artikel,
        SUM(anz_kunden) AS anz_kunden,
        SUM(kassierzeit) AS kassierzeit,
        SUM(registrierzeit) AS registrierzeit,
        SUM(zahlzeit) AS zahlzeit,
        SUM(bonanzahl_sug) AS bonanzahl_sug,
        SUM(anz_zeilenstorno) AS anz_zeilenstorno,
        SUM(umsatz_brutto_zeilenstorno) AS umsatz_brutto_zeilenstorno,
        SUM(umsatz_netto_zeilenstorno) AS umsatz_netto_zeilenstorno,
        SUM(anz_bonstorno) AS anz_bonstorno,
        SUM(umsatz_brutto_bonstorno) AS umsatz_brutto_bonstorno,
        SUM(umsatz_netto_bonstorno) AS umsatz_netto_bonstorno,
        SUM(anz_bonabbruch) AS anz_bonabbruch,
        SUM(umsatz_brutto_bonabbruch) AS umsatz_brutto_bonabbruch,
        SUM(umsatz_netto_bonabbruch) AS umsatz_netto_bonabbruch,
        SUM(anz_bonabbruch_suspended) AS anz_bonabbruch_suspended,
        SUM(anz_bon_zeilenstorno) AS anz_bon_zeilenstorno,
        SUM(anz_bon_kscan) AS anz_bon_kscan,
        SUM(anz_zeilen_kscan) AS anz_zeilen_kscan,
        SUM(umsatz_netto_bonabbruch_suspended) AS umsatz_netto_bonabbruch_suspended,
        SUM(umsatz_netto_kscan) AS umsatz_netto_kscan
    FROM dbp_etl.ods_bon_agg_15min
    WHERE kassensystem_name IN ('', 'KPOS', 'LUCAS', 'POSITION')
    GROUP BY
        dat,
        zeit_stunde,
        zeit_15min,
        mandant_id,
        wup_id,
        wrg_id,
        kasse_nr,
        kasse_typ_id
);


DELETE FROM dbp_etl.ods_bon_15min_agg
WHERE umsatz_brutto = 0 AND anz_artikel = 0 AND kassierzeit = 900 AND (mandant_id, wup_id, dat, kasse_nr) IN (SELECT (
    mandant_id,
    wup_id, dat, kasse_nr
)
FROM dbp_etl.`_kill_zombies_${TRANSIENT_TABLE_SUFFIX}`);


UPDATE dbp_etl.ods_bon_15min_agg SET
    kassierzeit = 900
WHERE kassierzeit > 900;


UPDATE dbp_etl.ods_bon_15min_agg SET
    registrierzeit = 0,
    zahlzeit = 0
WHERE umsatz_brutto = 0;


DELETE FROM dbp_etl.ods_bon_15min_agg
WHERE zeit_stunde <= 1 AND anz_kunden = 0;


DELETE FROM dbp_ods.ods_bon_agg_15min
WHERE (dat, wup_id, wrg_id, mandant_id, zeit_stunde, zeit_15min, kasse_nr) IN (SELECT (
    dat, wup_id, wrg_id, mandant_id,
    zeit_stunde, zeit_15min, kasse_nr
)
FROM (SELECT DISTINCT
    dat,
    wup_id,
    wrg_id,
    mandant_id,
    zeit_stunde,
    zeit_15min,
    kasse_nr
FROM dbp_etl.ods_bon_agg_15min
WHERE zeit_stunde <= 1) AS t1);


DELETE FROM dbp_ods.ods_bon_agg_15min
WHERE dat BETWEEN DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL ${days} DAY) AND (DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 1 DAY));


INSERT INTO dbp_ods.ods_bon_agg_15min (
    dat, zeit_stunde, zeit_15min, mandant_id, wup_id, kasse_nr,
    kasse_typ_id, wrg_id, umsatz_brutto, umsatz_brutto_zeilenstorno, umsatz_brutto_bonstorno, umsatz_brutto_bonabbruch,
    umsatz_netto, umsatz_netto_zeilenstorno, umsatz_netto_bonstorno, umsatz_netto_bonabbruch, anz_artikel, anz_kunden,
    anz_zeilenstorno, anz_bonstorno, anz_bonabbruch, kassierzeit, registrierzeit, zahlzeit, bonanzahl_sug_okf,
    anz_bonabbruch_suspended, anz_bon_zeilenstorno, anz_bon_kscan, anz_zeilen_kscan, umsatz_netto_bonabbruch_suspended,
    umsatz_netto_kscan, td_update, td_insert
)
(SELECT
    dat,
    zeit_stunde,
    zeit_15min,
    mandant_id,
    wup_id,
    kasse_nr,
    kasse_typ_id,
    wrg_id,
    umsatz_brutto,
    umsatz_brutto_zeilenstorno,
    umsatz_brutto_bonstorno,
    umsatz_brutto_bonabbruch,
    umsatz_netto,
    umsatz_netto_zeilenstorno,
    umsatz_netto_bonstorno,
    umsatz_netto_bonabbruch,
    anz_artikel,
    anz_kunden,
    anz_zeilenstorno,
    anz_bonstorno,
    anz_bonabbruch,
    kassierzeit,
    registrierzeit,
    zahlzeit,
    bonanzahl_sug,
    anz_bonabbruch_suspended,
    anz_bon_zeilenstorno,
    anz_bon_kscan,
    anz_zeilen_kscan,
    umsatz_netto_bonabbruch_suspended,
    umsatz_netto_kscan,
    CURRENT_TIMESTAMP(),
    CURRENT_TIMESTAMP()
FROM dbp_etl.ods_bon_15min_agg
WHERE dat BETWEEN DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL ${days} DAY) AND (DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 1 DAY)));


CREATE OR REPLACE TABLE dbp_etl.`_obsolet_${TRANSIENT_TABLE_SUFFIX}` AS
SELECT *
FROM dbp_ods.ods_bon_transaction
WHERE transaction_name IN (
    'SignOffTransaction', 'SignOnTransaction', 'OperatorLock', 'OperatorUnlock',
    'PosUnlockTransaction', 'PosLockTransaction'
)
AND bon_dat BETWEEN (
    SELECT MIN(bon_dat)
    FROM dbp_etl.bon_agg_kassenberichte_tmp) AND (
    SELECT MAX(bon_dat)
    FROM dbp_etl.bon_agg_kassenberichte_tmp
);


DELETE FROM dbp_ods.ods_bon_agg_15min
WHERE dat BETWEEN (
    SELECT MIN(bon_dat)
    FROM dbp_etl.bon_agg_kassenberichte_tmp) AND (
    SELECT MAX(bon_dat)
    FROM dbp_etl.bon_agg_kassenberichte_tmp
) AND umsatz_brutto = 0 AND anz_artikel = 0 AND kassierzeit
NOT IN (
    0, 900) AND (wup_id, mandant_id, kasse_nr, dat) NOT IN (
    SELECT (wup_id, mandant_id, kasse_nr, bon_dat)
    FROM dbp_etl.`_obsolet_${TRANSIENT_TABLE_SUFFIX}`
);


DELETE FROM dbp_ods.ods_bon_agg_15min
WHERE (
    wup_id, wrg_id, mandant_id, kasse_nr, dat) IN (
    SELECT (wup_id, wrg_id, mandant_id, kasse_nr, dat)
    FROM dbp_ods.ods_bon_agg_15min
    WHERE
        dat BETWEEN (
            SELECT MIN(bon_dat)
            FROM dbp_etl.bon_agg_kassenberichte_tmp) AND (
            SELECT MAX(bon_dat)
            FROM dbp_etl.bon_agg_kassenberichte_tmp
        )
        AND umsatz_brutto = 0
        AND anz_artikel = 0
        AND kassierzeit <> 0
        AND (
            wup_id, mandant_id, kasse_nr, dat) NOT IN (
            SELECT (wup_id, mandant_id, kasse_nr, bon_dat)
            FROM dbp_etl.`_obsolet_${TRANSIENT_TABLE_SUFFIX}`
        )
    GROUP BY
        dat,
        mandant_id,
        wup_id,
        kasse_nr,
        wrg_id
    HAVING MIN(zeit_stunde) NOT IN (0, 1)
);


CREATE OR REPLACE TABLE dbp_etl.vis_tag_kasse (
    wup_id INTEGER NOT NULL,
    wrg_id STRING(3) NOT NULL,
    nb_id INTEGER NOT NULL,
    mandant_id INTEGER NOT NULL,
    dat DATE NOT NULL,
    kasse_nr INTEGER NOT NULL,
    kasse_typ_id INTEGER DEFAULT -1 NOT NULL,
    kassierzeit NUMERIC(29, 2) DEFAULT 0.00 NOT NULL,
    anz_artikel INTEGER DEFAULT 0 NOT NULL,
    registrierzeit NUMERIC(29, 2),
    umsatz_netto NUMERIC(29, 4) DEFAULT 0.0000 NOT NULL,
    anz_kunden INTEGER DEFAULT 0 NOT NULL,
    kassiervorgangszeit INTEGER DEFAULT 0 NOT NULL,
    umsatz_netto_bonabbruch NUMERIC(29, 4) DEFAULT 0 NOT NULL,
    umsatz_netto_bonstorno NUMERIC(29, 4) DEFAULT 0 NOT NULL,
    umsatz_netto_zeilenstorno NUMERIC(29, 4) DEFAULT 0 NOT NULL,
    anz_zeilenstorno INTEGER DEFAULT 0 NOT NULL,
    anz_bonstorno INTEGER DEFAULT 0 NOT NULL,
    anz_bonabbruch INTEGER DEFAULT 0 NOT NULL,
    anz_bonabbruch_suspended INTEGER DEFAULT 0 NOT NULL,
    anz_bon_zeilenstorno INTEGER DEFAULT 0 NOT NULL,
    anz_bon_kscan INTEGER DEFAULT 0 NOT NULL,
    anz_zeilen_kscan INTEGER DEFAULT 0 NOT NULL,
    umsatz_netto_bonabbruch_suspended NUMERIC(29, 4) DEFAULT 0.0000 NOT NULL,
    umsatz_netto_kscan NUMERIC(29, 4) DEFAULT 0.0000 NOT NULL
);


INSERT INTO dbp_etl.vis_tag_kasse (
    wup_id, wrg_id, nb_id, mandant_id, dat, kasse_nr, kasse_typ_id,
    kassierzeit, anz_artikel, registrierzeit, umsatz_netto, anz_kunden, kassiervorgangszeit, umsatz_netto_bonabbruch,
    umsatz_netto_bonstorno, umsatz_netto_zeilenstorno, anz_zeilenstorno, anz_bonstorno, anz_bonabbruch,
    anz_bonabbruch_suspended, anz_bon_zeilenstorno, anz_bon_kscan, anz_zeilen_kscan, umsatz_netto_bonabbruch_suspended,
    umsatz_netto_kscan
)
(
    SELECT
        AGG.wup_id,
        AGG.wrg_id,
        0 AS nb_id,
        AGG.mandant_id,
        AGG.dat,
        AGG.kasse_nr,
        AGG.kasse_typ_id,
        SUM(AGG.kassierzeit) AS kassierzeit,
        SUM(AGG.anz_artikel) AS anz_artikel,
        SUM(AGG.registrierzeit) AS registrierzeit,
        SUM(AGG.umsatz_netto) AS umsatz_netto,
        SUM(AGG.anz_kunden) AS anz_kunden,
        SUM(AGG.registrierzeit + AGG.zahlzeit) AS kassiervorgangszeit,
        SUM(AGG.umsatz_netto_bonabbruch),
        SUM(AGG.umsatz_netto_bonstorno),
        SUM(AGG.umsatz_netto_zeilenstorno),
        SUM(AGG.anz_zeilenstorno),
        SUM(AGG.anz_bonstorno),
        SUM(AGG.anz_bonabbruch),
        SUM(AGG.anz_bonabbruch_suspended),
        SUM(AGG.anz_bon_zeilenstorno),
        SUM(AGG.anz_bon_kscan),
        SUM(AGG.anz_zeilen_kscan),
        SUM(AGG.umsatz_netto_bonabbruch_suspended),
        SUM(AGG.umsatz_netto_kscan)
    FROM dbp_ods.ods_bon_agg_15min AS AGG
    INNER JOIN dbp_etl.bon_agg_kassenberichte AS K
        ON
            AGG.mandant_id = K.mandant_id AND AGG.wup_id = K.wup_id
            AND AGG.dat = K.bon_dat AND AGG.kasse_nr = K.kasse_nr
    WHERE K.bon_dat BETWEEN DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL ${days} DAY) AND (DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 1 DAY))
    GROUP BY
        AGG.wup_id,
        AGG.wrg_id,
        nb_id,
        AGG.mandant_id,
        AGG.dat,
        AGG.kasse_nr,
        AGG.kasse_typ_id
);


DELETE FROM dbp_data.vis_tag_kasse
WHERE dat BETWEEN DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL ${days} DAY) AND (DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 1 DAY));


INSERT INTO dbp_data.vis_tag_kasse (
    wup_id, nb_id, mandant_id, dat, kasse_nr, kasse_typ_id, wrg_id,
    umsatz_netto, umsatz_netto_zeilenstorno, umsatz_netto_bonstorno, umsatz_netto_bonabbruch, anz_artikel, anz_kunden,
    anz_zeilenstorno, anz_bonstorno, anz_bonabbruch, kassierzeit, registrierzeit, kassiervorgangszeit,
    anz_bonabbruch_suspended, anz_bon_zeilenstorno, anz_bon_kscan, anz_zeilen_kscan, umsatz_netto_bonabbruch_suspended,
    umsatz_netto_kscan, td_update, td_insert
)
(SELECT
    wup_id,
    nb_id,
    mandant_id,
    dat,
    kasse_nr,
    kasse_typ_id,
    wrg_id,
    umsatz_netto,
    umsatz_netto_zeilenstorno,
    umsatz_netto_bonstorno,
    umsatz_netto_bonabbruch,
    anz_artikel,
    anz_kunden,
    anz_zeilenstorno,
    anz_bonstorno,
    anz_bonabbruch,
    CAST(kassierzeit AS INTEGER) AS kassierzeit,
    CAST(registrierzeit AS INTEGER) AS registrierzeit,
    kassiervorgangszeit,
    anz_bonabbruch_suspended,
    anz_bon_zeilenstorno,
    anz_bon_kscan,
    anz_zeilen_kscan,
    umsatz_netto_bonabbruch_suspended,
    umsatz_netto_kscan,
    CURRENT_TIMESTAMP(),
    CURRENT_TIMESTAMP()
FROM dbp_etl.vis_tag_kasse
WHERE dat BETWEEN DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL ${days} DAY) AND (DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 1 DAY)));


UPDATE dbp_data.wupcal AS W SET
    wrg_id = M.wrg_id
FROM dbp_data.mandant_wrg_zu_per AS M
WHERE W.mandant_id = M.mandant_id AND W.dat BETWEEN M.dat_von AND M.dat_bis AND W.wrg_id IS NULL;


UPDATE dbp_ods.bon_load_status SET
    ods_bon_agg_fg = 1,
    td_update = CURRENT_TIMESTAMP()
WHERE xml_name IN (
    SELECT xml_name
    FROM dbp_etl.bon_agg_kassenberichte_tmp
);
