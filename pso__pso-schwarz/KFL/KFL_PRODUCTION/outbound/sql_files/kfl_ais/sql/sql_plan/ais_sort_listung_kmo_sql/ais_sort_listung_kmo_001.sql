CREATE OR REPLACE TEMPORARY TABLE _art_list_wup_zu_per AS
SELECT
    A.art_id,
    A.wup_id,
    A.nb_id,
    A.dat_von,
    A.mandant_id,
    A.list_quelle_id,
    A.struktur_art_id,
    A.dat_bis,
    A.baustein_id,
    A.list_sap_id,
    A.list_komponente_fg,
    A.td_update,
    A.td_insert,
    B.wg_id
FROM dbp_data.art_list_wup_zu_per AS A
INNER JOIN dbp_data.art_wg_zu_per AS B
    ON
        A.mandant_id = B.mandant_id AND A.art_id = B.art_id AND B.arthiertyp_id
        = 2 AND B.dat_bis = DATE '9999-12-31'
INNER JOIN dbp_data.wup AS C ON A.mandant_id = C.mandant_id AND A.wup_id = C.wup_id
WHERE
    A.mandant_id = ${mandant_id}
    AND B.wg_id IN (
        SELECT wg_id
        FROM dbp_data.wg_filter_zu
        WHERE wg_filter_id = 47
    )
    AND CURRENT_DATE("Europe/Berlin") BETWEEN A.dat_von AND A.dat_bis
    AND TRIM(A.list_quelle_id) IN ('1', '3', '7', 'c')
    AND CAST(FLOOR(A.art_id / 10) AS INTEGER) = A.struktur_art_id
    AND A.nb_id = 0
    AND C.nb_id = 0
    AND C.dat_eroeffnung <= CURRENT_DATE("Europe/Berlin");


CREATE OR REPLACE TEMPORARY TABLE _sst AS
SELECT
    A.mandant_id,
    A.art_id,
    A.wup_id
FROM `_art_list_wup_zu_per` AS A
INNER JOIN dbp_etl_process.sm_wup_wg_zu_per AS C
    ON
        A.mandant_id = C.mandant_id AND A.wup_id = C.wup_id
        AND A.wg_id = C.wg_id AND C.dat_bis = DATE '9999-12-31' AND C.sm_id BETWEEN 1 AND 9
INNER JOIN dbp_data.wup AS B ON A.mandant_id = B.mandant_id AND A.wup_id = B.wup_id
WHERE
    C.sm_id IS NOT NULL
    AND TRIM(A.list_quelle_id) IN ('1', '7')
    AND B.nb_id = 0
    AND B.dat_eroeffnung < CURRENT_DATE("Europe/Berlin")
GROUP BY
    A.art_id,
    A.wup_id,
    A.mandant_id
UNION DISTINCT
SELECT
    A.mandant_id,
    A.art_id,
    A.wup_id
FROM `_art_list_wup_zu_per` AS A
INNER JOIN dbp_etl_process.sm_wup_wg_zu_per AS C
    ON
        A.mandant_id = C.mandant_id AND A.wup_id = C.wup_id
        AND A.wg_id = C.wg_id AND C.dat_bis = DATE '9999-12-31' AND C.sm_id BETWEEN 1 AND 9
INNER JOIN dbp_data.wup AS B ON A.mandant_id = B.mandant_id AND A.wup_id = B.wup_id
WHERE
    C.sm_id IS NOT NULL
    AND TRIM(A.list_quelle_id) IN ('3')
    AND B.nb_id = 0
    AND B.dat_eroeffnung < CURRENT_DATE("Europe/Berlin")
    AND (
        A.mandant_id, A.baustein_id) NOT IN (
        SELECT (mandant_id, baustein_id)
        FROM dbp_etl.baustein_wsop
        WHERE
            CURRENT_DATE("Europe/Berlin") BETWEEN dat_von AND dat_bis
            AND mandant_id = ${mandant_id}
    )
GROUP BY
    A.art_id,
    A.wup_id,
    A.mandant_id;


CREATE OR REPLACE TEMPORARY TABLE _ksst AS
SELECT
    A.mandant_id,
    A.art_id,
    A.wup_id
