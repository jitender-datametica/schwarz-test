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
    A.td_insert
FROM dbp_data.art_list_wup_zu_per_1 AS A
INNER JOIN dbp_data.art_wg_zu_per_1 AS B
    ON
        A.mandant_id = B.mandant_id AND A.art_id = B.art_id AND B.arthiertyp_id
        = 2 AND B.dat_bis = DATE '9999-12-31'
INNER JOIN dbp_data.wup_1 AS C ON A.mandant_id = C.mandant_id AND A.wup_id = C.wup_id
WHERE
    A.mandant_id = 1
    AND B.wg_id IN (
        SELECT wg_id
        FROM dbp_data.wg_filter_zu_1
        WHERE wg_filter_id = 11
    )
    AND CURRENT_DATE("Europe/Berlin") BETWEEN A.dat_von AND A.dat_bis
    AND TRIM(A.list_quelle_id) IN ('1', '3', '7', 'C')
    AND CAST(FLOOR(A.art_id / 100) AS INTEGER) = A.struktur_art_id
    AND A.nb_id = 0
    AND C.nb_id = 0
    AND C.dat_eroeffnung <= CURRENT_DATE("Europe/Berlin");


CREATE OR REPLACE TEMPORARY TABLE _fall1 AS
SELECT B.art_matching_id
FROM dbp_data.art_gp_zu_per_1 AS A
INNER JOIN dbp_etl.art_matching_nielsen_per_1 AS B ON A.mandant_id = B.mandant_id AND A.art_id = B.art_id
WHERE
    A.mandant_id = 1
    AND CURRENT_DATE("Europe/Berlin") BETWEEN A.dat_von AND A.dat_bis
    AND A.herst_id > -2
    AND B.status_1 = 'G'
GROUP BY B.art_matching_id;


CREATE OR REPLACE TEMPORARY TABLE _fall1_update_sst AS
SELECT
    mandant_id,
    art_matching_id,
    COUNT(DISTINCT sm_id) AS anz,
    MIN(sm_id) AS sm_id
FROM (
    SELECT
        A.mandant_id,
        A.art_matching_id,
        A.art_id,
        MIN(D.sm_id) AS sm_id
    FROM dbp_etl.art_matching_nielsen_per_1 AS A
    INNER JOIN `_fall1` AS B ON A.art_matching_id = B.art_matching_id
    INNER JOIN `_art_list_wup_zu_per` AS C
        ON
            A.mandant_id = C.mandant_id AND A.art_id = C.art_id AND TRIM(C.list_quelle_id
            ) = '3'
    INNER JOIN dbp_etl.baustein_tupel_region_zu AS D
        ON
            C.baustein_id = D.baustein_id AND A.mandant_id = D.mandant_id
    WHERE D.sm_id IS NOT NULL
    GROUP BY
        A.mandant_id,
        A.art_matching_id,
        A.art_id
) AS x
GROUP BY
    mandant_id,
    art_matching_id;


CREATE OR REPLACE TEMPORARY TABLE _fall1_update_regio AS
SELECT
    mandant_id,
    art_matching_id,
    MAX(nord_neu) AS nord_neu,
    MAX(west_neu) AS west_neu,
    MAX(ost_basis_neu) AS ost_basis_neu,
    MAX(ost_gross_neu) AS ost_gross_neu,
    MAX(sued_ost_neu) AS sued_ost_neu,
    MAX(sued_west_neu) AS sued_west_neu
FROM (
    SELECT
        A.mandant_id,
        A.art_matching_id,
        A.art_id,
        MAX(CASE
            WHEN TRIM(D.region_1) = 'N'
                THEN 'X'
            ELSE ''
        END) AS nord_neu,
        MAX(CASE
            WHEN TRIM(D.region_1) = 'W'
                THEN 'X'
            ELSE ''
        END) AS west_neu,
        MAX(CASE
            WHEN TRIM(D.region_1) = 'OB'
                THEN 'X'
            ELSE ''
        END) AS ost_basis_neu,
        MAX(CASE
            WHEN TRIM(D.region_1) = 'OG'
                THEN 'X'
            ELSE ''
        END) AS ost_gross_neu,
        MAX(CASE
            WHEN TRIM(D.region_1) = 'SO'
                THEN 'X'
            ELSE ''
        END) AS sued_ost_neu,
        MAX(CASE
            WHEN TRIM(D.region_1) = 'SW'
                THEN 'X'
            ELSE ''
        END) AS sued_west_neu
    FROM dbp_etl.art_matching_nielsen_per_1 AS A
    INNER JOIN `_fall1` AS B ON A.art_matching_id = B.art_matching_id
    INNER JOIN `_art_list_wup_zu_per` AS C
        ON
            A.mandant_id = C.mandant_id AND A.art_id = C.art_id AND TRIM(C.list_quelle_id
            ) = '3'
    INNER JOIN dbp_etl.baustein_tupel_region_zu AS D
        ON
            C.baustein_id = D.baustein_id AND A.mandant_id = D.mandant_id
    WHERE
        D.sm_id IS NULL
        AND D.sm_id_sst IS NULL
    GROUP BY
        A.mandant_id,
        A.art_matching_id,
        A.art_id
) AS x
GROUP BY
    mandant_id,
    art_matching_id;


CREATE OR REPLACE TEMPORARY TABLE _fall1_sst_regio AS
SELECT
    C.mandant_id,
    A.art_matching_id,
    C.wup_id
FROM dbp_etl.art_matching_nielsen_per_1 AS A
INNER JOIN `_fall1` AS B ON A.art_matching_id = B.art_matching_id
INNER JOIN `_art_list_wup_zu_per` AS C ON A.mandant_id = C.mandant_id AND A.art_id = C.art_id
INNER JOIN dbp_data.wup_1 AS D ON C.mandant_id = D.mandant_id AND C.wup_id = D.wup_id
WHERE
    TRIM(C.list_quelle_id) IN ('3')
    AND D.nb_id = 0
    AND D.dat_eroeffnung < CURRENT_DATE("Europe/Berlin")
    AND C.baustein_id IN (
        SELECT baustein_id
        FROM dbp_etl.baustein_tupel_region_zu
    )
GROUP BY
    C.mandant_id,
    A.art_matching_id,
    C.wup_id;


CREATE OR REPLACE TEMPORARY TABLE _fall1_sonstige_bst AS
SELECT
    C.mandant_id,
    A.art_matching_id,
    C.wup_id
FROM dbp_etl.art_matching_nielsen_per_1 AS A
INNER JOIN `_fall1` AS B ON A.art_matching_id = B.art_matching_id
INNER JOIN `_art_list_wup_zu_per` AS C ON A.mandant_id = C.mandant_id AND A.art_id = C.art_id
INNER JOIN dbp_data.wup_1 AS D ON C.mandant_id = D.mandant_id AND C.wup_id = D.wup_id
WHERE
    TRIM(C.list_quelle_id) IN ('3')
    AND C.baustein_id IN (
        SELECT baustein_id
        FROM dbp_etl.baustein_wsop_1
        WHERE CURRENT_DATE("Europe/Berlin") BETWEEN dat_von AND dat_bis
    )
    AND D.nb_id = 0
    AND D.dat_eroeffnung < CURRENT_DATE("Europe/Berlin")
    AND C.baustein_id NOT IN (
        SELECT baustein_id
        FROM dbp_etl.baustein_tupel_region_zu
    )
GROUP BY
    C.mandant_id,
    A.art_matching_id,
    C.wup_id;


CREATE OR REPLACE TEMPORARY TABLE _fall1_einzel_markt AS
SELECT
    C.mandant_id,
    A.art_matching_id,
    C.wup_id
FROM dbp_etl.art_matching_nielsen_per_1 AS A
INNER JOIN `_fall1` AS B ON A.art_matching_id = B.art_matching_id
INNER JOIN `_art_list_wup_zu_per` AS C ON A.mandant_id = C.mandant_id AND A.art_id = C.art_id
INNER JOIN dbp_data.wup_1 AS D ON C.mandant_id = D.mandant_id AND C.wup_id = D.wup_id
WHERE
    TRIM(C.list_quelle_id) IN ('C')
    AND D.nb_id = 0
    AND D.dat_eroeffnung < CURRENT_DATE("Europe/Berlin")
GROUP BY
    C.mandant_id,
    A.art_matching_id,
    C.wup_id;


CREATE OR REPLACE TEMPORARY TABLE _fall1_gesamt_sicht AS
SELECT
    mandant_id,
    art_matching_id,
    COUNT(DISTINCT wup_id) AS anz_markt
