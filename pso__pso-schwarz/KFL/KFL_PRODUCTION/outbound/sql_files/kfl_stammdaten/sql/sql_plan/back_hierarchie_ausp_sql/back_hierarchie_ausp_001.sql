DROP TABLE IF EXISTS dbp_etl.bake_final;


DROP TABLE IF EXISTS dbp_data.`_perf`;


DROP TABLE IF EXISTS dbp_data.`_join_help`;


DROP TABLE IF EXISTS dbp_etl.ausp_work;


DROP TABLE IF EXISTS dbp_etl.cabn_work;


DROP TABLE IF EXISTS dbp_etl.bake_final_de;


CREATE TABLE IF NOT EXISTS dbp_etl.bake_final (
    mandant_id INTEGER,
    wup_id INTEGER,
    nb_id INTEGER,
    the_type STRING(1) COLLATE 'und:ci',
    oventype STRING(2) COLLATE 'und:ci',
    dat_von DATE,
    dat_bis DATE,
    anz_blech INTEGER,
    anz_ofen INTEGER,
    gp_backen_bez STRING(20) COLLATE 'und:ci',
    klart STRING(3) COLLATE 'und:ci',
    art_id INTEGER,
    bestell_art_id INTEGER,
    inhalt_menge NUMERIC(29, 3),
    back_aufbereitung_id INTEGER,
    back_hinweis_id INTEGER,
    back_programm_id INTEGER,
    blechbelegung INTEGER
);


CREATE TABLE IF NOT EXISTS dbp_etl.bake_final_de (
    mandant_id INTEGER,
    wup_id INTEGER,
    nb_id INTEGER,
    the_type STRING(1) COLLATE 'und:ci',
    oventype STRING(2) COLLATE 'und:ci',
    dat_von DATE,
    dat_bis DATE,
    anz_blech INTEGER,
    anz_ofen INTEGER,
    gp_backen_bez STRING(20) COLLATE 'und:ci',
    klart STRING(3) COLLATE 'und:ci',
    art_id INTEGER,
    bestell_art_id INTEGER,
    inhalt_menge NUMERIC(29, 3),
    back_aufbereitung_id INTEGER,
    back_hinweis_id INTEGER,
    back_programm_id INTEGER,
    blechbelegung INTEGER
);


CREATE TABLE IF NOT EXISTS dbp_etl.ausp_work AS
SELECT *
FROM dbp_etl.ausp;


CREATE TABLE IF NOT EXISTS dbp_etl.cabn_work AS
SELECT *
FROM dbp_etl.cabn;


CREATE TEMPORARY TABLE IF NOT EXISTS _perf AS
SELECT mandant_id
FROM dbp_etl.ausp_work
GROUP BY mandant_id;


CREATE TEMPORARY TABLE IF NOT EXISTS _join_help (
    the_type STRING(1)
);


INSERT INTO `_join_help` (the_type)
VALUES ('A');


INSERT INTO `_join_help` (the_type)
VALUES ('B');


INSERT INTO `_join_help` (the_type)
VALUES ('C');


INSERT INTO `_join_help` (the_type)
VALUES ('D');


INSERT INTO `_join_help` (the_type)
VALUES ('E');


