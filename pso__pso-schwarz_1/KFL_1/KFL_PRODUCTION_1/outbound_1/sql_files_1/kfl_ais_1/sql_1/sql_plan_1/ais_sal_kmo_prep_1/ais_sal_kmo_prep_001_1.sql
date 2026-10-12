/* translated to SF by konopkaw / 2021-06-03 */


DROP TABLE IF EXISTS dbp_etl.anz_wo_listung_pre_1;


DROP TABLE IF EXISTS dbp_etl.st_ab_wg_art_wo_sum_kmo_1;


CREATE TABLE IF NOT EXISTS dbp_etl.st_ab_wg_art_wo_sum_kmo_1 AS
SELECT
    A.mandant_id,
    C.kjwo,
    B.wg_id,
    A.art_id,
    A.wup_id,
    A.nb_id,
    A.bewart_id,
    A.menge,
    A.umsatz_netto,
    A.ek_mep,
    A.einstandspreis
FROM dbp_data.artbew_wo_sum_1 AS A
INNER JOIN dbp_data.woche_kj_kl_1 AS C ON A.kjwo_kl = C.kjwo_kl
INNER JOIN dbp_data.art_wg_zu_per_1 AS B
    ON
        A.mandant_id = B.mandant_id AND A.art_id = B.art_id AND B.dat_bis
        = PARSE_DATE('%F', '9999-12-31')
INNER JOIN dbp_data.wg_filter_zu_1 AS WFZ ON B.wg_id = WFZ.wg_id AND A.mandant_id = WFZ.mandant_id AND WFZ.wg_filter_id = 47 AND WFZ.arthiertyp_id = 2
WHERE A.mandant_id = ${MANDANT_ID};


DROP TABLE IF EXISTS dbp_etl.st_listung_kw_kmo_1;


CREATE TABLE IF NOT EXISTS dbp_etl.st_listung_kw_kmo_1 AS
SELECT
    V01.mandant_id,
    V01.wg_id,
    V01.art_id,
    V01.wup_id,
    V01.nb_id,
    V04.kreistyp_gruppe_id,
    V01.kjwo,
    IFNULL(SUM(V01.menge), 0) AS absatz,
    IFNULL(SUM(CASE
        WHEN V01.bewart_id = 1002
            THEN V01.menge
        ELSE NULL
    END), 0) AS absatz_sa,
    IFNULL(SUM(CASE
        WHEN V01.bewart_id = 1001
            THEN V01.menge
        ELSE NULL
    END), 0) AS absatz_af,
    IFNULL(CASE
        WHEN IFNULL(SUM(V01.menge), 0) > 0
            THEN COUNT(DISTINCT V01.kjwo)
        ELSE NULL
    END, 0) AS anzahl_wochen_mit_absatz,
    IFNULL(CASE
        WHEN
            IFNULL(SUM(CASE
                WHEN V01.bewart_id = 1002
                    THEN V01.menge
                ELSE NULL
            END), 0) > 0 AND IFNULL(SUM(CASE
                WHEN V01.bewart_id = 1002
                    THEN V01.menge
                ELSE NULL
            END), 0) IS NOT NULL
            THEN COUNT(DISTINCT CASE
                WHEN V01.bewart_id = 1002
                    THEN V01.kjwo
                ELSE NULL
            END)
        ELSE NULL
    END, 0) AS anzahl_wochen_mit_absatz_sa,
    IFNULL(CASE
        WHEN
            IFNULL(SUM(CASE
                WHEN V01.bewart_id = 1001
                    THEN V01.menge
                ELSE NULL
            END), 0) > 0 AND IFNULL(SUM(CASE
                WHEN V01.bewart_id = 1001
                    THEN V01.menge
                ELSE NULL
            END), 0) IS NOT NULL
            THEN COUNT(DISTINCT CASE
                WHEN V01.bewart_id = 1001
                    THEN V01.kjwo
                ELSE NULL
            END)
        ELSE NULL
    END, 0) AS anzahl_wochen_mit_absatz_af