FROM `_art_list_wup_zu_per` AS A
INNER JOIN dbp_etl_process.sm_wup_wg_zu_per AS C
    ON
        A.mandant_id = C.mandant_id AND A.wup_id = C.wup_id
        AND A.wg_id = C.wg_id AND C.dat_bis = DATE '9999-12-31' AND ROUND(CAST(SUBSTR(C.ksm_id, 2, 1) AS BIGNUMERIC), 0)
        BETWEEN 1 AND 9
INNER JOIN dbp_data.wup AS B ON A.mandant_id = B.mandant_id AND A.wup_id = B.wup_id
WHERE
    C.ksm_id IS NOT NULL
    AND TRIM(A.list_quelle_id) IN ('1', '7')
    AND B.nb_id = 0
    AND B.dat_eroeffnung < CURRENT_DATE("Europe/Berlin")
GROUP BY
    A.art_id,
    A.wup_id,
    A.mandant_id
UNION DISTINCT
SELECT
    A.mandant_id,
    A.art_id,
    A.wup_id
FROM `_art_list_wup_zu_per` AS A
INNER JOIN dbp_etl_process.sm_wup_wg_zu_per AS C
    ON
        A.mandant_id = C.mandant_id AND A.wup_id = C.wup_id
        AND A.wg_id = C.wg_id AND C.dat_bis = DATE '9999-12-31' AND ROUND(
            CAST(SUBSTR(TRIM(C.ksm_id), 2, 1) AS BIGNUMERIC),
            0
        ) BETWEEN 1 AND 9
INNER JOIN dbp_data.wup AS B ON A.mandant_id = B.mandant_id AND A.wup_id = B.wup_id
WHERE
    C.ksm_id IS NOT NULL
    AND TRIM(A.list_quelle_id) IN ('3')
    AND B.nb_id = 0
    AND B.dat_eroeffnung < CURRENT_DATE("Europe/Berlin")
    AND (
        A.mandant_id, A.baustein_id) NOT IN (
        SELECT (mandant_id, baustein_id)
        FROM dbp_etl.baustein_wsop
        WHERE
            CURRENT_DATE("Europe/Berlin") BETWEEN dat_von AND dat_bis
            AND mandant_id = ${mandant_id}
    )
GROUP BY
    A.art_id,
    A.wup_id,
    A.mandant_id;


CREATE OR REPLACE TEMPORARY TABLE _sonstige_bst AS
SELECT
    A.mandant_id,
    A.art_id,
    A.wup_id
FROM `_art_list_wup_zu_per` AS A
INNER JOIN dbp_data.wup AS B ON A.mandant_id = B.mandant_id AND A.wup_id = B.wup_id
WHERE
    TRIM(A.list_quelle_id) IN ('3')
    AND (
        A.mandant_id, A.baustein_id) IN (
        SELECT (mandant_id, baustein_id)
        FROM dbp_etl.baustein_wsop
        WHERE
            CURRENT_DATE("Europe/Berlin") BETWEEN dat_von AND dat_bis
            AND mandant_id = ${mandant_id}
    )
    AND B.nb_id = 0
    AND B.dat_eroeffnung < CURRENT_DATE("Europe/Berlin")
GROUP BY
    A.mandant_id,
    A.art_id,
    A.wup_id;


CREATE OR REPLACE TEMPORARY TABLE _einzel_markt AS
SELECT
    A.mandant_id,
    A.art_id,
    A.wup_id,
    A.wg_id
FROM `_art_list_wup_zu_per` AS A
INNER JOIN dbp_data.wup AS B ON A.mandant_id = B.mandant_id AND A.wup_id = B.wup_id
WHERE
    TRIM(A.list_quelle_id) IN ('c')
    AND B.nb_id = 0
    AND B.dat_eroeffnung < CURRENT_DATE("Europe/Berlin")
GROUP BY
    A.art_id,
    A.wup_id,
    A.mandant_id,
    A.wg_id
UNION DISTINCT
SELECT
    A.mandant_id,
    A.art_id,
    A.wup_id,
    A.wg_id
FROM `_art_list_wup_zu_per` AS A
INNER JOIN dbp_etl_process.art_sm_vw_zu_per AS C
    ON
        A.mandant_id = C.mandant_id AND A.art_id = C.art_id
        AND CURRENT_DATE("Europe/Berlin") BETWEEN C.dat_von AND C.dat_bis AND CAST(C.sm_id AS FLOAT64) = -2
