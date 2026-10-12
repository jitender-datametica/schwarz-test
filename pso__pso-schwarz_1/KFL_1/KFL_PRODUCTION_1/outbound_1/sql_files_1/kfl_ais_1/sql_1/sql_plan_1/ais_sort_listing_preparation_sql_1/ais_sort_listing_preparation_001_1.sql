TRUNCATE TABLE dbp_etl_process.art_gtin_1;


INSERT INTO dbp_etl_process.art_gtin_1
(SELECT
    art_id,
    mandant_id,
    gtin_id,
    gtin_typ_kz,
    haupt_gtin_fg,
    td_insert,
    td_update
FROM dbp_data.art_gtin_zu_1);


CREATE OR REPLACE TABLE dbp_etl.anzeige_artikel_1 (
    mandant_id INTEGER,
    art_matching_id INTEGER,
    art_a INTEGER,
    art_b INTEGER,
    art_c1 INTEGER,
    art_c2 INTEGER,
    art_d1 INTEGER,
    art_d2 INTEGER,
    fg_a INTEGER,
    fg_b INTEGER,
    fg_c1 INTEGER,
    fg_c2 INTEGER,
    fg_d1 INTEGER,
    fg_d2 INTEGER,
    status_a STRING(2) COLLATE 'und:ci',
    status_b STRING(2) COLLATE 'und:ci',
    status_c1 STRING(2) COLLATE 'und:ci',
    status_c2 STRING(2) COLLATE 'und:ci',
    status_d1 STRING(2) COLLATE 'und:ci',
    status_d2 STRING(2) COLLATE 'und:ci'
);


CREATE OR REPLACE TABLE dbp_etl.sort_ist_1 (
    wup_id INTEGER,
    kreistyp_gruppe_id STRING(1) COLLATE 'und:ci',
    mandant_id INTEGER,
    wg_id INTEGER,
    art_id INTEGER,
    kassenumsatz FLOAT64,
    anz_tage INTEGER,
    preis FLOAT64,
    list_kz STRING(2) COLLATE 'und:ci'
);


DELETE FROM dbp_data.art_list_wup_zu_per_1
WHERE (
    mandant_id, art_id) IN (
    SELECT (mandant_id, art_id)
    FROM dbp_data.art_gp_zu_per_1
    WHERE
        mandant_id = 1
        AND gp_id = 5059720
        AND dat_bis = PARSE_DATE('%F', '9999-12-31')
    GROUP BY mandant_id,
    art_id
);


--- new list_kz logic


CREATE OR REPLACE TEMPORARY TABLE _art_nielsen AS
SELECT *
FROM dbp_data.art_nielsen_1
WHERE
    dat_bis = DATE '9999-12-31'
    AND mandant_id = 1;


CREATE OR REPLACE TEMPORARY TABLE _distinct_nl_arts AS
SELECT
    mandant_id,
    art_nielsen_id,
    gtin_id
FROM `_art_nielsen` AS A
WHERE mandant_id = 1
GROUP BY
    mandant_id,
    art_nielsen_id,
    gtin_id;


CREATE OR REPLACE TEMPORARY TABLE _article_matching0 AS
SELECT
    A.mandant_id,
    A.art_nielsen_id,
    b.art_id,
    A.gtin_id
FROM `_distinct_nl_arts` AS A
INNER JOIN (
    SELECT *
    FROM dbp_etl_process.art_gtin_1 AS A
    WHERE
        mandant_id = 1
        AND (
            mandant_id, art_id) NOT IN (
            SELECT (mandant_id, art_id)
            FROM dbp_data.art_gp_zu_per_1
            WHERE
                mandant_id = 1
                AND gp_id = 5059720
                AND dat_bis = DATE '9999-12-31'
            GROUP BY mandant_id,
            art_id
        )
) AS b
    ON A.gtin_id = b.gtin_id AND A.mandant_id = b.mandant_id
GROUP BY
    A.mandant_id,
    A.art_nielsen_id,
    b.art_id,
    A.gtin_id;


CREATE OR REPLACE TABLE dbp_etl.kl_basis_listung_1 (
    mandant_id INTEGER,
    art_id INTEGER,
    art_nielsen_id INTEGER,
    list_kz STRING(10) COLLATE 'und:ci'
);