FROM dbp_etl.st_ab_wg_art_wo_sum_kmo_1 AS V01
INNER JOIN dbp_data.wup_1 AS V04
    ON
        V01.wup_id = V04.wup_id AND V01.nb_id = V04.nb_id AND V01.mandant_id =
        V04.mandant_id
GROUP BY
    V01.mandant_id,
    V01.wg_id,
    V01.art_id,
    V01.wup_id,
    V01.nb_id,
    V04.kreistyp_gruppe_id,
    V01.kjwo;


DROP TABLE IF EXISTS dbp_etl.st_listung_sm_kw_kmo_1;


CREATE TABLE IF NOT EXISTS dbp_etl.st_listung_sm_kw_kmo_1 AS
SELECT
    A.mandant_id,
    C.kjwo,
    S.sm_id,
    S.ksm_id,
    B.wg_id,
    A.art_id,
    A.wup_id,
    A.nb_id,
    A.bewart_id,
    SUM(A.menge) AS menge,
    SUM(A.umsatz_netto) AS umsatz_netto,
    SUM(A.ek_mep) AS ek_mep,
    SUM(A.einstandspreis) AS einstandspreis,
    IFNULL(SUM(A.menge), 0) AS absatz,
    IFNULL(SUM(CASE
        WHEN A.bewart_id = 1002
            THEN A.menge
        ELSE NULL
    END), 0) AS absatz_sa,
    IFNULL(SUM(CASE
        WHEN A.bewart_id = 1001
            THEN A.menge
        ELSE NULL
    END), 0) AS absatz_af,
    IFNULL(CASE
        WHEN IFNULL(SUM(A.menge), 0) > 0
            THEN COUNT(DISTINCT C.kjwo)
        ELSE NULL
    END, 0) AS anz_wo_mit_absatz,
    IFNULL(CASE
        WHEN
            IFNULL(SUM(CASE
                WHEN A.bewart_id = 1002
                    THEN A.menge
                ELSE NULL
            END), 0) > 0 AND IFNULL(SUM(CASE
                WHEN A.bewart_id = 1002
                    THEN A.menge
                ELSE NULL
            END), 0) IS NOT NULL
            THEN COUNT(DISTINCT CASE
                WHEN A.bewart_id = 1002
                    THEN C.kjwo
                ELSE NULL
            END)
        ELSE NULL
    END, 0) AS anz_wo_mit_absatz_sa,
    IFNULL(CASE
        WHEN
            IFNULL(SUM(CASE
                WHEN A.bewart_id = 1001
                    THEN A.menge
                ELSE NULL
            END), 0) > 0 AND IFNULL(SUM(CASE
                WHEN A.bewart_id = 1001
                    THEN A.menge
                ELSE NULL
            END), 0) IS NOT NULL
            THEN COUNT(DISTINCT CASE
                WHEN A.bewart_id = 1001
                    THEN C.kjwo
                ELSE NULL
            END)
        ELSE NULL
    END, 0) AS anz_wo_mit_absatz_af
FROM dbp_data.artbew_wo_sum_1 AS A
INNER JOIN dbp_data.woche_kj_kl_1 AS C ON A.kjwo_kl = C.kjwo_kl -- AND c.akt_wo between -52 and 0

INNER JOIN dbp_data.art_wg_zu_per_1 AS B
    ON
        A.mandant_id = B.mandant_id AND A.art_id = B.art_id AND B.dat_bis
        = PARSE_DATE('%F', '9999-12-31')
INNER JOIN dbp_data.wg_filter_zu_1 AS WFZ ON B.wg_id = WFZ.wg_id AND A.mandant_id = WFZ.mandant_id AND WFZ.wg_filter_id = 47 AND WFZ.arthiertyp_id = 2
INNER JOIN dbp_etl_process.sm_wup_wg_zu_per_1 AS S
    ON
        A.mandant_id = S.mandant_id AND B.wg_id = S.wg_id
        AND A.wup_id = S.wup_id AND A.nb_id = S.nb_id AND S.nb_id <> 99 AND S.arthiertyp_id = 2 AND S.dat_bis = PARSE_DATE(
            '%F',
            '9999-12-31'
        )