INSERT INTO dbp_etl.bake_final (
    mandant_id, wup_id, nb_id, the_type, oventype, dat_von, dat_bis,
    anz_blech, anz_ofen, gp_backen_bez, klart
)
(
    SELECT
        x1.mandant_id,
        x1.wup_id,
        x1.nb_id,
        TRIM(x1.the_type) AS the_type,
        TRIM(x2.oventype) AS oventype,
        x3.dat_von,
        x4.dat_bis,
        CAST(x5.anz_blech AS INTEGER) AS anz_blech,
        CAST(x6.anz_ofen AS INTEGER) AS anz_ofen,
        COALESCE(x8.gp_backen_bez, 'N.N.') AS gp_backen_bez,
        x1.klart
    FROM (
        SELECT
            A.mandant_id,
            C.wup_id,
            C.nb_id,
            B.the_type,
            A.klart
        FROM dbp_etl.ausp_work AS A
        INNER JOIN `_join_help` AS B ON TRUE
        INNER JOIN dbp_data.wup AS C ON A.objek = C.wup_id AND A.mandant_id = C.mandant_id
        WHERE A.klart = 'Z30'
        GROUP BY
            A.mandant_id,
            A.klart,
            B.the_type,
            C.wup_id,
            C.nb_id
    ) AS x1
    INNER JOIN (
        SELECT
            A0.mandant_id,
            B0.objek AS wup_id,
            TRIM(B0.atwrt) AS oventype,
            CASE
                WHEN SUBSTR(TRIM(A0.atnam), 12, 3) = '00A'
                    THEN 'A'
                WHEN SUBSTR(TRIM(A0.atnam), 12, 3) = '00B'
                    THEN 'B'
                WHEN SUBSTR(TRIM(A0.atnam), 12, 3) = '00C'
                    THEN 'C'
                WHEN SUBSTR(TRIM(A0.atnam), 12, 3) = '00D'
                    THEN 'D'
                ELSE 'E'
            END AS the_type
        FROM dbp_etl.cabn_work AS A0
        INNER JOIN dbp_etl.ausp_work AS B0
            ON
                A0.mandant_id = B0.mandant_id AND A0.atinn = B0.atinn AND B0.klart
                = 'Z30'
        WHERE
            SUBSTR(TRIM(A0.atnam), 8, 3) = 'WER'
            AND SUBSTR(TRIM(A0.atnam), 16, 3) = '001'
    ) AS x2
        ON
            x1.mandant_id = x2.mandant_id AND x1.wup_id = x2.wup_id AND x1.the_type
            = x2.the_type
    INNER JOIN (
        SELECT
            A1.mandant_id,
            B1.objek AS wup_id,
            PARSE_DATE('%Y%m%d', CAST(B1.atflv AS STRING)) AS dat_von,
            CASE
                WHEN SUBSTR(TRIM(A1.atnam), 12, 3) = '00A'
                    THEN 'A'
                WHEN SUBSTR(TRIM(A1.atnam), 12, 3) = '00B'
                    THEN 'B'
                WHEN SUBSTR(TRIM(A1.atnam), 12, 3) = '00C'
                    THEN 'C'
                WHEN SUBSTR(TRIM(A1.atnam), 12, 3) = '00D'
                    THEN 'D'
                ELSE 'E'
            END AS the_type
        FROM dbp_etl.cabn_work AS A1
        INNER JOIN dbp_etl.ausp_work AS B1
            ON
                A1.mandant_id = B1.mandant_id AND A1.atinn = B1.atinn AND B1.klart
                = 'Z30'
        WHERE
            SUBSTR(TRIM(A1.atnam), 8, 3) = 'WER'
            AND SUBSTR(TRIM(A1.atnam), 16, 3) = '002'
            AND B1.atflv <> 3
    ) AS x3 ON x1.mandant_id = x3.mandant_id AND x1.wup_id = x3.wup_id AND x1.the_type = x3.the_type
    INNER JOIN (
        SELECT
            A2.mandant_id,
            B2.objek AS wup_id,
            PARSE_DATE('%Y%m%d', CAST(B2.atflv AS STRING)) AS dat_bis,
            CASE
                WHEN SUBSTR(TRIM(A2.atnam), 12, 3) = '00A'
                    THEN 'A'
                WHEN SUBSTR(TRIM(A2.atnam), 12, 3) = '00B'
                    THEN 'B'
                WHEN SUBSTR(TRIM(A2.atnam), 12, 3) = '00C'
                    THEN 'C'
                WHEN SUBSTR(TRIM(A2.atnam), 12, 3) = '00D'
                    THEN 'D'
                ELSE 'E'
            END AS the_type
        FROM dbp_etl.cabn_work AS A2
        INNER JOIN dbp_etl.ausp_work AS B2
            ON
                A2.mandant_id = B2.mandant_id AND A2.atinn = B2.atinn AND B2.klart
                = 'Z30'
        WHERE
            SUBSTR(TRIM(A2.atnam), 8, 3) = 'WER'
            AND SUBSTR(TRIM(A2.atnam), 16, 3) = '003'
    ) AS x4
        ON
            x1.mandant_id = x4.mandant_id AND x1.wup_id = x4.wup_id AND x1.the_type
            = x4.the_type
    INNER JOIN (
        SELECT
            A3.mandant_id,
            B3.objek AS wup_id,
            CAST(B3.atflv AS INTEGER) AS anz_blech,
            CASE
                WHEN SUBSTR(TRIM(A3.atnam), 12, 3) = '00A'
                    THEN 'A'
                WHEN SUBSTR(TRIM(A3.atnam), 12, 3) = '00B'
                    THEN 'B'
                WHEN SUBSTR(TRIM(A3.atnam), 12, 3) = '00C'
                    THEN 'C'
                WHEN SUBSTR(TRIM(A3.atnam), 12, 3) = '00D'
                    THEN 'D'
                ELSE 'E'
            END AS the_type
        FROM dbp_etl.cabn_work AS A3
        INNER JOIN dbp_etl.ausp_work AS B3
            ON
                A3.mandant_id = B3.mandant_id AND A3.atinn = B3.atinn AND B3.klart
                = 'Z30'
        WHERE
            SUBSTR(TRIM(A3.atnam), 8, 3) = 'WER'
            AND SUBSTR(TRIM(A3.atnam), 16, 3) = '004'
    ) AS x5
        ON
            x1.mandant_id = x5.mandant_id AND x1.wup_id = x5.wup_id AND x1.the_type
            = x5.the_type
    INNER JOIN (
        SELECT
            A4.mandant_id,
            B4.objek AS wup_id,
            CAST(B4.atflv AS INTEGER) AS anz_ofen,
            CASE
                WHEN SUBSTR(TRIM(A4.atnam), 12, 3) = '00A'
                    THEN 'A'
                WHEN SUBSTR(TRIM(A4.atnam), 12, 3) = '00B'
                    THEN 'B'
                WHEN SUBSTR(TRIM(A4.atnam), 12, 3) = '00C'
                    THEN 'C'
                WHEN SUBSTR(TRIM(A4.atnam), 12, 3) = '00D'
                    THEN 'D'
                ELSE 'E'
            END AS the_type
        FROM dbp_etl.cabn_work AS A4
        INNER JOIN dbp_etl.ausp_work AS B4
            ON
                A4.mandant_id = B4.mandant_id AND A4.atinn = B4.atinn AND B4.klart
                = 'Z30'
        WHERE
            SUBSTR(TRIM(A4.atnam), 8, 3) = 'WER'
            AND SUBSTR(TRIM(A4.atnam), 16, 3) = '005'
    ) AS x6
        ON
            x1.mandant_id = x6.mandant_id AND x1.wup_id = x6.wup_id AND x1.the_type
            = x6.the_type
    INNER JOIN (
        SELECT
            A5.mandant_id,
            B5.objek AS wup_id,
            TRIM(B5.atwrt) AS backplan_fg,
            CASE
                WHEN SUBSTR(TRIM(A5.atnam), 12, 3) = '00A'
                    THEN 'A'
                WHEN SUBSTR(TRIM(A5.atnam), 12, 3) = '00B'
                    THEN 'B'
                WHEN SUBSTR(TRIM(A5.atnam), 12, 3) = '00C'
                    THEN 'C'
                WHEN SUBSTR(TRIM(A5.atnam), 12, 3) = '00D'
                    THEN 'D'
                ELSE 'E'
            END AS the_type
        FROM dbp_etl.cabn_work AS A5
        INNER JOIN dbp_etl.ausp_work AS B5
            ON
                A5.mandant_id = B5.mandant_id AND A5.atinn = B5.atinn AND B5.klart
                = 'Z30'
        WHERE
            SUBSTR(TRIM(A5.atnam), 8, 3) = 'WER'
            AND SUBSTR(TRIM(A5.atnam), 16, 3) = '006'
    ) AS x7
        ON
            x1.mandant_id = x7.mandant_id AND x1.wup_id = x7.wup_id AND x1.the_type
            = x7.the_type
    LEFT JOIN (
        SELECT
            A6.mandant_id,
            B6.objek AS wup_id,
            UPPER(TRIM(B6.atwrt)) AS gp_backen_bez,
            CASE
                WHEN SUBSTR(TRIM(A6.atnam), 12, 3) = '00A'
                    THEN 'A'
                WHEN SUBSTR(TRIM(A6.atnam), 12, 3) = '00B'
                    THEN 'B'
                WHEN SUBSTR(TRIM(A6.atnam), 12, 3) = '00C'
                    THEN 'C'
                WHEN SUBSTR(TRIM(A6.atnam), 12, 3) = '00D'
                    THEN 'D'
                ELSE 'E'
            END AS the_type
        FROM dbp_etl.cabn_work AS A6
        INNER JOIN dbp_etl.ausp_work AS B6
            ON
                A6.mandant_id = B6.mandant_id AND A6.atinn = B6.atinn AND B6.klart
                = 'Z30'
        WHERE
            SUBSTR(TRIM(A6.atnam), 8, 3) = 'WER'
            AND SUBSTR(TRIM(A6.atnam), 16, 3) = '009'
    ) AS x8
        ON
            x1.mandant_id = x8.mandant_id AND x1.wup_id = x8.wup_id AND x1.the_type
            = x8.the_type
    WHERE x7.backplan_fg = 'Y'
    GROUP BY
        x1.mandant_id,
        x1.wup_id,
        x1.nb_id,
        the_type,
        oventype,
        x3.dat_von,
        x4.dat_bis,
        anz_blech,
        anz_ofen,
        gp_backen_bez,
        x1.klart
);