CREATE OR REPLACE TEMPORARY TABLE _kl_basis_listung (
    mandant_id INTEGER,
    art_id INTEGER,
    art_nielsen_id INTEGER,
    list_kz STRING(10) COLLATE 'und:ci'
);


CREATE OR REPLACE TEMPORARY TABLE _kl_basis_alle_gelistet AS
SELECT
    A.mandant_id,
    A.art_id
FROM dbp_data.art_list_wup_zu_per_1 AS A
INNER JOIN dbp_data.art_wg_zu_per_1 AS B
    ON
        A.mandant_id = B.mandant_id AND A.art_id = B.art_id AND B.dat_bis
        = PARSE_DATE('%F', '9999-12-31') AND B.arthiertyp_id = 2
INNER JOIN dbp_data.wg_filter_zu_1 AS WFZ
    ON
        B.wg_id = WFZ.wg_id AND B.mandant_id = WFZ.mandant_id AND WFZ.wg_filter_id = 11 AND WFZ.arthiertyp_id = 2
WHERE
    A.list_komponente_fg = 0
    AND A.nb_id = 0
    AND A.mandant_id = 1
    AND CURRENT_DATE("Europe/Berlin") BETWEEN A.dat_von AND A.dat_bis
    AND A.art_id > 0
    AND A.list_quelle_id NOT IN ('2')
GROUP BY
    A.mandant_id,
    A.art_id;


CREATE OR REPLACE TEMPORARY TABLE _kl_basis_nicht_gelistet AS
SELECT
    A.mandant_id,
    A.art_id
FROM dbp_data.art_wup_zu_per_1 AS A
INNER JOIN dbp_data.art_wg_zu_per_1 AS B
    ON
        A.mandant_id = B.mandant_id AND A.art_id = B.art_id AND B.dat_bis
        = PARSE_DATE('%F', '9999-12-31') AND B.arthiertyp_id = 2
INNER JOIN dbp_data.wg_filter_zu_1 AS WFZ
    ON
        B.wg_id = WFZ.wg_id AND B.mandant_id = WFZ.mandant_id AND WFZ.wg_filter_id = 11 AND WFZ.arthiertyp_id = 2
WHERE
    A.mandant_id = 1
    AND CURRENT_DATE("Europe/Berlin") BETWEEN A.dat_von AND A.dat_bis
    AND A.art_id > 0
GROUP BY
    A.mandant_id,
    A.art_id
HAVING MAX(A.listung_id) = 0;


CREATE OR REPLACE TEMPORARY TABLE _kl_basis_a AS
SELECT
    A.mandant_id,
    A.art_id,
    'A' AS list_kz
FROM dbp_data.artbew_wo_sum_1 AS A
INNER JOIN dbp_data.woche_kj_kl_1 AS X ON A.kjwo_kl = X.kjwo_kl
INNER JOIN dbp_data.art_wg_zu_per_1 AS B
    ON
        A.mandant_id = B.mandant_id AND A.art_id = B.art_id AND B.dat_bis
        = DATE '9999-12-31' AND B.arthiertyp_id = 2
WHERE
    A.mandant_id = 1
    AND X.kjwo IN (
        SELECT kjwo
        FROM dbp_data.art_nielsen_fakten_kjwo_1
        WHERE mandant_id = 1
        GROUP BY kjwo
        QUALIFY ((RANK() OVER (ORDER BY kjwo IS NULL DESC, kjwo DESC)) * -1) BETWEEN -52 AND (-1)
    )
    AND B.wg_id IN (
        SELECT wg_id
        FROM dbp_data.wg_filter_zu_1
        WHERE wg_filter_id = 11
        GROUP BY wg_id
    )
    AND (
        A.mandant_id, A.art_id) IN (
        SELECT (mandant_id, art_id)
        FROM (
            SELECT DISTINCT *
            FROM `_kl_basis_alle_gelistet`
        ) AS t9
    )
GROUP BY
    A.mandant_id,
    A.art_id
HAVING SUM(A.menge) > 0;


INSERT INTO `_kl_basis_listung`
(
    SELECT DISTINCT
        A.mandant_id,
        A.art_id,
        B.art_nielsen_id,
        A.list_kz
    FROM `_kl_basis_a` AS A
    LEFT JOIN `_article_matching0` AS B ON A.mandant_id = B.mandant_id AND A.art_id = B.art_id
);


CREATE OR REPLACE TEMPORARY TABLE _kl_basis_b AS
SELECT
    A.mandant_id,
    A.art_id,
    'B' AS list_kz
