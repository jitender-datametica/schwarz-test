DROP TABLE IF EXISTS dbp_etl.mis_q_umsatz_join_tag;


CREATE TABLE IF NOT EXISTS dbp_etl.mis_q_umsatz_join_tag (
    mandant_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    nb_id INTEGER NOT NULL,
    dat DATE NOT NULL,
    dat_vgl DATE NOT NULL,
    umsatzgleich_fg INTEGER NOT NULL,
    umsatzavg_fg INTEGER NOT NULL,
    umsatz_fg INTEGER NOT NULL
);


INSERT INTO dbp_etl.mis_q_umsatz_join_tag (
    mandant_id, wup_id, nb_id, dat, dat_vgl, umsatzgleich_fg,
    umsatzavg_fg, umsatz_fg
)
(
    SELECT
        mandant_id,
        wup_id,
        nb_id,
        dat,
        dat_vgl,
        SUM(umsatzgleich_fg),
        SUM(umsatzavg_fg),
        SUM(umsatz_fg)
    FROM (
        SELECT
            t3.mandant_id,
            t3.wup_id,
            t3.nb_id,
            T1.dat,
            T2.dat AS dat_vgl,
            CASE
                WHEN T1.dat = T2.dat
                    THEN 1
                ELSE 0
            END AS umsatz_fg,
            CASE
                WHEN T1.dat = T2.dat
                    THEN 0
                ELSE 1
            END AS umsatzavg_fg,
            0 AS umsatzgleich_fg
        FROM dbp_data.tag AS T1
        INNER JOIN (
            SELECT *
            FROM dbp_etl_process.artbew_wg_sum_agg_wt
            WHERE dat BETWEEN DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 365 DAY) AND (CURRENT_DATE("Europe/Berlin"))
        ) AS t3
            ON T1.dat = t3.dat
        INNER JOIN dbp_data.tag AS T2 ON T2.dat BETWEEN DATE_SUB(T1.dat, INTERVAL 30 DAY) AND T1.dat AND T1.wtag_id = T2.wtag_id
        WHERE t3.calc_fg = 0
        UNION DISTINCT
        SELECT
            t4.mandant_id,
            t4.wup_id,
            t4.nb_id,
            t4.dat,
            T5.dat AS dat_vgl,
            0 AS umsatz_fg,
            0 AS umsatzavg_fg,
            1 AS umsatzgleich_fg
        FROM (
            SELECT *
            FROM dbp_etl_process.artbew_wg_sum_agg_wt
            WHERE dat BETWEEN DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 365 DAY) AND (CURRENT_DATE("Europe/Berlin"))
        ) AS t4
        INNER JOIN dbp_data.tag AS T5
            ON T5.dat BETWEEN DATE_SUB(t4.dat, INTERVAL 3 DAY) AND (DATE_SUB(
                t4.dat,
                INTERVAL 1 DAY
            ))
        WHERE t4.calc_fg = 0
        GROUP BY
            t4.mandant_id,
            t4.wup_id,
            t4.nb_id,
            t4.dat,
            dat_vgl,
            umsatz_fg,
            umsatzavg_fg
    ) AS dt1
    WHERE
        EXISTS (
            SELECT *
            FROM dbp_data.wupcal AS T6
            WHERE
                dat = dt1.dat_vgl
                AND wup_id = dt1.wup_id
                AND nb_id = dt1.nb_id
                AND mandant_id = dt1.mandant_id
                AND datenlieferung_artbew_wg_sum = 1
                AND offen = 1
        )
        AND EXISTS (
            SELECT *
            FROM dbp_data.wupcal AS T7
            WHERE
                dat = dt1.dat
                AND wup_id = dt1.wup_id
                AND nb_id = dt1.nb_id
                AND mandant_id = dt1.mandant_id
                AND datenlieferung_artbew_wg_sum = 1
                AND offen = 1
        )
    GROUP BY
        mandant_id,
        wup_id,
        nb_id,
        dat,
        dat_vgl
);


DROP TABLE IF EXISTS dbp_etl.mis_q_umsatz;


