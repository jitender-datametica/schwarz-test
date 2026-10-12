--[OK] statement is translated correctly (syntax and type checks are fine)


DROP TABLE IF EXISTS dbp_etl.ekc_preis_abschriften_1;


--[OK] statement is translated correctly (syntax and type checks are fine)


CREATE TABLE IF NOT EXISTS dbp_etl.ekc_preis_abschriften_1 (
    mandant_id INTEGER,
    art_id INTEGER,
    bewart_id INTEGER,
    wup_id INTEGER,
    nb_id INTEGER,
    dat DATE,
    wrg_id STRING(3) COLLATE 'und:ci',
    zek_id INTEGER,
    eigenmarke_fg INTEGER,
    wup_bereinigt_fg INTEGER,
    preis_abschrift_netto FLOAT64
);


--[OK] statement is translated correctly (syntax and type checks are fine)


DROP TABLE IF EXISTS dbp_etl.ekc_werbe_abschriften_1;


--[OK] statement is translated correctly (syntax and type checks are fine)


CREATE TABLE IF NOT EXISTS dbp_etl.ekc_werbe_abschriften_1 (
    mandant_id INTEGER,
    art_id INTEGER,
    bewart_id INTEGER,
    wup_id INTEGER,
    nb_id INTEGER,
    dat DATE,
    wrg_id STRING(3) COLLATE 'und:ci',
    zek_id INTEGER,
    eigenmarke_fg INTEGER,
    wup_bereinigt_fg INTEGER,
    werbe_abschrift_netto NUMERIC(29, 2)
);


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Object 'KFL_DEVELOPMENT.DBP_ETL_PROCESS.EKC_ZEK_1' does not exist or not authorized.


INSERT INTO dbp_etl.ekc_preis_abschriften_1
(SELECT
    mandant_id,
    art_id,
    bewart_id,
    wup_id,
    nb_id,
    dat,
    wrg_id,
    CAST(zek_id AS INTEGER) AS zek_id,
    eigenmarke_fg,
    wup_bereinigt_fg,
    preis_abschrift_netto
FROM (
    SELECT
        A.mandant_id,
        A.art_id,
        COALESCE(B.bewart_id, 1002) AS bewart_id,
        A.wup_id,
        A.nb_id,
        A.dat,
        A.wrg_id,
        C.zek_id,
        C.eigenmarke_fg,
        0 AS wup_bereinigt_fg,
        ROUND(
            SUM(
                CAST(A.abschriftbetrag_netto AS FLOAT64)
                * COALESCE(CAST(B.anteil AS FLOAT64), 1.0000)
            ),
            2
        )
            AS
            preis_abschrift_netto
    FROM dbp_data.marktabschriften_1 AS A
    INNER JOIN
        dbp_etl_process.ekc_zek_1 AS C
        ON A.mandant_id = C.mandant_id AND A.art_id = C.art_id
    LEFT JOIN dbp_etl_process.ekc_artbew_flagging_1 AS B
        ON
            A.mandant_id = B.mandant_id AND A.wup_id = B.wup_id
            AND A.art_id = B.art_id AND A.dat = B.dat
    WHERE
        A.abschriftart_id IN (5, 7)
        AND A.mandant_id = 1
    GROUP BY
        A.mandant_id,
        A.art_id,
        bewart_id,
        A.wup_id,
        A.nb_id,
        A.dat,
        A.wrg_id,
        C.zek_id,
        C.eigenmarke_fg,
        wup_bereinigt_fg
    UNION ALL
    SELECT
        A.mandant_id,
        A.art_id,
        COALESCE(B.bewart_id, 1002) AS bewart_id,
        A.wup_id,
        A.nb_id,
        A.dat_umbew AS dat,
        A.wrg_id,
        C.zek_id,
        C.eigenmarke_fg,
        0 AS wup_bereinigt_fg,
        ROUND(SUM(CASE
            WHEN
                A.mandant_id IN (2, 5) AND A.preis_aend_grund_id IN (7, 10)
                OR A.mandant_id IN (6) AND A.preis_aend_grund_id
                IN (2)
                OR A.mandant_id IN (3) AND A.preis_aend_grund_id IN (11)
                OR A.mandant_id IN (4, 7, 8) AND A.preis_aend_grund_id
                IN (7)
                THEN
                    CAST(A.diff_wert_bestand_netto AS FLOAT64)
                    * COALESCE(CAST(B.anteil AS FLOAT64), 1.0000)
            ELSE 0
        END), 2) AS preis_abschrift_netto
    FROM dbp_data.art_umbewertung_1 AS A
    INNER JOIN
        dbp_etl_process.ekc_zek_1 AS C
        ON A.mandant_id = C.mandant_id AND A.art_id = C.art_id
    LEFT JOIN dbp_etl_process.ekc_artbew_flagging_1 AS B
        ON
            A.mandant_id = B.mandant_id AND A.wup_id = B.wup_id
            AND A.art_id = B.art_id AND A.dat_umbew = B.dat
    WHERE A.mandant_id > 1
    GROUP BY
        A.mandant_id,
        A.art_id,
        bewart_id,
        A.wup_id,
        A.nb_id,
        dat,
        A.wrg_id,
        C.zek_id,
        C.eigenmarke_fg,
        wup_bereinigt_fg
) AS t7);


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Object 'KFL_DEVELOPMENT.DBP_ETL_PROCESS.EKC_ZEK_1' does not exist or not authorized.


