CREATE OR REPLACE TABLE dbp_etl.`_subset_01_${TRANSIENT_TABLE_SUFFIX}` AS
SELECT
    mandant_id,
    wup_id,
    nb_id,
    art_id,
    bezugsweg_id,
    DATE(DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL ${LOOP_ID} DAY)) AS dat
FROM dbp_data.art_wup_zu_per AS A
WHERE
    DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL ${LOOP_ID} DAY) BETWEEN dat_von AND dat_bis
    AND listung_id = 1
    AND dat_von < DATE_SUB(DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL ${LOOP_ID} DAY), INTERVAL 28 DAY)
    AND COALESCE(kdis, 0) = 0
    AND nb_id = 0;


CREATE OR REPLACE TABLE dbp_etl.`_subset_01a_${TRANSIENT_TABLE_SUFFIX}` AS
-- KMO: nur 'S2'---
-- DE: '01,'11','ZZ'---
SELECT
    T21.dat,
    T21.mandant_id,
    T21.art_id,
    T21.wup_id,
    T21.nb_id,
    T21.bezugsweg_id,
    CASE
        WHEN T25.dispomerkmal = '01'
            THEN 3
        ELSE 2
    END AS relevant_fg
FROM dbp_etl.`_subset_01_${TRANSIENT_TABLE_SUFFIX}` AS T21
INNER JOIN dbp_data.art AS T23 ON T21.mandant_id = T23.mandant_id AND T21.art_id = T23.art_id
INNER JOIN dbp_data.wup AS T24
    ON
        T21.mandant_id = T24.mandant_id AND T21.wup_id = T24.wup_id AND T21.nb_id
        = T24.nb_id AND T21.dat BETWEEN T24.dat_von AND T24.dat_bis
INNER JOIN dbp_data.art_wup_status_per AS T25
    ON
        T21.mandant_id = T25.mandant_id AND T21.art_id = T25.art_id
        AND T21.wup_id = T25.wup_id AND T21.nb_id = T25.nb_id AND T21.dat BETWEEN T25.dat_von AND T25.dat_bis
WHERE
    T23.loesch_id <> 'L'
    AND (T23.display_id NOT IN (1, 2, 3) OR T23.display_id IS NULL)
    AND T23.wg_art_fg <> 1
    AND (
        T21.mandant_id <> 1 AND T25.dispomerkmal IN ('S2') OR T21.mandant_id = 1 AND T25.dispomerkmal IN ('01', '11', 'ZZ'
        )
    )
    AND T25.loesch_id NOT IN ('F1', 'F2', 'L')
GROUP BY
    T21.dat,
    T21.mandant_id,
    T21.art_id,
    T21.wup_id,
    T21.nb_id,
    T21.bezugsweg_id,
    relevant_fg;


CREATE OR REPLACE TABLE dbp_etl.`_subset_03_${TRANSIENT_TABLE_SUFFIX}` AS
SELECT
    mandant_id,
    wup_id,
    nb_id,
    art_id,
    bezugsweg_id,
    dat_von,
    dat_bis,
    DATE(DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL ${LOOP_ID} DAY)) AS dat
FROM dbp_data.art_wup_zu_per AS A
WHERE
    DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL ${LOOP_ID} DAY) BETWEEN dat_von AND dat_bis
    AND listung_id = 1
    AND dat_von >= DATE_SUB(DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL ${LOOP_ID} DAY), INTERVAL 28 DAY)
    AND COALESCE(kdis, 0) = 0
    AND nb_id = 0;


CREATE OR REPLACE TABLE dbp_etl.`_subset_03a_${TRANSIENT_TABLE_SUFFIX}` AS
-- KMO: nur 'S2'---
-- DE: '01,'11','ZZ'---
SELECT
    T21.dat,
    T21.mandant_id,
    T21.art_id,
    T21.wup_id,
    T21.nb_id,
    T21.bezugsweg_id,
    T21.dat_von,
    T21.dat_bis,
    CASE
        WHEN T25.dispomerkmal = '01'
            THEN 3
        ELSE 2
    END AS relevant_fg
