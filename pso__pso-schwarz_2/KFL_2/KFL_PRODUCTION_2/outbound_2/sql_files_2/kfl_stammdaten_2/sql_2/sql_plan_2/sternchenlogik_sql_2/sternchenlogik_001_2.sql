--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--DROP TABLE DBX_LOAD.sternchen_logik_tmp_2;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_2 your local system administrator.
--translated statement


DROP TABLE IF EXISTS dbp_etl.sternchen_logik_tmp_2;


CREATE TABLE IF NOT EXISTS dbp_etl.sternchen_logik_tmp_2 (
    mandant_id INTEGER NOT NULL,
    art_id INTEGER NOT NULL,
    vw_id INTEGER,
    sm_id INTEGER,
    list_durchg_fg INTEGER,
    bezugsweg1_fg INTEGER,
    bezugsweg4_fg INTEGER,
    kdis0_fg INTEGER,
    kdis1_fg INTEGER,
    anzahl_markt_soll INTEGER,
    anzahl_markt_listung INTEGER,
    anzahl_markt_bezugsweg1 INTEGER,
    anzahl_markt_bezugsweg4 INTEGER,
    anzahl_markt_kdis0 INTEGER,
    anzahl_markt_kdis1 INTEGER,
    ksm_id STRING(4)
);


