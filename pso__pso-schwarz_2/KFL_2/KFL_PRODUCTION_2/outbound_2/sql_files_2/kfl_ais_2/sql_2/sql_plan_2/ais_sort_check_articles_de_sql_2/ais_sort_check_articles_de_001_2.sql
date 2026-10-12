CREATE OR REPLACE TEMPORARY TABLE _dup_art_1 AS
SELECT
    t3.mandant_id,
    t3.kjwo_update,
    t3.art_id0 AS art_id,
    t3.anzahl
FROM (
    SELECT
        A.mandant_id,
        A.kjwo_update,
        B.art_id AS art_id0,
        COUNT(DISTINCT B.art_matching_id) AS anzahl
    FROM dbp_data.sortiment_leistung_2 AS A
    INNER JOIN dbp_etl.art_matching_nielsen_per_2 AS B
        ON
            A.matching_id = B.art_matching_id AND A.mandant_id
            = B.mandant_id
    WHERE
        A.art_id IS NOT NULL
        AND B.art_id <> -1
        AND A.mandant_id = 1
        AND A.kjwo_update IN (
            SELECT MAX(kjwo_update) AS kjwo_update
            FROM dbp_data.art_kl_preislage_zu_per_2
            WHERE mandant_id = 1
        )
    GROUP BY
        A.mandant_id,
        A.kjwo_update,
        B.art_id
    HAVING anzahl > 1
) AS t3;


CREATE OR REPLACE TEMPORARY TABLE _dup_art_2 AS
SELECT
    A.art_matching_id AS art_matching_id_ref,
    A.art_id,
    B.matching_id AS matching_id_sort,
    B.kjwo_update,
    B.mandant_id,
    B.rang_umsatz_wg,
    A.status_2
FROM dbp_etl.art_matching_nielsen_per_2 AS A
INNER JOIN
    `_dup_art_1` AS X
    ON A.art_id = X.art_id AND A.mandant_id = X.mandant_id
INNER JOIN dbp_data.sortiment_leistung_2 AS B
    ON
        A.mandant_id = B.mandant_id AND A.art_matching_id = B.matching_id
        AND X.kjwo_update = B.kjwo_update
WHERE
    B.art_id IS NOT NULL
    AND A.art_id <> -1
    AND B.mandant_id = 1
    AND B.kjwo_update IN (
        SELECT MAX(kjwo_update) AS kjwo_update
        FROM dbp_data.art_kl_preislage_zu_per_2
        WHERE mandant_id = 1
    );


DELETE FROM `_dup_art_2`
WHERE (
    matching_id_sort, art_id) IN (
    SELECT (matching_id_sort, art_id)
    FROM `_dup_art_2`
    WHERE (
        art_id, rang_umsatz_wg) IN (
        SELECT (art_id, MIN(rang_umsatz_wg))
        FROM `_dup_art_2`
        GROUP BY art_id
    )
    GROUP BY matching_id_sort,
    art_id
);


DELETE FROM dbp_data.sortiment_leistung_2
WHERE (
    mandant_id, kjwo_update, matching_id) IN (
    SELECT (mandant_id, kjwo_update, matching_id_sort)
    FROM `_dup_art_2`
);


CREATE OR REPLACE TEMPORARY TABLE _dup_art_1 AS
SELECT
    t3.mandant_id,
    t3.kjwo_update,
    t3.art_id0 AS art_id,
    t3.anzahl
FROM (
    SELECT
        A.mandant_id,
        A.kjwo_update,
        B.art_id AS art_id0,
        COUNT(DISTINCT B.art_matching_id) AS anzahl
    FROM dbp_data.sortiment_leistung_2 AS A
    INNER JOIN dbp_etl.art_matching_nielsen_per_2 AS B
        ON
            A.matching_id = B.art_matching_id AND A.mandant_id
            = B.mandant_id
    WHERE
        A.art_id IS NOT NULL
        AND B.art_id <> -1
        AND A.mandant_id = 1
        AND A.kjwo_update IN (
            SELECT MAX(kjwo_update) AS kjwo_update
            FROM dbp_data.art_kl_preislage_zu_per_2
            WHERE mandant_id = 1
        )
    GROUP BY
        A.mandant_id,
        A.kjwo_update,
        B.art_id
    HAVING anzahl > 1
) AS t3;


CREATE OR REPLACE TEMPORARY TABLE _dup_art_2 AS
SELECT
    A.art_matching_id AS art_matching_id_ref,
    A.art_id,
    B.matching_id AS matching_id_sort,
    B.kjwo_update,
    B.mandant_id,
    B.rang_umsatz_wg,
    A.status_2
FROM dbp_etl.art_matching_nielsen_per_2 AS A
INNER JOIN
    `_dup_art_1` AS X
    ON A.art_id = X.art_id AND A.mandant_id = X.mandant_id
INNER JOIN dbp_data.sortiment_leistung_2 AS B
    ON
        A.mandant_id = B.mandant_id AND A.art_matching_id = B.matching_id
        AND X.kjwo_update = B.kjwo_update
WHERE
    B.art_id IS NOT NULL
    AND A.art_id <> -1
    AND B.mandant_id = 1
    AND B.kjwo_update IN (
        SELECT MAX(kjwo_update) AS kjwo_update
        FROM dbp_data.art_kl_preislage_zu_per_2
        WHERE mandant_id = 1
    );


DELETE FROM `_dup_art_2`
WHERE (
    matching_id_sort, art_id) IN (
    SELECT (matching_id_sort, art_id)
    FROM `_dup_art_2`
    WHERE (
        art_id, matching_id_sort) IN (
        SELECT (art_id, MAX(matching_id_sort))
        FROM `_dup_art_2`
        GROUP BY art_id
    )
    GROUP BY matching_id_sort,
    art_id
);


DELETE FROM dbp_data.sortiment_leistung_2
WHERE (
    mandant_id, kjwo_update, matching_id) IN (
    SELECT (mandant_id, kjwo_update, matching_id_sort)
    FROM `_dup_art_2`
);