CREATE OR REPLACE TABLE dbp_etl.`_art_mix` AS
SELECT
    A.mandant_id,
    C.art_id,
    B.the_type,
    A.klart
FROM dbp_etl.ausp_work AS A
INNER JOIN `_join_help` AS B ON TRUE
INNER JOIN dbp_data.art AS C
    ON
        A.objek = C.kl_art_id AND A.mandant_id = C.mandant_id AND CURRENT_DATE("Europe/Berlin")
        BETWEEN C.dat_von AND C.dat_bis
WHERE
    A.klart = 'Z01'
    AND C.mandant_id IN (
        SELECT mandant_id
        FROM `_perf`
    )
GROUP BY
    A.mandant_id,
    C.art_id,
    B.the_type,
    A.klart;


CREATE TEMPORARY TABLE IF NOT EXISTS _snap1 AS
SELECT
    A.mandant_id,
    C1.art_id,
    C2.art_id AS bestell_art_id,
    D.the_type
FROM dbp_etl.cabn_work AS A
INNER JOIN dbp_etl.ausp_work AS B ON A.mandant_id = B.mandant_id AND A.atinn = B.atinn
INNER JOIN dbp_data.art AS C1
    ON
        B.objek = C1.kl_art_id AND B.mandant_id = C1.mandant_id AND
        CURRENT_DATE("Europe/Berlin") BETWEEN C1.dat_von AND C1.dat_bis