INNER JOIN dbp_data.wup AS B ON A.mandant_id = B.mandant_id AND A.wup_id = B.wup_id
WHERE
    TRIM(A.list_quelle_id) IN ('1')
    AND B.nb_id = 0
    AND B.dat_eroeffnung < CURRENT_DATE("Europe/Berlin")
GROUP BY
    A.art_id,
    A.wup_id,
    A.mandant_id,
    A.wg_id;


CREATE OR REPLACE TEMPORARY TABLE _gesamtsicht AS
SELECT
    A.mandant_id,
    A.art_id,
    A.wup_id
FROM dbp_data.art_list_wup_zu_per AS A
INNER JOIN dbp_data.art_wg_zu_per AS B
    ON
        A.mandant_id = B.mandant_id AND A.art_id = B.art_id AND B.arthiertyp_id
        = 2 AND B.dat_bis = DATE '9999-12-31'
INNER JOIN dbp_data.wup AS C ON A.mandant_id = C.mandant_id AND A.wup_id = C.wup_id
WHERE
    A.mandant_id = ${mandant_id}
    AND B.wg_id IN (
        SELECT wg_id
        FROM dbp_data.wg_filter_zu
        WHERE wg_filter_id = 47
    )
    AND CURRENT_DATE("Europe/Berlin") BETWEEN A.dat_von AND A.dat_bis
    AND CAST(FLOOR(A.art_id / 10) AS INTEGER) = A.struktur_art_id
    AND A.nb_id = 0
    AND C.nb_id = 0
    AND C.dat_eroeffnung <= CURRENT_DATE("Europe/Berlin")
    AND TRIM(A.list_quelle_id) NOT IN ('2')
GROUP BY
    A.mandant_id,
    A.art_id,
    A.wup_id;


CREATE OR REPLACE TEMPORARY TABLE _gesamt_sicht AS
SELECT
    mandant_id,
    art_id,
    COUNT(DISTINCT wup_id) AS anz_markt
FROM `_gesamtsicht` AS X
GROUP BY
    mandant_id,
    art_id;


CREATE OR REPLACE TEMPORARY TABLE _sst_org AS
SELECT
    mandant_id,
    art_id,
    COUNT(DISTINCT wup_id) AS anz_markt
FROM `_sst` AS X
GROUP BY
    mandant_id,
    art_id;


CREATE OR REPLACE TEMPORARY TABLE _ksst_org AS
SELECT
    mandant_id,
    art_id,
    COUNT(DISTINCT wup_id) AS anz_markt
FROM `_ksst` AS X
GROUP BY
    mandant_id,
    art_id;


CREATE OR REPLACE TEMPORARY TABLE _bst AS
SELECT
    mandant_id,
    art_id,
    COUNT(DISTINCT wup_id) AS anz_markt
FROM `_sonstige_bst` AS X
GROUP BY
    mandant_id,
    art_id;


CREATE OR REPLACE TEMPORARY TABLE _mkt AS
SELECT
    mandant_id,
    art_id,
    COUNT(DISTINCT wup_id) AS anz_markt
FROM `_einzel_markt` AS X
GROUP BY
    mandant_id,
    art_id;


UPDATE dbp_data.sortiment_leistung SET
    anz_maerkte_sst = b.anz_markt
FROM `_sst_org` AS b
WHERE sortiment_leistung.art_id = b.art_id AND sortiment_leistung.kjwo_update IN (
    SELECT MAX(kjwo_update) AS a1290333724

    FROM dbp_data.sortiment_leistung
    WHERE mandant_id = ${mandant_id}
) AND sortiment_leistung.mandant_id = b.mandant_id;


UPDATE dbp_data.sortiment_leistung SET
    anz_maerkte_k_sst = b.anz_markt
FROM `_ksst_org` AS b
WHERE sortiment_leistung.art_id = b.art_id AND sortiment_leistung.kjwo_update IN (
    SELECT MAX(kjwo_update) AS a1290333724

    FROM dbp_data.sortiment_leistung
    WHERE mandant_id = ${mandant_id}
) AND sortiment_leistung.mandant_id = b.mandant_id;