FROM (
    SELECT *
    FROM `_fall1_sst_regio`
    UNION ALL
    SELECT *
    FROM `_fall1_sonstige_bst`
    UNION ALL
    SELECT *
    FROM `_fall1_einzel_markt`
) AS x
GROUP BY
    mandant_id,
    art_matching_id;


CREATE OR REPLACE TEMPORARY TABLE _fall1_sst AS
SELECT
    mandant_id,
    art_matching_id,
    COUNT(DISTINCT wup_id) AS anz_markt
FROM `_fall1_sst_regio` AS X
GROUP BY
    mandant_id,
    art_matching_id;


CREATE OR REPLACE TEMPORARY TABLE _fall1_bst AS
SELECT
    mandant_id,
    art_matching_id,
    COUNT(DISTINCT wup_id) AS anz_markt
FROM `_fall1_sonstige_bst` AS X
GROUP BY
    mandant_id,
    art_matching_id;


CREATE OR REPLACE TEMPORARY TABLE _fall1_mkt AS
SELECT
    mandant_id,
    art_matching_id,
    COUNT(DISTINCT wup_id) AS anz_markt
FROM `_fall1_einzel_markt` AS X
GROUP BY
    mandant_id,
    art_matching_id;


UPDATE dbp_data.sortiment_leistung_1 SET
    anz_maerkte_sst = b.anz_markt
FROM `_fall1_sst` AS b
WHERE
    sortiment_leistung.matching_id = b.art_matching_id AND sortiment_leistung.mandant_id = 1 AND sortiment_leistung.kjwo_update
    IN (
        SELECT MAX(kjwo_update) AS a1290333724
        FROM dbp_data.sortiment_leistung_1
        WHERE mandant_id = 1
    );


UPDATE dbp_data.sortiment_leistung_1 SET
    anz_maerkte_baustein_sonstige = b.anz_markt
FROM `_fall1_bst` AS b
WHERE
    sortiment_leistung.matching_id = b.art_matching_id AND sortiment_leistung.mandant_id = 1 AND sortiment_leistung.kjwo_update
    IN (
        SELECT MAX(kjwo_update) AS a1290333724
        FROM dbp_data.sortiment_leistung_1
        WHERE mandant_id = 1
    );


UPDATE dbp_data.sortiment_leistung_1 SET
    anz_maerkte_listung_einzel = b.anz_markt
FROM `_fall1_mkt` AS b
WHERE
    sortiment_leistung.matching_id = b.art_matching_id AND sortiment_leistung.mandant_id = 1 AND sortiment_leistung.kjwo_update
    IN (
        SELECT MAX(kjwo_update) AS a1290333724
        FROM dbp_data.sortiment_leistung_1
        WHERE mandant_id = 1
    );


UPDATE dbp_data.sortiment_leistung_1 SET
    anz_maerkte_listung_gesamt = b.anz_markt
FROM `_fall1_gesamt_sicht` AS b
WHERE
    sortiment_leistung.matching_id = b.art_matching_id AND sortiment_leistung.mandant_id = 1 AND sortiment_leistung.kjwo_update
    IN (
        SELECT MAX(kjwo_update) AS a1290333724
        FROM dbp_data.sortiment_leistung_1
        WHERE mandant_id = 1
    );


UPDATE dbp_data.sortiment_leistung_1 SET
    listung_sst_mvke = CAST(b.sm_id AS STRING)
FROM `_fall1_update_sst` AS b
WHERE
    sortiment_leistung.mandant_id = b.mandant_id AND sortiment_leistung.matching_id = b.art_matching_id AND
    sortiment_leistung.mandant_id = 1 AND sortiment_leistung.kjwo_update IN (
        SELECT MAX(kjwo_update) AS a1290333724
        FROM dbp_data.sortiment_leistung_1
        WHERE mandant_id = 1
    );


UPDATE dbp_data.sortiment_leistung_1 SET
    nord = x.nord_neu,
    west = x.west_neu,
    ost_basis = x.ost_basis_neu,
    ost_gross = x.ost_gross_neu,
    sued_ost = x.sued_ost_neu,
    sued_west = x.sued_west_neu
FROM `_fall1_update_regio` AS x
WHERE
    sortiment_leistung.mandant_id = x.mandant_id AND sortiment_leistung.matching_id = x.art_matching_id AND
    sortiment_leistung.mandant_id = 1 AND sortiment_leistung.kjwo_update IN (
        SELECT MAX(kjwo_update) AS a1290333724
        FROM dbp_data.sortiment_leistung_1
        WHERE mandant_id = 1
    );


CREATE OR REPLACE TEMPORARY TABLE _fall2 AS
SELECT B.art_matching_id
FROM dbp_data.art_gp_zu_per_1 AS A
INNER JOIN dbp_etl.art_matching_nielsen_per_1 AS B ON A.mandant_id = B.mandant_id AND A.art_id = B.art_id
INNER JOIN (SELECT
    mandant_id,
    art_matching_id
FROM (
    SELECT
        mandant_id,
        art_matching_id,
        umrech_faktor,
        COUNT(*) AS anzahl
    FROM dbp_etl.art_matching_nielsen_per_1
    WHERE status_1 = 'G'
    GROUP BY
        mandant_id,
        art_matching_id,
        umrech_faktor
) AS x
GROUP BY
    mandant_id,
    art_matching_id
HAVING MAX(anzahl) = 1) AS c ON B.mandant_id = c.mandant_id AND B.art_matching_id = c.art_matching_id
WHERE
    A.mandant_id = 1
    AND CURRENT_DATE("Europe/Berlin") BETWEEN A.dat_von AND A.dat_bis
    AND B.status_1 = 'G'
GROUP BY B.art_matching_id
HAVING MAX(A.herst_id) = -2;


CREATE OR REPLACE TEMPORARY TABLE _fall2_update_sst AS
SELECT
    mandant_id,
    art_matching_id,
    COUNT(DISTINCT sm_id) AS anz,
    MIN(sm_id) AS sm_id
FROM (
    SELECT
        A.mandant_id,
        A.art_matching_id,
        A.art_id,
        MIN(C.sm_id) AS sm_id
    FROM dbp_etl.art_matching_nielsen_per_1 AS A
    INNER JOIN `_fall2` AS B ON A.art_matching_id = B.art_matching_id
    INNER JOIN dbp_etl_process.art_sm_vw_zu_per_1 AS C ON A.mandant_id = C.mandant_id AND A.art_id = C.art_id

    WHERE
        C.mandant_id = 1
        AND CURRENT_DATE("Europe/Berlin") BETWEEN C.dat_von AND C.dat_bis
    GROUP BY
        A.mandant_id,
        A.art_matching_id,
        A.art_id
) AS x
GROUP BY
    mandant_id,
    art_matching_id;


CREATE OR REPLACE TEMPORARY TABLE _fall2_update_regio AS
SELECT
    mandant_id,
    art_matching_id,
    MIN(nord_neu) AS nord_neu,
    MIN(west_neu) AS west_neu,
    MIN(ost_basis_neu) AS ost_basis_neu,
    MIN(ost_gross_neu) AS ost_gross_neu,
    MIN(sued_ost_neu) AS sued_ost_neu,
    MIN(sued_west_neu) AS sued_west_neu
FROM (
    SELECT
        A.mandant_id,
        A.art_matching_id,
        A.art_id,
        MAX(CASE
            WHEN TRIM(E.region_1) = 'N'
                THEN 'X'
            ELSE ''
        END) AS nord_neu,
        MAX(CASE
            WHEN TRIM(E.region_1) = 'W'
                THEN 'X'
            ELSE ''
        END) AS west_neu,
        MAX(CASE
            WHEN TRIM(E.region_1) = 'OB'
                THEN 'X'
            ELSE ''
        END) AS ost_basis_neu,
        MAX(CASE
            WHEN TRIM(E.region_1) = 'OG'
                THEN 'X'
            ELSE ''
        END) AS ost_gross_neu,
        MAX(CASE
            WHEN TRIM(E.region_1) = 'SO'
                THEN 'X'
            ELSE ''
        END) AS sued_ost_neu,
        MAX(CASE
            WHEN TRIM(E.region_1) = 'SW'
                THEN 'X'
            ELSE ''
        END) AS sued_west_neu
    FROM dbp_etl.art_matching_nielsen_per_1 AS A
    INNER JOIN `_fall2` AS B ON A.art_matching_id = B.art_matching_id
    INNER JOIN `_art_list_wup_zu_per` AS C
        ON
            A.mandant_id = C.mandant_id AND A.art_id = C.art_id AND TRIM(C.list_quelle_id
            ) = '3'
    INNER JOIN dbp_etl.baustein_wsop_1 AS D
        ON
            A.mandant_id = D.mandant_id AND C.baustein_id = D.baustein_id
            AND C.art_id = D.art_id
    INNER JOIN dbp_etl.baustein_region_zu_1 AS E ON A.mandant_id = E.mandant_id AND D.baustein_id = E.baustein_id

    WHERE CURRENT_DATE("Europe/Berlin") BETWEEN D.dat_von AND D.dat_bis
    GROUP BY
        A.mandant_id,
        A.art_matching_id,
        A.art_id
) AS x
GROUP BY
    mandant_id,
    art_matching_id;