INNER JOIN dbp_data.art AS C2
    ON
        B.atwrt = CAST(C2.kl_art_id AS STRING) AND B.mandant_id = C2.mandant_id
        AND CURRENT_DATE("Europe/Berlin") BETWEEN C2.dat_von AND C2.dat_bis
INNER JOIN `_join_help` AS D ON TRUE
WHERE
    B.klart = 'Z01'
    AND SUBSTR(A.atnam, 8, 3) = 'MAT'
    AND SUBSTR(A.atnam, 16, 3) = '001'
    AND LENGTH(TRANSLATE(TRIM(B.atwrt), 'a1234567890', 'a')) = 0
    AND C1.mandant_id IN (
        SELECT mandant_id
        FROM `_perf`
    )
    AND C2.mandant_id IN (
        SELECT mandant_id
        FROM `_perf`
    );


CREATE TEMPORARY TABLE IF NOT EXISTS _snap2 AS
SELECT
    A.mandant_id,
    C.art_id,
    CAST(B.atflv AS NUMERIC) AS inhalt_menge,
    D.the_type
FROM dbp_etl.cabn_work AS A
INNER JOIN dbp_etl.ausp_work AS B ON A.mandant_id = B.mandant_id AND A.atinn = B.atinn
INNER JOIN dbp_data.art AS C
    ON
        B.objek = C.kl_art_id AND B.mandant_id = C.mandant_id AND CURRENT_DATE("Europe/Berlin")
        BETWEEN C.dat_von AND C.dat_bis