CREATE TABLE IF NOT EXISTS dbp_etl.mis_q_umsatz (
    mandant_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    nb_id INTEGER NOT NULL,
    dat DATE NOT NULL,
    dat_vgl DATE NOT NULL,
    umsatz_netto NUMERIC(29, 2),
    umsatzgleich_fg INTEGER NOT NULL,
    umsatzavg_fg INTEGER NOT NULL,
    umsatz_fg INTEGER NOT NULL
);


INSERT INTO dbp_etl.mis_q_umsatz (
    mandant_id, wup_id, nb_id, dat, dat_vgl, umsatz_netto, umsatzgleich_fg,
    umsatzavg_fg, umsatz_fg
)
(
    SELECT
        T1.mandant_id,
        T1.wup_id,
        T1.nb_id,
        T2.dat,
        T2.dat_vgl,
        SUM(T1.umsatz_netto_konz),
        T2.umsatzgleich_fg,
        T2.umsatzavg_fg,
        T2.umsatz_fg
    FROM dbp_data.artbew_wg_sum AS T1
    INNER JOIN dbp_etl.mis_q_umsatz_join_tag AS T2
        ON
            T1.mandant_id = T2.mandant_id AND T1.wup_id = T2.wup_id
            AND T1.nb_id = T2.nb_id AND T1.dat = T2.dat_vgl
    WHERE T1.wg_id > -10
    GROUP BY
        T1.mandant_id,
        T1.nb_id,
        T1.wup_id,
        T2.dat,
        T2.dat_vgl,
        T2.umsatzgleich_fg,
        T2.umsatzavg_fg,
        T2.umsatz_fg
);


DROP TABLE IF EXISTS dbp_etl.mis_q_umsatz_abw_avg;


CREATE TABLE IF NOT EXISTS dbp_etl.mis_q_umsatz_abw_avg (
    mandant_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    nb_id INTEGER NOT NULL,
    dat DATE NOT NULL,
    umsatz_netto NUMERIC(29, 2),
    umsatz_netto_avg NUMERIC(29, 2),
    umsatzabweichung_prz NUMERIC(29, 2)
);


INSERT INTO dbp_etl.mis_q_umsatz_abw_avg (
    mandant_id, wup_id, nb_id, dat, umsatz_netto, umsatz_netto_avg,
    umsatzabweichung_prz
)
(SELECT
    mandant_id,
    wup_id,
    nb_id,
    dat,
    CAST(umsatz_netto AS NUMERIC) AS umsatz_netto,
    CAST(CASE
        WHEN umsatz_netto_avg_sum = 0
            THEN NULL
        ELSE umsatz_netto_avg_sum / umsatzavg_fg_sum
    END AS NUMERIC) AS umsatz_netto_avg,
    CAST(CASE
        WHEN
            CASE
                WHEN umsatz_netto_avg_sum = 0
                    THEN NULL
                ELSE umsatz_netto_avg_sum / umsatzavg_fg_sum
            END IS NULL
            THEN NULL
        ELSE (umsatz_netto - CASE
            WHEN umsatz_netto_avg_sum = 0
                THEN NULL
            ELSE umsatz_netto_avg_sum / umsatzavg_fg_sum
        END) / CASE
            WHEN umsatz_netto_avg_sum = 0
                THEN NULL
            ELSE umsatz_netto_avg_sum / umsatzavg_fg_sum
        END
    END AS NUMERIC) AS umsatzabweichung_prz
FROM (
    SELECT
        mandant_id,
        wup_id,
        nb_id,
        dat,
        SUM(umsatz_netto * umsatz_fg) AS umsatz_netto,
        SUM(umsatz_netto * umsatzavg_fg) AS umsatz_netto_avg_sum,
        SUM(umsatzavg_fg) AS umsatzavg_fg_sum
    FROM dbp_etl.mis_q_umsatz
    GROUP BY
        mandant_id,
        wup_id,
        nb_id,
        dat
) AS dt1
WHERE CASE
    WHEN
        CASE
            WHEN umsatz_netto_avg_sum = 0
                THEN NULL
            ELSE umsatz_netto_avg_sum / umsatzavg_fg_sum
        END IS NULL
        THEN NULL
    ELSE (umsatz_netto - CASE
        WHEN umsatz_netto_avg_sum = 0
            THEN NULL
        ELSE umsatz_netto_avg_sum / umsatzavg_fg_sum
    END) / CASE
        WHEN umsatz_netto_avg_sum = 0
            THEN NULL
        ELSE umsatz_netto_avg_sum / umsatzavg_fg_sum
    END
END NOT BETWEEN -0.5 AND 0.5);