CREATE OR REPLACE TEMPORARY TABLE _fall2_sst_regio AS
(
    SELECT
        C.mandant_id,
        A.art_matching_id,
        C.wup_id
    FROM dbp_etl.art_matching_nielsen_per_1 AS A
    INNER JOIN `_fall2` AS B ON A.art_matching_id = B.art_matching_id
    INNER JOIN `_art_list_wup_zu_per` AS C ON A.mandant_id = C.mandant_id AND A.art_id = C.art_id
    INNER JOIN dbp_data.wup_1 AS D ON C.mandant_id = D.mandant_id AND C.wup_id = D.wup_id
    WHERE
        TRIM(C.list_quelle_id) IN ('1', '7')
        AND D.nb_id = 0
        AND D.dat_eroeffnung < CURRENT_DATE("Europe/Berlin")
    GROUP BY
        A.art_matching_id,
        C.wup_id,
        C.mandant_id
    UNION DISTINCT
    SELECT
        C.mandant_id,
        A.art_matching_id,
        C.wup_id
    FROM dbp_etl.art_matching_nielsen_per_1 AS A
    INNER JOIN `_fall2` AS B ON A.art_matching_id = B.art_matching_id
    INNER JOIN `_art_list_wup_zu_per` AS C ON A.mandant_id = C.mandant_id AND A.art_id = C.art_id
    INNER JOIN dbp_data.wup_1 AS D ON C.mandant_id = D.mandant_id AND C.wup_id = D.wup_id
    WHERE
        TRIM(C.list_quelle_id) IN ('3')
        AND D.nb_id = 0
        AND D.dat_eroeffnung < CURRENT_DATE("Europe/Berlin")
        AND C.baustein_id NOT IN (
            SELECT baustein_id
            FROM dbp_etl.baustein_wsop_1
            WHERE CURRENT_DATE("Europe/Berlin") BETWEEN dat_von AND dat_bis
        )
    GROUP BY
        A.art_matching_id,
        C.wup_id,
        C.mandant_id
)
UNION DISTINCT
SELECT
    C.mandant_id,
    A.art_matching_id,
    C.wup_id
FROM dbp_etl.art_matching_nielsen_per_1 AS A
INNER JOIN `_fall2` AS B ON A.art_matching_id = B.art_matching_id
INNER JOIN `_art_list_wup_zu_per` AS C ON A.mandant_id = C.mandant_id AND A.art_id = C.art_id
INNER JOIN dbp_data.wup_1 AS D ON C.mandant_id = D.mandant_id AND C.wup_id = D.wup_id
WHERE
    TRIM(C.list_quelle_id) IN ('3')
    AND C.baustein_id IN (
        SELECT baustein_id
        FROM dbp_etl.baustein_region_zu_1
    )
    AND D.nb_id = 0
    AND D.dat_eroeffnung < CURRENT_DATE("Europe/Berlin")
GROUP BY
    A.art_matching_id,
    C.wup_id,
    C.mandant_id;


CREATE OR REPLACE TEMPORARY TABLE _fall2_sonstige_bst AS
SELECT
    C.mandant_id,
    A.art_matching_id,
    C.wup_id
FROM dbp_etl.art_matching_nielsen_per_1 AS A
INNER JOIN `_fall2` AS B ON A.art_matching_id = B.art_matching_id
INNER JOIN `_art_list_wup_zu_per` AS C ON A.mandant_id = C.mandant_id AND A.art_id = C.art_id
INNER JOIN dbp_data.wup_1 AS D ON C.mandant_id = D.mandant_id AND C.wup_id = D.wup_id
WHERE
    TRIM(C.list_quelle_id) IN ('3')
    AND C.baustein_id IN (
        SELECT baustein_id
        FROM dbp_etl.baustein_wsop_1
        WHERE CURRENT_DATE("Europe/Berlin") BETWEEN dat_von AND dat_bis
    )
    AND D.nb_id = 0
    AND D.dat_eroeffnung < CURRENT_DATE("Europe/Berlin")
    AND C.baustein_id NOT IN (
        SELECT baustein_id
        FROM dbp_etl.baustein_region_zu_1
    )
GROUP BY
    C.mandant_id,
    A.art_matching_id,
    C.wup_id;


CREATE OR REPLACE TEMPORARY TABLE _fall2_einzel_markt AS
SELECT
    C.mandant_id,
    A.art_matching_id,
    C.wup_id
FROM dbp_etl.art_matching_nielsen_per_1 AS A
INNER JOIN `_fall2` AS B ON A.art_matching_id = B.art_matching_id
INNER JOIN `_art_list_wup_zu_per` AS C ON A.mandant_id = C.mandant_id AND A.art_id = C.art_id
INNER JOIN dbp_data.wup_1 AS D ON C.mandant_id = D.mandant_id AND C.wup_id = D.wup_id
WHERE
    TRIM(C.list_quelle_id) IN ('C')
    AND D.nb_id = 0
    AND D.dat_eroeffnung < CURRENT_DATE("Europe/Berlin")
GROUP BY
    C.mandant_id,
    A.art_matching_id,
    C.wup_id;


CREATE OR REPLACE TEMPORARY TABLE _fall2_gesamt_sicht AS
SELECT
    mandant_id,
    art_matching_id,
    COUNT(DISTINCT wup_id) AS anz_markt
FROM (
    SELECT *
    FROM `_fall2_sst_regio`
    UNION ALL
    SELECT *
    FROM `_fall2_sonstige_bst`
    UNION ALL
    SELECT *
    FROM `_fall2_einzel_markt`
) AS x
GROUP BY
    mandant_id,
    art_matching_id;


CREATE OR REPLACE TEMPORARY TABLE _fall2_sst AS
SELECT
    mandant_id,
    art_matching_id,
    COUNT(DISTINCT wup_id) AS anz_markt
FROM `_fall2_sst_regio` AS X
GROUP BY
    mandant_id,
    art_matching_id;


CREATE OR REPLACE TEMPORARY TABLE _fall2_bst AS
SELECT
    mandant_id,
    art_matching_id,
    COUNT(DISTINCT wup_id) AS anz_markt
FROM `_fall2_sonstige_bst` AS X
GROUP BY
    mandant_id,
    art_matching_id;


CREATE OR REPLACE TEMPORARY TABLE _fall2_mkt AS
SELECT
    mandant_id,
    art_matching_id,
    COUNT(DISTINCT wup_id) AS anz_markt
FROM `_fall2_einzel_markt` AS X
GROUP BY
    mandant_id,
    art_matching_id;


UPDATE dbp_data.sortiment_leistung_1 SET
    anz_maerkte_sst = b.anz_markt
FROM `_fall2_sst` AS b
WHERE
    sortiment_leistung.matching_id = b.art_matching_id AND sortiment_leistung.mandant_id = 1 AND sortiment_leistung.kjwo_update
    IN (
        SELECT MAX(kjwo_update) AS a1290333724
        FROM dbp_data.sortiment_leistung_1
        WHERE mandant_id = 1
    );


UPDATE dbp_data.sortiment_leistung_1 SET
    anz_maerkte_baustein_sonstige = b.anz_markt
FROM `_fall2_bst` AS b
WHERE
    sortiment_leistung.matching_id = b.art_matching_id AND sortiment_leistung.mandant_id = 1 AND sortiment_leistung.kjwo_update
    IN (
        SELECT MAX(kjwo_update) AS a1290333724
        FROM dbp_data.sortiment_leistung_1
        WHERE mandant_id = 1
    );


UPDATE dbp_data.sortiment_leistung_1 SET
    anz_maerkte_listung_einzel = b.anz_markt