FROM dbp_data.artbew_wo_sum_1 AS A
INNER JOIN dbp_data.woche_kj_kl_1 AS X ON A.kjwo_kl = X.kjwo_kl
INNER JOIN dbp_data.art_wg_zu_per_1 AS B
    ON
        A.mandant_id = B.mandant_id AND A.art_id = B.art_id AND B.dat_bis
        = DATE '9999-12-31' AND B.arthiertyp_id = 2
WHERE
    A.mandant_id = 1
    AND X.kjwo IN (
        SELECT kjwo
        FROM dbp_data.art_nielsen_fakten_kjwo_1
        WHERE mandant_id = 1
        GROUP BY kjwo
        QUALIFY ((RANK() OVER (ORDER BY kjwo IS NULL DESC, kjwo DESC)) * -1) BETWEEN -52 AND (-1)
    )
    AND B.wg_id IN (
        SELECT wg_id
        FROM dbp_data.wg_filter_zu_1
        WHERE wg_filter_id = 11
        GROUP BY wg_id
    )
    AND (
        A.mandant_id, A.art_id) NOT IN (
        SELECT (mandant_id, art_id)
        FROM (
            SELECT DISTINCT *
            FROM `_kl_basis_alle_gelistet`
        ) AS t9
    )
    AND (
        A.mandant_id, A.art_id) NOT IN (
        SELECT (mandant_id, art_id)
        FROM `_kl_basis_listung`
    )
GROUP BY
    A.mandant_id,
    A.art_id
HAVING SUM(A.menge) > 0;


INSERT INTO `_kl_basis_listung`
(
    SELECT DISTINCT
        A.mandant_id,
        A.art_id,
        B.art_nielsen_id,
        A.list_kz
    FROM `_kl_basis_b` AS A
    LEFT JOIN `_article_matching0` AS B ON A.mandant_id = B.mandant_id AND A.art_id = B.art_id
);


CREATE OR REPLACE TEMPORARY TABLE _artikel_nielsen_agg AS
SELECT
    A.mandant_id,
    c.art_nielsen_id,
    SUM(A.menge) AS menge_,
    SUM(A.umsatz_brutto) AS umsatz_
FROM dbp_data.art_nielsen_fakten_kjwo_1 AS A
INNER JOIN (SELECT
    kjwo,
    MIN(kjmo) AS kjmo
FROM dbp_data.tag_1
GROUP BY kjwo) AS x ON A.kjwo = x.kjwo
INNER JOIN (
    SELECT
        mandant_id,
        gtin_id,
        art_nielsen_id,
        art_matching_id
    FROM dbp_etl.art_matching_nielsen_per_1
    GROUP BY
        mandant_id,
        gtin_id,
        art_nielsen_id,
        art_matching_id
    UNION DISTINCT
    SELECT
        mandant_id,
        gtin_id,
        art_nielsen_id,
        art_matching_id
    FROM dbp_etl_process.matching_art_nielsen_zu_1
    WHERE (
        mandant_id, kjwo_update) IN (
        SELECT (mandant_id, MAX(kjwo_update))
        FROM dbp_data.art_kl_preislage_zu_per_1
        WHERE mandant_id = 1
        GROUP BY mandant_id
    )
    GROUP BY
        mandant_id,
        gtin_id,
        art_nielsen_id,
        art_matching_id
) AS c ON A.mandant_id = c.mandant_id AND A.art_nielsen_id = c.art_nielsen_id
INNER JOIN dbp_data.nielsen_market_1 AS D ON A.mandant_id = D.mandant_id AND A.nielsen_market_id = D.nielsen_market_id

WHERE
    A.kjwo IN (
        SELECT kjwo
        FROM dbp_data.art_nielsen_fakten_kjwo_1
        WHERE mandant_id = 1
        GROUP BY kjwo
        QUALIFY ((RANK() OVER (ORDER BY kjwo IS NULL DESC, kjwo DESC)) * -1) BETWEEN -52 AND (-1)
    )
    AND D.nielsen_market_cluster_id = 2
    AND A.mandant_id = 1
GROUP BY
    A.mandant_id,
    c.art_nielsen_id;


CREATE OR REPLACE TEMPORARY TABLE _kl_basis_c1 AS
SELECT
    mandant_id,
    art_id,
    'C1' AS list_kz