INNER JOIN `_join_help` AS D ON TRUE
WHERE
    B.klart = 'Z01'
    AND SUBSTR(A.atnam, 8, 3) = 'MAT'
    AND SUBSTR(A.atnam, 16, 3) = '003'
    AND C.mandant_id IN (
        SELECT mandant_id
        FROM `_perf`
    );


CREATE TEMPORARY TABLE IF NOT EXISTS _snap3 AS
SELECT
    A.mandant_id,
    C.art_id,
    CAST(B.atflv AS INTEGER) AS back_aufbereitung_id,
    D.the_type
FROM dbp_etl.cabn_work AS A
INNER JOIN dbp_etl.ausp_work AS B ON A.mandant_id = B.mandant_id AND A.atinn = B.atinn
INNER JOIN dbp_data.art AS C
    ON
        B.objek = C.kl_art_id AND B.mandant_id = C.mandant_id AND CURRENT_DATE("Europe/Berlin")
        BETWEEN C.dat_von AND C.dat_bis
INNER JOIN `_join_help` AS D ON TRUE
WHERE
    B.klart = 'Z01'
    AND SUBSTR(A.atnam, 8, 3) = 'MAT'
    AND SUBSTR(A.atnam, 16, 3) = '004'
    AND C.mandant_id IN (
        SELECT mandant_id
        FROM `_perf`
    );


CREATE TEMPORARY TABLE IF NOT EXISTS _snap4 AS
SELECT
    A.mandant_id,
    C.art_id,
    CAST(B.atflv AS INTEGER) AS back_hinweis_id,
    D.the_type
FROM dbp_etl.cabn_work AS A
INNER JOIN dbp_etl.ausp_work AS B ON A.mandant_id = B.mandant_id AND A.atinn = B.atinn
INNER JOIN dbp_data.art AS C
    ON
        B.objek = C.kl_art_id AND B.mandant_id = C.mandant_id AND CURRENT_DATE("Europe/Berlin")
        BETWEEN C.dat_von AND C.dat_bis
INNER JOIN `_join_help` AS D ON TRUE
WHERE
    B.klart = 'Z01'
    AND SUBSTR(A.atnam, 8, 3) = 'MAT'
    AND SUBSTR(A.atnam, 16, 3) = '005'
    AND C.mandant_id IN (
        SELECT mandant_id
        FROM `_perf`
    );


CREATE TEMPORARY TABLE IF NOT EXISTS _snap5 AS
SELECT
    A.mandant_id,
    C.art_id,
    CAST(B.atflv AS INTEGER) AS back_programm_id,
    D.the_type
FROM dbp_etl.cabn_work AS A
INNER JOIN dbp_etl.ausp_work AS B ON A.mandant_id = B.mandant_id AND A.atinn = B.atinn
INNER JOIN dbp_data.art AS C
    ON
        B.objek = C.kl_art_id AND B.mandant_id = C.mandant_id AND CURRENT_DATE("Europe/Berlin")
        BETWEEN C.dat_von AND C.dat_bis
INNER JOIN `_join_help` AS D ON TRUE
WHERE
    B.klart = 'Z01'
    AND SUBSTR(A.atnam, 8, 3) = 'MAT'
    AND SUBSTR(A.atnam, 16, 3) = '006'
    AND C.mandant_id IN (
        SELECT mandant_id
        FROM `_perf`
    );


CREATE TEMPORARY TABLE IF NOT EXISTS _snap6 AS
SELECT
    A.mandant_id,
    C.art_id,
    CAST(B.atflv AS INTEGER) AS blechbelegung_a,
    D.the_type
FROM dbp_etl.cabn_work AS A
INNER JOIN dbp_etl.ausp_work AS B
    ON
        A.mandant_id = B.mandant_id AND A.atinn = B.atinn AND B.klart =
        'Z01'