DROP TABLE IF EXISTS dbp_etl.mis_q_umsatz_gleich;


CREATE TABLE IF NOT EXISTS dbp_etl.mis_q_umsatz_gleich (
    mandant_id INTEGER,
    wup_id INTEGER NOT NULL,
    nb_id INTEGER NOT NULL,
    dat DATE NOT NULL,
    dat_gleich DATE,
    umsatz_netto NUMERIC(29, 2)
);


INSERT INTO dbp_etl.mis_q_umsatz_gleich (mandant_id, wup_id, nb_id, dat, dat_gleich, umsatz_netto)
(
    SELECT
        T1.mandant_id,
        T1.wup_id,
        T1.nb_id,
        T1.dat,
        T2.dat_vgl AS dat_gleich,
        T1.umsatz_netto
    FROM dbp_etl.mis_q_umsatz AS T1
    INNER JOIN dbp_etl.mis_q_umsatz AS T2 ON T1.mandant_id = T2.mandant_id AND T1.wup_id = T2.wup_id AND T1.nb_id = T2.nb_id AND T1.dat = T2.dat AND T1.umsatz_netto = T2.umsatz_netto
    WHERE
        T1.umsatz_fg = 1
        AND T2.umsatzgleich_fg = 1
);


DROP TABLE IF EXISTS dbp_etl.mis_q_umsatz_neg;


CREATE TABLE IF NOT EXISTS dbp_etl.mis_q_umsatz_neg (
    mandant_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    nb_id INTEGER NOT NULL,
    dat DATE,
    umsatz_netto NUMERIC(29, 2)
);


INSERT INTO dbp_etl.mis_q_umsatz_neg (mandant_id, wup_id, nb_id, dat, umsatz_netto)
(
    SELECT
        mandant_id,
        wup_id,
        nb_id,
        dat,
        umsatz_netto
    FROM dbp_etl.mis_q_umsatz AS T1
    WHERE
        umsatz_fg = 1
        AND umsatz_netto < 0
);


UPDATE dbp_data.wupcal SET
    pruef_grund_id_umsatz = dt1.pruef_grund_id_umsatz_,
    pruef_status_id_umsatz = CASE
        WHEN wupcal.pruef_status_id_umsatz IS NULL
            THEN dt1.pruef_status_id_umsatz_
        ELSE dt1.pruef_status_id_umsatz_reload_
    END FROM (
    SELECT
        t1.mandant_id AS mandant_id_,
        t1.wup_id AS wup_id_,
        t1.nb_id AS nb_id_,
        t1.dat AS dat_,
        CASE
            WHEN T2.wup_id IS NULL
                THEN ' '
            ELSE 'D'
        END || CASE
            WHEN T3.wup_id IS NULL
                THEN ' '
            ELSE 'G'
        END || CASE
            WHEN T4.wup_id IS NULL
                THEN ' '
            ELSE 'N'
        END AS pruef_grund_id_umsatz_,
        CASE
            WHEN
                CASE
                    WHEN T2.wup_id IS NULL
                        THEN ' '
                    ELSE 'D'
                END || CASE
                    WHEN T3.wup_id IS NULL
                        THEN ' '
                    ELSE 'G'
                END || CASE
                    WHEN T4.wup_id IS NULL
                        THEN ' '
                    ELSE 'N'
                END = '   '
                THEN 1
            ELSE 0
        END AS pruef_status_id_umsatz_,
        CASE
            WHEN
                CASE
                    WHEN T2.wup_id IS NULL
                        THEN ' '
                    ELSE 'D'
                END || CASE
                    WHEN T3.wup_id IS NULL
                        THEN ' '
                    ELSE 'G'
                END || CASE
                    WHEN T4.wup_id IS NULL
                        THEN ' '
                    ELSE 'N'
                END = '   '
                THEN 2
            ELSE -1
        END AS pruef_status_id_umsatz_reload_,
        MAX(t1.dat_lief) AS dat_lief_
    FROM (
        SELECT *
        FROM dbp_etl_process.artbew_wg_sum_agg_wt
        WHERE dat BETWEEN DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 365 DAY) AND (CURRENT_DATE("Europe/Berlin"))
    ) AS t1
    LEFT JOIN dbp_etl.mis_q_umsatz_abw_avg AS T2
        ON
            t1.dat = T2.dat AND t1.mandant_id = T2.mandant_id AND
            t1.wup_id = T2.wup_id AND t1.nb_id = T2.nb_id
    LEFT JOIN dbp_etl.mis_q_umsatz_gleich AS T3
        ON
            t1.dat = T3.dat AND t1.mandant_id = T3.mandant_id AND
            t1.wup_id = T3.wup_id AND t1.nb_id = T3.nb_id
    LEFT JOIN dbp_etl.mis_q_umsatz_neg AS T4
        ON
            t1.dat = T4.dat AND t1.mandant_id = T4.mandant_id AND t1.wup_id
            = T4.wup_id AND t1.nb_id = T4.nb_id
    WHERE t1.calc_fg = 0
    GROUP BY
        mandant_id_,
        wup_id_,
        nb_id_,
        dat_,
        pruef_grund_id_umsatz_,
        pruef_status_id_umsatz_,
        pruef_status_id_umsatz_reload_
) AS dt1
WHERE
    wupcal.mandant_id = dt1.mandant_id_ AND wupcal.wup_id = dt1.wup_id_ AND wupcal.nb_id = dt1.nb_id_ AND wupcal.dat =
    dt1.dat_;