FROM `_kl_basis_alle_gelistet` AS A
WHERE (
    mandant_id, art_id) NOT IN (
    SELECT (mandant_id, art_id)
    FROM `_kl_basis_listung`
)
GROUP BY
    mandant_id,
    art_id;


INSERT INTO `_kl_basis_listung`
(
    SELECT DISTINCT
        A.mandant_id,
        A.art_id,
        B.art_nielsen_id,
        A.list_kz
    FROM `_kl_basis_c1` AS A
    LEFT JOIN `_article_matching0` AS B ON A.mandant_id = B.mandant_id AND A.art_id = B.art_id
    LEFT JOIN `_artikel_nielsen_agg` AS C ON B.mandant_id = C.mandant_id AND B.art_nielsen_id = C.art_nielsen_id
    WHERE C.umsatz_ > 0
);


CREATE OR REPLACE TEMPORARY TABLE _kl_basis_c2 AS
SELECT
    mandant_id,
    art_id,
    'C2' AS list_kz
FROM `_kl_basis_alle_gelistet` AS A
WHERE (
    mandant_id, art_id) NOT IN (
    SELECT (mandant_id, art_id)
    FROM `_kl_basis_listung`
)
GROUP BY
    mandant_id,
    art_id;


INSERT INTO `_kl_basis_listung`
(
    SELECT DISTINCT
        A.mandant_id,
        A.art_id,
        B.art_nielsen_id,
        A.list_kz
    FROM `_kl_basis_c2` AS A
    LEFT JOIN `_article_matching0` AS B ON A.mandant_id = B.mandant_id AND A.art_id = B.art_id
    LEFT JOIN `_artikel_nielsen_agg` AS C ON B.mandant_id = C.mandant_id AND B.art_nielsen_id = C.art_nielsen_id
    WHERE C.umsatz_ IS NULL
);


CREATE OR REPLACE TEMPORARY TABLE _kl_basis_d1 AS
SELECT
    mandant_id,
    art_id,
    'D1' AS list_kz
FROM `_kl_basis_nicht_gelistet` AS A
WHERE (
    mandant_id, art_id) NOT IN (
    SELECT (mandant_id, art_id)
    FROM `_kl_basis_listung`
)
GROUP BY
    mandant_id,
    art_id;


INSERT INTO `_kl_basis_listung`
(
    SELECT DISTINCT
        A.mandant_id,
        A.art_id,
        B.art_nielsen_id,
        A.list_kz
    FROM `_kl_basis_d1` AS A
    LEFT JOIN `_article_matching0` AS B ON A.mandant_id = B.mandant_id AND A.art_id = B.art_id
    LEFT JOIN `_artikel_nielsen_agg` AS C ON B.mandant_id = C.mandant_id AND B.art_nielsen_id = C.art_nielsen_id
    WHERE C.umsatz_ > 0
);


CREATE OR REPLACE TEMPORARY TABLE _kl_basis_d2 AS
SELECT
    mandant_id,
    art_id,
    'D2' AS list_kz
FROM `_kl_basis_nicht_gelistet` AS A
WHERE (
    mandant_id, art_id) NOT IN (
    SELECT (mandant_id, art_id)
    FROM `_kl_basis_listung`
)
GROUP BY
    mandant_id,
    art_id;


INSERT INTO `_kl_basis_listung`
(
    SELECT DISTINCT
        A.mandant_id,
        A.art_id,
        B.art_nielsen_id,
        A.list_kz
    FROM `_kl_basis_d2` AS A
    LEFT JOIN `_article_matching0` AS B ON A.mandant_id = B.mandant_id AND A.art_id = B.art_id
    LEFT JOIN `_artikel_nielsen_agg` AS C ON B.mandant_id = C.mandant_id AND B.art_nielsen_id = C.art_nielsen_id
    WHERE C.umsatz_ IS NULL
);


--gaps


CREATE OR REPLACE TEMPORARY TABLE _gaps AS
SELECT DISTINCT
    A.mandant_id,
    A.art_nielsen_id,
    A.art_id
FROM `_article_matching0` AS A
INNER JOIN `_artikel_nielsen_agg` AS B ON A.mandant_id = B.mandant_id AND A.art_nielsen_id = B.art_nielsen_id
WHERE B.umsatz_ > 0;