FROM `_fall2_mkt` AS b
WHERE
    sortiment_leistung.matching_id = b.art_matching_id AND sortiment_leistung.mandant_id = 1 AND sortiment_leistung.kjwo_update
    IN (
        SELECT MAX(kjwo_update) AS a1290333724
        FROM dbp_data.sortiment_leistung_1
        WHERE mandant_id = 1
    );


UPDATE dbp_data.sortiment_leistung_1 SET
    anz_maerkte_listung_gesamt = b.anz_markt
FROM `_fall2_gesamt_sicht` AS b
WHERE
    sortiment_leistung.matching_id = b.art_matching_id AND sortiment_leistung.mandant_id = 1 AND sortiment_leistung.kjwo_update
    IN (
        SELECT MAX(kjwo_update) AS a1290333724
        FROM dbp_data.sortiment_leistung_1
        WHERE mandant_id = 1
    );


UPDATE dbp_data.sortiment_leistung_1 SET
    listung_sst_mvke = CAST(b.sm_id AS STRING)
FROM `_fall2_update_sst` AS b
WHERE
    sortiment_leistung.mandant_id = b.mandant_id AND sortiment_leistung.matching_id = b.art_matching_id AND
    sortiment_leistung.mandant_id = 1 AND sortiment_leistung.kjwo_update IN (
        SELECT MAX(kjwo_update) AS a1290333724
        FROM dbp_data.sortiment_leistung_1
        WHERE mandant_id = 1
    );


UPDATE dbp_data.sortiment_leistung_1 SET
    nord = x.nord_neu,
    west = x.west_neu,
    ost_basis = x.ost_basis_neu,
    ost_gross = x.ost_gross_neu,
    sued_ost = x.sued_ost_neu,
    sued_west = x.sued_west_neu
FROM `_fall2_update_regio` AS x
WHERE
    sortiment_leistung.mandant_id = x.mandant_id AND sortiment_leistung.matching_id = x.art_matching_id AND
    sortiment_leistung.mandant_id = 1 AND sortiment_leistung.kjwo_update IN (
        SELECT MAX(kjwo_update) AS a1290333724
        FROM dbp_data.sortiment_leistung_1
        WHERE mandant_id = 1
    );


CREATE OR REPLACE TEMPORARY TABLE _fall3 AS
SELECT B.art_matching_id
FROM dbp_data.art_gp_zu_per_1 AS A
INNER JOIN dbp_etl.art_matching_nielsen_per_1 AS B ON A.mandant_id = B.mandant_id AND A.art_id = B.art_id
INNER JOIN (SELECT
    mandant_id,
    art_matching_id
FROM (
    SELECT
        mandant_id,
        art_matching_id,
        umrech_faktor,
        COUNT(*) AS anzahl
    FROM dbp_etl.art_matching_nielsen_per_1
    WHERE status_1 = 'G'
    GROUP BY
        mandant_id,
        art_matching_id,
        umrech_faktor
) AS x
GROUP BY
    mandant_id,
    art_matching_id
HAVING MAX(anzahl) > 1) AS c ON B.mandant_id = c.mandant_id AND B.art_matching_id = c.art_matching_id
WHERE
    A.mandant_id = 1
    AND CURRENT_DATE("Europe/Berlin") BETWEEN A.dat_von AND A.dat_bis
    AND B.status_1 = 'G'
GROUP BY B.art_matching_id
HAVING MAX(A.herst_id) = -2;


CREATE OR REPLACE TEMPORARY TABLE _fall3_upd_sst1 AS
SELECT
    A.mandant_id,
    A.art_matching_id,
    A.art_id,
    E.wg_id,
    C.wup_id,
    F.kreistyp_gruppe_id,
    E.sm_id
FROM dbp_etl.art_matching_nielsen_per_1 AS A
INNER JOIN `_fall3` AS B ON A.art_matching_id = B.art_matching_id
INNER JOIN `_art_list_wup_zu_per` AS C ON A.mandant_id = C.mandant_id AND A.art_id = C.art_id
INNER JOIN dbp_data.art_wg_zu_per_1 AS D
    ON
        A.mandant_id = D.mandant_id AND A.art_id = D.art_id AND D.arthiertyp_id
        = 2 AND D.dat_bis = DATE '9999-12-31'
INNER JOIN dbp_data.sm_wup_wg_zu_per_1 AS E
    ON
        A.mandant_id = E.mandant_id AND D.wg_id = E.wg_id AND C.wup_id
        = E.wup_id
INNER JOIN dbp_data.wup_1 AS F
    ON
        A.mandant_id = F.mandant_id AND E.wup_id = F.wup_id AND F.dat_bis =
        DATE '9999-12-31'
WHERE
    A.mandant_id = 1
    AND E.spr_id = 22
    AND E.arthiertyp_id = 2
    AND CURRENT_DATE("Europe/Berlin") BETWEEN E.dat_von AND E.dat_bis
    AND E.sm_id BETWEEN 1 AND 5
    AND F.nb_id = 0
    AND F.dat_von <= CURRENT_DATE("Europe/Berlin")
GROUP BY
    A.mandant_id,
    A.art_matching_id,
    A.art_id,
    E.wg_id,
    C.wup_id,
    F.kreistyp_gruppe_id,
    E.sm_id;


CREATE OR REPLACE TEMPORARY TABLE _fall3_upd_sst2 AS
SELECT
    A.mandant_id,
    A.art_matching_id,
    A.art_id,
    E.wg_id,
    E.wup_id,
    F.kreistyp_gruppe_id,
    E.sm_id
FROM dbp_etl.art_matching_nielsen_per_1 AS A
INNER JOIN `_fall3` AS B ON A.art_matching_id = B.art_matching_id
INNER JOIN dbp_data.art_wg_zu_per_1 AS D
    ON
        A.mandant_id = D.mandant_id AND A.art_id = D.art_id AND D.arthiertyp_id
        = 2 AND D.dat_bis = DATE '9999-12-31'
INNER JOIN dbp_data.sm_wup_wg_zu_per_1 AS E ON A.mandant_id = E.mandant_id AND D.wg_id = E.wg_id
INNER JOIN dbp_data.wup_1 AS F
    ON
        A.mandant_id = F.mandant_id AND E.wup_id = F.wup_id AND F.dat_bis =
        DATE '9999-12-31'
WHERE
    A.mandant_id = 1
    AND E.spr_id = 22
    AND E.arthiertyp_id = 2
    AND CURRENT_DATE("Europe/Berlin") BETWEEN E.dat_von AND E.dat_bis
    AND E.sm_id BETWEEN 1 AND 5
    AND F.nb_id = 0
    AND F.dat_von <= CURRENT_DATE("Europe/Berlin")
GROUP BY
    A.mandant_id,
    A.art_matching_id,
    A.art_id,
    E.wg_id,
    E.wup_id,
    F.kreistyp_gruppe_id,
    E.sm_id;


CREATE OR REPLACE TEMPORARY TABLE _fall3_ist_listung AS
SELECT
    mandant_id,
    art_matching_id,
    wg_id,
    sm_id,
    wup_id
FROM `_fall3_upd_sst1`
GROUP BY
    mandant_id,
    art_matching_id,
    wg_id,
    sm_id,
    wup_id;


CREATE OR REPLACE TEMPORARY TABLE _fall3_soll_listung AS
SELECT
    mandant_id,
    art_matching_id,
    wg_id,
    sm_id,
    wup_id
FROM `_fall3_upd_sst2`
GROUP BY
    mandant_id,
    art_matching_id,
    wg_id,
    sm_id,
    wup_id;


CREATE OR REPLACE TEMPORARY TABLE _fall3_update_sst AS
SELECT
    a.mandant_id,
    a.art_matching_id,
    MIN(a.sm_id) AS sm_id
FROM (
    SELECT
        mandant_id,
        art_matching_id,
        sm_id,
        COUNT(DISTINCT wup_id) AS anz_ist
    FROM `_fall3_ist_listung`
    GROUP BY
        mandant_id,
        art_matching_id,
        sm_id
) AS a
INNER JOIN (
    SELECT
        mandant_id,
        art_matching_id,
        sm_id,
        COUNT(DISTINCT wup_id) AS anz_soll
    FROM `_fall3_soll_listung`
    GROUP BY
        mandant_id,
        art_matching_id,
        sm_id
) AS b
    ON
        a.mandant_id = b.mandant_id AND a.art_matching_id = b.art_matching_id AND a.sm_id = b.sm_id AND a.anz_ist
        = b.anz_soll
GROUP BY
    a.mandant_id,
    a.art_matching_id;


