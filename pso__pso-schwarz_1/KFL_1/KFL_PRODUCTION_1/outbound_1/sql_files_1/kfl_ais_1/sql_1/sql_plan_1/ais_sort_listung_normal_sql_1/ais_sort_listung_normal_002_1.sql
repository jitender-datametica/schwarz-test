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


CREATE OR REPLACE TEMPORARY TABLE _sst_plus_regio AS
(
    SELECT
        A.mandant_id,
        A.art_id,
        A.wup_id
    FROM `_art_list_wup_zu_per` AS A
    INNER JOIN dbp_data.wup_1 AS B ON A.mandant_id = B.mandant_id AND A.wup_id = B.wup_id
    WHERE
        TRIM(A.list_quelle_id) IN ('1', '7')
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
    INNER JOIN dbp_data.wup_1 AS B ON A.mandant_id = B.mandant_id AND A.wup_id = B.wup_id
    WHERE
        TRIM(A.list_quelle_id) IN ('3')
        AND B.nb_id = 0
        AND B.dat_eroeffnung < CURRENT_DATE("Europe/Berlin")
        AND A.baustein_id NOT IN (
            SELECT baustein_id
            FROM dbp_etl.baustein_wsop_1
            WHERE CURRENT_DATE("Europe/Berlin") BETWEEN dat_von AND dat_bis
        )
    GROUP BY
        A.art_id,
        A.wup_id,
        A.mandant_id
)
UNION DISTINCT
SELECT
    A.mandant_id,
    A.art_id,
    A.wup_id
FROM `_art_list_wup_zu_per` AS A
INNER JOIN dbp_data.wup_1 AS B ON A.mandant_id = B.mandant_id AND A.wup_id = B.wup_id
WHERE
    TRIM(A.list_quelle_id) IN ('3')
    AND A.baustein_id IN (
        SELECT baustein_id
        FROM dbp_etl.baustein_region_zu_1
    )
    AND B.nb_id = 0
    AND B.dat_eroeffnung < CURRENT_DATE("Europe/Berlin")
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
INNER JOIN dbp_data.wup_1 AS B ON A.mandant_id = B.mandant_id AND A.wup_id = B.wup_id
WHERE
    TRIM(A.list_quelle_id) IN ('3')
    AND A.baustein_id IN (
        SELECT baustein_id
        FROM dbp_etl.baustein_wsop_1
        WHERE
            CURRENT_DATE("Europe/Berlin") BETWEEN dat_von AND dat_bis
            AND mandant_id = 1
    )
    AND B.nb_id = 0
    AND B.dat_eroeffnung < CURRENT_DATE("Europe/Berlin")
    AND A.baustein_id NOT IN (
        SELECT baustein_id
        FROM dbp_etl.baustein_region_zu_1
    )
GROUP BY
    A.mandant_id,
    A.art_id,
    A.wup_id;


CREATE OR REPLACE TEMPORARY TABLE _einzel_markt AS
SELECT
    A.mandant_id,
    A.art_id,
    A.wup_id
FROM `_art_list_wup_zu_per` AS A
INNER JOIN dbp_data.wup_1 AS B ON A.mandant_id = B.mandant_id AND A.wup_id = B.wup_id
WHERE
    TRIM(A.list_quelle_id) IN ('C')
    AND B.nb_id = 0
    AND B.dat_eroeffnung < CURRENT_DATE("Europe/Berlin")
GROUP BY
    A.mandant_id,
    A.art_id,
    A.wup_id;


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
    listung_sst_mvke = NULL
WHERE TRIM(
    listung_sst_mvke) = '-1' AND mandant_id = 1 AND kjwo_update IN (
    SELECT MAX(kjwo_update) AS a1290333724
    FROM dbp_data.sortiment_leistung_1
    WHERE mandant_id = 1
);


UPDATE dbp_data.sortiment_leistung_1 SET
    anz_maerkte_sst = 0
WHERE art_id IS NOT NULL AND mandant_id = 1 AND kjwo_update IN (
    SELECT MAX(kjwo_update) AS a1290333724
    FROM dbp_data.sortiment_leistung_1
    WHERE mandant_id = 1
);


UPDATE dbp_data.sortiment_leistung_1 SET
    anz_maerkte_listung_einzel = 0
WHERE art_id IS NOT NULL AND mandant_id = 1 AND kjwo_update IN (
    SELECT MAX(kjwo_update) AS a1290333724
    FROM dbp_data.sortiment_leistung_1
    WHERE mandant_id = 1
);


UPDATE dbp_data.sortiment_leistung_1 SET
    anz_maerkte_baustein_sonstige = 0
WHERE art_id IS NOT NULL AND mandant_id = 1 AND kjwo_update IN (
    SELECT MAX(kjwo_update) AS a1290333724
    FROM dbp_data.sortiment_leistung_1
    WHERE mandant_id = 1
);


UPDATE dbp_data.sortiment_leistung_1 SET
    anz_maerkte_listung_gesamt = 0
WHERE art_id IS NOT NULL AND mandant_id = 1 AND kjwo_update IN (
    SELECT MAX(kjwo_update) AS a1290333724
    FROM dbp_data.sortiment_leistung_1
    WHERE mandant_id = 1
);


UPDATE dbp_data.sortiment_leistung_1 SET
    ost_basis =
    '\nWHERE art_id IS NOT NULL AND\n      mandant_id = 1 AND\n      kjwo_update IN (SELECT MAX(kjwo_update) FROM dbp_data.sortiment_leistung_1 WHERE mandant_id = 1)\n;\n\nUPDATE DBP_DATA.sortiment_leistung_1 SET ost_gross = '