INSERT INTO `_kl_basis_listung`
(SELECT DISTINCT
    mandant_id,
    art_id,
    art_nielsen_id,
    'D1' AS list_kz
FROM `_gaps`
WHERE (
    mandant_id, art_id) NOT IN (
    SELECT (mandant_id, art_id)
    FROM `_kl_basis_listung`
));


INSERT INTO `_kl_basis_listung`
(SELECT DISTINCT
    mandant_id,
    art_id,
    art_nielsen_id,
    'D2' AS list_kz
FROM `_article_matching0`
WHERE (
    mandant_id, art_id) NOT IN (
    SELECT (mandant_id, art_id)
    FROM `_kl_basis_listung`
));


INSERT INTO dbp_etl.kl_basis_listung_1 (mandant_id, art_id, art_nielsen_id, list_kz)
(
    SELECT *
    FROM `_kl_basis_listung`
    GROUP BY
        mandant_id,
        art_id,
        art_nielsen_id,
        list_kz
);


DELETE FROM dbp_etl.kl_basis_listung_1
WHERE (
    mandant_id, art_id) IN (
    SELECT (mandant_id, art_id)
    FROM dbp_data.art_gp_zu_per_1
    WHERE
        mandant_id = 1
        AND gp_id = 5059720
        AND dat_bis = PARSE_DATE('%F', '9999-12-31')
    GROUP BY mandant_id,
    art_id
);


CREATE OR REPLACE TEMPORARY TABLE _sort_ist1 (
    wup_id INTEGER,
    kreistyp_gruppe_id STRING(1),
    mandant_id INTEGER,
    wg_id INTEGER,
    art_id INTEGER,
    kassenumsatz FLOAT64,
    anz_tage INTEGER,
    preis FLOAT64,
    list_kz STRING(2)
);


INSERT INTO `_sort_ist1`
(
    SELECT
        A11.wup_id,
        C.kreistyp_gruppe_id,
        A11.mandant_id,
        A12.wg_id,
        A11.art_id,
        CAST(SUM(A11.umsatz_netto + A11.umsatz_mwst_betrag) AS FLOAT64) AS kassenumsatz,
        COUNT(DISTINCT A11.dat) AS anz_tage,
        CAST(IFNULL(SUM(A11.umsatz_netto + A11.umsatz_mwst_betrag) / IF(SUM(A11.menge) = 0, NULL, SUM(A11.menge)), 0) AS FLOAT64)
            AS preis,
        x.list_kz
    FROM dbp_data.artbew_1 AS A11
    INNER JOIN dbp_data.tag_1 AS Y ON A11.dat = Y.dat
    INNER JOIN (SELECT DISTINCT
        mandant_id,
        art_id,
        list_kz
    FROM dbp_etl.kl_basis_listung_1) AS x
        ON
            A11.mandant_id = x.mandant_id AND A11.art_id = x.art_id AND x.list_kz
            = 'A'
    INNER JOIN dbp_data.art_wg_zu_per_1 AS A12
        ON
            A11.mandant_id = A12.mandant_id AND A11.art_id = A12.art_id
            AND A12.arthiertyp_id = 2 AND A12.dat_bis = PARSE_DATE('%F', '9999-12-31')
    INNER JOIN dbp_data.wg_filter_zu_1 AS WFZ
        ON
            A12.wg_id = WFZ.wg_id AND A12.mandant_id = WFZ.mandant_id
            AND WFZ.wg_filter_id = 11 AND WFZ.arthiertyp_id = 2
    INNER JOIN dbp_data.wup_1 AS C ON A11.wup_id = C.wup_id AND A11.mandant_id = C.mandant_id
    WHERE
        A11.dat BETWEEN DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 366 DAY) AND (DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 1 DAY))
        AND A11.mandant_id = 1
        AND A11.bewart_id IN (1001, 1002)
    GROUP BY
        A11.wup_id,
        C.kreistyp_gruppe_id,
        A11.mandant_id,
        A12.wg_id,
        A11.art_id,
        x.list_kz
);