INSERT INTO `_fall3_update_sst`
(
    SELECT
        mandant_id,
        art_matching_id,
        CAST(NULL AS INTEGER) AS sm_id
    FROM `_fall3_ist_listung`
    WHERE
        art_matching_id NOT IN (
            SELECT art_matching_id
            FROM `_fall3_update_sst`
        )
    GROUP BY
        mandant_id,
        art_matching_id,
        sm_id
);


CREATE OR REPLACE TEMPORARY TABLE _fall3_ist_listung_region AS
SELECT
    A.mandant_id,
    A.art_matching_id,
    A.kreistyp_gruppe_id,
    A.wup_id
FROM `_fall3_upd_sst1` AS A
INNER JOIN (
    SELECT *
    FROM `_fall3_update_sst`
    WHERE
        sm_id IS NULL
        OR sm_id <> 1
) AS b
    ON A.mandant_id = b.mandant_id AND A.art_matching_id = b.art_matching_id
GROUP BY
    A.mandant_id,
    A.art_matching_id,
    A.kreistyp_gruppe_id,
    A.wup_id;


CREATE OR REPLACE TEMPORARY TABLE _fall3_soll_listung_region AS
SELECT
    A.mandant_id,
    A.art_matching_id,
    A.kreistyp_gruppe_id,
    A.wup_id
FROM `_fall3_upd_sst2` AS A
INNER JOIN (
    SELECT *
    FROM `_fall3_update_sst`
    WHERE
        sm_id IS NULL
        OR sm_id <> 1
) AS b
    ON A.mandant_id = b.mandant_id AND A.art_matching_id = b.art_matching_id
GROUP BY
    A.mandant_id,
    A.art_matching_id,
    A.kreistyp_gruppe_id,
    A.wup_id;


CREATE OR REPLACE TEMPORARY TABLE _fall3_update_sst_region AS
SELECT
    a.mandant_id,
    a.art_matching_id,
    a.kreistyp_gruppe_id
FROM (
    SELECT
        mandant_id,
        art_matching_id,
        kreistyp_gruppe_id,
        COUNT(DISTINCT wup_id) AS anz_ist
    FROM `_fall3_ist_listung_region`
    GROUP BY
        mandant_id,
        art_matching_id,
        kreistyp_gruppe_id
) AS a
INNER JOIN (
    SELECT
        mandant_id,
        kreistyp_gruppe_id,
        COUNT(DISTINCT wup_id) AS anz_soll
    FROM dbp_data.wup_1
    WHERE
        mandant_id = 1
        AND nb_id = 0
        AND dat_bis = DATE '9999-12-31'
        AND kreistyp_gruppe_id IS NOT NULL
    GROUP BY
        mandant_id,
        kreistyp_gruppe_id
) AS b
    ON
        a.mandant_id = b.mandant_id AND a.kreistyp_gruppe_id = b.kreistyp_gruppe_id AND a.anz_ist
        = b.anz_soll
GROUP BY
    a.mandant_id,
    a.art_matching_id,
    a.kreistyp_gruppe_id;


CREATE OR REPLACE TEMPORARY TABLE _fall3_update_regio AS
SELECT
    mandant_id,
    art_matching_id,
    MAX(CASE
        WHEN TRIM(kreistyp_gruppe_id) = 'N'
            THEN 'X'
        ELSE ''
    END) AS nord_pflege_neu,
    MAX(CASE
        WHEN TRIM(kreistyp_gruppe_id) = 'W'
            THEN 'X'
        ELSE ''
    END) AS west_pflege_neu,
    MAX(CASE
        WHEN TRIM(kreistyp_gruppe_id) = 'O'
            THEN 'X'
        ELSE ''
    END) AS ost_basis_pflege_neu,
    MAX(CASE
        WHEN TRIM(kreistyp_gruppe_id) = 'Q'
            THEN 'X'
        ELSE ''
    END) AS ost_gross_pflege_neu,
    MAX(CASE
        WHEN TRIM(kreistyp_gruppe_id) = 'G'
            THEN 'X'
        ELSE ''
    END) AS sued_ost_pflege_neu,
    MAX(CASE
        WHEN TRIM(kreistyp_gruppe_id) = 'M'
            THEN 'X'
        ELSE ''
    END) AS sued_west_pflege_neu
FROM `_fall3_update_sst_region`
GROUP BY
    mandant_id,
    art_matching_id;


CREATE OR REPLACE TEMPORARY TABLE _fall3_sst_regio AS
SELECT
    mandant_id,
    art_matching_id,
    COUNT(DISTINCT wup_id) AS anz
FROM (SELECT
    mandant_id,
    art_matching_id,
    wup_id
FROM `_fall3_ist_listung`
WHERE (
    mandant_id, art_matching_id) IN (
    SELECT (mandant_id, art_matching_id)
    FROM `_fall3_update_sst`
    WHERE sm_id IS NOT NULL
)
UNION ALL
SELECT
    mandant_id,
    art_matching_id,
    wup_id
FROM `_fall3_ist_listung_region`
WHERE (
    mandant_id, art_matching_id) IN (
    SELECT (mandant_id, art_matching_id)
    FROM `_fall3_update_sst_region`
)) AS x
GROUP BY
    mandant_id,
    art_matching_id;


CREATE OR REPLACE TEMPORARY TABLE _fall3_gesamt_sicht AS
SELECT
    mandant_id,
    art_matching_id,
    COUNT(DISTINCT wup_id) AS anz_markt
FROM `_fall3_ist_listung` AS x
GROUP BY
    mandant_id,
    art_matching_id;


UPDATE dbp_data.sortiment_leistung_1 SET
    anz_maerkte_sst = b.anz
FROM `_fall3_sst_regio` AS b
WHERE
    sortiment_leistung.matching_id = b.art_matching_id AND sortiment_leistung.mandant_id = 1 AND sortiment_leistung.kjwo_update
    IN (
        SELECT MAX(kjwo_update) AS a1290333724
        FROM dbp_data.sortiment_leistung_1
        WHERE mandant_id = 1
    );


UPDATE dbp_data.sortiment_leistung_1 SET
    anz_maerkte_listung_gesamt = b.anz_markt
FROM `_fall3_gesamt_sicht` AS b
WHERE
    sortiment_leistung.matching_id = b.art_matching_id AND sortiment_leistung.mandant_id = 1 AND sortiment_leistung.kjwo_update
    IN (
        SELECT MAX(kjwo_update) AS a1290333724
        FROM dbp_data.sortiment_leistung_1
        WHERE mandant_id = 1
    );


UPDATE dbp_data.sortiment_leistung_1 SET
    listung_sst_mvke = CAST(b.sm_id AS STRING)
FROM `_fall3_update_sst` AS b
WHERE
    sortiment_leistung.mandant_id = b.mandant_id AND sortiment_leistung.matching_id = b.art_matching_id AND
    sortiment_leistung.mandant_id = 1 AND sortiment_leistung.kjwo_update IN (
        SELECT MAX(kjwo_update) AS a1290333724
        FROM dbp_data.sortiment_leistung_1
        WHERE mandant_id = 1
    );


UPDATE dbp_data.sortiment_leistung_1 SET
    nord = x.nord_pflege_neu,
    west = x.west_pflege_neu,
    ost_basis = x.ost_basis_pflege_neu,
    ost_gross = x.ost_gross_pflege_neu,
    sued_ost = x.sued_ost_pflege_neu,
    sued_west = x.sued_west_pflege_neu
FROM `_fall3_update_regio` AS x
WHERE
    sortiment_leistung.mandant_id = x.mandant_id AND sortiment_leistung.matching_id = x.art_matching_id AND
    sortiment_leistung.mandant_id = 1 AND sortiment_leistung.kjwo_update IN (
        SELECT MAX(kjwo_update) AS a1290333724
        FROM dbp_data.sortiment_leistung_1
        WHERE mandant_id = 1
    );


CREATE OR REPLACE TEMPORARY TABLE _fall4 AS
SELECT art_matching_id
FROM dbp_etl.art_matching_nielsen_per_1 AS B
WHERE status_1 = 'T';


CREATE OR REPLACE TEMPORARY TABLE _fall4_tracking_single AS
SELECT
    A.art_matching_id,
    COUNT(DISTINCT A.art_id) AS anzahl
FROM dbp_etl.art_matching_nielsen_per_1 AS A
INNER JOIN `_fall4` AS C ON A.art_matching_id = C.art_matching_id
INNER JOIN dbp_data.art_1 AS B
    ON A.art_id = B.art_id AND B.mandant_id = 1 AND TRIM(
        B.loesch_id) NOT IN (
        'L',
        'R'
    )