WHERE
    A.mandant_id = ${MANDANT_ID}
    AND (S.sm_id BETWEEN 1 AND 5 OR S.ksm_id IN ('K1', 'K2', 'K3', 'K4', 'K5', 'K6', 'K7', 'K8', 'K9'))
GROUP BY
    A.mandant_id,
    C.kjwo,
    S.sm_id,
    S.ksm_id,
    B.wg_id,
    A.art_id,
    A.wup_id,
    A.nb_id,
    A.bewart_id;


DROP TABLE IF EXISTS dbp_etl.st_listung_markt_tag_kmo_1;


CREATE TABLE IF NOT EXISTS dbp_etl.st_listung_markt_tag_kmo_1 AS
SELECT
    V01.mandant_id,
    V03.wg_id,
    V01.art_id,
    V01.dat,
    V02.kjwo,
    V01.wup_id,
    IFNULL(SUM(V01.menge), 0) AS absatz,
    IFNULL(SUM(CASE
        WHEN V01.bewart_id = 1002
            THEN V01.menge
        ELSE NULL
    END), 0) AS absatz_sa,
    IFNULL(SUM(CASE
        WHEN V01.bewart_id = 1001
            THEN V01.menge
        ELSE NULL
    END), 0) AS absatz_af,
    IFNULL(CASE
        WHEN IFNULL(SUM(V01.menge), 0) > 0
            THEN COUNT(DISTINCT V02.dat)
        ELSE NULL
    END, 0) AS anzahl_tage_mit_absatz,
    IFNULL(CASE
        WHEN
            IFNULL(SUM(CASE
                WHEN V01.bewart_id = 1002
                    THEN V01.menge
                ELSE NULL
            END), 0) > 0 AND IFNULL(SUM(CASE
                WHEN V01.bewart_id = 1002
                    THEN V01.menge
                ELSE NULL
            END), 0) IS NOT NULL
            THEN COUNT(DISTINCT CASE
                WHEN V01.bewart_id = 1002
                    THEN V02.dat
                ELSE NULL
            END)
        ELSE NULL
    END, 0) AS anzahl_tage_mit_absatz_sa,
    IFNULL(CASE
        WHEN
            IFNULL(SUM(CASE
                WHEN V01.bewart_id = 1001
                    THEN V01.menge
                ELSE NULL
            END), 0) > 0 AND IFNULL(SUM(CASE
                WHEN V01.bewart_id = 1001
                    THEN V01.menge
                ELSE NULL
            END), 0) IS NOT NULL
            THEN COUNT(DISTINCT CASE
                WHEN V01.bewart_id = 1001
                    THEN V02.dat
                ELSE NULL
            END)
        ELSE NULL
    END, 0) AS anzahl_tage_mit_absatz_af
FROM dbp_data.artbew_1 AS V01
INNER JOIN dbp_data.tag_1 AS V02 ON V01.dat = V02.dat
INNER JOIN dbp_data.art_wg_zu_per_1 AS V03
    ON
        V01.mandant_id = V03.mandant_id AND V01.art_id = V03.art_id
        AND V03.dat_bis = PARSE_DATE('%F', '9999-12-31')
INNER JOIN dbp_data.wg_filter_zu_1 AS WFZ
    ON
        V03.wg_id = WFZ.wg_id AND V01.mandant_id = WFZ.mandant_id AND
        WFZ.wg_filter_id = 47 AND WFZ.arthiertyp_id = 2
INNER JOIN dbp_data.wup_1 AS V04
    ON
        V01.wup_id = V04.wup_id AND V01.nb_id = V04.nb_id AND V01.mandant_id =
        V04.mandant_id
WHERE V01.mandant_id = ${MANDANT_ID}
GROUP BY
    V01.mandant_id,
    V03.wg_id,
    V01.art_id,
    V01.dat,
    V02.kjwo,
    V01.wup_id;


---


DROP TABLE IF EXISTS dbp_etl.anz_wo_absatz_pre_1;