INNER JOIN dbp_data.art AS C
    ON
        B.objek = C.kl_art_id AND B.mandant_id = C.mandant_id AND CURRENT_DATE("Europe/Berlin")
        BETWEEN C.dat_von AND C.dat_bis
INNER JOIN `_join_help` AS D ON 'A' = D.the_type
WHERE
    SUBSTR(A.atnam, 8, 3) = 'MAT'
    AND SUBSTR(A.atnam, 16, 4) = '00A2'
    AND C.mandant_id IN (
        SELECT mandant_id
        FROM `_perf`
    );


CREATE TEMPORARY TABLE IF NOT EXISTS _snap7 AS
SELECT
    A.mandant_id,
    C.art_id,
    CAST(B.atflv AS INTEGER) AS blechbelegung_b,
    D.the_type
FROM dbp_etl.cabn_work AS A
INNER JOIN dbp_etl.ausp_work AS B
    ON
        A.mandant_id = B.mandant_id AND A.atinn = B.atinn AND B.klart =
        'Z01'
INNER JOIN dbp_data.art AS C
    ON
        B.objek = C.kl_art_id AND B.mandant_id = C.mandant_id AND CURRENT_DATE("Europe/Berlin")
        BETWEEN C.dat_von AND C.dat_bis
INNER JOIN `_join_help` AS D ON 'B' = D.the_type
WHERE
    SUBSTR(A.atnam, 8, 3) = 'MAT'
    AND SUBSTR(A.atnam, 16, 4) = '00B2'
    AND C.mandant_id IN (
        SELECT mandant_id
        FROM `_perf`
    );


CREATE TEMPORARY TABLE IF NOT EXISTS _snap8 AS
SELECT
    A.mandant_id,
    C.art_id,
    CAST(B.atflv AS INTEGER) AS blechbelegung_c,
    D.the_type
FROM dbp_etl.cabn_work AS A
INNER JOIN dbp_etl.ausp_work AS B
    ON
        A.mandant_id = B.mandant_id AND A.atinn = B.atinn AND B.klart =
        'Z01'
INNER JOIN dbp_data.art AS C
    ON
        B.objek = C.kl_art_id AND B.mandant_id = C.mandant_id AND CURRENT_DATE("Europe/Berlin")
        BETWEEN C.dat_von AND C.dat_bis
INNER JOIN `_join_help` AS D ON 'C' = D.the_type
WHERE
    SUBSTR(A.atnam, 8, 3) = 'MAT'
    AND SUBSTR(A.atnam, 16, 4) = '00C2'
    AND C.mandant_id IN (
        SELECT mandant_id
        FROM `_perf`
    );


CREATE TEMPORARY TABLE IF NOT EXISTS _snap9 AS
SELECT
    A.mandant_id,
    C.art_id,
    CAST(B.atflv AS INTEGER) AS blechbelegung_d,
    D.the_type
FROM dbp_etl.cabn_work AS A
INNER JOIN dbp_etl.ausp_work AS B
    ON
        A.mandant_id = B.mandant_id AND A.atinn = B.atinn AND B.klart =
        'Z01'
INNER JOIN dbp_data.art AS C
    ON
        B.objek = C.kl_art_id AND B.mandant_id = C.mandant_id AND CURRENT_DATE("Europe/Berlin")
        BETWEEN C.dat_von AND C.dat_bis
INNER JOIN `_join_help` AS D ON 'D' = D.the_type
WHERE
    SUBSTR(A.atnam, 8, 3) = 'MAT'
    AND SUBSTR(A.atnam, 16, 4) = '00D2'
    AND C.mandant_id IN (
        SELECT mandant_id
        FROM `_perf`
    );


CREATE TEMPORARY TABLE IF NOT EXISTS _snap10 AS
SELECT
    A.mandant_id,
    C.art_id,
    CAST(B.atflv AS INTEGER) AS blechbelegung_e,
    D.the_type
FROM dbp_etl.cabn_work AS A
INNER JOIN dbp_etl.ausp_work AS B
    ON
        A.mandant_id = B.mandant_id AND A.atinn = B.atinn AND B.klart =
        'Z01'