GROUP BY A.art_matching_id
HAVING anzahl = 1;


DELETE FROM `_fall4`
WHERE art_matching_id IN (
    SELECT art_matching_id
    FROM `_fall4_tracking_single`
);


CREATE OR REPLACE TEMPORARY TABLE _fall4_upd_sst1 AS
SELECT
    A.mandant_id,
    A.art_matching_id,
    A.art_id,
    E.wg_id,
    C.wup_id,
    F.kreistyp_gruppe_id,
    E.sm_id
FROM dbp_etl.art_matching_nielsen_per_1 AS A
INNER JOIN `_fall4` AS B ON A.art_matching_id = B.art_matching_id
INNER JOIN `_art_list_wup_zu_per` AS C ON A.mandant_id = C.mandant_id AND A.art_id = C.art_id
INNER JOIN dbp_data.art_wg_zu_per_1 AS D
    ON
        A.mandant_id = D.mandant_id AND A.art_id = D.art_id AND D.arthiertyp_id
        = 2 AND D.dat_bis = DATE '9999-12-31'
INNER JOIN dbp_data.sm_wup_wg_zu_per_1 AS E
    ON
        A.mandant_id = E.mandant_id AND D.wg_id = E.wg_id AND C.wup_id
        = E.wup_id
INNER JOIN dbp_data.wup_1 AS F
    ON
        A.mandant_id = F.mandant_id AND E.wup_id = F.wup_id AND F.dat_bis =
        DATE '9999-12-31'
WHERE
    A.mandant_id = 1
    AND E.spr_id = 22
    AND E.arthiertyp_id = 2
    AND CURRENT_DATE("Europe/Berlin") BETWEEN E.dat_von AND E.dat_bis
    AND E.sm_id BETWEEN 1 AND 5
    AND F.nb_id = 0
    AND F.dat_von <= CURRENT_DATE("Europe/Berlin")
    AND A.art_id NOT IN (
        SELECT art_id
        FROM dbp_data.art_1
        WHERE
            mandant_id = 1
            AND TRIM(loesch_id) IN ('L', 'R')
    )
GROUP BY
    A.mandant_id,
    A.art_matching_id,
    A.art_id,
    E.wg_id,
    C.wup_id,
    F.kreistyp_gruppe_id,
    E.sm_id;


CREATE OR REPLACE TEMPORARY TABLE _fall4_upd_sst2 AS
SELECT
    A.mandant_id,
    A.art_matching_id,
    A.art_id,
    E.wg_id,
    E.wup_id,
    F.kreistyp_gruppe_id,
    E.sm_id
FROM dbp_etl.art_matching_nielsen_per_1 AS A
INNER JOIN `_fall4` AS B ON A.art_matching_id = B.art_matching_id
INNER JOIN dbp_data.art_wg_zu_per_1 AS D
    ON
        A.mandant_id = D.mandant_id AND A.art_id = D.art_id AND D.arthiertyp_id
        = 2 AND D.dat_bis = DATE '9999-12-31'
INNER JOIN dbp_data.sm_wup_wg_zu_per_1 AS E ON A.mandant_id = E.mandant_id AND D.wg_id = E.wg_id
INNER JOIN dbp_data.wup_1 AS F
    ON
        A.mandant_id = F.mandant_id AND E.wup_id = F.wup_id AND F.dat_bis =
        DATE '9999-12-31'
WHERE
    A.mandant_id = 1
    AND E.spr_id = 22
    AND E.arthiertyp_id = 2
    AND CURRENT_DATE("Europe/Berlin") BETWEEN E.dat_von AND E.dat_bis
    AND E.sm_id BETWEEN 1 AND 5
    AND F.nb_id = 0
    AND F.dat_von <= CURRENT_DATE("Europe/Berlin")
    AND A.art_id NOT IN (
        SELECT art_id
        FROM dbp_data.art_1
        WHERE
            mandant_id = 1
            AND TRIM(loesch_id) IN ('L', 'R')
    )
GROUP BY
    A.mandant_id,
    A.art_matching_id,
    A.art_id,
    E.wg_id,
    E.wup_id,
    F.kreistyp_gruppe_id,
    E.sm_id;


CREATE OR REPLACE TEMPORARY TABLE _fall4_ist_listung AS
SELECT
    mandant_id,
    art_matching_id,
    wg_id,
    sm_id,
    wup_id
FROM `_fall4_upd_sst1`
GROUP BY
    mandant_id,
    art_matching_id,
    wg_id,
    sm_id,
    wup_id;


CREATE OR REPLACE TEMPORARY TABLE _fall4_soll_listung AS
SELECT
    mandant_id,
    art_matching_id,
    wg_id,
    sm_id,
    wup_id
FROM `_fall4_upd_sst2`
GROUP BY
    mandant_id,
    art_matching_id,
    wg_id,
    sm_id,
    wup_id;


CREATE OR REPLACE TEMPORARY TABLE _fall4_update_sst AS
SELECT
    a.mandant_id,
    a.art_matching_id,
    MIN(a.sm_id) AS sm_id
FROM (
    SELECT
        mandant_id,
        art_matching_id,
        sm_id,
        COUNT(DISTINCT wup_id) AS anz_ist
    FROM `_fall4_ist_listung`
    GROUP BY
        mandant_id,
        art_matching_id,
        sm_id
) AS a
INNER JOIN (
    SELECT
        mandant_id,
        art_matching_id,
        sm_id,
        COUNT(DISTINCT wup_id) AS anz_soll
    FROM `_fall4_soll_listung`
    GROUP BY
        mandant_id,
        art_matching_id,
        sm_id
) AS b
    ON
        a.mandant_id = b.mandant_id AND a.art_matching_id = b.art_matching_id AND a.sm_id = b.sm_id AND a.anz_ist
        = b.anz_soll
GROUP BY
    a.mandant_id,
    a.art_matching_id;


INSERT INTO `_fall4_update_sst`
(
    SELECT
        mandant_id,
        art_matching_id,
        CAST(NULL AS INTEGER) AS sm_id
    FROM `_fall4_ist_listung`
    WHERE
        art_matching_id NOT IN (
            SELECT art_matching_id
            FROM `_fall4_update_sst`
        )
    GROUP BY
        mandant_id,
        art_matching_id,
        sm_id
);


CREATE OR REPLACE TEMPORARY TABLE _fall4_ist_listung_region AS
SELECT
    A.mandant_id,
    A.art_matching_id,
    A.kreistyp_gruppe_id,
    A.wup_id
FROM `_fall4_upd_sst1` AS A
INNER JOIN (
    SELECT *
    FROM `_fall4_update_sst`
    WHERE
        sm_id IS NULL
        OR sm_id <> 1
) AS b
    ON A.mandant_id = b.mandant_id AND A.art_matching_id = b.art_matching_id
GROUP BY
    A.mandant_id,
    A.art_matching_id,
    A.kreistyp_gruppe_id,
    A.wup_id;


CREATE OR REPLACE TEMPORARY TABLE _fall4_soll_listung_region AS
SELECT
    A.mandant_id,
    A.art_matching_id,
    A.kreistyp_gruppe_id,
    A.wup_id
FROM `_fall4_upd_sst2` AS A
INNER JOIN (
    SELECT *
    FROM `_fall4_update_sst`
    WHERE
        sm_id IS NULL
        OR sm_id <> 1
) AS b
    ON A.mandant_id = b.mandant_id AND A.art_matching_id = b.art_matching_id
GROUP BY
    A.mandant_id,
    A.art_matching_id,
    A.kreistyp_gruppe_id,
    A.wup_id;


CREATE OR REPLACE TEMPORARY TABLE _fall4_update_sst_region AS
SELECT
    a.mandant_id,
    a.art_matching_id,
    a.kreistyp_gruppe_id
FROM (
    SELECT
        mandant_id,
        art_matching_id,
        kreistyp_gruppe_id,
        COUNT(DISTINCT wup_id) AS anz_ist
    FROM `_fall4_ist_listung_region`
    GROUP BY
        mandant_id,
        art_matching_id,
        kreistyp_gruppe_id
) AS a
INNER JOIN (
    SELECT
        mandant_id,
        kreistyp_gruppe_id,
        COUNT(DISTINCT wup_id) AS anz_soll
    FROM dbp_data.wup_1
    WHERE
        mandant_id = 1
        AND nb_id = 0
        AND dat_bis = DATE '9999-12-31'
        AND kreistyp_gruppe_id IS NOT NULL
    GROUP BY
        mandant_id,
        kreistyp_gruppe_id
) AS b
    ON
        a.mandant_id = b.mandant_id AND a.kreistyp_gruppe_id = b.kreistyp_gruppe_id AND a.anz_ist
        = b.anz_soll