INSERT INTO `_sort_ist1`
(
    SELECT
        A11.wup_id,
        C.kreistyp_gruppe_id,
        A11.mandant_id,
        A12.wg_id,
        A11.art_id,
        CAST(SUM(A11.umsatz_netto + A11.umsatz_mwst_betrag) AS FLOAT64) AS kassenumsatz,
        COUNT(DISTINCT A11.dat) AS anz_tage,
        CAST(IFNULL(SUM(A11.umsatz_netto + A11.umsatz_mwst_betrag) / IF(SUM(A11.menge) = 0, NULL, SUM(A11.menge)), 0) AS FLOAT64)
            AS preis,
        x.list_kz
    FROM dbp_data.artbew_1 AS A11
    INNER JOIN dbp_data.tag_1 AS Y ON A11.dat = Y.dat
    INNER JOIN (SELECT DISTINCT
        mandant_id,
        art_id,
        list_kz
    FROM dbp_etl.kl_basis_listung_1) AS x
        ON
            A11.mandant_id = x.mandant_id AND A11.art_id = x.art_id AND x.list_kz
            = 'B'
    INNER JOIN dbp_data.art_wg_zu_per_1 AS A12
        ON
            A11.mandant_id = A12.mandant_id AND A11.art_id = A12.art_id
            AND A12.arthiertyp_id = 2 AND A12.dat_bis = PARSE_DATE('%F', '9999-12-31')
    INNER JOIN dbp_data.wg_filter_zu_1 AS WFZ
        ON
            A12.wg_id = WFZ.wg_id AND A12.mandant_id = WFZ.mandant_id
            AND WFZ.wg_filter_id = 11 AND WFZ.arthiertyp_id = 2
    INNER JOIN dbp_data.wup_1 AS C ON A11.wup_id = C.wup_id AND A11.mandant_id = C.mandant_id
    WHERE
        A11.dat BETWEEN DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 366 DAY) AND (DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 1 DAY))
        AND A11.mandant_id = 1
        AND A11.bewart_id IN (1001, 1002)
    GROUP BY
        A11.wup_id,
        C.kreistyp_gruppe_id,
        A11.mandant_id,
        A12.wg_id,
        A11.art_id,
        x.list_kz
);


CREATE OR REPLACE TEMPORARY TABLE _anzeige_artikel AS
SELECT
    a.mandant_id,
    D.art_matching_id,
    MAX(CASE
        WHEN a.list_kz = 'A'
            THEN a.art_id
        ELSE 0
    END) AS art_a,
    MAX(CASE
        WHEN a.list_kz = 'B'
            THEN a.art_id
        ELSE 0
    END) AS art_b,
    MAX(CASE
        WHEN a.list_kz = 'C1'
            THEN a.art_id
        ELSE 0
    END) AS art_c1,
    MAX(CASE
        WHEN a.list_kz = 'C2'
            THEN a.art_id
        ELSE 0
    END) AS art_c2,
    MAX(CASE
        WHEN a.list_kz = 'D1'
            THEN a.art_id
        ELSE 0
    END) AS art_d1,
    MAX(CASE
        WHEN a.list_kz = 'D2'
            THEN a.art_id
        ELSE 0
    END) AS art_d2,
    MAX(CASE
        WHEN a.list_kz = 'A'
            THEN 1
        ELSE 0
    END) AS fg_a,
    MAX(CASE
        WHEN a.list_kz = 'B'
            THEN 1
        ELSE 0
    END) AS fg_b,
    MAX(CASE
        WHEN a.list_kz = 'C1'
            THEN 1
        ELSE 0
    END) AS fg_c1,
    MAX(CASE
        WHEN a.list_kz = 'C2'
            THEN 1
        ELSE 0
    END) AS fg_c2,
    MAX(CASE
        WHEN a.list_kz = 'D1'
            THEN 1
        ELSE 0
    END) AS fg_d1,
    MAX(CASE
        WHEN a.list_kz = 'D2'
            THEN 1
        ELSE 0
    END) AS fg_d2,
    MAX(CASE
        WHEN a.list_kz = 'A'
            THEN C.art_status
        ELSE ''
    END) AS status_a,
    MAX(CASE
        WHEN a.list_kz = 'B'
            THEN C.art_status
        ELSE ''
    END) AS status_b,
    MAX(CASE
        WHEN a.list_kz = 'C1'
            THEN C.art_status
        ELSE ''
    END) AS status_c1,
    MAX(CASE
        WHEN a.list_kz = 'C2'
            THEN C.art_status
        ELSE ''
    END) AS status_c2,
    MAX(CASE
        WHEN a.list_kz = 'D1'
            THEN C.art_status
        ELSE ''
    END) AS status_d1,
    MAX(CASE
        WHEN a.list_kz = 'D2'
            THEN C.art_status
        ELSE ''
    END) AS status_d2