INSERT INTO dbp_etl.ekc_werbe_abschriften_1
(SELECT
    mandant_id,
    art_id,
    bewart_id,
    wup_id,
    nb_id,
    dat,
    wrg_id,
    CAST(zek_id AS INTEGER) AS zek_id,
    eigenmarke_fg,
    wup_bereinigt_fg,
    CAST(werbe_abschrift_netto AS NUMERIC) AS werbe_abschrift_netto
FROM (
    SELECT
        A.mandant_id,
        A.art_id,
        1002 AS bewart_id,
        A.wup_id,
        A.nb_id,
        A.dat,
        A.wrg_id,
        C.zek_id,
        C.eigenmarke_fg,
        0 AS wup_bereinigt_fg,
        SUM(A.abschriftbetrag_netto) AS werbe_abschrift_netto
    FROM dbp_data.marktabschriften_1 AS A
    INNER JOIN
        dbp_etl_process.ekc_zek_1 AS C
        ON A.mandant_id = C.mandant_id AND A.art_id = C.art_id
    WHERE
        A.abschriftart_id = -1
        AND A.mandant_id = 1
    GROUP BY
        A.mandant_id,
        A.art_id,
        bewart_id,
        A.wup_id,
        A.nb_id,
        A.dat,
        A.wrg_id,
        C.zek_id,
        C.eigenmarke_fg,
        wup_bereinigt_fg
    UNION ALL
    SELECT
        x.mandant_id,
        x.art_id,
        x.bewart_id,
        x.wup_id,
        x.nb_id,
        x.dat,
        x.wrg_id,
        C.zek_id,
        C.eigenmarke_fg,
        0 AS wup_bereinigt_fg,
        SUM(x.abschriftbetrag_netto) AS werbe_abschrift_netto
    FROM (
        SELECT
            A.mandant_id,
            A.wup_id,
            A.nb_id,
            A.art_id,
            1002 AS bewart_id,
            A.dat,
            A.wrg_id,
            SUM(A.abschriftbetrag_netto) AS abschriftbetrag_netto
        FROM dbp_data.marktabschriften_kmo_aktion_1 AS A
        INNER JOIN dbp_data.art_wg_zu_per_1 AS B
            ON
                A.mandant_id = B.mandant_id AND A.art_id = B.art_id
                AND B.arthiertyp_id = 2 AND B.dat_bis = PARSE_DATE('%F', '9999-12-31')
        WHERE
            A.mandant_id > 1
            AND A.aktion_relevant_fg = 1
            AND (
                B.mandant_id, B.wg_id) NOT IN (
                SELECT (mandant_id, wg_id)
                FROM dbp_data.wg_filter_zu_1
                WHERE
                    arthiertyp_id = 2
                    AND wg_filter_id = 2
            )
        GROUP BY
            A.mandant_id,
            A.wup_id,
            A.nb_id,
            A.art_id,
            bewart_id,
            A.dat,
            A.wrg_id
        UNION ALL
        SELECT
            A.mandant_id,
            A.wup_id,
            A.nb_id,
            A.art_id,
            1002 AS bewart_id,
            A.dat_umbew AS dat,
            A.wrg_id,
            SUM(-1 * A.diff_wert_bestand_netto) AS abschriftbetrag_netto
        FROM dbp_data.art_umbewertung_1 AS A
        INNER JOIN dbp_data.art_wg_zu_per_1 AS B
            ON
                A.mandant_id = B.mandant_id AND A.art_id = B.art_id
                AND B.arthiertyp_id = 2 AND B.dat_bis = PARSE_DATE('%F', '9999-12-31')
        WHERE
            A.mandant_id > 1
            AND A.preis_aend_grund_id = 6
            AND (
                B.mandant_id, B.wg_id) NOT IN (
                SELECT (mandant_id, wg_id)
                FROM dbp_data.wg_filter_zu_1
                WHERE
                    arthiertyp_id = 2
                    AND wg_filter_id = 2
            )
        GROUP BY
            A.mandant_id,
            A.wup_id,
            A.nb_id,
            A.art_id,
            bewart_id,
            dat,
            A.wrg_id
    ) AS x
    INNER JOIN
        dbp_etl_process.ekc_zek_1 AS C
        ON x.mandant_id = C.mandant_id AND x.art_id = C.art_id
    GROUP BY
        x.mandant_id,
        x.art_id,
        x.bewart_id,
        x.wup_id,
        x.nb_id,
        x.dat,
        x.wrg_id,
        C.zek_id,
        C.eigenmarke_fg,
        wup_bereinigt_fg
) AS t19);