/*BB optimierung */


DROP TABLE IF EXISTS dbp_etl.bb_check_wupcal_update;


CREATE TABLE IF NOT EXISTS dbp_etl.bb_check_wupcal_update (
    mandant_id INTEGER NOT NULL,
    dat DATE NOT NULL,
    wup_id INTEGER NOT NULL,
    offen INTEGER,
    bonanzahl_sug INTEGER,
    nb_id INTEGER NOT NULL,
    umsatz_brutto_ods_verkauf NUMERIC(29, 4),
    umsatz_brutto_ods_kassenabschluss NUMERIC(29, 4),
    diff_wert NUMERIC(29, 4),
    diff_proz NUMERIC(29, 4),
    pruef_status_id_umsatz INTEGER,
    pruef_grund_id_umsatz STRING(3)
);


INSERT INTO dbp_etl.bb_check_wupcal_update
(
    SELECT
        mandant_id,
        dat,
        wup_id,
        offen,
        bonanzahl_sug,
        nb_id,
        umsatz_brutto_ods_verkauf,
        umsatz_brutto_ods_kassenabschluss,
        umsatz_brutto_ods_verkauf - umsatz_brutto_ods_kassenabschluss AS diff_wert,
        (
            umsatz_brutto_ods_verkauf - umsatz_brutto_ods_kassenabschluss) / IF(
            umsatz_brutto_ods_kassenabschluss = 0, NULL,
            umsatz_brutto_ods_kassenabschluss
        ) * 100 AS diff_proz,
        CASE
            WHEN ((
                umsatz_brutto_ods_verkauf - umsatz_brutto_ods_kassenabschluss) / IF(
                umsatz_brutto_ods_kassenabschluss = 0,
                NULL, umsatz_brutto_ods_kassenabschluss
            ) * 100) NOT BETWEEN -${limit} AND ${limit}
                THEN -1
            ELSE 1
        END AS pruef_status_id_umsatz,
        pruef_grund_id_umsatz
    FROM dbp_data.wupcal
    WHERE
        dat = DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 1 DAY)
        AND offen = 1
        AND nb_id = 0
        AND umsatz_brutto_ods_kassenabschluss <> 0
);


DROP TABLE IF EXISTS dbp_etl.bb_check_wupcal;


CREATE TABLE IF NOT EXISTS dbp_etl.bb_check_wupcal AS
SELECT *
FROM dbp_data.wupcal
WHERE dat = DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 1 DAY);


UPDATE dbp_data.wupcal AS T1 SET
    pruef_status_id_umsatz = dt1.pruef_status_id_umsatz
FROM dbp_etl.bb_check_wupcal_update AS dt1
WHERE T1.mandant_id = dt1.mandant_id AND T1.wup_id = dt1.wup_id AND T1.nb_id = dt1.nb_id AND T1.dat = dt1.dat;