FROM (SELECT DISTINCT
    mandant_id,
    art_id,
    list_kz
FROM dbp_etl.kl_basis_listung_1) AS a
INNER JOIN dbp_etl.art_matching_nielsen_per_1 AS D ON a.mandant_id = D.mandant_id AND a.art_id = D.art_id
INNER JOIN dbp_etl.bf_sort_sal_export_1 AS C ON a.art_id / 100 = ROUND(CAST(C.art_nr AS BIGNUMERIC), 0)
GROUP BY
    a.mandant_id,
    D.art_matching_id
HAVING COUNT(*) > 1 AND fg_a + fg_b + fg_c1 + fg_c2 + fg_d1 + fg_d2 > 1;


--[OK] statement is translated correctly (syntax and type checks are fine)


INSERT INTO dbp_etl.anzeige_artikel_1 (
    mandant_id, art_matching_id, art_a, art_b, art_c1, art_c2, art_d1,
    art_d2, fg_a, fg_b, fg_c1, fg_c2, fg_d1, fg_d2, status_a, status_b, status_c1, status_c2, status_d1, status_d2
)
(
    SELECT *
    FROM `_anzeige_artikel`
);


--[OK] statement is translated correctly (syntax and type checks are fine)


INSERT INTO dbp_etl.sort_ist_1 (
    wup_id, kreistyp_gruppe_id, mandant_id, wg_id, art_id, kassenumsatz,
    anz_tage, preis, list_kz
)
(
    SELECT *
    FROM `_sort_ist1`
);


--[OK] statement is translated correctly (syntax and type checks are fine)


INSERT INTO dbp_etl.sort_ist_1 (
    wup_id, kreistyp_gruppe_id, mandant_id, wg_id, art_id, kassenumsatz,
    anz_tage, preis, list_kz
)
(
    SELECT
        A.wup_id,
        D.kreistyp_gruppe_id,
        A.mandant_id,
        C.wg_id,
        A.art_id,
        CAST(0 AS FLOAT64) AS kassenumsatz,
        0 AS anz_tage,
        CAST(0 AS FLOAT64) AS preis,
        b.list_kz
    FROM dbp_data.art_list_wup_zu_per_1 AS A
    INNER JOIN (SELECT DISTINCT
        mandant_id,
        art_id,
        list_kz
    FROM dbp_etl.kl_basis_listung_1) AS b ON A.mandant_id = b.mandant_id AND A.art_id = b.art_id
    INNER JOIN dbp_data.art_wg_zu_per_1 AS C
        ON
            A.mandant_id = C.mandant_id AND A.art_id = C.art_id AND C.arthiertyp_id
            = 2 AND C.dat_bis = PARSE_DATE('%F', '9999-12-31')
    INNER JOIN dbp_data.wg_per_1 AS E
        ON
            A.mandant_id = E.mandant_id AND C.wg_id = E.wg_id AND E.arthiertyp_id
            = 2 AND E.dat_bis = PARSE_DATE('%F', '9999-12-31')
    INNER JOIN dbp_data.wg_filter_zu_1 AS WFZ
        ON
            C.wg_id = WFZ.wg_id AND C.mandant_id = WFZ.mandant_id AND
            WFZ.wg_filter_id = 11 AND WFZ.arthiertyp_id = 2
    INNER JOIN dbp_etl_process.sort_tool_owg_de_1 AS F ON E.owg_id = F.owg_id
    INNER JOIN dbp_data.wup_1 AS D
        ON
            A.wup_id = D.wup_id AND A.mandant_id = D.mandant_id AND CURRENT_DATE("Europe/Berlin")
            BETWEEN D.dat_von AND D.dat_bis AND D.nb_id = 0 AND D.wup_id >= 1300
    WHERE
        A.nb_id = 0
        AND CURRENT_DATE("Europe/Berlin") BETWEEN A.dat_von AND A.dat_bis
        AND A.list_komponente_fg = 0
        AND (
            A.mandant_id, A.art_id, A.wup_id) NOT IN (
            SELECT (mandant_id, art_id, wup_id)
            FROM `_sort_ist1`
        )
        AND A.list_quelle_id NOT IN ('2')
    GROUP BY
        A.wup_id,
        D.kreistyp_gruppe_id,
        A.mandant_id,
        C.wg_id,
        A.art_id,
        kassenumsatz,
        anz_tage,
        preis,
        b.list_kz
);