INSERT INTO dbp_etl.sternchen_logik_tmp_2 (
    mandant_id, art_id, vw_id, sm_id, list_durchg_fg, bezugsweg1_fg,
    bezugsweg4_fg, kdis0_fg, kdis1_fg, anzahl_markt_soll, anzahl_markt_listung, anzahl_markt_bezugsweg1,
    anzahl_markt_bezugsweg4, anzahl_markt_kdis0, anzahl_markt_kdis1, ksm_id
)
(
    SELECT
        dt_1.mandant_id,
        dt_2.art_id,
        dt_1.vw_id,
        dt_1.sm_id,
        CASE
            WHEN dt_2.s_lstg = dt_1.wup_anz
                THEN 1
            ELSE 0
        END AS list_durchg_fg,
        CASE
            WHEN dt_2.s_bzwg1 = dt_2.s_lstg
                THEN 1
            ELSE 0
        END AS bezugsweg1_fg,
        CASE
            WHEN dt_2.s_bzwg4 = dt_2.s_lstg
                THEN 1
            ELSE 0
        END AS bezugsweg4_fg,
        CASE
            WHEN dt_2.s_kdis0 = dt_2.s_lstg
                THEN 1
            ELSE 0
        END AS kdis0_fg,
        CASE
            WHEN dt_2.s_kdis1 = dt_2.s_lstg
                THEN 1
            ELSE 0
        END AS kdis1_fg,
        IFNULL(dt_1.wup_anz, 0) AS anzahl_markt_soll,
        IFNULL(dt_2.s_lstg, 0) AS anzahl_markt_listing,
        IFNULL(dt_2.s_bzwg1, 0) AS anzahl_markt_bezugsweg1,
        IFNULL(dt_2.s_bzwg4, 0) AS anzahl_markt_bezugsweg4,
        IFNULL(dt_2.s_kdis0, 0) AS anzahl_markt_kdis0,
        IFNULL(dt_2.s_kdis1, 0) AS anzahl_markt_kdis1,
        CAST(NULL AS STRING) AS ksm_id
    FROM (
        SELECT
            DT1_1.mandant_id,
            DT1_1.wg_id,
            DT1_1.sm_id,
            DT1_2.vw_id,
            COUNT(DISTINCT DT1_1.wup_id) AS wup_anz
        FROM dbp_data.sm_wup_wg_zu_per_2 AS DT1_1
        INNER JOIN dbp_data.wup_2 AS DT1_2
            ON
                DT1_1.mandant_id = DT1_2.mandant_id AND DT1_1.wup_id = DT1_2.wup_id
                AND DT1_1.nb_id = DT1_2.nb_id
        WHERE
            DT1_1.nb_id = 0
            AND CURRENT_DATE("Europe/Berlin") BETWEEN DT1_1.dat_von AND DT1_1.dat_bis
            AND CURRENT_DATE("Europe/Berlin") BETWEEN DATE_SUB(DT1_2.dat_von, INTERVAL 42 DAY) AND DT1_2.dat_bis
        GROUP BY
            DT1_1.mandant_id,
            DT1_1.wg_id,
            DT1_1.sm_id,
            DT1_2.vw_id
    ) AS dt_1
    INNER JOIN (
        SELECT
            t3.mandant_id,
            t3.art_id,
            t3.wg_id,
            dt2_2.sm_id,
            dt2_2.vw_id,
            SUM(t3.listung_id) AS s_lstg,
            SUM(t3.listung_id * t3.kdis) AS s_kdis,
            SUM(t3.listung_id * CASE
                WHEN t3.bezugsweg_id = 4
                    THEN 1
                ELSE 0
            END) AS s_bzwg4,
            SUM(t3.listung_id * CASE
                WHEN t3.bezugsweg_id = 1
                    THEN 1
                ELSE 0
            END) AS s_bzwg1,
            SUM(t3.listung_id * CASE
                WHEN t3.kdis = 0
                    THEN 1
                ELSE 0
            END) AS s_kdis0,
            SUM(t3.listung_id * t3.kdis) AS s_kdis1,
            COUNT(t3.wup_id) AS c_wup_id
        FROM (
            SELECT
                DT2_1_1.mandant_id,
                DT2_1_1.art_id,
                DT2_1_1.wup_id,
                DT2_1_2.wg_id,
                DT2_1_1.kdis,
                DT2_1_1.listung_id,
                DT2_1_1.bezugsweg_id
            FROM dbp_data.art_wup_zu_per_2 AS DT2_1_1
            INNER JOIN dbp_data.art_wg_zu_per_2 AS DT2_1_2
                ON
                    DT2_1_1.mandant_id = DT2_1_2.mandant_id AND DT2_1_1.art_id = DT2_1_2.art_id
            WHERE
                DT2_1_2.arthiertyp_id = 2
                AND CURRENT_DATE("Europe/Berlin") BETWEEN DT2_1_2.dat_von AND DT2_1_2.dat_bis
                AND CURRENT_DATE("Europe/Berlin") BETWEEN DT2_1_1.dat_von AND DT2_1_1.dat_bis
            GROUP BY
                DT2_1_1.mandant_id,
                DT2_1_1.wup_id,
                DT2_1_1.art_id,
                DT2_1_1.bezugsweg_id,
                DT2_1_1.listung_id,
                DT2_1_1.kdis,
                DT2_1_2.wg_id
        ) AS t3
        INNER JOIN (
            SELECT
                DT2_2_1.mandant_id,
                DT2_2_1.wup_id,
                DT2_2_1.wg_id,
                DT2_2_1.sm_id,
                DT2_2_2.vw_id
            FROM dbp_data.sm_wup_wg_zu_per_2 AS DT2_2_1
            INNER JOIN dbp_data.wup_2 AS DT2_2_2
                ON
                    DT2_2_1.mandant_id = DT2_2_2.mandant_id AND DT2_2_1.wup_id =
                    DT2_2_2.wup_id AND DT2_2_1.nb_id = DT2_2_2.nb_id
            WHERE
                DT2_2_1.nb_id = 0
                AND CURRENT_DATE("Europe/Berlin") BETWEEN DT2_2_1.dat_von AND DT2_2_1.dat_bis
                AND CURRENT_DATE("Europe/Berlin") BETWEEN DATE_SUB(DT2_2_2.dat_von, INTERVAL 42 DAY) AND DT2_2_2.dat_bis
            GROUP BY
                DT2_2_1.mandant_id,
                DT2_2_1.wup_id,
                DT2_2_1.wg_id,
                DT2_2_1.sm_id,
                DT2_2_2.vw_id
        ) AS dt2_2 ON t3.mandant_id = dt2_2.mandant_id AND t3.wup_id = dt2_2.wup_id AND t3.wg_id = dt2_2.wg_id

        GROUP BY
            t3.mandant_id,
            t3.art_id,
            t3.wg_id,
            dt2_2.sm_id,
            dt2_2.vw_id
    ) AS dt_2
        ON
            dt_1.mandant_id = dt_2.mandant_id AND dt_1.wg_id = dt_2.wg_id AND dt_1.sm_id = dt_2.sm_id
            AND dt_1.vw_id = dt_2.vw_id
);