CREATE TABLE IF NOT EXISTS dbp_etl.anz_wo_absatz_pre_1 (
    art_id INTEGER,
    mandant_id INTEGER,
    kjwo INTEGER,
    wup_id INTEGER,
    anz_maerkte INTEGER,
    absatz_gesamt FLOAT64,
    anz_wo_mit_absatz FLOAT64,
    absatz_af_sk1_bis6 FLOAT64,
    anz_wo_mit_abs_af_sk1_bis6 FLOAT64,
    anz_wo_mit_abs_tot_sk1_bis6 FLOAT64
);


CREATE TABLE IF NOT EXISTS dbp_etl.anz_wo_listung_pre_1 (
    art_id INTEGER,
    mandant_id INTEGER,
    kjwo INTEGER,
    wup_id INTEGER,
    anz_wo_listung_1 FLOAT64
);


INSERT INTO dbp_etl.anz_wo_absatz_pre_1 (
    art_id, mandant_id, kjwo, wup_id, anz_maerkte, absatz_gesamt,
    anz_wo_mit_absatz, absatz_af_sk1_bis6, anz_wo_mit_abs_af_sk1_bis6, anz_wo_mit_abs_tot_sk1_bis6
)
(
    SELECT
        A.art_id,
        A.mandant_id,
        A.kjwo,
        A.wup_id,
        COUNT(DISTINCT A.wup_id) AS anz_maerkte,
        CAST(SUM(A.absatz) AS FLOAT64) AS absatz_gesamt,
        CAST(SUM(A.anzahl_wochen_mit_absatz) AS FLOAT64) AS anz_wo_mit_absatz,
        CAST(SUM(A.absatz_af) AS FLOAT64) AS absatz_af_sk1_bis6,
        CAST(SUM(A.anzahl_wochen_mit_absatz_af) AS FLOAT64) AS anz_wo_mit_abs_af_sk1_bis6,
        CAST(SUM(A.anzahl_wochen_mit_absatz) AS FLOAT64) AS anz_wo_mit_abs_tot_sk1_bis6
    FROM dbp_etl.st_listung_kw_kmo_1 AS A
    INNER JOIN (
        SELECT
            A0.kjwo_sort_von,
            A0.kjwo_sort_bis
        FROM dbp_etl_process.sort_monat_woche_1 AS A0
        INNER JOIN dbp_data.monat_1 AS B ON A0.kjmo_sort = B.kjmo
        WHERE B.akt_mo = -1
    ) AS b ON A.kjwo BETWEEN b.kjwo_sort_von AND b.kjwo_sort_bis
    WHERE A.mandant_id = ${MANDANT_ID}
    GROUP BY
        A.mandant_id,
        A.art_id,
        A.wup_id,
        A.kjwo
);


INSERT INTO dbp_etl.anz_wo_listung_pre_1 (art_id, mandant_id, kjwo, wup_id, anz_wo_listung_1)
(
    SELECT
        A.art_id,
        A.mandant_id,
        A.kjwo,
        A.wup_id,
        CAST(SUM(A.listung_id) AS FLOAT64) AS anz_wo_listung_1
    FROM dbp_data.art_wup_listung_kjwo_1 AS A
    INNER JOIN (
        SELECT
            A0.kjwo_sort_von,
            A0.kjwo_sort_bis
        FROM dbp_etl_process.sort_monat_woche_1 AS A0
        INNER JOIN dbp_data.monat_1 AS B ON A0.kjmo_sort = B.kjmo
        WHERE B.akt_mo = -1
    ) AS b ON A.kjwo BETWEEN b.kjwo_sort_von AND b.kjwo_sort_bis
    WHERE A.mandant_id = ${MANDANT_ID}
    GROUP BY
        A.mandant_id,
        A.art_id,
        A.wup_id,
        A.kjwo
);


-- 23.03.2018, -dbay-
--
-- Neue Tabelle, um die SDQs nach neuer Definition zu erzeugen.