UPDATE dbp_data.sortiment_leistung SET
    anz_maerkte_baustein_sonstige = b.anz_markt
FROM `_bst` AS b
WHERE sortiment_leistung.art_id = b.art_id AND sortiment_leistung.kjwo_update IN (
    SELECT MAX(kjwo_update) AS a1290333724

    FROM dbp_data.sortiment_leistung
    WHERE mandant_id = ${mandant_id}
) AND sortiment_leistung.mandant_id = b.mandant_id;


UPDATE dbp_data.sortiment_leistung SET
    anz_maerkte_listung_einzel = b.anz_markt
FROM `_mkt` AS b
WHERE sortiment_leistung.art_id = b.art_id AND sortiment_leistung.kjwo_update IN (
    SELECT MAX(kjwo_update) AS a1290333724

    FROM dbp_data.sortiment_leistung
    WHERE mandant_id = ${mandant_id}
) AND sortiment_leistung.mandant_id = b.mandant_id;


UPDATE dbp_data.sortiment_leistung SET
    anz_maerkte_listung_gesamt = b.anz_markt
FROM `_gesamt_sicht` AS b
WHERE sortiment_leistung.art_id = b.art_id AND sortiment_leistung.kjwo_update IN (
    SELECT MAX(kjwo_update) AS a1290333724

    FROM dbp_data.sortiment_leistung
    WHERE mandant_id = ${mandant_id}
) AND sortiment_leistung.mandant_id = b.mandant_id;


UPDATE dbp_data.sortiment_leistung SET
    listung_sst_mvke = CAST(FLOOR(b.sm_id) AS STRING) FROM (
    SELECT
        mandant_id,
        art_id,
        MIN(CASE
            WHEN CAST(sm_id AS FLOAT64) = 6
                THEN 5
            ELSE CAST(sm_id AS FLOAT64)
        END) AS sm_id
    FROM dbp_etl_process.art_sm_vw_zu_per
    WHERE
        mandant_id = ${mandant_id}
        AND CURRENT_DATE("Europe/Berlin") BETWEEN dat_von AND dat_bis
    GROUP BY
        mandant_id,
        art_id
) AS b
WHERE
    sortiment_leistung.mandant_id = b.mandant_id AND sortiment_leistung.art_id = b.art_id AND sortiment_leistung.kjwo_update
    IN (
        SELECT MAX(kjwo_update) AS a1290333724
        FROM dbp_data.sortiment_leistung
        WHERE mandant_id = ${mandant_id}
    );


UPDATE dbp_data.sortiment_leistung SET
    listung_k_sst_mvke = TRIM(b.ksm_id) FROM (
    SELECT
        mandant_id,
        art_id,
        MIN(ksm_id) AS ksm_id
    FROM dbp_etl_process.art_sm_vw_zu_per
    WHERE
        mandant_id = ${mandant_id}
        AND CURRENT_DATE("Europe/Berlin") BETWEEN dat_von AND dat_bis
        AND TRIM(ksm_id) IN ('R', 'K1', 'K2', 'K3', 'K4', 'K5', 'K6', 'K7', 'K8', 'K9')
    GROUP BY
        art_id,
        mandant_id
) AS b
WHERE
    sortiment_leistung.mandant_id = b.mandant_id AND sortiment_leistung.art_id = b.art_id AND sortiment_leistung.kjwo_update
    IN (
        SELECT MAX(kjwo_update) AS a1290333724
        FROM dbp_data.sortiment_leistung
        WHERE mandant_id = ${mandant_id}
    );


UPDATE dbp_data.sortiment_leistung SET
    listung_k_sst_mvke = NULL
WHERE kjwo_update IN (
    SELECT MAX(kjwo_update) AS a1290333724
    FROM dbp_data.sortiment_leistung
    WHERE mandant_id = ${mandant_id}) AND mandant_id = ${mandant_id} AND TRIM(listung_k_sst_mvke) NOT IN (
    'R', 'K1',
    'K2', 'K3', 'K4', 'K5', 'K6', 'K7', 'K8', 'K9'
);


UPDATE dbp_data.sortiment_leistung SET
    listung_sst_mvke = NULL