INNER JOIN dbp_data.art AS C
    ON
        B.objek = C.kl_art_id AND B.mandant_id = C.mandant_id AND CURRENT_DATE("Europe/Berlin")
        BETWEEN C.dat_von AND C.dat_bis
INNER JOIN `_join_help` AS D ON 'E' = D.the_type
WHERE
    SUBSTR(A.atnam, 8, 3) = 'MAT'
    AND SUBSTR(A.atnam, 16, 4) = '00E2'
    AND C.mandant_id IN (
        SELECT mandant_id
        FROM `_perf`
    );


/* Bestellartikel */ INSERT INTO dbp_etl.bake_final (
    mandant_id, the_type, klart, art_id, bestell_art_id,
    inhalt_menge, back_aufbereitung_id, back_hinweis_id, back_programm_id, blechbelegung
)
(
    SELECT
        X1.mandant_id,
        X1.the_type,
        X1.klart,
        X1.art_id,
        X2.bestell_art_id,
        X3.inhalt_menge,
        CAST(X4.back_aufbereitung_id AS INTEGER) AS back_aufbereitung_id,
        CAST(X5.back_hinweis_id AS INTEGER) AS back_hinweis_id,
        CAST(X6.back_programm_id AS INTEGER) AS back_programm_id,
        CAST(COALESCE(X7.blechbelegung_a, X8.blechbelegung_b, X9.blechbelegung_c, X10.blechbelegung_d, X11.blechbelegung_e, 0) AS INTEGER)
            AS blechbelegung
    FROM dbp_etl.`_art_mix` AS X1
    INNER JOIN `_snap1` AS X2 ON X1.mandant_id = X2.mandant_id AND X1.art_id = X2.art_id AND X1.the_type = X2.the_type
    /* Inhaltsmenge */
    INNER JOIN `_snap2` AS X3 ON X1.mandant_id = X3.mandant_id AND X1.art_id = X3.art_id AND X1.the_type = X3.the_type
    /* Veredlungsschritte */
    INNER JOIN `_snap3` AS X4 ON X1.mandant_id = X4.mandant_id AND X1.art_id = X4.art_id AND X1.the_type = X4.the_type
    /* Backhinweis */
    INNER JOIN `_snap4` AS X5 ON X1.mandant_id = X5.mandant_id AND X1.art_id = X5.art_id AND X1.the_type = X5.the_type
    /* Backprogramm */
    INNER JOIN `_snap5` AS X6 ON X1.mandant_id = X6.mandant_id AND X1.art_id = X6.art_id AND X1.the_type = X6.the_type
    /* Blechbelegung A */
    LEFT JOIN `_snap6` AS X7 ON X1.mandant_id = X7.mandant_id AND X1.art_id = X7.art_id AND X1.the_type = X7.the_type
    /* Blechbelegung B */
    LEFT JOIN `_snap7` AS X8 ON X1.mandant_id = X8.mandant_id AND X1.art_id = X8.art_id AND X1.the_type = X8.the_type
    /* Blechbelegung C */
    LEFT JOIN `_snap8` AS X9 ON X1.mandant_id = X9.mandant_id AND X1.art_id = X9.art_id AND X1.the_type = X9.the_type
    /* Blechbelegung D */
    LEFT JOIN `_snap9` AS X10 ON X1.mandant_id = X10.mandant_id AND X1.art_id = X10.art_id AND X1.the_type = X10.the_type
    /* Blechbelegung E */
    LEFT JOIN `_snap10` AS X11 ON X1.mandant_id = X11.mandant_id AND X1.art_id = X11.art_id AND X1.the_type = X11.the_type

    GROUP BY
        X1.mandant_id,
        X1.art_id,
        X1.the_type,
        X2.bestell_art_id,
        X3.inhalt_menge,
        X4.back_aufbereitung_id,
        X5.back_hinweis_id,
        X6.back_programm_id,
        blechbelegung,
        X1.klart
);


INSERT INTO dbp_etl.bake_final_de
(
    SELECT *
    FROM dbp_etl.bake_final
    WHERE mandant_id = 1
);


DELETE FROM dbp_etl.bake_final
WHERE mandant_id = 1;