FROM dbp_etl.`_subset_03_${TRANSIENT_TABLE_SUFFIX}` AS T21
INNER JOIN dbp_data.art AS T23 ON T21.mandant_id = T23.mandant_id AND T21.art_id = T23.art_id
INNER JOIN dbp_data.wup AS T24
    ON
        T21.mandant_id = T24.mandant_id AND T21.wup_id = T24.wup_id AND T21.nb_id
        = T24.nb_id AND T21.dat BETWEEN T24.dat_von AND T24.dat_bis
INNER JOIN dbp_data.art_wup_status_per AS T25
    ON
        T21.mandant_id = T25.mandant_id AND T21.art_id = T25.art_id
        AND T21.wup_id = T25.wup_id AND T21.nb_id = T25.nb_id AND T21.dat BETWEEN T25.dat_von AND T25.dat_bis
WHERE
    T23.loesch_id <> 'L'
    AND (T23.display_id NOT IN (1, 2, 3) OR T23.display_id IS NULL)
    AND T23.wg_art_fg <> 1
    AND (
        T21.mandant_id <> 1 AND T25.dispomerkmal IN ('S2') OR T21.mandant_id = 1 AND T25.dispomerkmal IN ('01', '11', 'ZZ'
        )
    )
    AND T25.loesch_id NOT IN ('F1', 'F2', 'L')
GROUP BY
    T21.dat,
    T21.mandant_id,
    T21.art_id,
    T21.wup_id,
    T21.nb_id,
    T21.bezugsweg_id,
    T21.dat_von,
    T21.dat_bis,
    relevant_fg;


CREATE OR REPLACE TABLE dbp_etl.`_ueberpruefung01_${TRANSIENT_TABLE_SUFFIX}` AS
SELECT
    B.dat,
    B.mandant_id,
    B.art_id,
    B.wup_id,
    B.nb_id,
    B.bezugsweg_id,
    B.relevant_fg
FROM dbp_data.art_wup_zu_per AS A
INNER JOIN dbp_etl.`_subset_03a_${TRANSIENT_TABLE_SUFFIX}` AS B
    ON
        A.mandant_id = B.mandant_id
        AND A.wup_id = B.wup_id AND A.art_id = B.art_id AND A.dat_bis = DATE_SUB(B.dat_von, INTERVAL 1 DAY)
WHERE
    A.listung_id = 1
    AND COALESCE(A.kdis, 0) = 0
    AND A.nb_id = 0;


DELETE FROM dbp_etl.`_subset_03a_${TRANSIENT_TABLE_SUFFIX}`
WHERE (
    mandant_id, art_id, wup_id, dat) IN (
    SELECT (mandant_id, art_id, wup_id, dat)
    FROM dbp_etl.`_ueberpruefung01_${TRANSIENT_TABLE_SUFFIX}`
);