GROUP BY
    a.mandant_id,
    a.art_matching_id,
    a.kreistyp_gruppe_id;


CREATE OR REPLACE TEMPORARY TABLE _fall4_update_regio AS
SELECT
    mandant_id,
    art_matching_id,
    MAX(CASE
        WHEN TRIM(kreistyp_gruppe_id) = 'N'
            THEN 'X'
        ELSE ''
    END) AS nord_pflege_neu,
    MAX(CASE
        WHEN TRIM(kreistyp_gruppe_id) = 'W'
            THEN 'X'
        ELSE ''
    END) AS west_pflege_neu,
    MAX(CASE
        WHEN TRIM(kreistyp_gruppe_id) = 'O'
            THEN 'X'
        ELSE ''
    END) AS ost_basis_pflege_neu,
    MAX(CASE
        WHEN TRIM(kreistyp_gruppe_id) = 'Q'
            THEN 'X'
        ELSE ''
    END) AS ost_gross_pflege_neu,
    MAX(CASE
        WHEN TRIM(kreistyp_gruppe_id) = 'G'
            THEN 'X'
        ELSE ''
    END) AS sued_ost_pflege_neu,
    MAX(CASE
        WHEN TRIM(kreistyp_gruppe_id) = 'M'
            THEN 'X'
        ELSE ''
    END) AS sued_west_pflege_neu
FROM `_fall4_update_sst_region`
GROUP BY
    mandant_id,
    art_matching_id;


CREATE OR REPLACE TEMPORARY TABLE _fall4_sst_regio AS
SELECT
    mandant_id,
    art_matching_id,
    COUNT(DISTINCT wup_id) AS anz
FROM (SELECT
    mandant_id,
    art_matching_id,
    wup_id
FROM `_fall4_ist_listung`
WHERE (
    mandant_id, art_matching_id) IN (
    SELECT (mandant_id, art_matching_id)
    FROM `_fall4_update_sst`
    WHERE sm_id IS NOT NULL
)
UNION ALL
SELECT
    mandant_id,
    art_matching_id,
    wup_id
FROM `_fall4_ist_listung_region`
WHERE (
    mandant_id, art_matching_id) IN (
    SELECT (mandant_id, art_matching_id)
    FROM `_fall4_update_sst_region`
)) AS x
GROUP BY
    mandant_id,
    art_matching_id;


CREATE OR REPLACE TEMPORARY TABLE _fall4_gesamt_sicht AS
SELECT
    mandant_id,
    art_matching_id,
    COUNT(DISTINCT wup_id) AS anz_markt
FROM `_fall4_ist_listung` AS x
GROUP BY
    mandant_id,
    art_matching_id;


UPDATE dbp_data.sortiment_leistung_1 SET
    anz_maerkte_sst = b.anz
FROM `_fall4_sst_regio` AS b
WHERE
    sortiment_leistung.matching_id = b.art_matching_id AND sortiment_leistung.mandant_id = 1 AND sortiment_leistung.kjwo_update
    IN (
        SELECT MAX(kjwo_update) AS a1290333724
        FROM dbp_data.sortiment_leistung_1
        WHERE mandant_id = 1
    );


UPDATE dbp_data.sortiment_leistung_1 SET
    anz_maerkte_listung_gesamt = b.anz_markt
FROM `_fall4_gesamt_sicht` AS b
WHERE
    sortiment_leistung.matching_id = b.art_matching_id AND sortiment_leistung.mandant_id = 1 AND sortiment_leistung.kjwo_update
    IN (
        SELECT MAX(kjwo_update) AS a1290333724
        FROM dbp_data.sortiment_leistung_1
        WHERE mandant_id = 1
    );


UPDATE dbp_data.sortiment_leistung_1 SET
    listung_sst_mvke = CAST(b.sm_id AS STRING)
FROM `_fall4_update_sst` AS b
WHERE
    sortiment_leistung.mandant_id = b.mandant_id AND sortiment_leistung.matching_id = b.art_matching_id AND
    sortiment_leistung.mandant_id = 1 AND sortiment_leistung.kjwo_update IN (
        SELECT MAX(kjwo_update) AS a1290333724
        FROM dbp_data.sortiment_leistung_1
        WHERE mandant_id = 1
    );


UPDATE dbp_data.sortiment_leistung_1 SET
    nord = x.nord_pflege_neu,
    west = x.west_pflege_neu,
    ost_basis = x.ost_basis_pflege_neu,
    ost_gross = x.ost_gross_pflege_neu,
    sued_ost = x.sued_ost_pflege_neu,
    sued_west = x.sued_west_pflege_neu
FROM `_fall4_update_regio` AS x
WHERE
    sortiment_leistung.mandant_id = x.mandant_id AND sortiment_leistung.matching_id = x.art_matching_id AND
    sortiment_leistung.mandant_id = 1 AND sortiment_leistung.kjwo_update IN (
        SELECT MAX(kjwo_update) AS a1290333724
        FROM dbp_data.sortiment_leistung_1
        WHERE mandant_id = 1
    );


CREATE OR REPLACE TEMPORARY TABLE _fall5 AS
SELECT
    art_matching_id,
    art_id
FROM dbp_etl.art_matching_nielsen_per_1 AS B
WHERE status_1 = 'N'
GROUP BY
    art_matching_id,
    art_id
UNION DISTINCT
SELECT
    B.art_matching_id,
    B.art_id
FROM dbp_etl.art_matching_nielsen_per_1 AS B
INNER JOIN `_fall4_tracking_single` AS C ON B.art_matching_id = C.art_matching_id
INNER JOIN dbp_data.art_1 AS A ON B.art_id = A.art_id AND A.mandant_id = 1 AND TRIM(
    A.loesch_id) NOT IN (
    'L',
    'R'
);


CREATE OR REPLACE TEMPORARY TABLE _sst_plus_regio AS
(
    SELECT
        A.mandant_id,
        C.art_id,
        C.wup_id
    FROM dbp_etl.art_matching_nielsen_per_1 AS A
    INNER JOIN `_fall5` AS B ON A.art_matching_id = B.art_matching_id
    INNER JOIN `_art_list_wup_zu_per` AS C ON A.art_id = C.art_id
    INNER JOIN dbp_data.wup_1 AS D ON C.mandant_id = D.mandant_id AND C.wup_id = D.wup_id
    WHERE
        TRIM(C.list_quelle_id) IN ('1', '7')
        AND D.nb_id = 0
        AND D.dat_eroeffnung < CURRENT_DATE("Europe/Berlin")
    GROUP BY
        A.mandant_id,
        C.art_id,
        C.wup_id
    UNION DISTINCT
    SELECT
        A.mandant_id,
        C.art_id,
        C.wup_id
    FROM dbp_etl.art_matching_nielsen_per_1 AS A
    INNER JOIN `_fall5` AS B ON A.art_matching_id = B.art_matching_id
    INNER JOIN `_art_list_wup_zu_per` AS C ON A.art_id = C.art_id
    INNER JOIN dbp_data.wup_1 AS D ON C.mandant_id = D.mandant_id AND C.wup_id = D.wup_id
    WHERE
        TRIM(C.list_quelle_id) IN ('3')
        AND D.nb_id = 0
        AND D.dat_eroeffnung < CURRENT_DATE("Europe/Berlin")
        AND C.baustein_id NOT IN (
            SELECT baustein_id
            FROM dbp_etl.baustein_wsop_1
            WHERE CURRENT_DATE("Europe/Berlin") BETWEEN dat_von AND dat_bis
        )
    GROUP BY
        A.mandant_id,
        C.art_id,
        C.wup_id
)
UNION DISTINCT
SELECT
    A.mandant_id,
    C.art_id,
    C.wup_id
FROM dbp_etl.art_matching_nielsen_per_1 AS A
INNER JOIN `_fall5` AS B ON A.art_matching_id = B.art_matching_id
INNER JOIN `_art_list_wup_zu_per` AS C ON A.art_id = C.art_id
INNER JOIN dbp_data.wup_1 AS D ON C.mandant_id = D.mandant_id AND C.wup_id = D.wup_id
WHERE
    TRIM(C.list_quelle_id) IN ('3')
    AND C.baustein_id IN (
        SELECT baustein_id
        FROM dbp_etl.baustein_region_zu_1
    )
    AND D.nb_id = 0
    AND D.dat_eroeffnung < CURRENT_DATE("Europe/Berlin")
