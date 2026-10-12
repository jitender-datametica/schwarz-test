-- WW
-- KM
-- KW
CREATE OR REPLACE TEMPORARY TABLE _zeitraeume AS
(((
    SELECT
        A.mandant_id,
        'KM' AS zeitraum_kz,
        B.kjmo AS zeit_1,
        MIN(B.dat) AS min_dat,
        MAX(B.dat) AS max_dat,
        MIN(B.dat) AS fake_min_dat,
        DATE_SUB(MIN(B.dat), INTERVAL 730 DAY) AS mseg_min_dat
    FROM dbp_data.mandant_1 AS A
    INNER JOIN dbp_data.tag_1 AS B ON TRUE
    WHERE
        B.akt_mo_komplett = 0
        AND A.mandant_id IN (2, 3, 4, 5, 6, 7, 8)
        AND 1 = (
            SELECT 1
            FROM (
                SELECT MIN(dat) AS dat
                FROM dbp_data.tag_1
                WHERE akt_mo = 1
            ) AS a
            INNER JOIN dbp_data.tag_1 AS B0 ON a.dat = B0.dat
            WHERE B0.dat = CURRENT_DATE("Europe/Berlin")
        )
    GROUP BY
        A.mandant_id,
        zeitraum_kz,
        zeit_1
    UNION DISTINCT
    SELECT
        x.mandant_id,
        x.zeitraum_kz,
        x.zeit_1,
        x.min_dat,
        x.max_dat,
        Y.dat AS fake_min_dat,
        x.mseg_min_dat
    FROM (
        SELECT
            A.mandant_id,
            'KM' AS zeitraum_kz,
            B.kjmo AS zeit_1,
            MIN(B.dat) AS min_dat,
            MAX(B.dat) AS max_dat,
            DATE_DIFF(CURRENT_DATE("Europe/Berlin"), MIN(B.dat), DAY) AS abstand,
            CASE
                WHEN DATE_DIFF(CURRENT_DATE("Europe/Berlin"), MIN(B.dat), DAY) <= 0
                    THEN 7
                WHEN DATE_DIFF(CURRENT_DATE("Europe/Berlin"), MIN(B.dat), DAY) <= 7
                    THEN 7 - DATE_DIFF(CURRENT_DATE("Europe/Berlin"), MIN(B.dat), DAY)
                ELSE 0
            END AS diff,
            DATE_SUB(MIN(B.dat), INTERVAL 730 DAY) AS mseg_min_dat
        FROM dbp_data.mandant_1 AS A
        INNER JOIN dbp_data.tag_1 AS B ON TRUE
        WHERE
            B.akt_mo_komplett = 1
            AND A.mandant_id IN (2, 3, 4, 5, 6, 7, 8)
        GROUP BY
            A.mandant_id,
            zeitraum_kz,
            zeit_1
    ) AS x
    INNER JOIN dbp_data.tag_1 AS Y ON DATE_SUB(x.min_dat, INTERVAL x.diff DAY) = Y.dat
)
UNION DISTINCT
SELECT
    A.mandant_id,
    'KW' AS zeitraum_kz,
    B.kjwo AS zeit_1,
    MIN(B.dat) AS min_dat,
    MAX(B.dat) AS max_dat,
    MIN(B.dat) AS fake_min_dat,
    DATE_SUB(MIN(B.dat), INTERVAL 730 DAY) AS mseg_min_dat
FROM dbp_data.mandant_1 AS A
INNER JOIN dbp_data.tag_1 AS B ON TRUE
    WHERE
        B.akt_wo_komplett = 0
        AND A.mandant_id IN (2, 3, 4, 5, 6, 7, 8)
    GROUP BY
        A.mandant_id,
        zeitraum_kz,
        zeit_1
)
UNION DISTINCT
SELECT
    x.mandant_id,
    'KW' AS zeitraum_kz,
    x.kjwo AS zeit_1,
    x.min_dat,
    x.max_dat,
    Y.dat AS fake_min_dat,
    x.mseg_min_dat
FROM (
    SELECT
        A.mandant_id,
        B.kjwo,
        MIN(B.dat) AS min_dat,
        MAX(B.dat) AS max_dat,
        DATE_DIFF(CURRENT_DATE("Europe/Berlin"), MIN(B.dat), DAY) AS abstand,
        CASE
            WHEN DATE_DIFF(CURRENT_DATE("Europe/Berlin"), MIN(B.dat), DAY) <= 0
                THEN 7
            WHEN DATE_DIFF(CURRENT_DATE("Europe/Berlin"), MIN(B.dat), DAY) <= 7
                THEN 7 - DATE_DIFF(CURRENT_DATE("Europe/Berlin"), MIN(B.dat), DAY)
            ELSE 0
        END AS diff,
        DATE_SUB(MIN(B.dat), INTERVAL 730 DAY) AS mseg_min_dat
    FROM dbp_data.mandant_1 AS A
    INNER JOIN dbp_data.tag_1 AS B ON TRUE
    WHERE
        B.akt_wo_komplett = 1
        AND A.mandant_id IN (2, 3, 4, 5, 6, 7, 8)
    GROUP BY
        A.mandant_id,
        B.kjwo
) AS x
INNER JOIN dbp_data.tag_1 AS Y ON DATE_SUB(x.min_dat, INTERVAL x.diff DAY) = Y.dat
)
UNION DISTINCT
SELECT
    x.mandant_id,
    'WW' AS zeitraum_kz,
    x.kjwo AS zeit_1,
    x.min_dat,
    x.max_dat,
    Y.dat AS fake_min_dat,
    x.mseg_min_dat
FROM (
    SELECT
        A.mandant_id,
        B.kjwo,
        CASE
            WHEN A.mandant_id = 8
                THEN DATE_ADD(MIN(B.dat), INTERVAL 7 DAY)
            WHEN A.mandant_id = 2 AND DATE_ADD(MAX(B.dat), INTERVAL 3 DAY) >= DATE '2019-02-27' OR A.mandant_id = 7
                THEN DATE_ADD(MIN(B.dat), INTERVAL 2 DAY)
            ELSE DATE_ADD(MIN(B.dat), INTERVAL 3 DAY)
        END AS min_dat,
        CASE
            WHEN A.mandant_id = 8
                THEN DATE_ADD(MAX(B.dat), INTERVAL 7 DAY)
            WHEN A.mandant_id = 2 AND DATE_ADD(MAX(B.dat), INTERVAL 3 DAY) >= DATE '2019-02-27' OR A.mandant_id = 7
                THEN DATE_ADD(MAX(B.dat), INTERVAL 2 DAY)
            ELSE DATE_ADD(MAX(B.dat), INTERVAL 3 DAY)
        END AS max_dat,
        DATE_DIFF(CURRENT_DATE("Europe/Berlin"), CASE
            WHEN A.mandant_id = 8
                THEN DATE_ADD(MIN(B.dat), INTERVAL 7 DAY)
            WHEN A.mandant_id = 2 AND DATE_ADD(MAX(B.dat), INTERVAL 3 DAY) >= DATE '2019-02-27' OR A.mandant_id = 7
                THEN DATE_ADD(MIN(B.dat), INTERVAL 2 DAY)
            ELSE DATE_ADD(MIN(B.dat), INTERVAL 3 DAY)
        END, DAY) AS abstand,
        CASE
            WHEN
                DATE_DIFF(CURRENT_DATE("Europe/Berlin"), CASE
                    WHEN A.mandant_id = 8
                        THEN DATE_ADD(MIN(B.dat), INTERVAL 7 DAY)
                    WHEN A.mandant_id = 2 AND DATE_ADD(MAX(B.dat), INTERVAL 3 DAY) >= DATE '2019-02-27' OR A.mandant_id = 7
                        THEN DATE_ADD(MIN(B.dat), INTERVAL 2 DAY)
                    ELSE DATE_ADD(MIN(B.dat), INTERVAL 3 DAY)
                END, DAY) <= 0
                THEN 7
            WHEN
                DATE_DIFF(CURRENT_DATE("Europe/Berlin"), CASE
                    WHEN A.mandant_id = 8
                        THEN DATE_ADD(MIN(B.dat), INTERVAL 7 DAY)
                    WHEN A.mandant_id = 2 AND DATE_ADD(MAX(B.dat), INTERVAL 3 DAY) >= DATE '2019-02-27' OR A.mandant_id = 7
                        THEN DATE_ADD(MIN(B.dat), INTERVAL 2 DAY)
                    ELSE DATE_ADD(MIN(B.dat), INTERVAL 3 DAY)
                END, DAY) <= 7
                THEN 7 - DATE_DIFF(CURRENT_DATE("Europe/Berlin"), CASE
                    WHEN A.mandant_id = 8
                        THEN DATE_ADD(MIN(B.dat), INTERVAL 7 DAY)
                    WHEN A.mandant_id = 2 AND DATE_ADD(MAX(B.dat), INTERVAL 3 DAY) >= DATE '2019-02-27' OR A.mandant_id = 7
                        THEN DATE_ADD(MIN(B.dat), INTERVAL 2 DAY)
                    ELSE DATE_ADD(MIN(B.dat), INTERVAL 3 DAY)
                END, DAY)
            ELSE 0
        END AS diff,
        DATE_SUB(CASE
            WHEN A.mandant_id = 8
                THEN DATE_ADD(MIN(B.dat), INTERVAL 7 DAY)
            WHEN A.mandant_id = 2 AND DATE_ADD(MAX(B.dat), INTERVAL 3 DAY) >= DATE '2019-02-27' OR A.mandant_id = 7
                THEN DATE_ADD(MIN(B.dat), INTERVAL 2 DAY)
            ELSE DATE_ADD(MIN(B.dat), INTERVAL 3 DAY)
        END, INTERVAL 730 DAY) AS mseg_min_dat
    FROM dbp_data.mandant_1 AS A
    INNER JOIN dbp_data.tag_1 AS B ON TRUE
    WHERE
        B.akt_wo_komplett BETWEEN 0 AND 1
        AND A.mandant_id IN (2, 3, 4, 5, 6, 7)
    GROUP BY
        A.mandant_id,
        B.kjwo
) AS x
INNER JOIN dbp_data.tag_1 AS Y ON DATE_SUB(x.min_dat, INTERVAL x.diff DAY) = Y.dat;


/***************************************************/
/*    s t a r t   n o r m a l e   a r t i k e l    */
/***************************************************/


CREATE OR REPLACE TEMPORARY TABLE _artbew_snap_kp AS
SELECT
    A.mandant_id,
    B.zeitraum_kz,
    B.zeit_1,
    A.art_id,
    A.gp_id,
    A.dat,
    A.wup_id,
    CASE
        WHEN A.bq_findung_id = 28
            THEN 1
        ELSE 0
    END AS kopf_fg,
    SUM(A.menge) AS menge,
    SUM(A.umsatz_netto) AS umsatz_netto
FROM dbp_data.artbew_1 AS A
INNER JOIN `_zeitraeume` AS B ON A.mandant_id = B.mandant_id AND A.dat BETWEEN B.fake_min_dat AND B.max_dat
GROUP BY
    A.mandant_id,
    B.zeitraum_kz,
    B.zeit_1,
    A.art_id,
    A.gp_id,
    A.dat,
    A.wup_id,
    kopf_fg;


INSERT INTO `_artbew_snap_kp`
(
    SELECT
        A.mandant_id,
        A.zeitraum_kz,
        A.zeit_1,
        B.komponente_art_id,
        A.gp_id,
        A.dat,
        A.wup_id,
        0 AS kopf_fg,
        SUM(B.menge) AS menge,
        SUM(B.umsatz_netto) AS umsatz_netto
    FROM `_artbew_snap_kp` AS A
    INNER JOIN dbp_data.artbew_stueckliste_zu_1 AS B
        ON
            A.mandant_id = B.mandant_id AND A.art_id = B.art_id
            AND A.dat = B.dat AND A.wup_id = B.wup_id
    WHERE A.kopf_fg = 1
    GROUP BY
        A.mandant_id,
        A.zeitraum_kz,
        A.zeit_1,
        B.komponente_art_id,
        A.gp_id,
        A.dat,
        A.wup_id,
        kopf_fg
);


DELETE FROM `_artbew_snap_kp`
WHERE kopf_fg = 1;


CREATE OR REPLACE TEMPORARY TABLE _artbew_snap AS
SELECT
    mandant_id,
    zeitraum_kz,
    zeit_1,
    art_id,
    gp_id,
    wup_id,
    SUM(menge) AS menge,
    SUM(umsatz_netto) AS umsatz_netto
FROM `_artbew_snap_kp`
GROUP BY
    mandant_id,
    zeitraum_kz,
    zeit_1,
    art_id,
    gp_id,
    wup_id;