/* Absender oder Empfaenger muss VZ sein */ CREATE OR REPLACE TABLE dbp_etl.`_subset_02_${TRANSIENT_TABLE_SUFFIX}`
AS
((SELECT
    t2.dat,
    t2.mandant_id,
    t2.wup_id,
    t2.nb_id,
    t2.art_id
FROM (
    SELECT
        B.dat,
        A.mandant_id,
        A.wup_id,
        A.nb_id,
        A.art_id,
        SUM(CASE
            WHEN CAST(A.lager_bewart_id AS INTEGER) IN (101, 102, 901, 902, 905, 906, 913, 915) AND A.nb_id IN (0)
                THEN A.menge_rech
            ELSE 0
        END) AS bsch_menge_dz
    FROM dbp_data.bsch_rech_det AS A
    INNER JOIN dbp_etl.`_subset_03a_${TRANSIENT_TABLE_SUFFIX}` AS B
        ON
            A.mandant_id = B.mandant_id
            AND A.wup_id = B.wup_id AND A.art_id = B.art_id
    WHERE
        A.dat BETWEEN DATE_SUB(B.dat, INTERVAL 28 DAY) AND B.dat
        AND A.dat BETWEEN DATE_SUB(DATE_SUB(
            CURRENT_DATE("Europe/Berlin"), INTERVAL ${LOOP_ID} DAY), INTERVAL 28 DAY) AND (DATE_SUB(
            CURRENT_DATE("Europe/Berlin"),
            INTERVAL ${LOOP_ID} DAY
        ))
        AND A.mandant_id = 1
        AND A.status <> 2
        AND A.nb_id NOT IN (2, 6, 7)
    GROUP BY
        B.dat,
        A.mandant_id,
        A.wup_id,
        A.nb_id,
        A.art_id
    HAVING bsch_menge_dz <> 0
) AS t2
UNION DISTINCT
SELECT
    t7.dat,
    t7.mandant_id,
    t7.wup_id,
    t7.nb_id,
    t7.art_id
FROM (
    SELECT
        B.dat,
        V01.mandant_id,
        V01.art_id,
        V03.wup_id,
        V03.nb_id,
        SUM(CAST(CASE
            WHEN V02.faktura_typ_id IN ('O', 'N')
                THEN V01.menge_faktura_bme * -1
            ELSE V01.menge_faktura_bme
        END AS NUMERIC)) AS faktura_menge_bme
    FROM dbp_data.besch_faktura_det AS V01
    INNER JOIN dbp_etl.`_subset_03a_${TRANSIENT_TABLE_SUFFIX}` AS B
        ON
            V01.mandant_id = B.mandant_id
            AND V01.wup_id = B.wup_id AND V01.art_id = B.art_id
    INNER JOIN dbp_data.besch_faktura AS V02
        ON
            V01.faktura_beleg_id = V02.faktura_beleg_id AND V01.mandant_id
            = V02.mandant_id AND V01.dat_faktura_sap = V02.dat_faktura_sap AND V02.auftraggeber_id BETWEEN '0000001000'
            AND '0000009999'
    INNER JOIN dbp_data.wup AS V03
        ON
            CAST(ROUND(SAFE_CAST(V02.auftraggeber_id AS BIGNUMERIC), 0) AS BIGNUMERIC)
            = V03.wup_id AND V01.mandant_id = V03.mandant_id
    INNER JOIN dbp_data.art_gp_zu_per AS V04
        ON
            V01.art_id = V04.art_id AND V01.mandant_id = V04.mandant_id
            AND V01.dat_faktura BETWEEN V04.dat_von AND V04.dat_bis
    WHERE
        V01.mandant_id = 1 -- 20100330 Filterung der IWT Fakturen

        AND V01.nb_id <> 99
        AND V01.dat_faktura BETWEEN DATE_SUB(B.dat, INTERVAL 28 DAY) AND B.dat
        AND V01.dat_faktura BETWEEN DATE_SUB(DATE_SUB(
            CURRENT_DATE("Europe/Berlin"), INTERVAL ${LOOP_ID} DAY), INTERVAL 28 DAY) AND (DATE_SUB(
            CURRENT_DATE("Europe/Berlin"),
            INTERVAL ${LOOP_ID} DAY
        ))
        AND V02.fakturaart_id NOT IN ('ZIWU', 'ZIWV')
    GROUP BY
        B.dat,
        V01.mandant_id,
        V01.art_id,
        V03.wup_id,
        V03.nb_id
    HAVING faktura_menge_bme <> 0
) AS t7)
UNION DISTINCT
SELECT
    t12.dat,
    t12.mandant_id,
    t12.wup_id,
    t12.nb_id,
    t12.art_id
FROM (
    SELECT
        X.dat,
        A.mandant_id,
        A.empfaenger_id AS wup_id,
        B.nb_id,
        A.art_id,
        SUM(CASE
            WHEN A.lager_bewart_id IN ('641', '647')
                THEN ABS(A.menge_lagerbew_bme)
            WHEN A.lager_bewart_id IN ('642', '648')
                THEN -1 * ABS(A.menge_lagerbew_bme)
            ELSE 0
        END) AS wa_vz_menge
    FROM dbp_data.lagerbew_det AS A
    INNER JOIN dbp_etl.`_subset_03a_${TRANSIENT_TABLE_SUFFIX}` AS X
        ON
            A.mandant_id = X.mandant_id
            AND A.wup_id = X.wup_id AND A.art_id = X.art_id
    INNER JOIN dbp_data.wup AS B ON A.mandant_id_empfaenger = B.mandant_id AND A.empfaenger_id = B.wup_id

    WHERE
        A.mandant_id <> 1
        AND (A.nb_id = -111 OR B.nb_id = -111)
        AND (
            A.lager_bewart_id IN ('641', '642', '647', '648') OR A.lager_bewart_id IN ('301', '302', '311', '312') AND A.lagerort_id
            = '0019'
        )
        AND A.dat_buch BETWEEN DATE_SUB(X.dat, INTERVAL 28 DAY) AND X.dat
        AND A.dat_buch BETWEEN DATE_SUB(DATE_SUB(
            CURRENT_DATE("Europe/Berlin"), INTERVAL ${LOOP_ID} DAY), INTERVAL 28 DAY) AND (DATE_SUB(
            CURRENT_DATE("Europe/Berlin"),
            INTERVAL ${LOOP_ID} DAY
        ))
    GROUP BY
        X.dat,
        A.mandant_id,
        wup_id,
        B.nb_id,
        A.art_id
    HAVING wa_vz_menge <> 0
) AS t12)
UNION DISTINCT
SELECT
    t17.dat,
    t17.mandant_id,
    t17.wup_id,
    t17.nb_id,
    t17.art_id