WHERE art_id IS NOT NULL AND mandant_id = 1 AND kjwo_update IN (
    SELECT MAX(kjwo_update) AS a1290333724
    FROM dbp_data.sortiment_leistung_1
    WHERE mandant_id = 1
);


UPDATE dbp_data.sortiment_leistung_1 SET
    sued_ost =
    '\nWHERE art_id IS NOT NULL AND\n      mandant_id = 1 AND\n      kjwo_update IN (SELECT MAX(kjwo_update) FROM dbp_data.sortiment_leistung_1 WHERE mandant_id = 1)\n;\n\nUPDATE DBP_DATA.sortiment_leistung_1 SET sued_west = '

WHERE art_id IS NOT NULL AND mandant_id = 1 AND kjwo_update IN (
    SELECT MAX(kjwo_update) AS a1290333724
    FROM dbp_data.sortiment_leistung_1
    WHERE mandant_id = 1
);


UPDATE dbp_data.sortiment_leistung_1 SET
    nord =
    '\nWHERE art_id IS NOT NULL AND\n      mandant_id = 1 AND\n      kjwo_update IN (SELECT MAX(kjwo_update) FROM dbp_data.sortiment_leistung_1 WHERE mandant_id = 1)\n;\n\nUPDATE DBP_DATA.sortiment_leistung_1 SET west = '

WHERE art_id IS NOT NULL AND mandant_id = 1 AND kjwo_update IN (
    SELECT MAX(kjwo_update) AS a1290333724
    FROM dbp_data.sortiment_leistung_1
    WHERE mandant_id = 1
);


UPDATE dbp_data.sortiment_leistung_1 SET
    anz_maerkte_sst = b.anz_markt FROM (
    SELECT *
    FROM `_sst`
    WHERE art_id IN (
        SELECT art_id
        FROM dbp_etl.art_matching_nielsen_per_1
        WHERE status_1 = 'N'
    )
) AS b
WHERE sortiment_leistung.art_id = b.art_id AND sortiment_leistung.mandant_id = 1 AND sortiment_leistung.kjwo_update IN (
    SELECT MAX(kjwo_update) AS a1290333724
    FROM dbp_data.sortiment_leistung_1
    WHERE mandant_id = 1
);


UPDATE dbp_data.sortiment_leistung_1 SET
    anz_maerkte_baustein_sonstige = b.anz_markt FROM (
    SELECT *
    FROM `_bst`
    WHERE art_id IN (
        SELECT art_id
        FROM dbp_etl.art_matching_nielsen_per_1
        WHERE status_1 = 'N'
    )
) AS b
WHERE sortiment_leistung.art_id = b.art_id AND sortiment_leistung.mandant_id = 1 AND sortiment_leistung.kjwo_update IN (
    SELECT MAX(kjwo_update) AS a1290333724
    FROM dbp_data.sortiment_leistung_1
    WHERE mandant_id = 1
);


UPDATE dbp_data.sortiment_leistung_1 SET
    anz_maerkte_listung_einzel = b.anz_markt FROM (
    SELECT *
    FROM `_mkt`
    WHERE art_id IN (
        SELECT art_id
        FROM dbp_etl.art_matching_nielsen_per_1
        WHERE status_1 = 'N'
    )
) AS b
WHERE sortiment_leistung.art_id = b.art_id AND sortiment_leistung.mandant_id = 1 AND sortiment_leistung.kjwo_update IN (
    SELECT MAX(kjwo_update) AS a1290333724
    FROM dbp_data.sortiment_leistung_1
    WHERE mandant_id = 1
);


UPDATE dbp_data.sortiment_leistung_1 SET
    anz_maerkte_listung_gesamt = b.anz_markt FROM (
    SELECT *
    FROM `_gesamt_sicht`
    WHERE art_id IN (
        SELECT art_id
        FROM dbp_etl.art_matching_nielsen_per_1
        WHERE status_1 = 'N'
    )
) AS b
WHERE sortiment_leistung.art_id = b.art_id AND sortiment_leistung.mandant_id = 1 AND sortiment_leistung.kjwo_update IN (
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

    WHERE
        A.mandant_id = 1
        AND CURRENT_DATE("Europe/Berlin") BETWEEN A.dat_von AND A.dat_bis
        AND A.art_id IN (
            SELECT art_id
            FROM dbp_etl.art_matching_nielsen_per_1
            WHERE status_1 = 'N'
        )
    GROUP BY A.art_id
) AS x
WHERE sortiment_leistung.art_id = x.art_id AND sortiment_leistung.mandant_id = 1 AND sortiment_leistung.kjwo_update IN (
    SELECT MAX(kjwo_update) AS a1290333724
    FROM dbp_data.sortiment_leistung_1
    WHERE mandant_id = 1
);


UPDATE dbp_data.sortiment_leistung_1 SET
    listung_sst_mvke = CAST(t3.sm_id AS STRING) FROM (
    SELECT
        mandant_id,
        art_id,
        MIN(sm_id) AS sm_id
    FROM dbp_etl_process.art_sm_vw_zu_per_1
    WHERE
        mandant_id = 1
        AND CURRENT_DATE("Europe/Berlin") BETWEEN dat_von AND dat_bis
        AND art_id IN (
            SELECT art_id
            FROM dbp_etl.art_matching_nielsen_per_1
            WHERE status_1 = 'N'
        )
    GROUP BY
        art_id,
        mandant_id
) AS t3
WHERE
    sortiment_leistung.mandant_id = t3.mandant_id AND sortiment_leistung.art_id = t3.art_id AND sortiment_leistung.mandant_id
    = 1 AND sortiment_leistung.kjwo_update IN (
        SELECT MAX(kjwo_update) AS a1290333724
        FROM dbp_data.sortiment_leistung_1
        WHERE mandant_id = 1
    );