GROUP BY
    A.mandant_id,
    C.art_id,
    C.wup_id;


CREATE OR REPLACE TEMPORARY TABLE _sonstige_bst AS
SELECT
    A.mandant_id,
    C.art_id,
    C.wup_id
FROM dbp_etl.art_matching_nielsen_per_1 AS A
INNER JOIN `_fall5` AS B ON A.art_matching_id = B.art_matching_id
INNER JOIN `_art_list_wup_zu_per` AS C ON A.art_id = C.art_id
INNER JOIN dbp_data.wup_1 AS D ON C.mandant_id = D.mandant_id AND C.wup_id = D.wup_id
WHERE
    TRIM(C.list_quelle_id) IN ('3')
    AND C.baustein_id IN (
        SELECT baustein_id
        FROM dbp_etl.baustein_wsop_1
        WHERE CURRENT_DATE("Europe/Berlin") BETWEEN dat_von AND dat_bis
    )
    AND D.nb_id = 0
    AND D.dat_eroeffnung < CURRENT_DATE("Europe/Berlin")
    AND C.baustein_id NOT IN (
        SELECT baustein_id
        FROM dbp_etl.baustein_region_zu_1
    )
GROUP BY
    A.mandant_id,
    C.art_id,
    C.wup_id;


CREATE OR REPLACE TEMPORARY TABLE _einzel_markt AS
SELECT
    A.mandant_id,
    C.art_id,
    C.wup_id
FROM dbp_etl.art_matching_nielsen_per_1 AS A
INNER JOIN `_fall5` AS B ON A.art_matching_id = B.art_matching_id
INNER JOIN `_art_list_wup_zu_per` AS C ON A.art_id = C.art_id
INNER JOIN dbp_data.wup_1 AS D ON C.mandant_id = D.mandant_id AND C.wup_id = D.wup_id
WHERE
    TRIM(C.list_quelle_id) IN ('C')
    AND D.nb_id = 0
    AND D.dat_eroeffnung < CURRENT_DATE("Europe/Berlin")
GROUP BY
    A.mandant_id,
    C.art_id,
    C.wup_id;


CREATE OR REPLACE TEMPORARY TABLE _gesamt_sicht AS
SELECT
    mandant_id,
    art_id,
    COUNT(DISTINCT wup_id) AS anz_markt
FROM (
    SELECT *
    FROM `_sst_plus_regio`
    UNION ALL
    SELECT *
    FROM `_sonstige_bst`
    UNION ALL
    SELECT *
    FROM `_einzel_markt`
) AS x
GROUP BY
    mandant_id,
    art_id;


CREATE OR REPLACE TEMPORARY TABLE _sst AS
SELECT
    mandant_id,
    art_id,
    COUNT(DISTINCT wup_id) AS anz_markt
FROM `_sst_plus_regio` AS X
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


UPDATE dbp_data.sortiment_leistung_1 SET
    anz_maerkte_sst = b.anz_markt
FROM `_sst` AS b
WHERE
    sortiment_leistung.art_id = b.art_id AND sortiment_leistung.mandant_id = 1 AND sortiment_leistung.anz_maerkte_sst
    = 0 AND sortiment_leistung.kjwo_update IN (
        SELECT MAX(kjwo_update) AS a1290333724
        FROM dbp_data.sortiment_leistung_1
        WHERE mandant_id = 1
    );


UPDATE dbp_data.sortiment_leistung_1 SET
    anz_maerkte_baustein_sonstige = b.anz_markt
FROM `_bst` AS b
WHERE
    sortiment_leistung.art_id = b.art_id AND sortiment_leistung.mandant_id = 1 AND sortiment_leistung.anz_maerkte_baustein_sonstige
    = 0 AND sortiment_leistung.kjwo_update IN (
        SELECT MAX(kjwo_update) AS a1290333724
        FROM dbp_data.sortiment_leistung_1
        WHERE mandant_id = 1
    );


UPDATE dbp_data.sortiment_leistung_1 SET
    anz_maerkte_listung_einzel = b.anz_markt
FROM `_mkt` AS b
WHERE
    sortiment_leistung.art_id = b.art_id AND sortiment_leistung.mandant_id = 1 AND sortiment_leistung.anz_maerkte_listung_einzel
    = 0 AND sortiment_leistung.kjwo_update IN (
        SELECT MAX(kjwo_update) AS a1290333724
        FROM dbp_data.sortiment_leistung_1
        WHERE mandant_id = 1
    );


UPDATE dbp_data.sortiment_leistung_1 SET
    anz_maerkte_listung_gesamt = b.anz_markt
FROM `_gesamt_sicht` AS b
WHERE
    sortiment_leistung.art_id = b.art_id AND sortiment_leistung.mandant_id = 1 AND sortiment_leistung.anz_maerkte_listung_gesamt
    = 0 AND sortiment_leistung.kjwo_update IN (
        SELECT MAX(kjwo_update) AS a1290333724
        FROM dbp_data.sortiment_leistung_1
        WHERE mandant_id = 1
    );


UPDATE dbp_data.sortiment_leistung_1 SET
    nord = x.nord_neu,
    west = x.west_neu,
    ost_basis = x.ost_basis_neu,
    ost_gross = x.ost_gross_neu,
    sued_ost = x.sued_ost_neu,
    sued_west = x.sued_west_neu FROM (
    SELECT
        A.art_id,
        MAX(CASE
            WHEN TRIM(B.region_1) = 'N'
                THEN 'X'
            ELSE ''
        END) AS nord_neu,
        MAX(CASE
            WHEN TRIM(B.region_1) = 'W'
                THEN 'X'
            ELSE ''
        END) AS west_neu,
        MAX(CASE
            WHEN TRIM(B.region_1) = 'OB'
                THEN 'X'
            ELSE ''
        END) AS ost_basis_neu,
        MAX(CASE
            WHEN TRIM(B.region_1) = 'OG'
                THEN 'X'
            ELSE ''
        END) AS ost_gross_neu,
        MAX(CASE
            WHEN TRIM(B.region_1) = 'SO'
                THEN 'X'
            ELSE ''
        END) AS sued_ost_neu,
        MAX(CASE
            WHEN TRIM(B.region_1) = 'SW'
                THEN 'X'
            ELSE ''
        END) AS sued_west_neu
    FROM dbp_etl.baustein_wsop_1 AS A
    INNER JOIN dbp_etl.baustein_region_zu_1 AS B ON A.mandant_id = B.mandant_id AND A.baustein_id = B.baustein_id

    INNER JOIN (
        SELECT art_id
        FROM `_fall5`
        GROUP BY art_id
    ) AS c
        ON A.art_id = c.art_id
    WHERE
        A.mandant_id = 1
        AND CURRENT_DATE("Europe/Berlin") BETWEEN A.dat_von AND A.dat_bis
    GROUP BY A.art_id
) AS x
WHERE sortiment_leistung.art_id = x.art_id AND sortiment_leistung.mandant_id = 1 AND sortiment_leistung.kjwo_update IN (
    SELECT MAX(kjwo_update) AS a1290333724
    FROM dbp_data.sortiment_leistung_1
    WHERE mandant_id = 1
);


UPDATE dbp_data.sortiment_leistung_1 SET
    listung_sst_mvke = CAST(t2.sm_id AS STRING) FROM (
    SELECT
        A.mandant_id,
        A.art_id,
        MIN(A.sm_id) AS sm_id
    FROM dbp_etl_process.art_sm_vw_zu_per_1 AS A
    INNER JOIN (
        SELECT art_id
        FROM `_fall5`
        GROUP BY art_id
    ) AS c
        ON A.art_id = c.art_id
    WHERE
        A.mandant_id = 1
        AND CURRENT_DATE("Europe/Berlin") BETWEEN A.dat_von AND A.dat_bis
    GROUP BY
        A.art_id,
        A.mandant_id
) AS t2
WHERE
    sortiment_leistung.mandant_id = t2.mandant_id AND sortiment_leistung.art_id = t2.art_id AND sortiment_leistung.mandant_id
    = 1 AND sortiment_leistung.kjwo_update IN (
        SELECT MAX(kjwo_update) AS a1290333724
        FROM dbp_data.sortiment_leistung_1
        WHERE mandant_id = 1
    );