FROM (
    SELECT
        B.dat,
        A.mandant_id,
        A.wup_id,
        A.nb_id,
        A.art_id,
        SUM(CASE
            WHEN A.lager_bewart_id IN ('101', '102', '901', '902') AND A.nb_id = 0
                THEN A.menge_basis
            ELSE 0
        END) AS wewa_menge_dz
    FROM dbp_data.wewa AS A
    INNER JOIN dbp_etl.`_subset_03a_${TRANSIENT_TABLE_SUFFIX}` AS B
        ON
            A.mandant_id = B.mandant_id
            AND A.wup_id = B.wup_id AND A.art_id = B.art_id
    WHERE
        A.mandant_id > 1
        AND A.lager_bewart_id IN ('101', '102', '901', '902')
        AND A.nb_id = 0
        AND A.dat_buch BETWEEN DATE_SUB(B.dat, INTERVAL 28 DAY) AND B.dat
        AND A.dat_buch BETWEEN DATE_SUB(DATE_SUB(
            CURRENT_DATE("Europe/Berlin"), INTERVAL ${LOOP_ID} DAY), INTERVAL 28 DAY) AND (DATE_SUB(
            CURRENT_DATE("Europe/Berlin"),
            INTERVAL ${LOOP_ID} DAY
        ))
    GROUP BY
        B.dat,
        A.mandant_id,
        A.wup_id,
        A.nb_id,
        A.art_id
    HAVING wewa_menge_dz <> 0
) AS t17;


CREATE OR REPLACE TABLE dbp_etl.`_subset_02a_${TRANSIENT_TABLE_SUFFIX}` AS
SELECT
    A.dat,
    A.mandant_id,
    A.wup_id,
    A.nb_id,
    A.art_id,
    B.bezugsweg_id,
    CASE
        WHEN C.dispomerkmal = '01'
            THEN 3
        ELSE 2
    END AS relevant_fg
FROM dbp_etl.`_subset_02_${TRANSIENT_TABLE_SUFFIX}` AS A
INNER JOIN dbp_data.art_wup_zu_per AS B
    ON
        A.mandant_id = B.mandant_id AND A.wup_id = B.wup_id AND A.art_id
        = B.art_id AND A.dat BETWEEN B.dat_von AND B.dat_bis
INNER JOIN dbp_data.art_wup_status_per AS C ON A.mandant_id = C.mandant_id AND A.wup_id = C.wup_id AND A.art_id = C.art_id AND A.dat BETWEEN C.dat_von AND C.dat_bis;


DELETE FROM dbp_etl.`_subset_02a_${TRANSIENT_TABLE_SUFFIX}`
WHERE (
    dat, mandant_id, wup_id, nb_id, art_id) NOT IN (
    SELECT (dat, mandant_id, wup_id, nb_id, art_id)
    FROM dbp_etl.`_subset_03a_${TRANSIENT_TABLE_SUFFIX}`
);