WHERE kjwo_update IN (
    SELECT MAX(kjwo_update) AS a1290333724
    FROM dbp_data.sortiment_leistung
    WHERE mandant_id = ${mandant_id}) AND mandant_id = ${mandant_id} AND TRIM(listung_sst_mvke) NOT IN (
    '-2', '1', '2',
    '3', '4', '5'
);


UPDATE dbp_data.sortiment_leistung SET
    listung_sst_mvke = 'R'
WHERE TRIM(
    listung_sst_mvke) IN ('-2') AND kjwo_update IN (
    SELECT MAX(kjwo_update) AS a1290333724
    FROM dbp_data.sortiment_leistung
    WHERE mandant_id = ${mandant_id}
) AND mandant_id = ${mandant_id};


UPDATE dbp_data.sortiment_leistung SET
    anz_maerkte_sst = 0
WHERE anz_maerkte_sst IS NULL AND kjwo_update IN (
    SELECT MAX(kjwo_update) AS a1290333724
    FROM dbp_data.sortiment_leistung
    WHERE mandant_id = ${mandant_id}
) AND mandant_id = ${mandant_id};


UPDATE dbp_data.sortiment_leistung SET
    anz_maerkte_k_sst = 0
WHERE anz_maerkte_k_sst IS NULL AND kjwo_update IN (
    SELECT MAX(kjwo_update) AS a1290333724
    FROM dbp_data.sortiment_leistung
    WHERE mandant_id = ${mandant_id}
) AND mandant_id = ${mandant_id};


UPDATE dbp_data.sortiment_leistung SET
    anz_maerkte_baustein_sonstige = 0
WHERE anz_maerkte_baustein_sonstige IS NULL AND kjwo_update IN (
    SELECT MAX(kjwo_update) AS a1290333724
    FROM dbp_data.sortiment_leistung
    WHERE mandant_id = ${mandant_id}
) AND mandant_id = ${mandant_id};


UPDATE dbp_data.sortiment_leistung SET
    anz_maerkte_listung_einzel = 0
WHERE anz_maerkte_listung_einzel IS NULL AND kjwo_update IN (
    SELECT MAX(kjwo_update) AS a1290333724
    FROM dbp_data.sortiment_leistung
    WHERE mandant_id = ${mandant_id}
) AND mandant_id = ${mandant_id};


UPDATE dbp_data.sortiment_leistung SET
    anz_maerkte_listung_gesamt = 0
WHERE anz_maerkte_listung_gesamt IS NULL AND kjwo_update IN (
    SELECT MAX(kjwo_update) AS a1290333724
    FROM dbp_data.sortiment_leistung
    WHERE mandant_id = ${mandant_id}
) AND mandant_id = ${mandant_id};


CREATE OR REPLACE TEMPORARY TABLE _murks1 AS
SELECT
    A.mandant_id,
    b.art_id,
    A.wup_id,
    A.wg_id,
    CASE
        WHEN A.sm_id = 6
            THEN 5
        ELSE A.sm_id
    END AS sm_id,
    A.ksm_id
FROM dbp_data.sm_wup_wg_zu_per AS A
INNER JOIN (
    SELECT
        X1.mandant_id,
        X1.art_id,
        X2.wg_id
    FROM dbp_data.sortiment_leistung AS X1
    INNER JOIN dbp_data.art_wg_zu_per AS X2
        ON
            X1.mandant_id = X2.mandant_id AND X1.art_id = X2.art_id AND
            X2.arthiertyp_id = 2 AND X2.dat_bis = DATE '9999-12-31'
    WHERE
        X1.art_id IS NOT NULL
        AND X1.mandant_id = ${mandant_id}
        AND X1.kjwo_update IN (
            SELECT MAX(kjwo_update) AS a1290333724
            FROM dbp_data.sortiment_leistung
            WHERE mandant_id = ${mandant_id}
        )
    GROUP BY
        X1.mandant_id,
        X1.art_id,
        X2.wg_id
) AS b ON A.mandant_id = b.mandant_id AND A.wg_id = b.wg_id
INNER JOIN dbp_data.wup AS C ON A.mandant_id = C.mandant_id AND A.wup_id = C.wup_id AND A.nb_id = C.nb_id