INSERT INTO dbp_etl.sternchen_logik_tmp_2 (
    mandant_id, art_id, vw_id, sm_id, list_durchg_fg, bezugsweg1_fg,
    bezugsweg4_fg, kdis0_fg, kdis1_fg, anzahl_markt_soll, anzahl_markt_listung, anzahl_markt_bezugsweg1,
    anzahl_markt_bezugsweg4, anzahl_markt_kdis0, anzahl_markt_kdis1, ksm_id
)
(
    SELECT
        dt_1.mandant_id,
        dt_2.art_id,
        dt_1.vw_id,
        CAST(NULL AS INTEGER) AS sm_id,
        CASE
            WHEN dt_2.s_lstg = dt_1.wup_anz
                THEN 1
            ELSE 0
        END AS list_durchg_fg,
        CASE
            WHEN dt_2.s_bzwg1 = dt_2.s_lstg
                THEN 1
            ELSE 0
        END AS bezugsweg1_fg,
        CASE
            WHEN dt_2.s_bzwg4 = dt_2.s_lstg
                THEN 1
            ELSE 0
        END AS bezugsweg4_fg,
        CASE
            WHEN dt_2.s_kdis0 = dt_2.s_lstg
                THEN 1
            ELSE 0
        END AS kdis0_fg,
        CASE
            WHEN dt_2.s_kdis1 = dt_2.s_lstg
                THEN 1
            ELSE 0
        END AS kdis1_fg,
        IFNULL(dt_1.wup_anz, 0) AS anzahl_markt_soll,
        IFNULL(dt_2.s_lstg, 0) AS anzahl_markt_listing,
        IFNULL(dt_2.s_bzwg1, 0) AS anzahl_markt_bezugsweg1,
        IFNULL(dt_2.s_bzwg4, 0) AS anzahl_markt_bezugsweg4,
        IFNULL(dt_2.s_kdis0, 0) AS anzahl_markt_kdis0,
        IFNULL(dt_2.s_kdis1, 0) AS anzahl_markt_kdis1,
        dt_1.ksm_id
    FROM (
        SELECT
            DT1_1.mandant_id,
            DT1_1.wg_id,
            DT1_1.ksm_id,
            DT1_2.vw_id,
            COUNT(DISTINCT DT1_1.wup_id) AS wup_anz
        FROM dbp_data.sm_wup_wg_zu_per_2 AS DT1_1
        INNER JOIN dbp_data.wup_2 AS DT1_2
            ON
                DT1_1.mandant_id = DT1_2.mandant_id AND DT1_1.wup_id = DT1_2.wup_id
                AND DT1_1.nb_id = DT1_2.nb_id
        WHERE
            DT1_1.nb_id = 0
            AND CURRENT_DATE("Europe/Berlin") BETWEEN DT1_1.dat_von AND DT1_1.dat_bis
            AND CURRENT_DATE("Europe/Berlin") BETWEEN DATE_SUB(DT1_2.dat_von, INTERVAL 42 DAY) AND DT1_2.dat_bis
        GROUP BY
            DT1_1.mandant_id,
            DT1_1.wg_id,
            DT1_1.ksm_id,
            DT1_2.vw_id
    ) AS dt_1
    INNER JOIN (
        SELECT
            t3.mandant_id,
            t3.art_id,
            t3.wg_id,
            dt2_2.ksm_id,
            dt2_2.vw_id,
            SUM(t3.listung_id) AS s_lstg,
            SUM(t3.listung_id * t3.kdis) AS s_kdis,
            SUM(t3.listung_id * CASE
                WHEN t3.bezugsweg_id = 4
                    THEN 1
                ELSE 0
            END) AS s_bzwg4,
            SUM(t3.listung_id * CASE
                WHEN t3.bezugsweg_id = 1
                    THEN 1
                ELSE 0
            END) AS s_bzwg1,
            SUM(t3.listung_id * CASE
                WHEN t3.kdis = 0
                    THEN 1
                ELSE 0
            END) AS s_kdis0,
            SUM(t3.listung_id * t3.kdis) AS s_kdis1,
            COUNT(t3.wup_id) AS c_wup_id
        FROM (
            SELECT
                DT2_1_1.mandant_id,
                DT2_1_1.art_id,
                DT2_1_1.wup_id,
                DT2_1_2.wg_id,
                DT2_1_1.kdis,
                DT2_1_1.listung_id,
                DT2_1_1.bezugsweg_id
            FROM dbp_data.art_wup_zu_per_2 AS DT2_1_1
            INNER JOIN dbp_data.art_wg_zu_per_2 AS DT2_1_2
                ON
                    DT2_1_1.mandant_id = DT2_1_2.mandant_id AND DT2_1_1.art_id = DT2_1_2.art_id
            WHERE
                DT2_1_2.arthiertyp_id = 2
                AND CURRENT_DATE("Europe/Berlin") BETWEEN DT2_1_2.dat_von AND DT2_1_2.dat_bis
                AND CURRENT_DATE("Europe/Berlin") BETWEEN DT2_1_1.dat_von AND DT2_1_1.dat_bis
            GROUP BY
                DT2_1_1.mandant_id,
                DT2_1_1.wup_id,
                DT2_1_1.art_id,
                DT2_1_1.bezugsweg_id,
                DT2_1_1.listung_id,
                DT2_1_1.kdis,
                DT2_1_2.wg_id
        ) AS t3
        INNER JOIN (
            SELECT
                DT2_2_1.mandant_id,
                DT2_2_1.wup_id,
                DT2_2_1.wg_id,
                DT2_2_1.ksm_id,
                DT2_2_2.vw_id
            FROM dbp_data.sm_wup_wg_zu_per_2 AS DT2_2_1
            INNER JOIN dbp_data.wup_2 AS DT2_2_2
                ON
                    DT2_2_1.mandant_id = DT2_2_2.mandant_id AND DT2_2_1.wup_id =
                    DT2_2_2.wup_id AND DT2_2_1.nb_id = DT2_2_2.nb_id
            WHERE
                DT2_2_1.nb_id = 0
                AND CURRENT_DATE("Europe/Berlin") BETWEEN DT2_2_1.dat_von AND DT2_2_1.dat_bis
                AND CURRENT_DATE("Europe/Berlin") BETWEEN DATE_SUB(DT2_2_2.dat_von, INTERVAL 42 DAY) AND DT2_2_2.dat_bis
            GROUP BY
                DT2_2_1.mandant_id,
                DT2_2_1.wup_id,
                DT2_2_1.wg_id,
                DT2_2_1.ksm_id,
                DT2_2_2.vw_id
        ) AS dt2_2 ON t3.mandant_id = dt2_2.mandant_id AND t3.wup_id = dt2_2.wup_id AND t3.wg_id = dt2_2.wg_id

        GROUP BY
            t3.mandant_id,
            t3.art_id,
            t3.wg_id,
            dt2_2.ksm_id,
            dt2_2.vw_id
    ) AS dt_2
        ON
            dt_1.mandant_id = dt_2.mandant_id AND dt_1.wg_id = dt_2.wg_id AND dt_1.ksm_id = dt_2.ksm_id
            AND dt_1.vw_id = dt_2.vw_id
);