CREATE OR REPLACE TABLE dbp_etl.`_mm_${TRANSIENT_TABLE_SUFFIX}` AS
SELECT
    A.art_id,
    A.mandant_id,
    A.kjwo,
    A.wup_id,
    A.anz_wo_listung_1,
    B.anz_maerkte,
    B.absatz_gesamt,
    B.anz_wo_mit_absatz,
    B.absatz_af_sk1_bis6,
    B.anz_wo_mit_abs_af_sk1_bis6,
    B.anz_wo_mit_abs_tot_sk1_bis6
FROM dbp_etl.anz_wo_listung_pre_1 AS A
INNER JOIN dbp_etl.anz_wo_absatz_pre_1
    AS B ON A.mandant_id = B.mandant_id AND A.art_id = B.art_id AND A.wup_id
= B.wup_id AND A.kjwo = B.kjwo;


INSERT INTO dbp_etl.`_mm_${TRANSIENT_TABLE_SUFFIX}`
(SELECT
    art_id,
    mandant_id,
    kjwo,
    wup_id,
    anz_wo_listung_1,
    0,
    0,
    0,
    0,
    0,
    0
FROM dbp_etl.anz_wo_listung_pre_1
WHERE (
    art_id, mandant_id, kjwo, wup_id) NOT IN (
    SELECT (art_id, mandant_id, kjwo, wup_id)
    FROM dbp_etl.`_mm_${TRANSIENT_TABLE_SUFFIX}`
));


-- 23.03.2018, -dbay-
--
-- Ab hier die urspruenglichen Tabellen, um den Folgeprozess nicht
-- anpassen zu muessen. Allerdings mit der neuen Logik.


DROP TABLE IF EXISTS dbp_etl.anz_wo_absatz_1;


CREATE TABLE IF NOT EXISTS dbp_etl.anz_wo_absatz_1 (
    art_id INTEGER,
    mandant_id INTEGER,
    kjwo INTEGER,
    anz_maerkte INTEGER,
    absatz_gesamt FLOAT64,
    anz_wo_mit_absatz FLOAT64,
    absatz_af_sk1_bis6 FLOAT64,
    anz_wo_mit_abs_af_sk1_bis6 FLOAT64,
    anz_wo_mit_abs_tot_sk1_bis6 FLOAT64
);


INSERT INTO dbp_etl.anz_wo_absatz_1 (
    art_id, mandant_id, kjwo, anz_maerkte, absatz_gesamt,
    anz_wo_mit_absatz, absatz_af_sk1_bis6, anz_wo_mit_abs_af_sk1_bis6, anz_wo_mit_abs_tot_sk1_bis6
)
(
    SELECT
        art_id,
        mandant_id,
        kjwo,
        COUNT(DISTINCT wup_id) AS anz_maerkte,
        SUM(absatz_gesamt) AS absatz_gesamt,
        SUM(anz_wo_mit_absatz) AS anz_wo_mit_absatz,
        SUM(absatz_af_sk1_bis6) AS absatz_af_sk1_bis6,
        SUM(anz_wo_mit_abs_af_sk1_bis6) AS anz_wo_mit_abs_af_sk1_bis6,
        SUM(anz_wo_mit_abs_tot_sk1_bis6) AS anz_wo_mit_abs_tot_sk1_bis6
    FROM dbp_etl.`_mm_${TRANSIENT_TABLE_SUFFIX}` AS A11
    WHERE anz_wo_mit_absatz <> 0
    GROUP BY
        art_id,
        mandant_id,
        kjwo
);


DROP TABLE IF EXISTS dbp_etl.anz_wo_listung_1;


CREATE TABLE IF NOT EXISTS dbp_etl.anz_wo_listung_1 (
    art_id INTEGER,
    mandant_id INTEGER,
    kjwo INTEGER,
    anz_wo_listung_1 FLOAT64
);


INSERT INTO dbp_etl.anz_wo_listung_1
(
    SELECT
        art_id,
        mandant_id,
        kjwo,
        SUM(anz_wo_listung_1) AS anz_wo_listung_1
    FROM dbp_etl.`_mm_${TRANSIENT_TABLE_SUFFIX}` AS A11
    GROUP BY
        art_id,
        mandant_id,
        kjwo
);