WHERE
    A.mandant_id = ${mandant_id}
    AND A.arthiertyp_id = 2
    AND CURRENT_DATE("Europe/Berlin") BETWEEN A.dat_von AND A.dat_bis
    AND CURRENT_DATE("Europe/Berlin") BETWEEN C.dat_von AND C.dat_bis
    AND (A.sm_id BETWEEN 1 AND 6 OR TRIM(A.ksm_id) IN ('K1', 'K2', 'K3', 'K4', 'K5', 'K6', 'K7', 'K8', 'K9'))
    AND A.nb_id = 0
GROUP BY
    A.mandant_id,
    b.art_id,
    A.wup_id,
    A.wg_id,
    sm_id,
    A.ksm_id;


CREATE OR REPLACE TEMPORARY TABLE _track_ist AS
SELECT
    mandant_id,
    art_id,
    listung_sst_mvke,
    listung_k_sst_mvke
FROM dbp_data.sortiment_leistung AS X1
WHERE
    art_id IS NOT NULL
    AND mandant_id = ${mandant_id}
    AND kjwo_update IN (
        SELECT MAX(kjwo_update) AS a1290333724
        FROM dbp_data.sortiment_leistung
        WHERE mandant_id = ${mandant_id}
    )
GROUP BY
    mandant_id,
    art_id,
    listung_sst_mvke,
    listung_k_sst_mvke;


CREATE OR REPLACE TEMPORARY TABLE _test_sst AS
SELECT
    A.mandant_id,
    A.art_id,
    A.wup_id,
    A.wg_id,
    A.sm_id,
    A.ksm_id
FROM `_murks1` AS A
INNER JOIN `_track_ist` AS B
    ON A.mandant_id = B.mandant_id AND A.art_id = B.art_id AND A.sm_id >= ROUND(
        CAST(B.listung_sst_mvke AS BIGNUMERIC),
        0
    )
WHERE
    B.listung_sst_mvke IS NOT NULL
    AND B.listung_sst_mvke NOT IN ('N/A', 'R');


CREATE OR REPLACE TEMPORARY TABLE _test_ksst AS
SELECT
    A.mandant_id,
    A.art_id,
    A.wup_id,
    A.wg_id,
    A.sm_id,
    A.ksm_id
FROM `_murks1` AS A
INNER JOIN `_track_ist` AS B
    ON A.mandant_id = B.mandant_id AND A.art_id = B.art_id AND ROUND(
        CAST(SUBSTR(TRIM(A.ksm_id), 2, 1) AS BIGNUMERIC),
        0
    ) >= ROUND(CAST(SUBSTR(TRIM(B.listung_k_sst_mvke), 2, 1) AS BIGNUMERIC), 0
    )
WHERE
    B.listung_k_sst_mvke IS NOT NULL
    AND B.listung_k_sst_mvke NOT IN ('N/A', 'R');


CREATE OR REPLACE TEMPORARY TABLE _upd_sst AS
SELECT
    mandant_id,
    art_id,
    COUNT(DISTINCT wup_id) AS anz_markt
FROM `_test_sst`
GROUP BY
    mandant_id,
    art_id;


CREATE OR REPLACE TEMPORARY TABLE _upd_ksst AS
SELECT
    mandant_id,
    art_id,
    COUNT(DISTINCT wup_id) AS anz_markt
FROM `_test_ksst`
GROUP BY
    mandant_id,
    art_id;


UPDATE dbp_data.sortiment_leistung SET
    max_anz_maerkte_sst = b.anz_markt
FROM `_upd_sst` AS b
WHERE
    sortiment_leistung.mandant_id = b.mandant_id AND sortiment_leistung.art_id = b.art_id AND sortiment_leistung.kjwo_update
    IN (
        SELECT MAX(kjwo_update) AS a1290333724
        FROM dbp_data.sortiment_leistung
        WHERE mandant_id = ${mandant_id}
    );


UPDATE dbp_data.sortiment_leistung SET
    max_anz_maerkte_k_sst = b.anz_markt
FROM `_upd_ksst` AS b
WHERE
    sortiment_leistung.mandant_id = b.mandant_id AND sortiment_leistung.art_id = b.art_id AND sortiment_leistung.kjwo_update
    IN (
        SELECT MAX(kjwo_update) AS a1290333724
        FROM dbp_data.sortiment_leistung
        WHERE mandant_id = ${mandant_id}
    );