CREATE OR REPLACE TABLE dbp_etl.`_subset_final_${TRANSIENT_TABLE_SUFFIX}` AS
(
    SELECT
        dat,
        mandant_id,
        wup_id,
        nb_id,
        art_id,
        bezugsweg_id,
        relevant_fg
    FROM dbp_etl.`_subset_01a_${TRANSIENT_TABLE_SUFFIX}`
    GROUP BY
        dat,
        mandant_id,
        art_id,
        wup_id,
        nb_id,
        bezugsweg_id,
        relevant_fg
    UNION DISTINCT
    SELECT
        dat,
        mandant_id,
        wup_id,
        nb_id,
        art_id,
        bezugsweg_id,
        relevant_fg
    FROM dbp_etl.`_subset_02a_${TRANSIENT_TABLE_SUFFIX}`
    GROUP BY
        dat,
        mandant_id,
        wup_id,
        nb_id,
        art_id,
        bezugsweg_id,
        relevant_fg
)
UNION DISTINCT
SELECT
    dat,
    mandant_id,
    wup_id,
    nb_id,
    art_id,
    bezugsweg_id,
    relevant_fg
FROM dbp_etl.`_ueberpruefung01_${TRANSIENT_TABLE_SUFFIX}`
GROUP BY
    dat,
    mandant_id,
    art_id,
    wup_id,
    nb_id,
    bezugsweg_id,
    relevant_fg;


UPDATE dbp_etl.marktbestand_erp_tmp SET
    relevant_fg = dt1.`_relevant_fg` FROM (
    SELECT
        mandant_id AS `_mandant_id`,
        wup_id AS `_wup_id`,
        art_id AS `_art_id`,
        bezugsweg_id AS `_bezugsweg_id`,
        MIN(relevant_fg) AS `_relevant_fg`
    FROM dbp_etl.`_subset_final_${TRANSIENT_TABLE_SUFFIX}`
    GROUP BY
        `_mandant_id`,
        `_wup_id`,
        `_art_id`,
        `_bezugsweg_id`
) AS dt1
WHERE
    marktbestand_erp_tmp.mandant_id = dt1.`_mandant_id` AND marktbestand_erp_tmp.wup_id = dt1.`_wup_id` AND
    marktbestand_erp_tmp.art_id = dt1.`_art_id` AND marktbestand_erp_tmp.bezugsweg_id = dt1.`_bezugsweg_id`;


UPDATE dbp_etl.marktbestand_erp_tmp SET
    relevant_fg = 1 FROM (
    SELECT
        T01.mandant_id AS `_mandant_id`,
        T01.wup_id AS `_wup_id`,
        T01.art_id AS `_art_id`,
        T04.bezugsweg_id AS `_bezugsweg_id`
    FROM dbp_etl.marktbestand_erp_tmp AS T01
    INNER JOIN dbp_data.art AS T02 ON T01.mandant_id = T02.mandant_id AND T01.art_id = T02.art_id
    INNER JOIN dbp_data.wup AS T03 ON T01.mandant_id = T03.mandant_id AND T01.wup_id = T03.wup_id
    INNER JOIN dbp_data.art_wup_status_per AS T04 ON T01.mandant_id = T04.mandant_id AND T01.wup_id = T04.wup_id AND T01.art_id = T04.art_id
    WHERE
        T01.listung_id = 1
        AND T01.kdis = 0
        AND T02.loesch_id <> 'L'
        AND (T02.display_id NOT IN (1, 2, 3) OR T02.display_id IS NULL)
        AND T02.wg_art_fg <> 1
        AND (T04.mandant_id <> 1 AND T04.dispomerkmal IN ('S2') OR T04.mandant_id = 1 AND T04.dispomerkmal IN ('11', 'ZZ'))
        AND DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL ${LOOP_ID} DAY) BETWEEN T03.dat_von AND T03.dat_bis
        AND DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL ${LOOP_ID} DAY) BETWEEN T04.dat_von AND T04.dat_bis
) AS dt1
WHERE
    marktbestand_erp_tmp.mandant_id = dt1.`_mandant_id` AND marktbestand_erp_tmp.wup_id = dt1.`_wup_id` AND
    marktbestand_erp_tmp.art_id = dt1.`_art_id` AND marktbestand_erp_tmp.bezugsweg_id = dt1.`_bezugsweg_id` AND
    marktbestand_erp_tmp.relevant_fg = 0;