TRUNCATE TABLE dbp_data.sternchen_logik_2;


INSERT INTO dbp_data.sternchen_logik_2 (
    art_id, vw_id, sm_id, dat_von, mandant_id, dat_bis, list_durchg_fg,
    bezugsweg1_fg, bezugsweg4_fg, kdis0_fg, kdis1_fg, anzahl_markt_soll, anzahl_markt_listung, anzahl_markt_bezugsweg1,
    anzahl_markt_bezugsweg4, anzahl_markt_kdis0, anzahl_markt_kdis1, ksm_id
)
(SELECT
    art_id,
    vw_id,
    COALESCE(sm_id, -9) AS sm_id,
    CURRENT_DATE("Europe/Berlin") AS dat_von,
    mandant_id,
    PARSE_DATE('%F', '9999-12-31') AS dat_bis,
    list_durchg_fg,
    bezugsweg1_fg,
    bezugsweg4_fg,
    kdis0_fg,
    kdis1_fg,
    anzahl_markt_soll,
    anzahl_markt_listung,
    anzahl_markt_bezugsweg1,
    anzahl_markt_bezugsweg4,
    anzahl_markt_kdis0,
    anzahl_markt_kdis1,
    COALESCE(ksm_id, '-9') AS ksm_id
FROM dbp_etl.sternchen_logik_tmp_2);


DELETE FROM dbp_data.sternchen_logik_2
WHERE sm_id = -1;


DROP TABLE IF EXISTS dbp_etl.sternchen_logik_kreis_tmp_2;


CREATE TABLE IF NOT EXISTS dbp_etl.sternchen_logik_kreis_tmp_2 (
    mandant_id INTEGER NOT NULL,
    art_id INTEGER NOT NULL,
    kreistyp_gruppe_id STRING(4),
    list_durchg_fg INTEGER,
    bezugsweg1_fg INTEGER,
    bezugsweg4_fg INTEGER,
    kdis0_fg INTEGER,
    kdis1_fg INTEGER,
    anzahl_markt_soll INTEGER,
    anzahl_markt_listung INTEGER,
    anzahl_markt_bezugsweg1 INTEGER,
    anzahl_markt_bezugsweg4 INTEGER,
    anzahl_markt_kdis0 INTEGER,
    anzahl_markt_kdis1 INTEGER
);