CREATE OR REPLACE TEMPORARY TABLE _mseg_snap1 AS
SELECT
    mandant_id,
    zeitraum_kz,
    zeit_1,
    dat_buch,
    art_id,
    gp_id,
    menge_lagerbew_bme,
    zeile,
    SUM(menge_lagerbew_bme) OVER (
        PARTITION BY mandant_id, art_id, zeitraum_kz, zeit_1 ORDER BY zeile IS NULL, zeile
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS accum
FROM (
    SELECT
        A.mandant_id,
        B.zeitraum_kz,
        B.zeit_1,
        A.dat_buch,
        A.art_id,
        A.gp_id,
        A.menge_lagerbew_bme,
        ROW_NUMBER() OVER (
            PARTITION BY
                A.mandant_id, A.art_id, B.zeitraum_kz, B.zeit_1 ORDER BY
                A.dat_buch IS NULL DESC, A.dat_buch
                DESC, A.gp_id IS NULL DESC, A.gp_id DESC, A.menge_lagerbew_bme IS NULL DESC, A.menge_lagerbew_bme DESC
        ) AS zeile
    FROM dbp_data.lagerbew_det_1 AS A
    INNER JOIN `_zeitraeume` AS B ON A.mandant_id = B.mandant_id AND A.dat_buch BETWEEN B.mseg_min_dat AND B.max_dat
    WHERE (
        A.mandant_id, A.art_id, B.zeitraum_kz, B.zeit_1) IN (
        SELECT (mandant_id, art_id, zeitraum_kz, zeit_1)
        FROM `_artbew_snap`
    )
    AND A.gp_id <> -1
    AND CASE
        WHEN A.mandant_id = 4 AND A.gp_id = 6100 OR A.gp_id >= 10000
            THEN 1
        ELSE 0
    END = 1
    AND A.lager_bewart_id IN ('101', '102', '901', '902', '161', '162')
    AND A.menge_lagerbew_bme > 0
) AS xxx_1;


CREATE OR REPLACE TEMPORARY TABLE _mseg_row_counter AS
SELECT
    X.mandant_id,
    X.zeitraum_kz,
    X.zeit_1,
    X.art_id,
    MIN(X.gp_id) AS gp_id,
    MIN(X.zeile) AS zeile,
    MAX(b.menge) AS menge
FROM `_mseg_snap1` AS X
INNER JOIN (
    SELECT
        mandant_id,
        zeitraum_kz,
        zeit_1,
        art_id,
        SUM(menge) AS menge
    FROM `_artbew_snap`
    WHERE gp_id <> -1
    GROUP BY
        mandant_id,
        zeitraum_kz,
        zeit_1,
        art_id
) AS b
    ON
        X.mandant_id = b.mandant_id AND X.art_id = b.art_id AND X.zeitraum_kz = b.zeitraum_kz AND X.zeit_1 = b.zeit_1
WHERE X.accum - b.menge >= 0
GROUP BY
    X.mandant_id,
    X.zeitraum_kz,
    X.zeit_1,
    X.art_id;


CREATE OR REPLACE TEMPORARY TABLE _mseg_snap2 AS
SELECT
    A.mandant_id,
    A.zeitraum_kz,
    A.zeit_1,
    A.dat_buch,
    A.art_id,
    A.gp_id,
    A.menge_lagerbew_bme,
    A.zeile,
    A.accum
FROM `_mseg_snap1` AS A
INNER JOIN `_mseg_row_counter` AS B
    ON
        A.mandant_id = B.mandant_id AND A.art_id = B.art_id AND A.zeitraum_kz = B.zeitraum_kz
        AND A.zeit_1 = B.zeit_1 AND A.zeile <= B.zeile
GROUP BY
    A.mandant_id,
    A.zeitraum_kz,
    A.zeit_1,
    A.dat_buch,
    A.art_id,
    A.gp_id,
    A.menge_lagerbew_bme,
    A.zeile,
    A.accum;


CREATE OR REPLACE TEMPORARY TABLE _mseg_snap3 AS
SELECT
    A.mandant_id,
    A.zeitraum_kz,
    A.zeit_1,
    A.dat_buch,
    A.art_id,
    A.gp_id,
    A.menge_lagerbew_bme,
    A.zeile,
    A.accum,
    CAST(B.ek_nettonetto AS NUMERIC) AS ek_nettonetto,
    CAST(B.ek_mep AS NUMERIC) AS ek_mep,
    CAST(B.ek_mep_vor_fwu AS NUMERIC) AS ek_mep_vor_fwu
FROM `_mseg_snap2` AS A
INNER JOIN dbp_data.art_gp_wup_zu_per_1 AS B
    ON
        A.mandant_id = B.mandant_id AND A.art_id = B.art_id AND A.gp_id = B.gp_id AND B.wup_id = -1 AND A.dat_buch BETWEEN B.dat_von AND B.dat_bis
WHERE A.mandant_id = 2;


INSERT INTO `_mseg_snap3`
(
    SELECT
        A.mandant_id,
        A.zeitraum_kz,
        A.zeit_1,
        A.dat_buch,
        A.art_id,
        A.gp_id,
        A.menge_lagerbew_bme,
        A.zeile,
        A.accum,
        CAST(B.ek_nettonetto AS NUMERIC) AS ek_nettonetto,
        CAST(B.ek_mep AS NUMERIC) AS ek_mep,
        CAST(B.ek_mep_vor_fwu AS NUMERIC) AS ek_mep_vor_fwu
    FROM `_mseg_snap2` AS A
    INNER JOIN dbp_data.art_gp_wup_zu_per_1 AS B
        ON
            A.mandant_id = B.mandant_id AND A.art_id = B.art_id AND A.gp_id = B.gp_id AND B.wup_id = -1 AND A.dat_buch BETWEEN B.dat_von AND B.dat_bis
    WHERE A.mandant_id = 3
);


INSERT INTO `_mseg_snap3`
(
    SELECT
        A.mandant_id,
        A.zeitraum_kz,
        A.zeit_1,
        A.dat_buch,
        A.art_id,
        A.gp_id,
        A.menge_lagerbew_bme,
        A.zeile,
        A.accum,
        CAST(B.ek_nettonetto AS NUMERIC) AS ek_nettonetto,
        CAST(B.ek_mep AS NUMERIC) AS ek_mep,
        CAST(B.ek_mep_vor_fwu AS NUMERIC) AS ek_mep_vor_fwu
    FROM `_mseg_snap2` AS A
    INNER JOIN dbp_data.art_gp_wup_zu_per_1 AS B
        ON
            A.mandant_id = B.mandant_id AND A.art_id = B.art_id AND A.gp_id = B.gp_id AND B.wup_id = -1 AND A.dat_buch BETWEEN B.dat_von AND B.dat_bis
    WHERE A.mandant_id = 4
);


INSERT INTO `_mseg_snap3`
(
    SELECT
        A.mandant_id,
        A.zeitraum_kz,
        A.zeit_1,
        A.dat_buch,
        A.art_id,
        A.gp_id,
        A.menge_lagerbew_bme,
        A.zeile,
        A.accum,
        CAST(B.ek_nettonetto AS NUMERIC) AS ek_nettonetto,
        CAST(B.ek_mep AS NUMERIC) AS ek_mep,
        CAST(B.ek_mep_vor_fwu AS NUMERIC) AS ek_mep_vor_fwu
    FROM `_mseg_snap2` AS A
    INNER JOIN dbp_data.art_gp_wup_zu_per_1 AS B
        ON
            A.mandant_id = B.mandant_id AND A.art_id = B.art_id AND A.gp_id = B.gp_id AND B.wup_id = -1 AND A.dat_buch BETWEEN B.dat_von AND B.dat_bis
    WHERE A.mandant_id = 5
);


INSERT INTO `_mseg_snap3`
(
    SELECT
        A.mandant_id,
        A.zeitraum_kz,
        A.zeit_1,
        A.dat_buch,
        A.art_id,
        A.gp_id,
        A.menge_lagerbew_bme,
        A.zeile,
        A.accum,
        CAST(B.ek_nettonetto AS NUMERIC) AS ek_nettonetto,
        CAST(B.ek_mep AS NUMERIC) AS ek_mep,
        CAST(B.ek_mep_vor_fwu AS NUMERIC) AS ek_mep_vor_fwu
    FROM `_mseg_snap2` AS A
    INNER JOIN dbp_data.art_gp_wup_zu_per_1 AS B
        ON
            A.mandant_id = B.mandant_id AND A.art_id = B.art_id AND A.gp_id = B.gp_id AND B.wup_id = -1 AND A.dat_buch BETWEEN B.dat_von AND B.dat_bis
    WHERE A.mandant_id = 6
);


INSERT INTO `_mseg_snap3`
(
    SELECT
        A.mandant_id,
        A.zeitraum_kz,
        A.zeit_1,
        A.dat_buch,
        A.art_id,
        A.gp_id,
        A.menge_lagerbew_bme,
        A.zeile,
        A.accum,
        CAST(B.ek_nettonetto AS NUMERIC) AS ek_nettonetto,
        CAST(B.ek_mep AS NUMERIC) AS ek_mep,
        CAST(B.ek_mep_vor_fwu AS NUMERIC) AS ek_mep_vor_fwu
    FROM `_mseg_snap2` AS A
    INNER JOIN dbp_data.art_gp_wup_zu_per_1 AS B
        ON
            A.mandant_id = B.mandant_id AND A.art_id = B.art_id AND A.gp_id = B.gp_id AND B.wup_id = -1 AND A.dat_buch BETWEEN B.dat_von AND B.dat_bis
    WHERE A.mandant_id = 7
);


INSERT INTO `_mseg_snap3`
(
    SELECT
        A.mandant_id,
        A.zeitraum_kz,
        A.zeit_1,
        A.dat_buch,
        A.art_id,
        A.gp_id,
        A.menge_lagerbew_bme,
        A.zeile,
        A.accum,
        CAST(B.ek_nettonetto AS NUMERIC) AS ek_nettonetto,
        CAST(B.ek_mep AS NUMERIC) AS ek_mep,
        CAST(B.ek_mep_vor_fwu AS NUMERIC) AS ek_mep_vor_fwu
    FROM `_mseg_snap2` AS A
    INNER JOIN dbp_data.art_gp_wup_zu_per_1 AS B
        ON
            A.mandant_id = B.mandant_id AND A.art_id = B.art_id AND A.gp_id = B.gp_id AND B.wup_id = -1 AND A.dat_buch BETWEEN B.dat_von AND B.dat_bis
    WHERE A.mandant_id = 8
);


CREATE OR REPLACE TEMPORARY TABLE _mseg_snap4 AS
SELECT
    A.mandant_id,
    A.zeitraum_kz,
    A.zeit_1,
    A.dat_buch,
    A.art_id,
    A.gp_id,
    A.menge_lagerbew_bme,
    A.zeile,
    A.accum,
    A.ek_nettonetto,
    A.ek_mep,
    A.ek_mep_vor_fwu,
    CASE
        WHEN B.menge IS NULL
            THEN A.menge_lagerbew_bme
        ELSE A.menge_lagerbew_bme - (A.accum - B.menge)
    END AS neue_menge,
    A.ek_nettonetto - A.ek_mep AS ek_diff,
    A.ek_nettonetto - A.ek_mep_vor_fwu AS ek_diff_fwu,
    (A.ek_nettonetto - A.ek_mep) * CASE
        WHEN B.menge IS NULL
            THEN A.menge_lagerbew_bme
        ELSE A.menge_lagerbew_bme - (A.accum - B.menge)
    END AS boni,
    (A.ek_nettonetto - A.ek_mep_vor_fwu) * CASE
        WHEN B.menge IS NULL
            THEN A.menge_lagerbew_bme
        ELSE A.menge_lagerbew_bme - (A.accum - B.menge)
    END AS boni_fwu,
    X.min_dat AS dat_von,
    X.max_dat AS dat_bis
FROM `_mseg_snap3` AS A
INNER JOIN `_zeitraeume` AS X ON A.mandant_id = X.mandant_id AND A.zeitraum_kz = X.zeitraum_kz AND A.zeit_1 = X.zeit_1
LEFT JOIN `_mseg_row_counter`
    AS B ON A.mandant_id = B.mandant_id AND A.art_id = B.art_id AND A.zeitraum_kz = B.zeitraum_kz
AND A.zeit_1 = B.zeit_1 AND A.zeile = B.zeile;


CREATE OR REPLACE TEMPORARY TABLE _mseg_snap5 AS
SELECT
    mandant_id,
    zeitraum_kz,
    zeit_1,
    art_id,
    SUM(neue_menge) AS we_menge,
    SUM(boni) AS boni,
    SUM(boni_fwu) AS boni_fwu
FROM `_mseg_snap4` AS A
GROUP BY
    mandant_id,
    zeitraum_kz,
    zeit_1,
    art_id;


CREATE OR REPLACE TEMPORARY TABLE _hilfe AS
SELECT
    A.mandant_id,
    b.zeitraum_kz,
    b.zeit_1,
    A.art_id,
    SUM(A.menge) AS menge
FROM dbp_data.artbew_1 AS A
INNER JOIN (
    SELECT
        A0.mandant_id,
        A0.zeitraum_kz,
        A0.zeit_1,
        A0.art_id,
        B.fake_min_dat,
        B.max_dat
    FROM `_mseg_snap5` AS A0
    INNER JOIN `_zeitraeume` AS B ON A0.mandant_id = B.mandant_id AND A0.zeitraum_kz = B.zeitraum_kz AND A0.zeit_1 = B.zeit_1

    GROUP BY
        A0.mandant_id,
        A0.zeitraum_kz,
        A0.zeit_1,
        A0.art_id,
        B.fake_min_dat,
        B.max_dat
) AS b ON A.mandant_id = b.mandant_id AND A.art_id = b.art_id AND A.dat BETWEEN b.fake_min_dat AND b.max_dat

GROUP BY
    A.mandant_id,
    b.zeitraum_kz,
    b.zeit_1,
    A.art_id;


CREATE OR REPLACE TEMPORARY TABLE _testit AS
SELECT
    A.mandant_id,
    A.art_id,
    A.zeitraum_kz,
    B.min_dat AS dat_von,
    B.max_dat AS dat_bis,
    ROUND(CAST(COALESCE(A.boni, 0) AS NUMERIC), 4) AS betrag_kmep,
    COALESCE(c.menge, 0) AS menge_artbew_sum,
    CAST(IFNULL(COALESCE(A.boni, 0) / IF(c.menge = 0, NULL, c.menge), 0) AS NUMERIC) AS betrag_kmep_einh,
    CAST(IFNULL(COALESCE(A.boni_fwu, 0) / IF(c.menge = 0, NULL, c.menge), 0) AS NUMERIC) AS betrag_kmep_einh_o_fwu
FROM `_mseg_snap5` AS A
INNER JOIN `_zeitraeume` AS B ON A.mandant_id = B.mandant_id AND A.zeitraum_kz = B.zeitraum_kz AND A.zeit_1 = B.zeit_1
LEFT JOIN `_hilfe` AS c
    ON
        A.mandant_id = c.mandant_id AND A.art_id = c.art_id AND A.zeitraum_kz = c.zeitraum_kz AND A.zeit_1 = c.zeit_1
UNION DISTINCT
SELECT
    A.mandant_id,
    A.art_id,
    'WW' AS zeitraum_kz,
    B.min_dat AS dat_von,
    B.max_dat AS dat_bis,
    ROUND(CAST(COALESCE(A.boni, 0) AS NUMERIC), 4) AS betrag_kmep,
    COALESCE(c.menge, 0) AS menge_artbew_sum,
    CAST(IFNULL(COALESCE(A.boni, 0) / IF(c.menge = 0, NULL, c.menge), 0) AS NUMERIC) AS betrag_kmep_einh,
    CAST(IFNULL(COALESCE(A.boni_fwu, 0) / IF(c.menge = 0, NULL, c.menge), 0) AS NUMERIC) AS betrag_kmep_einh_o_fwu
FROM `_mseg_snap5` AS A
INNER JOIN `_zeitraeume` AS B ON A.mandant_id = B.mandant_id AND A.zeitraum_kz = B.zeitraum_kz AND A.zeit_1 = B.zeit_1
LEFT JOIN `_hilfe` AS c
    ON
        A.mandant_id = c.mandant_id AND A.art_id = c.art_id AND A.zeitraum_kz = c.zeitraum_kz AND A.zeit_1 = c.zeit_1
WHERE
    B.zeitraum_kz = 'KW'
    AND B.mandant_id = 8;


/***************************************************/
/*    s t a r t   d i s p l a y   a r t i k e l    */
/***************************************************/

---------- 0. display-analyse ----------


CREATE OR REPLACE TEMPORARY TABLE _relevante_artikel_1 AS
SELECT
    A.mandant_id,
    A.dat_von,
    A.dat_bis,
    A.art_id AS kopf_art_id,
    B.art_id AS pos_art_id,
    B.komponentenmenge,
    B.komponentenmenge_einh_id
FROM dbp_data.stueckliste_1 AS A
INNER JOIN dbp_data.stueckliste_det_1 AS B
    ON
        A.mandant_id = B.mandant_id AND A.stueckliste_id = B.stueckliste_id
        AND B.dat_bis = DATE '9999-12-31'
WHERE (
    A.mandant_id, A.art_id) IN (
    SELECT (mandant_id, art_id)
    FROM dbp_data.art_1
    WHERE
        artikeltyp_id = 12
        AND mandant_id > 1
        AND (
            mandant_id, art_id) NOT IN (
            SELECT (mandant_id, art_id)
            FROM dbp_etl_process.ekc_deny_displays_1
        )
);


CREATE OR REPLACE TEMPORARY TABLE _nums AS
SELECT
    mandant_id,
    kopf_art_id,
    COUNT(DISTINCT pos_art_id) AS anz
FROM `_relevante_artikel_1`
GROUP BY
    mandant_id,
    kopf_art_id;


CREATE OR REPLACE TEMPORARY TABLE _mseg_snap0 AS
SELECT
    A.mandant_id,
    A.lagerbew_beleg_id,
    A.lagerbew_beleg_pos_id,
    A.kj,
    A.grund_id,
    A.lager_bewart_id,
    A.art_id,
    A.wup_id,
    A.nb_id,
    A.auto_fg,
    A.lagerort_id,
    A.gp_id,
    A.einkaufsorganisation_id,
    A.soll_haben_kz,
    A.wrg_id,
    A.best_beleg_id,
    A.best_beleg_pos_id,
    A.betrag_lagerbew,
    A.betrag_verkauf,
    A.erfsngs_menge_einh_id,
    A.lagerplatz_id,
    A.kunde_id,
    A.menge_lagerbew_kolli,
    A.menge_lagerbew_bme,
    A.menge_lagerbew_palette,
    A.menge_lieferschein,
    A.menge_lief,
    A.menge_erf,
    A.empfaenger_id,
    A.dat_buch,
    A.lagerbew_beleg_storno_id,
    A.lagerbew_beleg_pos_storno_id,
    A.lagerbew_beleg_storno_kj,
    A.betrag_vk_netto,
    A.system_id,
    A.betrag_belegfluss_wg_art,
    A.mandant_id_kunde,
    A.mandant_id_empfaenger,
    A.bw_vorgang_id,
    A.betrag_verkauf_ist,
    A.betrag_vk_netto_vz,
    A.betrag_verkauf_ist_netto,
    A.betrag_einstandspreis,
    A.gp_id_zl,
    A.bq_findung_id,
    A.lagerbew_beleg_pos_mutter_id,
    A.line_id,
    A.display_art_id,
    A.td_update,
    A.td_insert
FROM dbp_data.lagerbew_det_1 AS A
INNER JOIN (
    SELECT
        mandant_id,
        kopf_art_id
    FROM `_relevante_artikel_1`
    GROUP BY
        mandant_id,
        kopf_art_id
) AS b ON A.mandant_id = b.mandant_id AND A.art_id = b.kopf_art_id
WHERE A.mandant_id > 1;


CREATE OR REPLACE TEMPORARY TABLE _shit AS
SELECT
    A.mandant_id,
    B.zeitraum_kz,
    B.zeit_1,
    A.dat_buch,
    c.dat_von,
    c.dat_bis,
    D.kopf_art_id,
    D.pos_art_id AS art_id,
    A.gp_id,
    A.menge_lagerbew_bme * D.komponentenmenge AS menge_lagerbew_bme_
FROM `_mseg_snap0` AS A
INNER JOIN `_zeitraeume` AS B ON A.mandant_id = B.mandant_id AND A.dat_buch BETWEEN B.mseg_min_dat AND B.max_dat
INNER JOIN (
    SELECT
        mandant_id,
        kopf_art_id,
        dat_von,
        dat_bis
    FROM `_relevante_artikel_1`
    GROUP BY
        mandant_id,
        kopf_art_id,
        dat_von,
        dat_bis
) AS c ON A.mandant_id = c.mandant_id AND A.art_id = c.kopf_art_id AND A.dat_buch BETWEEN c.dat_von AND c.dat_bis

INNER JOIN `_relevante_artikel_1` AS D
    ON
        A.mandant_id = D.mandant_id AND c.kopf_art_id = D.kopf_art_id AND A.dat_buch
        BETWEEN D.dat_von AND D.dat_bis
WHERE
    A.gp_id <> -1
    AND CASE
        WHEN A.mandant_id = 4 AND A.gp_id = 6100 OR A.gp_id >= 10000
            THEN 1
        ELSE 0
    END = 1
    AND A.lager_bewart_id IN ('101', '102', '901', '902', '161', '162')
GROUP BY
    A.mandant_id,
    B.zeitraum_kz,
    B.zeit_1,
    A.dat_buch,
    c.dat_von,
    c.dat_bis,
    D.kopf_art_id,
    art_id,
    A.gp_id,
    menge_lagerbew_bme_;


CREATE OR REPLACE TEMPORARY TABLE _zwischen AS
SELECT *
FROM `_shit` AS A
QUALIFY (ROW_NUMBER() OVER (
    PARTITION BY
        mandant_id, art_id, zeitraum_kz, zeit_1 ORDER BY
        dat_buch IS NULL DESC, dat_buch
        DESC
)) = 1;


CREATE OR REPLACE TEMPORARY TABLE _verarbeitung1 AS
SELECT
    A.mandant_id,
    A.kopf_art_id,
    COUNT(DISTINCT A.art_id) AS anz_pos,
    MAX(B.anz) AS anz_vorgabe
FROM `_zwischen` AS A
INNER JOIN `_nums` AS B ON A.mandant_id = B.mandant_id AND A.kopf_art_id = B.kopf_art_id
GROUP BY
    A.mandant_id,
    A.kopf_art_id
HAVING anz_pos = anz_vorgabe;


CREATE OR REPLACE TEMPORARY TABLE _verarbeitung2 AS
SELECT
    A.mandant_id,
    A.kopf_art_id,
    COUNT(DISTINCT A.art_id) AS anz_pos,
    MAX(B.anz) AS anz_vorgabe
FROM `_zwischen` AS A
INNER JOIN `_nums` AS B ON A.mandant_id = B.mandant_id AND A.kopf_art_id = B.kopf_art_id
GROUP BY
    A.mandant_id,
    A.kopf_art_id
HAVING anz_pos <> anz_vorgabe;


---------- 1. display-verarbeitung ----------


CREATE OR REPLACE TEMPORARY TABLE _relevante_artikel_1 AS
SELECT
    A.mandant_id,
    A.dat_von,
    A.dat_bis,
    A.art_id AS kopf_art_id,
    B.art_id AS pos_art_id,
    B.komponentenmenge,
    B.komponentenmenge_einh_id
FROM dbp_data.stueckliste_1 AS A
INNER JOIN dbp_data.stueckliste_det_1 AS B
    ON
        A.mandant_id = B.mandant_id AND A.stueckliste_id = B.stueckliste_id
        AND B.dat_bis = DATE '9999-12-31'
WHERE (
    A.mandant_id, A.art_id) IN (
    SELECT (mandant_id, art_id)
    FROM dbp_data.art_1
    WHERE
        artikeltyp_id = 12
        AND mandant_id > 1
        AND (
            mandant_id, art_id) NOT IN (
            SELECT (mandant_id, art_id)
            FROM dbp_etl_process.ekc_deny_displays_1
        )
)
AND (
    A.mandant_id, A.art_id) IN (
    SELECT (mandant_id, kopf_art_id)
    FROM `_verarbeitung1`
);


CREATE OR REPLACE TEMPORARY TABLE _mseg_snap0 AS
SELECT
    A.mandant_id,
    A.lagerbew_beleg_id,
    A.lagerbew_beleg_pos_id,
    A.kj,
    A.grund_id,
    A.lager_bewart_id,
    A.art_id,
    A.wup_id,
    A.nb_id,
    A.auto_fg,
    A.lagerort_id,
    A.gp_id,
    A.einkaufsorganisation_id,
    A.soll_haben_kz,
    A.wrg_id,
    A.best_beleg_id,
    A.best_beleg_pos_id,
    A.betrag_lagerbew,
    A.betrag_verkauf,
    A.erfsngs_menge_einh_id,
    A.lagerplatz_id,
    A.kunde_id,
    A.menge_lagerbew_kolli,
    A.menge_lagerbew_bme,
    A.menge_lagerbew_palette,
    A.menge_lieferschein,
    A.menge_lief,
    A.menge_erf,
    A.empfaenger_id,
    A.dat_buch,
    A.lagerbew_beleg_storno_id,
    A.lagerbew_beleg_pos_storno_id,
    A.lagerbew_beleg_storno_kj,
    A.betrag_vk_netto,
    A.system_id,
    A.betrag_belegfluss_wg_art,
    A.mandant_id_kunde,
    A.mandant_id_empfaenger,
    A.bw_vorgang_id,
    A.betrag_verkauf_ist,
    A.betrag_vk_netto_vz,
    A.betrag_verkauf_ist_netto,
    A.betrag_einstandspreis,
    A.gp_id_zl,
    A.bq_findung_id,
    A.lagerbew_beleg_pos_mutter_id,
    A.line_id,
    A.display_art_id,
    A.td_update,
    A.td_insert
FROM dbp_data.lagerbew_det_1 AS A
INNER JOIN (
    SELECT
        mandant_id,
        kopf_art_id
    FROM `_relevante_artikel_1`
    GROUP BY
        mandant_id,
        kopf_art_id
) AS b ON A.mandant_id = b.mandant_id AND A.art_id = b.kopf_art_id
WHERE A.mandant_id > 1;


CREATE OR REPLACE TEMPORARY TABLE _shit AS
SELECT
    A.mandant_id,
    B.zeitraum_kz,
    B.zeit_1,
    A.dat_buch,
    c.dat_von,
    c.dat_bis,
    D.kopf_art_id,
    D.pos_art_id AS art_id,
    A.gp_id,
    A.menge_lagerbew_bme * D.komponentenmenge AS menge_lagerbew_bme_
FROM `_mseg_snap0` AS A
INNER JOIN `_zeitraeume` AS B ON A.mandant_id = B.mandant_id AND A.dat_buch BETWEEN B.mseg_min_dat AND B.max_dat
INNER JOIN (
    SELECT
        mandant_id,
        kopf_art_id,
        dat_von,
        dat_bis
    FROM `_relevante_artikel_1`
    GROUP BY
        mandant_id,
        kopf_art_id,
        dat_von,
        dat_bis
) AS c ON A.mandant_id = c.mandant_id AND A.art_id = c.kopf_art_id AND A.dat_buch BETWEEN c.dat_von AND c.dat_bis

INNER JOIN `_relevante_artikel_1` AS D
    ON
        A.mandant_id = D.mandant_id AND c.kopf_art_id = D.kopf_art_id AND A.dat_buch
        BETWEEN D.dat_von AND D.dat_bis
WHERE
    A.gp_id <> -1
    AND CASE
        WHEN A.mandant_id = 4 AND A.gp_id = 6100 OR A.gp_id >= 10000
            THEN 1
        ELSE 0
    END = 1
    AND A.lager_bewart_id IN ('101', '102', '901', '902', '161', '162')
GROUP BY
    A.mandant_id,
    B.zeitraum_kz,
    B.zeit_1,
    A.dat_buch,
    c.dat_von,
    c.dat_bis,
    D.kopf_art_id,
    art_id,
    A.gp_id,
    menge_lagerbew_bme_;


CREATE OR REPLACE TEMPORARY TABLE _zwischen AS
SELECT *
FROM `_shit` AS A
QUALIFY (ROW_NUMBER() OVER (
    PARTITION BY
        mandant_id, art_id, zeitraum_kz, zeit_1 ORDER BY
        dat_buch IS NULL DESC, dat_buch
        DESC
)) = 1;


CREATE OR REPLACE TEMPORARY TABLE _relevante_artikel_2 AS
SELECT
    A.mandant_id,
    A.dat_von,
    A.dat_bis,
    MAX(A.art_id) AS kopf_art_id,
    B.art_id AS pos_art_id,
    B.komponentenmenge,
    B.komponentenmenge_einh_id
FROM dbp_data.stueckliste_1 AS A
INNER JOIN dbp_data.stueckliste_det_1 AS B
    ON
        A.mandant_id = B.mandant_id AND A.stueckliste_id = B.stueckliste_id
        AND B.dat_bis = DATE '9999-12-31'
WHERE (
    A.mandant_id, A.art_id) IN (
    SELECT (mandant_id, art_id)
    FROM dbp_data.art_1
    WHERE
        artikeltyp_id = 12
        AND mandant_id > 1
        AND (
            mandant_id, art_id) NOT IN (
            SELECT (mandant_id, art_id)
            FROM dbp_etl_process.ekc_deny_displays_1
        )
)
AND (
    A.mandant_id, A.art_id) IN (
    SELECT (mandant_id, kopf_art_id)
    FROM `_zwischen`
)
GROUP BY
    A.mandant_id,
    A.dat_von,
    A.dat_bis,
    pos_art_id,
    B.komponentenmenge,
    B.komponentenmenge_einh_id;


CREATE OR REPLACE TEMPORARY TABLE _artbew_snap_kp_0 AS
SELECT
    A.mandant_id,
    B.zeitraum_kz,
    B.zeit_1,
    A.art_id,
    A.gp_id,
    A.dat,
    A.wup_id,
    CASE
        WHEN A.bq_findung_id = 28
            THEN 1
        ELSE 0
    END AS kopf_fg,
    SUM(A.menge) AS menge,
    SUM(A.umsatz_netto) AS umsatz_netto
FROM dbp_data.artbew_1 AS A
INNER JOIN `_zeitraeume` AS B ON A.mandant_id = B.mandant_id AND A.dat BETWEEN B.fake_min_dat AND B.max_dat
GROUP BY
    A.mandant_id,
    B.zeitraum_kz,
    B.zeit_1,
    A.art_id,
    A.gp_id,
    A.dat,
    A.wup_id,
    kopf_fg;


CREATE OR REPLACE TEMPORARY TABLE _artbew_snap_kp AS
SELECT DISTINCT
    A.mandant_id,
    A.zeitraum_kz,
    A.zeit_1,
    A.art_id,
    A.gp_id,
    A.dat,
    A.wup_id,
    A.kopf_fg,
    A.menge,
    A.umsatz_netto
FROM `_artbew_snap_kp_0` AS A
INNER JOIN (
    SELECT
        mandant_id,
        pos_art_id
    FROM `_relevante_artikel_2`
    GROUP BY
        mandant_id,
        pos_art_id
) AS c ON A.mandant_id = c.mandant_id AND A.art_id = c.pos_art_id;


CREATE OR REPLACE TEMPORARY TABLE _artbew_snap AS
SELECT
    mandant_id,
    zeitraum_kz,
    zeit_1,
    art_id,
    gp_id,
    wup_id,
    SUM(menge) AS menge,
    SUM(umsatz_netto) AS umsatz_netto
FROM `_artbew_snap_kp`
GROUP BY
    mandant_id,
    zeitraum_kz,
    zeit_1,
    art_id,
    gp_id,
    wup_id;


CREATE OR REPLACE TEMPORARY TABLE _mseg_snap0 AS
SELECT
    A.mandant_id,
    A.lagerbew_beleg_id,
    A.lagerbew_beleg_pos_id,
    A.kj,
    A.grund_id,
    A.lager_bewart_id,
    A.art_id,
    A.wup_id,
    A.nb_id,
    A.auto_fg,
    A.lagerort_id,
    A.gp_id,
    A.einkaufsorganisation_id,
    A.soll_haben_kz,
    A.wrg_id,
    A.best_beleg_id,
    A.best_beleg_pos_id,
    A.betrag_lagerbew,
    A.betrag_verkauf,
    A.erfsngs_menge_einh_id,
    A.lagerplatz_id,
    A.kunde_id,
    A.menge_lagerbew_kolli,
    A.menge_lagerbew_bme,
    A.menge_lagerbew_palette,
    A.menge_lieferschein,
    A.menge_lief,
    A.menge_erf,
    A.empfaenger_id,
    A.dat_buch,
    A.lagerbew_beleg_storno_id,
    A.lagerbew_beleg_pos_storno_id,
    A.lagerbew_beleg_storno_kj,
    A.betrag_vk_netto,
    A.system_id,
    A.betrag_belegfluss_wg_art,
    A.mandant_id_kunde,
    A.mandant_id_empfaenger,
    A.bw_vorgang_id,
    A.betrag_verkauf_ist,
    A.betrag_vk_netto_vz,
    A.betrag_verkauf_ist_netto,
    A.betrag_einstandspreis,
    A.gp_id_zl,
    A.bq_findung_id,
    A.lagerbew_beleg_pos_mutter_id,
    A.line_id,
    A.display_art_id,
    A.td_update,
    A.td_insert
FROM dbp_data.lagerbew_det_1 AS A
INNER JOIN (
    SELECT
        mandant_id,
        kopf_art_id
    FROM `_relevante_artikel_2`
    GROUP BY
        mandant_id,
        kopf_art_id
) AS b ON A.mandant_id = b.mandant_id AND A.art_id = b.kopf_art_id
WHERE A.mandant_id > 1;


CREATE OR REPLACE TEMPORARY TABLE _mseg_snap1 AS
SELECT
    mandant_id,
    zeitraum_kz,
    zeit_1,
    dat_buch,
    kopf_art_id,
    art_id,
    gp_id,
    menge_lagerbew_bme_ AS menge_lagerbew_bme,
    zeile,
    SUM(menge_lagerbew_bme_) OVER (
        PARTITION BY mandant_id, art_id, zeitraum_kz, zeit_1 ORDER BY zeile IS NULL, zeile
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS accum
FROM (SELECT
    mandant_id,
    zeitraum_kz,
    zeit_1,
    dat_buch,
    kopf_art_id,
    art_id,
    gp_id,
    kopf_fg,
    lagerbew_beleg_id,
    menge_lagerbew_bme_,
    ROW_NUMBER() OVER (
        PARTITION BY
            mandant_id, art_id, zeitraum_kz, zeit_1 ORDER BY
            dat_buch IS NULL DESC, dat_buch DESC,
            kopf_fg IS NULL, kopf_fg, lagerbew_beleg_id IS NULL, lagerbew_beleg_id, gp_id IS NULL DESC, gp_id DESC,
            menge_lagerbew_bme_ IS NULL DESC, menge_lagerbew_bme_ DESC
    ) AS zeile
FROM (
    SELECT
        mandant_id,
        zeitraum_kz,
        zeit_1,
        dat_buch,
        kopf_art_id,
        art_id,
        gp_id,
        kopf_fg,
        lagerbew_beleg_id,
        SUM(menge_lagerbew_bme) AS menge_lagerbew_bme_
    FROM ((
        SELECT
            A.mandant_id,
            B.zeitraum_kz,
            B.zeit_1,
            A.dat_buch,
            D.kopf_art_id,
            A.lagerbew_beleg_id,
            A.art_id,
            A.gp_id,
            A.menge_lagerbew_bme,
            1 AS kopf_fg
        FROM dbp_data.lagerbew_det_1 AS A
        INNER JOIN `_zeitraeume` AS B ON A.mandant_id = B.mandant_id AND A.dat_buch BETWEEN B.mseg_min_dat AND B.max_dat

        INNER JOIN (
            SELECT
                mandant_id,
                kopf_art_id,
                dat_von,
                dat_bis
            FROM `_relevante_artikel_2`
            GROUP BY
                mandant_id,
                dat_von,
                dat_bis,
                kopf_art_id
        ) AS t0
            ON
                A.mandant_id = t0.mandant_id AND A.art_id = t0.kopf_art_id AND A.dat_buch BETWEEN t0.dat_von
                AND t0.dat_bis
        INNER JOIN `_relevante_artikel_2` AS D ON A.mandant_id = D.mandant_id AND t0.kopf_art_id = D.kopf_art_id
        WHERE (
            A.mandant_id, A.art_id, B.zeitraum_kz, B.zeit_1) IN (
            SELECT (mandant_id, art_id, zeitraum_kz, zeit_1)
            FROM `_artbew_snap`
        )
        AND A.gp_id <> -1
        AND CASE
            WHEN A.mandant_id = 4 AND A.gp_id = 6100 OR A.gp_id >= 10000
                THEN 1
            ELSE 0
        END = 1
        AND A.lager_bewart_id IN ('101', '102', '901', '902', '161', '162')
        AND A.menge_lagerbew_bme > 0
        UNION DISTINCT
        SELECT
            A.mandant_id,
            B.zeitraum_kz,
            B.zeit_1,
            A.dat_buch,
            D.kopf_art_id,
            A.lagerbew_beleg_id,
            D.pos_art_id AS art_id,
            A.gp_id,
            A.menge_lagerbew_bme * D.komponentenmenge AS menge_lagerbew_bme,
            1 AS kopf_fg
        FROM `_mseg_snap0` AS A
        INNER JOIN `_zeitraeume` AS B ON A.mandant_id = B.mandant_id AND A.dat_buch BETWEEN B.mseg_min_dat AND B.max_dat

        INNER JOIN (
            SELECT
                mandant_id,
                kopf_art_id,
                dat_von,
                dat_bis
            FROM `_relevante_artikel_2`
            GROUP BY
                mandant_id,
                dat_von,
                dat_bis,
                kopf_art_id
        ) AS t5
            ON
                A.mandant_id = t5.mandant_id AND A.art_id = t5.kopf_art_id AND A.dat_buch BETWEEN t5.dat_von
                AND t5.dat_bis
        INNER JOIN `_relevante_artikel_2` AS D
            ON
                A.mandant_id = D.mandant_id AND t5.kopf_art_id = D.kopf_art_id AND A.dat_buch BETWEEN D.dat_von AND D.dat_bis
        WHERE
            A.gp_id <> -1
            AND CASE
                WHEN A.mandant_id = 4 AND A.gp_id = 6100 OR A.gp_id >= 10000
                    THEN 1
                ELSE 0
            END = 1
            AND A.lager_bewart_id IN ('101', '102', '901', '902', '161', '162')
            AND A.menge_lagerbew_bme > 0
    )
    UNION DISTINCT
    SELECT
        A.mandant_id,
        B.zeitraum_kz,
        B.zeit_1,
        A.dat_buch,
        9999 AS kopf_art_id,
        A.lagerbew_beleg_id,
        A.art_id,
        A.gp_id,
        A.menge_lagerbew_bme,
        0 AS kopf_fg
    FROM dbp_data.lagerbew_det_1 AS A
    INNER JOIN `_zeitraeume` AS B ON A.mandant_id = B.mandant_id AND A.dat_buch BETWEEN B.mseg_min_dat AND B.max_dat

        WHERE (
            A.mandant_id, A.art_id, B.zeitraum_kz, B.zeit_1) IN (
            SELECT (mandant_id, art_id, zeitraum_kz, zeit_1)
            FROM `_artbew_snap`
        )
        AND A.gp_id <> -1
        AND CASE
            WHEN A.mandant_id = 4 AND A.gp_id = 6100 OR A.gp_id >= 10000
                THEN 1
            ELSE 0
        END = 1
        AND A.lager_bewart_id IN ('101', '102', '901', '902', '161', '162')
        AND A.menge_lagerbew_bme > 0
    ) AS x
    GROUP BY
        mandant_id,
        zeitraum_kz,
        zeit_1,
        dat_buch,
        kopf_art_id,
        lagerbew_beleg_id,
        art_id,
        gp_id,
        kopf_fg
) AS t13) AS xxx_1;


CREATE OR REPLACE TEMPORARY TABLE _mseg_row_counter AS
SELECT
    X.mandant_id,
    X.zeitraum_kz,
    X.zeit_1,
    MAX(X.kopf_art_id) AS kopf_art_id,
    X.art_id,
    MIN(X.gp_id) AS gp_id,
    MIN(X.zeile) AS zeile,
    MAX(b.menge) AS menge
FROM `_mseg_snap1` AS X
INNER JOIN (
    SELECT
        mandant_id,
        zeitraum_kz,
        zeit_1,
        art_id,
        SUM(menge) AS menge
    FROM `_artbew_snap`
    WHERE gp_id <> -1
    GROUP BY
        mandant_id,
        zeitraum_kz,
        zeit_1,
        art_id
) AS b
    ON
        X.mandant_id = b.mandant_id AND X.art_id = b.art_id AND X.zeitraum_kz = b.zeitraum_kz AND X.zeit_1 = b.zeit_1
WHERE X.accum - b.menge >= 0
GROUP BY
    X.mandant_id,
    X.zeitraum_kz,
    X.zeit_1,
    X.art_id;


CREATE OR REPLACE TEMPORARY TABLE _mseg_snap2 AS
SELECT
    A.mandant_id,
    A.zeitraum_kz,
    A.zeit_1,
    A.dat_buch,
    A.kopf_art_id,
    A.art_id,
    A.gp_id,
    A.menge_lagerbew_bme,
    A.zeile,
    A.accum
FROM `_mseg_snap1` AS A
INNER JOIN `_mseg_row_counter` AS B
    ON
        A.mandant_id = B.mandant_id AND A.art_id = B.art_id AND A.zeitraum_kz = B.zeitraum_kz
        AND A.zeit_1 = B.zeit_1 AND A.zeile <= B.zeile
GROUP BY
    A.mandant_id,
    A.zeitraum_kz,
    A.zeit_1,
    A.dat_buch,
    A.kopf_art_id,
    A.art_id,
    A.gp_id,
    A.menge_lagerbew_bme,
    A.zeile,
    A.accum;


CREATE OR REPLACE TEMPORARY TABLE _positionen_tmp AS
SELECT DISTINCT
    C.mandant_id,
    C.dat_von,
    C.dat_bis,
    C.kopf_art_id,
    C.pos_art_id,
    C.komponentenmenge,
    C.komponentenmenge_einh_id,
    A.zeitraum_kz,
    A.zeit_1,
    A.gp_id,
    A.dat_buch
FROM `_mseg_snap1` AS A
INNER JOIN `_relevante_artikel_2` AS C
    ON
        A.kopf_art_id = C.kopf_art_id AND A.mandant_id = C.mandant_id AND A.dat_buch
        BETWEEN C.dat_von AND C.dat_bis
WHERE (C.mandant_id, A.zeitraum_kz, A.zeit_1, A.art_id, A.dat_buch) IN (SELECT (
    mandant_id, zeitraum_kz, zeit_1, art_id,
    dat_buch
)
FROM `_mseg_snap2`);


CREATE OR REPLACE TEMPORARY TABLE _positionen AS
SELECT DISTINCT
    A.mandant_id,
    A.dat_von,
    A.dat_bis,
    A.kopf_art_id,
    A.pos_art_id,
    A.komponentenmenge,
    A.komponentenmenge_einh_id,
    A.zeitraum_kz,
    A.zeit_1,
    A.gp_id,
    A.dat_buch,
    B.ek_nettonetto,
    B.ek_mep,
    COALESCE(A.komponentenmenge * B.ek_mep, A.komponentenmenge * C.ek_mep) AS gesamt_pos_wert
FROM `_positionen_tmp` AS A
LEFT JOIN dbp_data.art_gp_wup_zu_per_1 AS B
    ON
        A.mandant_id = B.mandant_id AND A.pos_art_id = B.art_id AND
        A.gp_id = B.gp_id AND B.wup_id = -1 AND A.dat_buch BETWEEN B.dat_von AND B.dat_bis
LEFT JOIN dbp_data.art_gp_wup_zu_per_1 AS C
    ON
        A.mandant_id = C.mandant_id AND A.pos_art_id = C.art_id AND
        C.wup_id = -1 AND A.dat_buch BETWEEN C.dat_von AND C.dat_bis
QUALIFY (ROW_NUMBER() OVER (
    PARTITION BY
        A.mandant_id, A.dat_von, A.dat_bis, A.kopf_art_id, A.pos_art_id, A.zeit_1, A.zeitraum_kz,
        A.komponentenmenge, A.dat_buch
    ORDER BY gesamt_pos_wert IS NULL DESC, gesamt_pos_wert DESC
)) = 1;


CREATE OR REPLACE TEMPORARY TABLE _positionen2 AS
SELECT
    A.mandant_id,
    A.dat_von,
    A.dat_bis,
    A.kopf_art_id,
    A.pos_art_id,
    A.komponentenmenge,
    A.komponentenmenge_einh_id,
    A.zeitraum_kz,
    A.zeit_1,
    A.gp_id,
    A.dat_buch,
    A.ek_nettonetto,
    A.ek_mep,
    A.gesamt_pos_wert,
    IFNULL(A.gesamt_pos_wert / IF(b.gesamt_pos_wert_sum = 0, NULL, b.gesamt_pos_wert_sum), 0) AS gesamt_pos_wert_prozent
FROM `_positionen` AS A
INNER JOIN (
    SELECT
        mandant_id,
        kopf_art_id,
        zeitraum_kz,
        zeit_1,
        SUM(gesamt_pos_wert) AS gesamt_pos_wert_sum
    FROM `_positionen`
    GROUP BY
        mandant_id,
        kopf_art_id,
        zeitraum_kz,
        zeit_1
)
    AS b ON A.mandant_id = b.mandant_id AND A.kopf_art_id = b.kopf_art_id AND A.zeitraum_kz = b.zeitraum_kz AND A.zeit_1
= b.zeit_1;


CREATE OR REPLACE TEMPORARY TABLE _mseg_snap3 AS
SELECT
    A.mandant_id,
    A.zeitraum_kz,
    A.zeit_1,
    A.dat_buch,
    A.kopf_art_id,
    A.art_id,
    A.gp_id,
    A.menge_lagerbew_bme,
    A.zeile,
    A.accum,
    CAST(B.ek_nettonetto AS NUMERIC) AS ek_nettonetto,
    CAST(B.ek_mep AS NUMERIC) AS ek_mep,
    CAST(B.ek_mep_vor_fwu AS NUMERIC) AS ek_mep_vor_fwu
FROM `_mseg_snap2` AS A
INNER JOIN dbp_data.art_gp_wup_zu_per_1 AS B
    ON A.mandant_id = B.mandant_id AND CASE
        WHEN A.kopf_art_id = 9999
            THEN A.art_id
        ELSE A.kopf_art_id
    END = B.art_id AND A.gp_id = B.gp_id AND B.wup_id = -1 AND A.dat_buch BETWEEN B.dat_von AND B.dat_bis
WHERE A.mandant_id = 2;


INSERT INTO `_mseg_snap3`
(
    SELECT
        A.mandant_id,
        A.zeitraum_kz,
        A.zeit_1,
        A.dat_buch,
        A.kopf_art_id,
        A.art_id,
        A.gp_id,
        A.menge_lagerbew_bme,
        A.zeile,
        A.accum,
        CAST(B.ek_nettonetto AS NUMERIC) AS ek_nettonetto,
        CAST(B.ek_mep AS NUMERIC) AS ek_mep,
        CAST(B.ek_mep_vor_fwu AS NUMERIC) AS ek_mep_vor_fwu
    FROM `_mseg_snap2` AS A
    INNER JOIN dbp_data.art_gp_wup_zu_per_1 AS B
        ON A.mandant_id = B.mandant_id AND CASE
            WHEN A.kopf_art_id = 9999
                THEN A.art_id
            ELSE A.kopf_art_id
        END = B.art_id AND A.gp_id = B.gp_id AND B.wup_id = -1 AND A.dat_buch BETWEEN B.dat_von AND B.dat_bis
    WHERE A.mandant_id = 3
);


INSERT INTO `_mseg_snap3`
(
    SELECT
        A.mandant_id,
        A.zeitraum_kz,
        A.zeit_1,
        A.dat_buch,
        A.kopf_art_id,
        A.art_id,
        A.gp_id,
        A.menge_lagerbew_bme,
        A.zeile,
        A.accum,
        CAST(B.ek_nettonetto AS NUMERIC) AS ek_nettonetto,
        CAST(B.ek_mep AS NUMERIC) AS ek_mep,
        CAST(B.ek_mep_vor_fwu AS NUMERIC) AS ek_mep_vor_fwu
    FROM `_mseg_snap2` AS A
    INNER JOIN dbp_data.art_gp_wup_zu_per_1 AS B
        ON A.mandant_id = B.mandant_id AND CASE
            WHEN A.kopf_art_id = 9999
                THEN A.art_id
            ELSE A.kopf_art_id
        END = B.art_id AND A.gp_id = B.gp_id AND B.wup_id = -1 AND A.dat_buch BETWEEN B.dat_von AND B.dat_bis
    WHERE A.mandant_id = 4
);


INSERT INTO `_mseg_snap3`
(
    SELECT
        A.mandant_id,
        A.zeitraum_kz,
        A.zeit_1,
        A.dat_buch,
        A.kopf_art_id,
        A.art_id,
        A.gp_id,
        A.menge_lagerbew_bme,
        A.zeile,
        A.accum,
        CAST(B.ek_nettonetto AS NUMERIC) AS ek_nettonetto,
        CAST(B.ek_mep AS NUMERIC) AS ek_mep,
        CAST(B.ek_mep_vor_fwu AS NUMERIC) AS ek_mep_vor_fwu
    FROM `_mseg_snap2` AS A
    INNER JOIN dbp_data.art_gp_wup_zu_per_1 AS B
        ON A.mandant_id = B.mandant_id AND CASE
            WHEN A.kopf_art_id = 9999
                THEN A.art_id
            ELSE A.kopf_art_id
        END = B.art_id AND A.gp_id = B.gp_id AND B.wup_id = -1 AND A.dat_buch BETWEEN B.dat_von AND B.dat_bis
    WHERE A.mandant_id = 5
);


INSERT INTO `_mseg_snap3`
(
    SELECT
        A.mandant_id,
        A.zeitraum_kz,
        A.zeit_1,
        A.dat_buch,
        A.kopf_art_id,
        A.art_id,
        A.gp_id,
        A.menge_lagerbew_bme,
        A.zeile,
        A.accum,
        CAST(B.ek_nettonetto AS NUMERIC) AS ek_nettonetto,
        CAST(B.ek_mep AS NUMERIC) AS ek_mep,
        CAST(B.ek_mep_vor_fwu AS NUMERIC) AS ek_mep_vor_fwu
    FROM `_mseg_snap2` AS A
    INNER JOIN dbp_data.art_gp_wup_zu_per_1 AS B
        ON A.mandant_id = B.mandant_id AND CASE
            WHEN A.kopf_art_id = 9999
                THEN A.art_id
            ELSE A.kopf_art_id
        END = B.art_id AND A.gp_id = B.gp_id AND B.wup_id = -1 AND A.dat_buch BETWEEN B.dat_von AND B.dat_bis
    WHERE A.mandant_id = 6
);


INSERT INTO `_mseg_snap3`
(
    SELECT
        A.mandant_id,
        A.zeitraum_kz,
        A.zeit_1,
        A.dat_buch,
        A.kopf_art_id,
        A.art_id,
        A.gp_id,
        A.menge_lagerbew_bme,
        A.zeile,
        A.accum,
        CAST(B.ek_nettonetto AS NUMERIC) AS ek_nettonetto,
        CAST(B.ek_mep AS NUMERIC) AS ek_mep,
        CAST(B.ek_mep_vor_fwu AS NUMERIC) AS ek_mep_vor_fwu
    FROM `_mseg_snap2` AS A
    INNER JOIN dbp_data.art_gp_wup_zu_per_1 AS B
        ON A.mandant_id = B.mandant_id AND CASE
            WHEN A.kopf_art_id = 9999
                THEN A.art_id
            ELSE A.kopf_art_id
        END = B.art_id AND A.gp_id = B.gp_id AND B.wup_id = -1 AND A.dat_buch BETWEEN B.dat_von AND B.dat_bis
    WHERE A.mandant_id = 7
);


INSERT INTO `_mseg_snap3`
(
    SELECT
        A.mandant_id,
        A.zeitraum_kz,
        A.zeit_1,
        A.dat_buch,
        A.kopf_art_id,
        A.art_id,
        A.gp_id,
        A.menge_lagerbew_bme,
        A.zeile,
        A.accum,
        CAST(B.ek_nettonetto AS NUMERIC) AS ek_nettonetto,
        CAST(B.ek_mep AS NUMERIC) AS ek_mep,
        CAST(B.ek_mep_vor_fwu AS NUMERIC) AS ek_mep_vor_fwu
    FROM `_mseg_snap2` AS A
    INNER JOIN dbp_data.art_gp_wup_zu_per_1 AS B
        ON A.mandant_id = B.mandant_id AND CASE
            WHEN A.kopf_art_id = 9999
                THEN A.art_id
            ELSE A.kopf_art_id
        END = B.art_id AND A.gp_id = B.gp_id AND B.wup_id = -1 AND A.dat_buch BETWEEN B.dat_von AND B.dat_bis
    WHERE A.mandant_id = 8
);


CREATE OR REPLACE TEMPORARY TABLE _mseg_snap4 AS
SELECT DISTINCT
    A.mandant_id,
    A.zeitraum_kz,
    A.zeit_1,
    A.dat_buch,
    A.kopf_art_id,
    A.art_id,
    A.gp_id,
    A.menge_lagerbew_bme,
    A.zeile,
    A.accum,
    A.ek_nettonetto,
    A.ek_mep,
    A.ek_mep_vor_fwu,
    CASE
        WHEN B.menge IS NULL
            THEN A.menge_lagerbew_bme
        ELSE A.menge_lagerbew_bme - (A.accum - B.menge)
    END AS neue_menge,
    A.ek_nettonetto - A.ek_mep AS ek_diff,
    A.ek_nettonetto - A.ek_mep_vor_fwu AS ek_diff_fwu,
    X.min_dat AS dat_von,
    X.max_dat AS dat_bis,
    A.ek_nettonetto - A.ek_mep * COALESCE(
        y.gesamt_pos_wert_prozent, 1) / COALESCE(
        y.komponentenmenge,
        1
    ) AS ek_stueck,
    A.ek_nettonetto - A.ek_mep_vor_fwu * COALESCE(y.gesamt_pos_wert_prozent, 1) /
    COALESCE(y.komponentenmenge, 1) AS ek_stueck_fwu
FROM `_mseg_snap3` AS A
INNER JOIN `_zeitraeume` AS X ON A.mandant_id = X.mandant_id AND A.zeitraum_kz = X.zeitraum_kz AND A.zeit_1 = X.zeit_1
LEFT JOIN (
    SELECT
        mandant_id,
        kopf_art_id,
        pos_art_id,
        zeitraum_kz,
        zeit_1,
        komponentenmenge,
        SUM(gesamt_pos_wert_prozent) AS gesamt_pos_wert_prozent
    FROM `_positionen2`
    GROUP BY
        mandant_id,
        kopf_art_id,
        pos_art_id,
        zeitraum_kz,
        zeit_1,
        komponentenmenge
) AS y
    ON
        A.mandant_id = y.mandant_id AND A.kopf_art_id = y.kopf_art_id AND A.art_id = y.pos_art_id
        AND A.zeitraum_kz = y.zeitraum_kz AND A.zeit_1 = y.zeit_1
LEFT JOIN `_mseg_row_counter`
    AS B ON A.mandant_id = B.mandant_id AND A.art_id = B.art_id AND A.zeitraum_kz = B.zeitraum_kz
AND A.zeit_1 = B.zeit_1 AND A.zeile = B.zeile;


CREATE OR REPLACE TEMPORARY TABLE _mseg_snap5_v1 AS
SELECT
    A.mandant_id,
    A.zeitraum_kz,
    A.zeit_1,
    A.art_id,
    SUM(A.ek_stueck * b.we_menge) AS boni,
    SUM(A.ek_stueck_fwu * b.we_menge) AS boni_fwu
FROM `_mseg_snap4` AS A
INNER JOIN (
    SELECT
        mandant_id,
        zeitraum_kz,
        zeit_1,
        art_id,
        zeile,
        neue_menge AS we_menge
    FROM `_mseg_snap4`
    GROUP BY
        mandant_id,
        zeitraum_kz,
        zeit_1,
        art_id,
        zeile,
        we_menge
) AS b
    ON
        A.mandant_id = b.mandant_id AND A.zeitraum_kz = b.zeitraum_kz AND A.zeit_1 = b.zeit_1 AND A.art_id = b.art_id AND A.zeile = b.zeile
GROUP BY
    A.mandant_id,
    A.zeitraum_kz,
    A.zeit_1,
    A.art_id;


CREATE OR REPLACE TEMPORARY TABLE _hilfe_v1 AS
SELECT
    A.mandant_id,
    b.zeitraum_kz,
    b.zeit_1,
    A.art_id,
    SUM(A.menge) AS menge
FROM dbp_data.artbew_1 AS A
INNER JOIN (
    SELECT
        A0.mandant_id,
        A0.zeitraum_kz,
        A0.zeit_1,
        A0.art_id,
        B.fake_min_dat,
        B.max_dat
    FROM `_mseg_snap5_v1` AS A0
    INNER JOIN `_zeitraeume` AS B ON A0.mandant_id = B.mandant_id AND A0.zeitraum_kz = B.zeitraum_kz AND A0.zeit_1 = B.zeit_1

    GROUP BY
        A0.mandant_id,
        A0.zeitraum_kz,
        A0.zeit_1,
        A0.art_id,
        B.fake_min_dat,
        B.max_dat
) AS b ON A.mandant_id = b.mandant_id AND A.art_id = b.art_id AND A.dat BETWEEN b.fake_min_dat AND b.max_dat

GROUP BY
    A.mandant_id,
    b.zeitraum_kz,
    b.zeit_1,
    A.art_id;


---------- 2. display-verarbeitung ----------


CREATE OR REPLACE TEMPORARY TABLE _relevante_artikel_1 AS
SELECT
    A.mandant_id,
    A.dat_von,
    A.dat_bis,
    A.art_id AS kopf_art_id,
    B.art_id AS pos_art_id,
    B.komponentenmenge,
    B.komponentenmenge_einh_id
FROM dbp_data.stueckliste_1 AS A
INNER JOIN dbp_data.stueckliste_det_1 AS B
    ON
        A.mandant_id = B.mandant_id AND A.stueckliste_id = B.stueckliste_id
        AND B.dat_bis = DATE '9999-12-31'
WHERE (
    A.mandant_id, A.art_id) IN (
    SELECT (mandant_id, art_id)
    FROM dbp_data.art_1
    WHERE
        artikeltyp_id = 12
        AND mandant_id > 1
        AND (
            mandant_id, art_id) NOT IN (
            SELECT (mandant_id, art_id)
            FROM dbp_etl_process.ekc_deny_displays_1
        )
)
AND (
    A.mandant_id, A.art_id) IN (
    SELECT (mandant_id, kopf_art_id)
    FROM `_verarbeitung2`
);


CREATE OR REPLACE TEMPORARY TABLE _mseg_snap0 AS
SELECT
    A.mandant_id,
    A.lagerbew_beleg_id,
    A.lagerbew_beleg_pos_id,
    A.kj,
    A.grund_id,
    A.lager_bewart_id,
    A.art_id,
    A.wup_id,
    A.nb_id,
    A.auto_fg,
    A.lagerort_id,
    A.gp_id,
    A.einkaufsorganisation_id,
    A.soll_haben_kz,
    A.wrg_id,
    A.best_beleg_id,
    A.best_beleg_pos_id,
    A.betrag_lagerbew,
    A.betrag_verkauf,
    A.erfsngs_menge_einh_id,
    A.lagerplatz_id,
    A.kunde_id,
    A.menge_lagerbew_kolli,
    A.menge_lagerbew_bme,
    A.menge_lagerbew_palette,
    A.menge_lieferschein,
    A.menge_lief,
    A.menge_erf,
    A.empfaenger_id,
    A.dat_buch,
    A.lagerbew_beleg_storno_id,
    A.lagerbew_beleg_pos_storno_id,
    A.lagerbew_beleg_storno_kj,
    A.betrag_vk_netto,
    A.system_id,
    A.betrag_belegfluss_wg_art,
    A.mandant_id_kunde,
    A.mandant_id_empfaenger,
    A.bw_vorgang_id,
    A.betrag_verkauf_ist,
    A.betrag_vk_netto_vz,
    A.betrag_verkauf_ist_netto,
    A.betrag_einstandspreis,
    A.gp_id_zl,
    A.bq_findung_id,
    A.lagerbew_beleg_pos_mutter_id,
    A.line_id,
    A.display_art_id,
    A.td_update,
    A.td_insert
FROM dbp_data.lagerbew_det_1 AS A
INNER JOIN (
    SELECT
        mandant_id,
        kopf_art_id
    FROM `_relevante_artikel_1`
    GROUP BY
        mandant_id,
        kopf_art_id
) AS b ON A.mandant_id = b.mandant_id AND A.art_id = b.kopf_art_id
WHERE A.mandant_id > 1;


CREATE OR REPLACE TEMPORARY TABLE _shit AS
SELECT
    A.mandant_id,
    B.zeitraum_kz,
    B.zeit_1,
    A.dat_buch,
    c.dat_von,
    c.dat_bis,
    D.kopf_art_id,
    D.pos_art_id AS art_id,
    A.gp_id,
    A.menge_lagerbew_bme * D.komponentenmenge AS menge_lagerbew_bme_
FROM `_mseg_snap0` AS A
INNER JOIN `_zeitraeume` AS B ON A.mandant_id = B.mandant_id AND A.dat_buch BETWEEN B.mseg_min_dat AND B.max_dat
INNER JOIN (
    SELECT
        mandant_id,
        kopf_art_id,
        dat_von,
        dat_bis
    FROM `_relevante_artikel_1`
    GROUP BY
        mandant_id,
        kopf_art_id,
        dat_von,
        dat_bis
) AS c ON A.mandant_id = c.mandant_id AND A.art_id = c.kopf_art_id AND A.dat_buch BETWEEN c.dat_von AND c.dat_bis

INNER JOIN `_relevante_artikel_1` AS D
    ON
        A.mandant_id = D.mandant_id AND c.kopf_art_id = D.kopf_art_id AND A.dat_buch
        BETWEEN D.dat_von AND D.dat_bis
WHERE
    A.gp_id <> -1
    AND CASE
        WHEN A.mandant_id = 4 AND A.gp_id = 6100 OR A.gp_id >= 10000
            THEN 1
        ELSE 0
    END = 1
    AND A.lager_bewart_id IN ('101', '102', '901', '902', '161', '162')
GROUP BY
    A.mandant_id,
    B.zeitraum_kz,
    B.zeit_1,
    A.dat_buch,
    c.dat_von,
    c.dat_bis,
    D.kopf_art_id,
    art_id,
    A.gp_id,
    menge_lagerbew_bme_;


CREATE OR REPLACE TEMPORARY TABLE _zwischen AS
SELECT *
FROM `_shit` AS A
QUALIFY (ROW_NUMBER() OVER (
    PARTITION BY
        mandant_id, art_id, kopf_art_id, zeitraum_kz, zeit_1 ORDER BY
        dat_buch IS NULL
        DESC, dat_buch DESC
)) = 1;


CREATE OR REPLACE TEMPORARY TABLE _relevante_artikel_2 AS
SELECT
    A.mandant_id,
    A.dat_von,
    A.dat_bis,
    MAX(A.art_id) AS kopf_art_id,
    B.art_id AS pos_art_id,
    B.komponentenmenge,
    B.komponentenmenge_einh_id
FROM dbp_data.stueckliste_1 AS A
INNER JOIN dbp_data.stueckliste_det_1 AS B
    ON
        A.mandant_id = B.mandant_id AND A.stueckliste_id = B.stueckliste_id
        AND B.dat_bis = DATE '9999-12-31'
WHERE (
    A.mandant_id, A.art_id) IN (
    SELECT (mandant_id, art_id)
    FROM dbp_data.art_1
    WHERE
        artikeltyp_id = 12
        AND mandant_id > 1
        AND (
            mandant_id, art_id) NOT IN (
            SELECT (mandant_id, art_id)
            FROM dbp_etl_process.ekc_deny_displays_1
        )
)
AND (
    A.mandant_id, A.art_id) IN (
    SELECT (mandant_id, kopf_art_id)
    FROM `_zwischen`
)
GROUP BY
    A.mandant_id,
    A.dat_von,
    A.dat_bis,
    pos_art_id,
    B.komponentenmenge,
    B.komponentenmenge_einh_id;


CREATE OR REPLACE TEMPORARY TABLE _artbew_snap_kp_0 AS
SELECT
    A.mandant_id,
    B.zeitraum_kz,
    B.zeit_1,
    A.art_id,
    A.gp_id,
    A.dat,
    A.wup_id,
    CASE
        WHEN A.bq_findung_id = 28
            THEN 1
        ELSE 0
    END AS kopf_fg,
    SUM(A.menge) AS menge,
    SUM(A.umsatz_netto) AS umsatz_netto
FROM dbp_data.artbew_1 AS A
INNER JOIN `_zeitraeume` AS B ON A.mandant_id = B.mandant_id AND A.dat BETWEEN B.fake_min_dat AND B.max_dat
GROUP BY
    A.mandant_id,
    B.zeitraum_kz,
    B.zeit_1,
    A.art_id,
    A.gp_id,
    A.dat,
    A.wup_id,
    kopf_fg;


CREATE OR REPLACE TEMPORARY TABLE _artbew_snap_kp AS
SELECT DISTINCT
    A.mandant_id,
    A.zeitraum_kz,
    A.zeit_1,
    A.art_id,
    A.gp_id,
    A.dat,
    A.wup_id,
    A.kopf_fg,
    A.menge,
    A.umsatz_netto
FROM `_artbew_snap_kp_0` AS A
INNER JOIN (
    SELECT
        mandant_id,
        pos_art_id
    FROM `_relevante_artikel_2`
    GROUP BY
        mandant_id,
        pos_art_id
) AS c ON A.mandant_id = c.mandant_id AND A.art_id = c.pos_art_id;


CREATE OR REPLACE TEMPORARY TABLE _artbew_snap AS
SELECT
    mandant_id,
    zeitraum_kz,
    zeit_1,
    art_id,
    gp_id,
    wup_id,
    SUM(menge) AS menge,
    SUM(umsatz_netto) AS umsatz_netto
FROM `_artbew_snap_kp`
GROUP BY
    mandant_id,
    zeitraum_kz,
    zeit_1,
    art_id,
    gp_id,
    wup_id;


CREATE OR REPLACE TEMPORARY TABLE _mseg_snap0 AS
SELECT
    A.mandant_id,
    A.lagerbew_beleg_id,
    A.lagerbew_beleg_pos_id,
    A.kj,
    A.grund_id,
    A.lager_bewart_id,
    A.art_id,
    A.wup_id,
    A.nb_id,
    A.auto_fg,
    A.lagerort_id,
    A.gp_id,
    A.einkaufsorganisation_id,
    A.soll_haben_kz,
    A.wrg_id,
    A.best_beleg_id,
    A.best_beleg_pos_id,
    A.betrag_lagerbew,
    A.betrag_verkauf,
    A.erfsngs_menge_einh_id,
    A.lagerplatz_id,
    A.kunde_id,
    A.menge_lagerbew_kolli,
    A.menge_lagerbew_bme,
    A.menge_lagerbew_palette,
    A.menge_lieferschein,
    A.menge_lief,
    A.menge_erf,
    A.empfaenger_id,
    A.dat_buch,
    A.lagerbew_beleg_storno_id,
    A.lagerbew_beleg_pos_storno_id,
    A.lagerbew_beleg_storno_kj,
    A.betrag_vk_netto,
    A.system_id,
    A.betrag_belegfluss_wg_art,
    A.mandant_id_kunde,
    A.mandant_id_empfaenger,
    A.bw_vorgang_id,
    A.betrag_verkauf_ist,
    A.betrag_vk_netto_vz,
    A.betrag_verkauf_ist_netto,
    A.betrag_einstandspreis,
    A.gp_id_zl,
    A.bq_findung_id,
    A.lagerbew_beleg_pos_mutter_id,
    A.line_id,
    A.display_art_id,
    A.td_update,
    A.td_insert
FROM dbp_data.lagerbew_det_1 AS A
INNER JOIN (
    SELECT
        mandant_id,
        kopf_art_id
    FROM `_relevante_artikel_2`
    GROUP BY
        mandant_id,
        kopf_art_id
) AS b ON A.mandant_id = b.mandant_id AND A.art_id = b.kopf_art_id
WHERE A.mandant_id > 1;


CREATE OR REPLACE TEMPORARY TABLE _mseg_snap1 AS
SELECT
    mandant_id,
    zeitraum_kz,
    zeit_1,
    dat_buch,
    kopf_art_id,
    art_id,
    gp_id,
    menge_lagerbew_bme_ AS menge_lagerbew_bme,
    zeile,
    SUM(menge_lagerbew_bme_) OVER (
        PARTITION BY mandant_id, art_id, zeitraum_kz, zeit_1 ORDER BY zeile IS NULL, zeile
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS accum
FROM (SELECT
    mandant_id,
    zeitraum_kz,
    zeit_1,
    dat_buch,
    kopf_art_id,
    art_id,
    gp_id,
    kopf_fg,
    lagerbew_beleg_id,
    menge_lagerbew_bme_,
    ROW_NUMBER() OVER (
        PARTITION BY
            mandant_id, art_id, zeitraum_kz, zeit_1 ORDER BY
            dat_buch IS NULL DESC, dat_buch DESC,
            kopf_fg IS NULL, kopf_fg, lagerbew_beleg_id IS NULL, lagerbew_beleg_id, gp_id IS NULL DESC, gp_id DESC,
            menge_lagerbew_bme_ IS NULL DESC, menge_lagerbew_bme_ DESC
    ) AS zeile
FROM (
    SELECT
        mandant_id,
        zeitraum_kz,
        zeit_1,
        dat_buch,
        kopf_art_id,
        art_id,
        gp_id,
        kopf_fg,
        lagerbew_beleg_id,
        SUM(menge_lagerbew_bme) AS menge_lagerbew_bme_
    FROM (
        SELECT
            A.mandant_id,
            B.zeitraum_kz,
            B.zeit_1,
            A.dat_buch,
            D.kopf_art_id,
            A.lagerbew_beleg_id,
            A.art_id,
            A.gp_id,
            A.menge_lagerbew_bme,
            1 AS kopf_fg
        FROM dbp_data.lagerbew_det_1 AS A
        INNER JOIN `_zeitraeume` AS B ON A.mandant_id = B.mandant_id AND A.dat_buch BETWEEN B.mseg_min_dat AND B.max_dat

        INNER JOIN (
            SELECT
                mandant_id,
                kopf_art_id,
                dat_von,
                dat_bis
            FROM `_relevante_artikel_2`
            GROUP BY
                mandant_id,
                dat_von,
                dat_bis,
                kopf_art_id
        ) AS t0
            ON
                A.mandant_id = t0.mandant_id AND A.art_id = t0.kopf_art_id AND A.dat_buch BETWEEN t0.dat_von
                AND t0.dat_bis
        INNER JOIN `_relevante_artikel_2` AS D ON A.mandant_id = D.mandant_id AND t0.kopf_art_id = D.kopf_art_id
        WHERE (
            A.mandant_id, A.art_id, B.zeitraum_kz, B.zeit_1) IN (
            SELECT (mandant_id, art_id, zeitraum_kz, zeit_1)
            FROM `_artbew_snap`
        )
        AND A.gp_id <> -1
        AND CASE
            WHEN A.mandant_id = 4 AND A.gp_id = 6100 OR A.gp_id >= 10000
                THEN 1
            ELSE 0
        END = 1
        AND A.lager_bewart_id IN ('101', '102', '901', '902', '161', '162')
        AND A.menge_lagerbew_bme > 0
        UNION ALL
        SELECT
            A.mandant_id,
            B.zeitraum_kz,
            B.zeit_1,
            A.dat_buch,
            D.kopf_art_id,
            A.lagerbew_beleg_id,
            D.pos_art_id AS art_id,
            A.gp_id,
            A.menge_lagerbew_bme * D.komponentenmenge AS menge_lagerbew_bme,
            1 AS kopf_fg
        FROM `_mseg_snap0` AS A
        INNER JOIN `_zeitraeume` AS B ON A.mandant_id = B.mandant_id AND A.dat_buch BETWEEN B.mseg_min_dat AND B.max_dat

        INNER JOIN (
            SELECT
                mandant_id,
                kopf_art_id,
                dat_von,
                dat_bis
            FROM `_relevante_artikel_2`
            GROUP BY
                mandant_id,
                dat_von,
                dat_bis,
                kopf_art_id
        ) AS t5
            ON
                A.mandant_id = t5.mandant_id AND A.art_id = t5.kopf_art_id AND A.dat_buch BETWEEN t5.dat_von
                AND t5.dat_bis
        INNER JOIN `_relevante_artikel_2` AS D
            ON
                A.mandant_id = D.mandant_id AND t5.kopf_art_id = D.kopf_art_id AND A.dat_buch
                BETWEEN D.dat_von AND D.dat_bis
        WHERE
            A.gp_id <> -1
            AND CASE
                WHEN A.mandant_id = 4 AND A.gp_id = 6100 OR A.gp_id >= 10000
                    THEN 1
                ELSE 0
            END = 1
            AND A.lager_bewart_id IN ('101', '102', '901', '902', '161', '162')
            AND A.menge_lagerbew_bme > 0
        UNION ALL
        SELECT
            A.mandant_id,
            B.zeitraum_kz,
            B.zeit_1,
            A.dat_buch,
            9999 AS kopf_art_id,
            A.lagerbew_beleg_id,
            A.art_id,
            A.gp_id,
            A.menge_lagerbew_bme,
            0 AS kopf_fg
        FROM dbp_data.lagerbew_det_1 AS A
        INNER JOIN `_zeitraeume` AS B ON A.mandant_id = B.mandant_id AND A.dat_buch BETWEEN B.mseg_min_dat AND B.max_dat

        WHERE (
            A.mandant_id, A.art_id, B.zeitraum_kz, B.zeit_1) IN (
            SELECT (mandant_id, art_id, zeitraum_kz, zeit_1)
            FROM `_artbew_snap`
        )
        AND A.gp_id <> -1
        AND CASE
            WHEN A.mandant_id = 4 AND A.gp_id = 6100 OR A.gp_id >= 10000
                THEN 1
            ELSE 0
        END = 1
        AND A.lager_bewart_id IN ('101', '102', '901', '902', '161', '162')
        AND A.menge_lagerbew_bme > 0
    ) AS x
    GROUP BY
        mandant_id,
        zeitraum_kz,
        zeit_1,
        dat_buch,
        kopf_art_id,
        lagerbew_beleg_id,
        art_id,
        gp_id,
        kopf_fg
) AS t13) AS xxx_1;


CREATE OR REPLACE TEMPORARY TABLE _mseg_row_counter AS
SELECT
    X.mandant_id,
    X.zeitraum_kz,
    X.zeit_1,
    MAX(X.kopf_art_id) AS kopf_art_id,
    X.art_id,
    MIN(X.gp_id) AS gp_id,
    MIN(X.zeile) AS zeile,
    MAX(b.menge) AS menge
FROM `_mseg_snap1` AS X
INNER JOIN (
    SELECT
        mandant_id,
        zeitraum_kz,
        zeit_1,
        art_id,
        SUM(menge) AS menge
    FROM `_artbew_snap`
    WHERE gp_id <> -1
    GROUP BY
        mandant_id,
        zeitraum_kz,
        zeit_1,
        art_id
) AS b
    ON
        X.mandant_id = b.mandant_id AND X.art_id = b.art_id AND X.zeitraum_kz = b.zeitraum_kz AND X.zeit_1 = b.zeit_1
WHERE X.accum - b.menge >= 0
GROUP BY
    X.mandant_id,
    X.zeitraum_kz,
    X.zeit_1,
    X.art_id;


CREATE OR REPLACE TEMPORARY TABLE _mseg_snap2 AS
SELECT
    A.mandant_id,
    A.zeitraum_kz,
    A.zeit_1,
    A.dat_buch,
    A.kopf_art_id,
    A.art_id,
    A.gp_id,
    A.menge_lagerbew_bme,
    A.zeile,
    A.accum
FROM `_mseg_snap1` AS A
INNER JOIN `_mseg_row_counter` AS B
    ON
        A.mandant_id = B.mandant_id AND A.art_id = B.art_id AND A.zeitraum_kz = B.zeitraum_kz
        AND A.zeit_1 = B.zeit_1 AND A.zeile <= B.zeile
GROUP BY
    A.mandant_id,
    A.zeitraum_kz,
    A.zeit_1,
    A.dat_buch,
    A.kopf_art_id,
    A.art_id,
    A.gp_id,
    A.menge_lagerbew_bme,
    A.zeile,
    A.accum;


CREATE OR REPLACE TEMPORARY TABLE _positionen_tmp AS
SELECT DISTINCT
    C.mandant_id,
    C.dat_von,
    C.dat_bis,
    C.kopf_art_id,
    C.pos_art_id,
    C.komponentenmenge,
    C.komponentenmenge_einh_id,
    A.zeitraum_kz,
    A.zeit_1,
    A.gp_id,
    A.dat_buch
FROM `_mseg_snap1` AS A
INNER JOIN `_relevante_artikel_2` AS C
    ON
        A.kopf_art_id = C.kopf_art_id AND A.mandant_id = C.mandant_id AND A.dat_buch
        BETWEEN C.dat_von AND C.dat_bis
WHERE (C.mandant_id, A.zeitraum_kz, A.zeit_1, A.art_id, A.dat_buch) IN (SELECT (
    mandant_id, zeitraum_kz, zeit_1, art_id,
    dat_buch
)
FROM `_mseg_snap2`);


CREATE OR REPLACE TEMPORARY TABLE _positionen AS
SELECT DISTINCT
    A.mandant_id,
    A.dat_von,
    A.dat_bis,
    A.kopf_art_id,
    A.pos_art_id,
    A.komponentenmenge,
    A.komponentenmenge_einh_id,
    A.zeitraum_kz,
    A.zeit_1,
    A.gp_id,
    A.dat_buch,
    B.ek_nettonetto,
    B.ek_mep,
    COALESCE(A.komponentenmenge * B.ek_mep, A.komponentenmenge * C.ek_mep) AS gesamt_pos_wert
FROM `_positionen_tmp` AS A
LEFT JOIN dbp_data.art_gp_wup_zu_per_1 AS B
    ON
        A.mandant_id = B.mandant_id AND A.pos_art_id = B.art_id AND
        A.gp_id = B.gp_id AND B.wup_id = -1 AND A.dat_buch BETWEEN B.dat_von AND B.dat_bis
LEFT JOIN dbp_data.art_gp_wup_zu_per_1 AS C
    ON
        A.mandant_id = C.mandant_id AND A.pos_art_id = C.art_id AND
        C.wup_id = -1 AND A.dat_buch BETWEEN C.dat_von AND C.dat_bis
QUALIFY (ROW_NUMBER() OVER (
    PARTITION BY
        A.mandant_id, A.dat_von, A.dat_bis, A.kopf_art_id, A.pos_art_id, A.zeit_1, A.zeitraum_kz,
        A.komponentenmenge, A.dat_buch
    ORDER BY gesamt_pos_wert IS NULL DESC, gesamt_pos_wert DESC
)) = 1;


CREATE OR REPLACE TEMPORARY TABLE _positionen2 AS
SELECT
    A.mandant_id,
    A.dat_von,
    A.dat_bis,
    A.kopf_art_id,
    A.pos_art_id,
    A.komponentenmenge,
    A.komponentenmenge_einh_id,
    A.zeitraum_kz,
    A.zeit_1,
    A.gp_id,
    A.dat_buch,
    A.ek_nettonetto,
    A.ek_mep,
    A.gesamt_pos_wert,
    A.gesamt_pos_wert / b.gesamt_pos_wert_sum AS gesamt_pos_wert_prozent
FROM `_positionen` AS A
INNER JOIN (
    SELECT
        mandant_id,
        kopf_art_id,
        zeitraum_kz,
        zeit_1,
        SUM(gesamt_pos_wert) AS gesamt_pos_wert_sum
    FROM `_positionen`
    GROUP BY
        mandant_id,
        kopf_art_id,
        zeitraum_kz,
        zeit_1
)
    AS b ON A.mandant_id = b.mandant_id AND A.kopf_art_id = b.kopf_art_id AND A.zeitraum_kz = b.zeitraum_kz AND A.zeit_1
= b.zeit_1;


CREATE OR REPLACE TEMPORARY TABLE _mseg_snap3 AS
SELECT
    A.mandant_id,
    A.zeitraum_kz,
    A.zeit_1,
    A.dat_buch,
    A.kopf_art_id,
    A.art_id,
    A.gp_id,
    A.menge_lagerbew_bme,
    A.zeile,
    A.accum,
    CAST(B.ek_nettonetto AS NUMERIC) AS ek_nettonetto,
    CAST(B.ek_mep AS NUMERIC) AS ek_mep,
    CAST(B.ek_mep_vor_fwu AS NUMERIC) AS ek_mep_vor_fwu
FROM `_mseg_snap2` AS A
INNER JOIN dbp_data.art_gp_wup_zu_per_1 AS B
    ON A.mandant_id = B.mandant_id AND CASE
        WHEN A.kopf_art_id = 9999
            THEN A.art_id
        ELSE A.kopf_art_id
    END = B.art_id AND A.gp_id = B.gp_id AND B.wup_id = -1 AND A.dat_buch BETWEEN B.dat_von AND B.dat_bis
WHERE A.mandant_id = 2;


INSERT INTO `_mseg_snap3`
(
    SELECT
        A.mandant_id,
        A.zeitraum_kz,
        A.zeit_1,
        A.dat_buch,
        A.kopf_art_id,
        A.art_id,
        A.gp_id,
        A.menge_lagerbew_bme,
        A.zeile,
        A.accum,
        CAST(B.ek_nettonetto AS NUMERIC) AS ek_nettonetto,
        CAST(B.ek_mep AS NUMERIC) AS ek_mep,
        CAST(B.ek_mep_vor_fwu AS NUMERIC) AS ek_mep_vor_fwu
    FROM `_mseg_snap2` AS A
    INNER JOIN dbp_data.art_gp_wup_zu_per_1 AS B
        ON A.mandant_id = B.mandant_id AND CASE
            WHEN A.kopf_art_id = 9999
                THEN A.art_id
            ELSE A.kopf_art_id
        END = B.art_id AND A.gp_id = B.gp_id AND B.wup_id = -1 AND A.dat_buch BETWEEN B.dat_von AND B.dat_bis
    WHERE A.mandant_id = 3
);


INSERT INTO `_mseg_snap3`
(
    SELECT
        A.mandant_id,
        A.zeitraum_kz,
        A.zeit_1,
        A.dat_buch,
        A.kopf_art_id,
        A.art_id,
        A.gp_id,
        A.menge_lagerbew_bme,
        A.zeile,
        A.accum,
        CAST(B.ek_nettonetto AS NUMERIC) AS ek_nettonetto,
        CAST(B.ek_mep AS NUMERIC) AS ek_mep,
        CAST(B.ek_mep_vor_fwu AS NUMERIC) AS ek_mep_vor_fwu
    FROM `_mseg_snap2` AS A
    INNER JOIN dbp_data.art_gp_wup_zu_per_1 AS B
        ON A.mandant_id = B.mandant_id AND CASE
            WHEN A.kopf_art_id = 9999
                THEN A.art_id
            ELSE A.kopf_art_id
        END = B.art_id AND A.gp_id = B.gp_id AND B.wup_id = -1 AND A.dat_buch BETWEEN B.dat_von AND B.dat_bis
    WHERE A.mandant_id = 4
);


INSERT INTO `_mseg_snap3`
(
    SELECT
        A.mandant_id,
        A.zeitraum_kz,
        A.zeit_1,
        A.dat_buch,
        A.kopf_art_id,
        A.art_id,
        A.gp_id,
        A.menge_lagerbew_bme,
        A.zeile,
        A.accum,
        CAST(B.ek_nettonetto AS NUMERIC) AS ek_nettonetto,
        CAST(B.ek_mep AS NUMERIC) AS ek_mep,
        CAST(B.ek_mep_vor_fwu AS NUMERIC) AS ek_mep_vor_fwu
    FROM `_mseg_snap2` AS A
    INNER JOIN dbp_data.art_gp_wup_zu_per_1 AS B
        ON A.mandant_id = B.mandant_id AND CASE
            WHEN A.kopf_art_id = 9999
                THEN A.art_id
            ELSE A.kopf_art_id
        END = B.art_id AND A.gp_id = B.gp_id AND B.wup_id = -1 AND A.dat_buch BETWEEN B.dat_von AND B.dat_bis
    WHERE A.mandant_id = 5
);


INSERT INTO `_mseg_snap3`
(
    SELECT
        A.mandant_id,
        A.zeitraum_kz,
        A.zeit_1,
        A.dat_buch,
        A.kopf_art_id,
        A.art_id,
        A.gp_id,
        A.menge_lagerbew_bme,
        A.zeile,
        A.accum,
        CAST(B.ek_nettonetto AS NUMERIC) AS ek_nettonetto,
        CAST(B.ek_mep AS NUMERIC) AS ek_mep,
        CAST(B.ek_mep_vor_fwu AS NUMERIC) AS ek_mep_vor_fwu
    FROM `_mseg_snap2` AS A
    INNER JOIN dbp_data.art_gp_wup_zu_per_1 AS B
        ON A.mandant_id = B.mandant_id AND CASE
            WHEN A.kopf_art_id = 9999
                THEN A.art_id
            ELSE A.kopf_art_id
        END = B.art_id AND A.gp_id = B.gp_id AND B.wup_id = -1 AND A.dat_buch BETWEEN B.dat_von AND B.dat_bis
    WHERE A.mandant_id = 6
);


INSERT INTO `_mseg_snap3`
(
    SELECT
        A.mandant_id,
        A.zeitraum_kz,
        A.zeit_1,
        A.dat_buch,
        A.kopf_art_id,
        A.art_id,
        A.gp_id,
        A.menge_lagerbew_bme,
        A.zeile,
        A.accum,
        CAST(B.ek_nettonetto AS NUMERIC) AS ek_nettonetto,
        CAST(B.ek_mep AS NUMERIC) AS ek_mep,
        CAST(B.ek_mep_vor_fwu AS NUMERIC) AS ek_mep_vor_fwu
    FROM `_mseg_snap2` AS A
    INNER JOIN dbp_data.art_gp_wup_zu_per_1 AS B
        ON A.mandant_id = B.mandant_id AND CASE
            WHEN A.kopf_art_id = 9999
                THEN A.art_id
            ELSE A.kopf_art_id
        END = B.art_id AND A.gp_id = B.gp_id AND B.wup_id = -1 AND A.dat_buch BETWEEN B.dat_von AND B.dat_bis
    WHERE A.mandant_id = 7
);


INSERT INTO `_mseg_snap3`
(
    SELECT
        A.mandant_id,
        A.zeitraum_kz,
        A.zeit_1,
        A.dat_buch,
        A.kopf_art_id,
        A.art_id,
        A.gp_id,
        A.menge_lagerbew_bme,
        A.zeile,
        A.accum,
        CAST(B.ek_nettonetto AS NUMERIC) AS ek_nettonetto,
        CAST(B.ek_mep AS NUMERIC) AS ek_mep,
        CAST(B.ek_mep_vor_fwu AS NUMERIC) AS ek_mep_vor_fwu
    FROM `_mseg_snap2` AS A
    INNER JOIN dbp_data.art_gp_wup_zu_per_1 AS B
        ON A.mandant_id = B.mandant_id AND CASE
            WHEN A.kopf_art_id = 9999
                THEN A.art_id
            ELSE A.kopf_art_id
        END = B.art_id AND A.gp_id = B.gp_id AND B.wup_id = -1 AND A.dat_buch BETWEEN B.dat_von AND B.dat_bis
    WHERE A.mandant_id = 8
);


CREATE OR REPLACE TEMPORARY TABLE _mseg_snap4 AS
SELECT DISTINCT
    A.mandant_id,
    A.zeitraum_kz,
    A.zeit_1,
    A.dat_buch,
    A.kopf_art_id,
    A.art_id,
    A.gp_id,
    A.menge_lagerbew_bme,
    A.zeile,
    A.accum,
    A.ek_nettonetto,
    A.ek_mep,
    A.ek_mep_vor_fwu,
    CASE
        WHEN B.menge IS NULL
            THEN A.menge_lagerbew_bme
        ELSE A.menge_lagerbew_bme - (A.accum - B.menge)
    END AS neue_menge,
    A.ek_nettonetto - A.ek_mep AS ek_diff,
    A.ek_nettonetto - A.ek_mep_vor_fwu AS ek_diff_fwu,
    X.min_dat AS dat_von,
    X.max_dat AS dat_bis,
    A.ek_nettonetto - A.ek_mep * COALESCE(
        y.gesamt_pos_wert_prozent, 1) / COALESCE(
        y.komponentenmenge,
        1
    ) AS ek_stueck,
    A.ek_nettonetto - A.ek_mep_vor_fwu * COALESCE(y.gesamt_pos_wert_prozent, 1) /
    COALESCE(y.komponentenmenge, 1) AS ek_stueck_fwu
FROM `_mseg_snap3` AS A
INNER JOIN `_zeitraeume` AS X ON A.mandant_id = X.mandant_id AND A.zeitraum_kz = X.zeitraum_kz AND A.zeit_1 = X.zeit_1
LEFT JOIN (
    SELECT
        mandant_id,
        kopf_art_id,
        pos_art_id,
        zeitraum_kz,
        zeit_1,
        komponentenmenge,
        SUM(gesamt_pos_wert_prozent) AS gesamt_pos_wert_prozent
    FROM `_positionen2`
    GROUP BY
        mandant_id,
        kopf_art_id,
        pos_art_id,
        zeitraum_kz,
        zeit_1,
        komponentenmenge
) AS y
    ON
        A.mandant_id = y.mandant_id AND A.kopf_art_id = y.kopf_art_id AND A.art_id = y.pos_art_id
        AND A.zeitraum_kz = y.zeitraum_kz AND A.zeit_1 = y.zeit_1
LEFT JOIN `_mseg_row_counter`
    AS B ON A.mandant_id = B.mandant_id AND A.art_id = B.art_id AND A.zeitraum_kz = B.zeitraum_kz
AND A.zeit_1 = B.zeit_1 AND A.zeile = B.zeile;


CREATE OR REPLACE TEMPORARY TABLE _mseg_snap5_v2 AS
SELECT
    A.mandant_id,
    A.zeitraum_kz,
    A.zeit_1,
    A.art_id,
    SUM(A.ek_stueck * b.we_menge) AS boni,
    SUM(A.ek_stueck_fwu * b.we_menge) AS boni_fwu
FROM `_mseg_snap4` AS A
INNER JOIN (
    SELECT
        mandant_id,
        zeitraum_kz,
        zeit_1,
        art_id,
        zeile,
        neue_menge AS we_menge
    FROM `_mseg_snap4`
    GROUP BY
        mandant_id,
        zeitraum_kz,
        zeit_1,
        art_id,
        zeile,
        we_menge
) AS b
    ON
        A.mandant_id = b.mandant_id AND A.zeitraum_kz = b.zeitraum_kz AND A.zeit_1 = b.zeit_1 AND A.art_id = b.art_id AND A.zeile = b.zeile
GROUP BY
    A.mandant_id,
    A.zeitraum_kz,
    A.zeit_1,
    A.art_id;


CREATE OR REPLACE TEMPORARY TABLE _hilfe_v2 AS
SELECT
    A.mandant_id,
    b.zeitraum_kz,
    b.zeit_1,
    A.art_id,
    SUM(A.menge) AS menge
FROM dbp_data.artbew_1 AS A
INNER JOIN (
    SELECT
        A0.mandant_id,
        A0.zeitraum_kz,
        A0.zeit_1,
        A0.art_id,
        B.fake_min_dat,
        B.max_dat
    FROM `_mseg_snap5_v2` AS A0
    INNER JOIN `_zeitraeume` AS B ON A0.mandant_id = B.mandant_id AND A0.zeitraum_kz = B.zeitraum_kz AND A0.zeit_1 = B.zeit_1

    GROUP BY
        A0.mandant_id,
        A0.zeitraum_kz,
        A0.zeit_1,
        A0.art_id,
        B.fake_min_dat,
        B.max_dat
) AS b ON A.mandant_id = b.mandant_id AND A.art_id = b.art_id AND A.dat BETWEEN b.fake_min_dat AND b.max_dat

GROUP BY
    A.mandant_id,
    b.zeitraum_kz,
    b.zeit_1,
    A.art_id;


DELETE FROM `_testit`
WHERE (mandant_id, art_id, zeitraum_kz, dat_von, dat_bis) IN (SELECT
    (mandant_id, art_id, zeitraum_kz, dat_von, dat_bis
    )
FROM (((
    SELECT
        A.mandant_id,
        A.art_id,
        A.zeitraum_kz,
        B.min_dat AS dat_von,
        B.max_dat AS dat_bis
    FROM `_mseg_snap5_v1` AS A
    INNER JOIN `_zeitraeume` AS B ON A.mandant_id = B.mandant_id AND A.zeitraum_kz = B.zeitraum_kz AND A.zeit_1 = B.zeit_1

    UNION DISTINCT
    SELECT
        A.mandant_id,
        A.art_id,
        'WW' AS zeitraum_kz,
        B.min_dat AS dat_von,
        B.max_dat AS dat_bis
    FROM `_mseg_snap5_v1` AS A
    INNER JOIN `_zeitraeume` AS B ON A.mandant_id = B.mandant_id AND A.zeitraum_kz = B.zeitraum_kz AND A.zeit_1 = B.zeit_1

    WHERE
        B.zeitraum_kz = 'KW'
        AND B.mandant_id = 8
)
UNION DISTINCT
SELECT
    A.mandant_id,
    A.art_id,
    A.zeitraum_kz,
    B.min_dat AS dat_von,
    B.max_dat AS dat_bis
FROM `_mseg_snap5_v2` AS A
INNER JOIN `_zeitraeume` AS B ON A.mandant_id = B.mandant_id AND A.zeitraum_kz = B.zeitraum_kz AND A.zeit_1 = B.zeit_1
)
UNION DISTINCT
SELECT
    A.mandant_id,
    A.art_id,
    'WW' AS zeitraum_kz,
    B.min_dat AS dat_von,
    B.max_dat AS dat_bis
FROM `_mseg_snap5_v2` AS A
INNER JOIN `_zeitraeume` AS B ON A.mandant_id = B.mandant_id AND A.zeitraum_kz = B.zeitraum_kz AND A.zeit_1 = B.zeit_1

    WHERE
        B.zeitraum_kz = 'KW'
        AND B.mandant_id = 8
) AS t5);


INSERT INTO `_testit` (
    mandant_id, art_id, zeitraum_kz, dat_von, dat_bis, betrag_kmep, menge_artbew_sum,
    betrag_kmep_einh, betrag_kmep_einh_o_fwu
)
(
    SELECT *
    FROM (
        SELECT
            A.mandant_id,
            A.art_id,
            A.zeitraum_kz,
            B.min_dat AS dat_von,
            B.max_dat AS dat_bis,
            ROUND(CAST(COALESCE(A.boni, 0) AS NUMERIC), 4) AS betrag_kmep,
            COALESCE(c.menge, 0) AS menge_artbew_sum,
            ROUND(CAST(IFNULL(COALESCE(A.boni, 0) / IF(c.menge = 0, NULL, c.menge), 0) AS NUMERIC), 4) AS betrag_kmep_einh,
            ROUND(CAST(IFNULL(COALESCE(A.boni_fwu, 0) / IF(c.menge = 0, NULL, c.menge), 0) AS NUMERIC), 4)
                AS
                betrag_kmep_einh_fwu
        FROM `_mseg_snap5_v1` AS A
        INNER JOIN `_zeitraeume` AS B ON A.mandant_id = B.mandant_id AND A.zeitraum_kz = B.zeitraum_kz AND A.zeit_1 = B.zeit_1
        LEFT JOIN `_hilfe_v1` AS c
            ON
                A.mandant_id = c.mandant_id AND A.art_id = c.art_id AND A.zeitraum_kz = c.zeitraum_kz
                AND A.zeit_1 = c.zeit_1
        UNION DISTINCT
        SELECT
            A.mandant_id,
            A.art_id,
            'WW' AS zeitraum_kz,
            B.min_dat AS dat_von,
            B.max_dat AS dat_bis,
            ROUND(CAST(COALESCE(A.boni, 0) AS NUMERIC), 4) AS betrag_kmep,
            COALESCE(c.menge, 0) AS menge_artbew_sum,
            ROUND(CAST(IFNULL(COALESCE(A.boni, 0) / IF(c.menge = 0, NULL, c.menge), 0) AS NUMERIC), 4) AS betrag_kmep_einh,
            ROUND(CAST(IFNULL(COALESCE(A.boni_fwu, 0) / IF(c.menge = 0, NULL, c.menge), 0) AS NUMERIC), 4)
                AS
                betrag_kmep_einh_fwu
        FROM `_mseg_snap5_v1` AS A
        INNER JOIN `_zeitraeume` AS B ON A.mandant_id = B.mandant_id AND A.zeitraum_kz = B.zeitraum_kz AND A.zeit_1 = B.zeit_1
        LEFT JOIN `_hilfe_v1` AS c
            ON
                A.mandant_id = c.mandant_id AND A.art_id = c.art_id AND A.zeitraum_kz = c.zeitraum_kz
                AND A.zeit_1 = c.zeit_1
        WHERE
            B.zeitraum_kz = 'KW'
            AND B.mandant_id = 8
    ) AS t2
);


INSERT INTO `_testit` (
    mandant_id, art_id, zeitraum_kz, dat_von, dat_bis, betrag_kmep, menge_artbew_sum,
    betrag_kmep_einh, betrag_kmep_einh_o_fwu
)
(
    SELECT *
    FROM (
        SELECT
            A.mandant_id,
            A.art_id,
            A.zeitraum_kz,
            B.min_dat AS dat_von,
            B.max_dat AS dat_bis,
            ROUND(CAST(COALESCE(A.boni, 0) AS NUMERIC), 4) AS betrag_kmep,
            COALESCE(c.menge, 0) AS menge_artbew_sum,
            ROUND(CAST(IFNULL(COALESCE(A.boni, 0) / IF(c.menge = 0, NULL, c.menge), 0) AS NUMERIC), 4) AS betrag_kmep_einh,
            ROUND(CAST(IFNULL(COALESCE(A.boni_fwu, 0) / IF(c.menge = 0, NULL, c.menge), 0) AS NUMERIC), 4)
                AS
                betrag_kmep_einh_fwu
        FROM `_mseg_snap5_v2` AS A
        INNER JOIN `_zeitraeume` AS B ON A.mandant_id = B.mandant_id AND A.zeitraum_kz = B.zeitraum_kz AND A.zeit_1 = B.zeit_1
        LEFT JOIN `_hilfe_v2` AS c
            ON
                A.mandant_id = c.mandant_id AND A.art_id = c.art_id AND A.zeitraum_kz = c.zeitraum_kz
                AND A.zeit_1 = c.zeit_1
        WHERE (
            A.mandant_id, A.art_id, A.zeitraum_kz, A.zeit_1) NOT IN (
            SELECT (mandant_id, art_id, zeitraum_kz, zeit_1)
            FROM `_mseg_snap5_v1`
        )
        UNION DISTINCT
        SELECT
            A.mandant_id,
            A.art_id,
            'WW' AS zeitraum_kz,
            B.min_dat AS dat_von,
            B.max_dat AS dat_bis,
            ROUND(CAST(COALESCE(A.boni, 0) AS NUMERIC), 4) AS betrag_kmep,
            COALESCE(c.menge, 0) AS menge_artbew_sum,
            ROUND(CAST(IFNULL(COALESCE(A.boni, 0) / IF(c.menge = 0, NULL, c.menge), 0) AS NUMERIC), 4) AS betrag_kmep_einh,
            ROUND(CAST(IFNULL(COALESCE(A.boni_fwu, 0) / IF(c.menge = 0, NULL, c.menge), 0) AS NUMERIC), 4)
                AS
                betrag_kmep_einh_fwu
        FROM `_mseg_snap5_v2` AS A
        INNER JOIN `_zeitraeume` AS B ON A.mandant_id = B.mandant_id AND A.zeitraum_kz = B.zeitraum_kz AND A.zeit_1 = B.zeit_1
        LEFT JOIN `_hilfe_v2` AS c
            ON
                A.mandant_id = c.mandant_id AND A.art_id = c.art_id AND A.zeitraum_kz = c.zeitraum_kz
                AND A.zeit_1 = c.zeit_1
        WHERE
            B.zeitraum_kz = 'KW'
            AND B.mandant_id = 8
            AND (
                A.mandant_id, A.art_id, A.zeitraum_kz, A.zeit_1) NOT IN (
                SELECT (mandant_id, art_id, zeitraum_kz, zeit_1)
                FROM `_mseg_snap5_v1`
            )
    ) AS t5
);


DELETE FROM dbp_data.art_umsatz_kmep_zu_per_1
WHERE (
    mandant_id, dat_von, dat_bis, zeitraum_kz) IN (
    SELECT (mandant_id, dat_von, dat_bis, zeitraum_kz)
    FROM `_testit`
);


INSERT INTO dbp_data.art_umsatz_kmep_zu_per_1 (
    mandant_id, art_id, zeitraum_kz, dat_von, dat_bis,
    menge_artbew_sum, betrag_kmep, betrag_kmep_einh, betrag_kmep_einh_o_fwu, wrg_id
)
(
    SELECT
        A.mandant_id,
        A.art_id,
        A.zeitraum_kz,
        A.dat_von,
        A.dat_bis,
        A.menge_artbew_sum,
        NULL AS betrag_kmep,
        A.betrag_kmep_einh,
        A.betrag_kmep_einh_o_fwu,
        B.default_wrg AS wrg_id
    FROM `_testit` AS A
    INNER JOIN dbp_data.mandant_1 AS B ON A.mandant_id = B.mandant_id
);


DELETE FROM dbp_etl_process.ekc_artbew_kmep_1
WHERE (
    mandant_id, dat_von, dat_bis, zeitraum_kz) IN (
    SELECT (mandant_id, dat_von, dat_bis, zeitraum_kz)
    FROM `_testit`
);


INSERT INTO dbp_etl_process.ekc_artbew_kmep_1 (
    mandant_id, art_id, zeitraum_kz, dat_von, dat_bis,
    betrag_kmep, menge_artbew_sum, betrag_kmep_einh, wrg_id, betrag_kmep_einh_o_fwu
)
(
    SELECT
        A.mandant_id,
        A.art_id,
        A.zeitraum_kz,
        A.dat_von,
        A.dat_bis,
        A.betrag_kmep,
        A.menge_artbew_sum,
        A.betrag_kmep_einh,
        B.default_wrg AS wrg_id,
        A.betrag_kmep_einh_o_fwu
    FROM `_testit` AS A
    INNER JOIN dbp_data.mandant_1 AS B ON A.mandant_id = B.mandant_id
);