INSERT INTO dbp_etl.sternchen_logik_kreis_tmp_2 (
    mandant_id, art_id, kreistyp_gruppe_id, list_durchg_fg,
    bezugsweg1_fg, bezugsweg4_fg, kdis0_fg, kdis1_fg, anzahl_markt_soll, anzahl_markt_listung, anzahl_markt_bezugsweg1,
    anzahl_markt_bezugsweg4, anzahl_markt_kdis0, anzahl_markt_kdis1
)
(
    SELECT
        dt_1.mandant_id,
        dt_2.art_id,
        dt_1.kreistyp_gruppe_id,
        CASE
            WHEN dt_2.s_lstg = dt_1.wup_anz
                THEN 1
            ELSE 0
        END AS list_durchg_fg,
        CASE
            WHEN dt_2.s_bzwg1 = dt_2.s_lstg
                THEN 1
            ELSE 0
        END AS bezugsweg1_fg,
        CASE
            WHEN dt_2.s_bzwg4 = dt_2.s_lstg
                THEN 1
            ELSE 0
        END AS bezugsweg4_fg,
        CASE
            WHEN dt_2.s_kdis0 = dt_2.s_lstg
                THEN 1
            ELSE 0
        END AS kdis0_fg,
        CASE
            WHEN dt_2.s_kdis1 = dt_2.s_lstg
                THEN 1
            ELSE 0
        END AS kdis1_fg,
        IFNULL(dt_1.wup_anz, 0) AS anzahl_markt_soll,
        IFNULL(dt_2.s_lstg, 0) AS anzahl_markt_listing,
        IFNULL(dt_2.s_bzwg1, 0) AS anzahl_markt_bezugsweg1,
        IFNULL(dt_2.s_bzwg4, 0) AS anzahl_markt_bezugsweg4,
        IFNULL(dt_2.s_kdis0, 0) AS anzahl_markt_kdis0,
        IFNULL(dt_2.s_kdis1, 0) AS anzahl_markt_kdis1
    FROM (
        SELECT
            DT1_1.mandant_id,
            DT1_1.wg_id,
            DT1_2.kreistyp_gruppe_id,
            COUNT(DISTINCT DT1_1.wup_id) AS wup_anz
        FROM dbp_data.sm_wup_wg_zu_per_2 AS DT1_1
        INNER JOIN dbp_data.wup_2 AS DT1_2
            ON
                DT1_1.mandant_id = DT1_2.mandant_id AND DT1_1.wup_id = DT1_2.wup_id
                AND DT1_1.nb_id = DT1_2.nb_id
        WHERE
            DT1_1.nb_id = 0
            AND DT1_1.sm_id BETWEEN 1 AND 6
            AND CURRENT_DATE("Europe/Berlin") BETWEEN DT1_1.dat_von AND DT1_1.dat_bis
            AND CURRENT_DATE("Europe/Berlin") BETWEEN DATE_SUB(DT1_2.dat_von, INTERVAL 42 DAY) AND DT1_2.dat_bis
        GROUP BY
            DT1_1.mandant_id,
            DT1_1.wg_id,
            DT1_2.kreistyp_gruppe_id
    ) AS dt_1
    INNER JOIN (
        SELECT
            t3.mandant_id,
            t3.art_id,
            t3.wg_id,
            dt2_2.kreistyp_gruppe_id,
            SUM(t3.listung_id) AS s_lstg,
            SUM(t3.listung_id * t3.kdis) AS s_kdis,
            SUM(t3.listung_id * CASE
                WHEN t3.bezugsweg_id = 4
                    THEN 1
                ELSE 0
            END) AS s_bzwg4,
            SUM(t3.listung_id * CASE
                WHEN t3.bezugsweg_id = 1
                    THEN 1
                ELSE 0
            END) AS s_bzwg1,
            SUM(t3.listung_id * CASE
                WHEN t3.kdis = 0
                    THEN 1
                ELSE 0
            END) AS s_kdis0,
            SUM(t3.listung_id * t3.kdis) AS s_kdis1,
            COUNT(t3.wup_id) AS c_wup_id
        FROM (
            SELECT
                DT2_1_1.mandant_id,
                DT2_1_1.art_id,
                DT2_1_1.wup_id,
                DT2_1_2.wg_id,
                DT2_1_1.kdis,
                DT2_1_1.listung_id,
                DT2_1_1.bezugsweg_id
            FROM dbp_data.art_wup_zu_per_2 AS DT2_1_1
            INNER JOIN dbp_data.art_wg_zu_per_2 AS DT2_1_2
                ON
                    DT2_1_1.mandant_id = DT2_1_2.mandant_id AND DT2_1_1.art_id = DT2_1_2.art_id
            WHERE
                DT2_1_2.arthiertyp_id = 2
                AND CURRENT_DATE("Europe/Berlin") BETWEEN DT2_1_2.dat_von AND DT2_1_2.dat_bis
                AND CURRENT_DATE("Europe/Berlin") BETWEEN DT2_1_1.dat_von AND DT2_1_1.dat_bis
            GROUP BY
                DT2_1_1.mandant_id,
                DT2_1_1.wup_id,
                DT2_1_1.art_id,
                DT2_1_1.bezugsweg_id,
                DT2_1_1.listung_id,
                DT2_1_1.kdis,
                DT2_1_2.wg_id
        ) AS t3
        INNER JOIN (
            SELECT
                DT2_2_1.mandant_id,
                DT2_2_1.wup_id,
                DT2_2_1.wg_id,
                DT2_2_2.kreistyp_gruppe_id
            FROM dbp_data.sm_wup_wg_zu_per_2 AS DT2_2_1
            INNER JOIN dbp_data.wup_2 AS DT2_2_2
                ON
                    DT2_2_1.mandant_id = DT2_2_2.mandant_id AND DT2_2_1.wup_id =
                    DT2_2_2.wup_id AND DT2_2_1.nb_id = DT2_2_2.nb_id
            WHERE
                DT2_2_1.nb_id = 0
                AND DT2_2_1.sm_id BETWEEN 1 AND 6
                AND CURRENT_DATE("Europe/Berlin") BETWEEN DT2_2_1.dat_von AND DT2_2_1.dat_bis
                AND CURRENT_DATE("Europe/Berlin") BETWEEN DATE_SUB(DT2_2_2.dat_von, INTERVAL 42 DAY) AND DT2_2_2.dat_bis
            GROUP BY
                DT2_2_1.mandant_id,
                DT2_2_1.wup_id,
                DT2_2_1.wg_id,
                DT2_2_2.kreistyp_gruppe_id
        ) AS dt2_2
            ON
                t3.mandant_id = dt2_2.mandant_id AND t3.wup_id = dt2_2.wup_id AND t3.wg_id
                = dt2_2.wg_id
        GROUP BY
            t3.mandant_id,
            t3.art_id,
            t3.wg_id,
            dt2_2.kreistyp_gruppe_id
    ) AS dt_2
        ON
            dt_1.mandant_id = dt_2.mandant_id AND dt_1.wg_id = dt_2.wg_id AND dt_1.kreistyp_gruppe_id
            = dt_2.kreistyp_gruppe_id
);


TRUNCATE TABLE dbp_data.sternchen_logik_kreis_2;


INSERT INTO dbp_data.sternchen_logik_kreis_2 (
    mandant_id, art_id, kreistyp_gruppe_id, dat_von, dat_bis,
    list_durchg_fg, bezugsweg1_fg, bezugsweg4_fg, kdis0_fg, kdis1_fg, anzahl_markt_soll, anzahl_markt_listung,
    anzahl_markt_bezugsweg1, anzahl_markt_bezugsweg4, anzahl_markt_kdis0, anzahl_markt_kdis1
)
(SELECT
    mandant_id,
    art_id,
    kreistyp_gruppe_id,
    CURRENT_DATE("Europe/Berlin") AS dat_von,
    PARSE_DATE('%F', '9999-12-31') AS dat_bis,
    list_durchg_fg,
    bezugsweg1_fg,
    bezugsweg4_fg,
    kdis0_fg,
    kdis1_fg,
    anzahl_markt_soll,
    anzahl_markt_listung,
    anzahl_markt_bezugsweg1,
    anzahl_markt_bezugsweg4,
    anzahl_markt_kdis0,
    anzahl_markt_kdis1
FROM dbp_etl.sternchen_logik_kreis_tmp_2);
