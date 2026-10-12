--multiple gtin's version


CREATE OR REPLACE TEMPORARY TABLE _distinct_nl_arts AS
SELECT
    A.mandant_id,
    A.art_nielsen_id,
    b.gtin_id,
    SUM(A.menge) AS menge
FROM dbp_data.art_nielsen_fakten_kjmo_1 AS A
INNER JOIN (SELECT DISTINCT
    mandant_id,
    art_nielsen_id,
    gtin_id
FROM dbp_data.art_nielsen_1
WHERE (
    mandant_id, art_nielsen_id) IN (
    SELECT (mandant_id, art_nielsen_id)
    FROM dbp_etl_process.art_nielsen_gtin_zu_1
)
UNION DISTINCT
SELECT DISTINCT
    mandant_id,
    art_nielsen_id,
    gtin_ref_id AS gtin_id
FROM dbp_etl_process.art_nielsen_gtin_zu_1) AS b
    ON
        A.mandant_id = b.mandant_id AND A.art_nielsen_id = b.art_nielsen_id
INNER JOIN dbp_data.nielsen_market_1 AS C ON A.mandant_id = C.mandant_id AND A.nielsen_market_id = C.nielsen_market_id

WHERE (A.mandant_id, A.kjmo) IN (
    SELECT (mandant_id, kjmo)
    FROM dbp_data.art_nielsen_fakten_kjmo_1
    WHERE mandant_id IN (2, 3, 5, 6, 7, 8)
    GROUP BY
        mandant_id,
        kjmo
    QUALIFY ((RANK() OVER (PARTITION BY mandant_id ORDER BY kjmo IS NULL DESC, kjmo DESC)) * -1) BETWEEN -12 AND (-1)
)
AND A.mandant_id IN (2, 3, 5, 6, 7, 8)
AND C.nielsen_market_cluster_id IN (1, 2)
GROUP BY
    A.mandant_id,
    A.art_nielsen_id,
    b.gtin_id;


-- step1 for kl-articles


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
    WHERE mandant_id IN (2, 3, 5, 6, 7, 8)
) AS b
    ON A.gtin_id = b.gtin_id AND A.mandant_id = b.mandant_id
GROUP BY
    A.mandant_id,
    A.art_nielsen_id,
    b.art_id,
    A.gtin_id;


-- step2 for nl-articles


INSERT INTO `_article_matching0`
(
    SELECT
        mandant_id,
        art_nielsen_id,
        -1 AS art_id,
        gtin_id
    FROM `_distinct_nl_arts`
    WHERE (
        mandant_id, art_nielsen_id, gtin_id) NOT IN (
        SELECT (mandant_id, art_nielsen_id, gtin_id)
        FROM `_article_matching0`
    )
    GROUP BY
        mandant_id,
        art_nielsen_id,
        art_id,
        gtin_id
);


CREATE OR REPLACE TEMPORARY TABLE _nielsen_kl_matching (
    mandant_id INTEGER NOT NULL,
    matching_id INTEGER NOT NULL,
    art_nielsen_id INTEGER NOT NULL,
    art_id INTEGER NOT NULL,
    gtin_id INTEGER NOT NULL
);


-- 1st level


INSERT INTO `_nielsen_kl_matching` (mandant_id, matching_id, art_nielsen_id, art_id, gtin_id)
(
    SELECT
        mandant_id,
        art_matching_id,
        art_nielsen_id,
        art_id,
        gtin_id
    FROM dbp_etl_process.art_art_nielsen_matching_zu_kmo_1
    WHERE (
        mandant_id, art_id, art_nielsen_id) IN (
        SELECT (mandant_id, art_id, art_nielsen_id)
        FROM `_article_matching0`
    )
    AND kjwo_update IN (
        SELECT MAX(kjwo_update) AS a1290333724
        FROM dbp_etl_process.art_art_nielsen_matching_zu_kmo_1
    )
    AND (mandant_id, art_matching_id, art_id, art_nielsen_id, gtin_id) NOT IN (SELECT (
        mandant_id, matching_id, art_id,
        art_nielsen_id, gtin_id
    )
    FROM `_nielsen_kl_matching`)
    GROUP BY
        mandant_id,
        art_matching_id,
        art_id,
        art_nielsen_id,
        gtin_id
);


DELETE FROM `_article_matching0`
WHERE (
    mandant_id, art_nielsen_id, art_id) IN (
    SELECT (mandant_id, art_nielsen_id, art_id)
    FROM `_nielsen_kl_matching`
);


-- 2nd level


INSERT INTO `_nielsen_kl_matching` (mandant_id, matching_id, art_nielsen_id, art_id, gtin_id)
(
    SELECT
        mandant_id,
        art_matching_id,
        art_nielsen_id,
        art_id,
        gtin_id
    FROM dbp_etl_process.art_art_nielsen_matching_zu_kmo_1
    WHERE (
        mandant_id, art_nielsen_id) IN (
        SELECT (mandant_id, art_nielsen_id)
        FROM `_article_matching0`
        WHERE art_nielsen_id <> -1
    )
    AND kjwo_update IN (
        SELECT MAX(kjwo_update) AS a1290333724
        FROM dbp_etl_process.art_art_nielsen_matching_zu_kmo_1
    )
    AND (mandant_id, art_matching_id, art_id, art_nielsen_id, gtin_id) NOT IN (SELECT (
        mandant_id, matching_id, art_id,
        art_nielsen_id, gtin_id
    )
    FROM `_nielsen_kl_matching`)
    GROUP BY
        mandant_id,
        art_matching_id,
        art_id,
        art_nielsen_id,
        gtin_id
);


DELETE FROM `_article_matching0`
WHERE (
    mandant_id, art_nielsen_id) IN (
    SELECT (mandant_id, art_nielsen_id)
    FROM `_nielsen_kl_matching`
    WHERE art_nielsen_id <> -1
);


-- 3rd level


INSERT INTO `_nielsen_kl_matching` (mandant_id, matching_id, art_nielsen_id, art_id, gtin_id)
(
    SELECT
        mandant_id,
        art_matching_id,
        art_nielsen_id,
        art_id,
        gtin_id
    FROM dbp_etl_process.art_art_nielsen_matching_zu_kmo_1
    WHERE (
        mandant_id, art_id, gtin_id) IN (
        SELECT (mandant_id, art_id, gtin_id)
        FROM `_article_matching0`
        WHERE
            art_id <> -1
            AND gtin_id NOT IN (-9999, -9998)
    )
    AND kjwo_update IN (
        SELECT MAX(kjwo_update) AS a1290333724
        FROM dbp_etl_process.art_art_nielsen_matching_zu_kmo_1
    )
    AND (mandant_id, art_matching_id, art_id, art_nielsen_id, gtin_id) NOT IN (SELECT (
        mandant_id, matching_id, art_id,
        art_nielsen_id, gtin_id
    )
    FROM `_nielsen_kl_matching`)
    GROUP BY
        mandant_id,
        art_matching_id,
        art_id,
        art_nielsen_id,
        gtin_id
);


DELETE FROM `_article_matching0`
WHERE (
    mandant_id, art_id, gtin_id) IN (
    SELECT (mandant_id, art_id, gtin_id)
    FROM `_nielsen_kl_matching`
    WHERE
        art_id <> -1
        AND gtin_id NOT IN (-9999, -9998)
);


-- 4th level


INSERT INTO `_nielsen_kl_matching` (mandant_id, matching_id, art_nielsen_id, art_id, gtin_id)
(
    SELECT
        mandant_id,
        art_matching_id,
        art_nielsen_id,
        art_id,
        gtin_id
    FROM dbp_etl_process.art_art_nielsen_matching_zu_kmo_1
    WHERE (
        mandant_id, art_id) IN (
        SELECT (mandant_id, art_id)
        FROM `_article_matching0`
        WHERE art_id <> -1
    )
    AND kjwo_update IN (
        SELECT MAX(kjwo_update) AS a1290333724
        FROM dbp_etl_process.art_art_nielsen_matching_zu_kmo_1
    )
    AND (mandant_id, art_matching_id, art_id, art_nielsen_id, gtin_id) NOT IN (SELECT (
        mandant_id, matching_id, art_id,
        art_nielsen_id, gtin_id
    )
    FROM `_nielsen_kl_matching`)
    GROUP BY
        mandant_id,
        art_matching_id,
        art_id,
        art_nielsen_id,
        gtin_id
);


DELETE FROM `_article_matching0`
WHERE (
    mandant_id, art_id) IN (
    SELECT (mandant_id, art_id)
    FROM `_nielsen_kl_matching`
    WHERE art_id <> -1
);


-- 5th level


INSERT INTO `_nielsen_kl_matching` (mandant_id, matching_id, art_nielsen_id, art_id, gtin_id)
(
    SELECT
        mandant_id,
        art_matching_id,
        art_nielsen_id,
        art_id,
        gtin_id
    FROM dbp_etl_process.art_art_nielsen_matching_zu_kmo_1
    WHERE (
        mandant_id, gtin_id) IN (
        SELECT (mandant_id, gtin_id)
        FROM `_article_matching0`
        WHERE gtin_id NOT IN (-9999, -9998)
    )
    AND kjwo_update IN (
        SELECT MAX(kjwo_update) AS a1290333724
        FROM dbp_etl_process.art_art_nielsen_matching_zu_kmo_1
    )
    AND (mandant_id, art_matching_id, art_id, art_nielsen_id, gtin_id) NOT IN (SELECT (
        mandant_id, matching_id, art_id,
        art_nielsen_id, gtin_id
    )
    FROM `_nielsen_kl_matching`)
    GROUP BY
        mandant_id,
        art_matching_id,
        art_id,
        art_nielsen_id,
        gtin_id
);


DELETE FROM `_article_matching0`
WHERE (
    mandant_id, gtin_id) IN (
    SELECT (mandant_id, gtin_id)
    FROM `_nielsen_kl_matching`
    WHERE gtin_id NOT IN (-9999, -9998)
);


-- 1


CREATE OR REPLACE TEMPORARY TABLE _upd_new_match AS
SELECT DISTINCT
    b.mandant_id,
    c.max_art_matching_id AS art_matching_id,
    b.art_nielsen_id,
    A.art_id,
    A.gtin_id,
    DENSE_RANK() OVER (ORDER BY A.mandant_id IS NULL, A.mandant_id, A.art_nielsen_id IS NULL, A.art_nielsen_id) AS rang
FROM `_article_matching0` AS A
INNER JOIN (
    SELECT *
    FROM (SELECT DISTINCT
        mandant_id,
        art_nielsen_id,
        gtin_id
    FROM dbp_data.art_nielsen_1
    WHERE (
        mandant_id, art_nielsen_id) IN (
        SELECT (mandant_id, art_nielsen_id)
        FROM dbp_etl_process.art_nielsen_gtin_zu_1
    )
    UNION DISTINCT
    SELECT DISTINCT
        mandant_id,
        art_nielsen_id,
        gtin_ref_id AS gtin_id
    FROM dbp_etl_process.art_nielsen_gtin_zu_1) AS t5
) AS b
    ON
        A.mandant_id = b.mandant_id AND A.art_nielsen_id
        = b.art_nielsen_id AND A.gtin_id = b.gtin_id AND A.gtin_id NOT IN (-9999, -9998)
INNER JOIN (SELECT
    mandant_id,
    MAX(art_matching_id) AS max_art_matching_id
FROM dbp_etl_process.art_art_nielsen_matching_zu_kmo_1
GROUP BY mandant_id) AS c ON TRUE;


INSERT INTO `_nielsen_kl_matching` (mandant_id, matching_id, art_nielsen_id, art_id, gtin_id)
(SELECT
    mandant_id,
    art_matching_id + rang,
    art_nielsen_id,
    art_id,
    gtin_id
FROM `_upd_new_match` AS A);


DELETE FROM `_article_matching0`
WHERE (
    mandant_id, art_nielsen_id) IN (
    SELECT (mandant_id, art_nielsen_id)
    FROM `_nielsen_kl_matching`
    WHERE art_nielsen_id <> -1
);


-- start of integrating new article references


DELETE FROM `_nielsen_kl_matching`
WHERE (
    mandant_id, matching_id) IN (
    SELECT (mandant_id, art_matching_id)
    FROM dbp_etl_process.art_art_nielsen_matching_zu_kmo_1
    WHERE
        kjwo_update IN (
            SELECT MAX(kjwo_update) AS a1290333724
            FROM dbp_etl_process.art_art_nielsen_matching_zu_kmo_1
        )
);


INSERT INTO dbp_etl_process.art_art_nielsen_matching_zu_kmo_1
(
    SELECT
        A.mandant_id,
        B.art_matching_id,
        A.art_id,
        A.art_nielsen_id,
        A.gtin_id,
        B.kl_art_kat_id,
        B.kl_wg_id,
        B.kl_owg_id,
        B.kl_uwg_id,
        B.umrech_faktor,
        B.status_1,
        B.list_kz,
        B.komponente_fg,
        B.kjwo_update,
        CURRENT_TIMESTAMP(),
        CURRENT_TIMESTAMP()
    FROM `_nielsen_kl_matching` AS A
    INNER JOIN dbp_etl_process.art_art_nielsen_matching_zu_kmo_1 AS B
        ON
            A.mandant_id = B.mandant_id AND A.gtin_id
            = B.gtin_id AND A.art_nielsen_id = B.art_nielsen_id
    WHERE
        B.kjwo_update IN (
            SELECT MAX(kjwo_update) AS a1290333724
            FROM dbp_etl_process.art_art_nielsen_matching_zu_kmo_1
        )
        AND (
            A.mandant_id, A.art_id) NOT IN (
            SELECT (mandant_id, art_id)
            FROM dbp_etl_process.art_art_nielsen_matching_zu_kmo_1
            WHERE
                kjwo_update IN (
                    SELECT MAX(kjwo_update) AS a1290333724
                    FROM dbp_etl_process.art_art_nielsen_matching_zu_kmo_1
                )
        )
);


INSERT INTO dbp_etl_process.art_art_nielsen_matching_zu_kmo_1
(SELECT
    mandant_id,
    matching_id,
    art_id,
    art_nielsen_id,
    gtin_id,
    0,
    0,
    0,
    0,
    1,
    'N',
    CAST(NULL AS STRING),
    0,
    (
        SELECT MAX(kjwo_update)
        FROM dbp_etl_process.art_art_nielsen_matching_zu_kmo_1
    ),
    CURRENT_TIMESTAMP(),
    CURRENT_TIMESTAMP()
FROM `_nielsen_kl_matching`
WHERE (
    mandant_id, matching_id) NOT IN (
    SELECT (mandant_id, art_matching_id)
    FROM dbp_etl_process.art_art_nielsen_matching_zu_kmo_1
    WHERE
        kjwo_update IN (
            SELECT MAX(kjwo_update) AS a1290333724
            FROM dbp_etl_process.art_art_nielsen_matching_zu_kmo_1
        )
)
AND (mandant_id, matching_id, art_id, art_nielsen_id, gtin_id) NOT IN (SELECT (
    mandant_id, art_matching_id, art_id,
    art_nielsen_id, gtin_id
)
FROM dbp_etl_process.art_art_nielsen_matching_zu_kmo_1
WHERE kjwo_update IN (
    SELECT MAX(kjwo_update) AS a1290333724
    FROM dbp_etl_process.art_art_nielsen_matching_zu_kmo_1
)));


-- retracking of eventually missing rows
--
-- single gtins and multipple art_nielsen_id


CREATE OR REPLACE TEMPORARY TABLE _upd_new_match AS
SELECT
    mandant_id,
    (
        SELECT MAX(art_matching_id)
        FROM dbp_etl_process.art_art_nielsen_matching_zu_kmo_1
        WHERE mandant_id IN (2, 3, 5, 6, 7, 8)
    ) AS art_matching_id,
    art_nielsen_id,
    -1 AS art_id,
    gtin_id,
    DENSE_RANK() OVER (ORDER BY mandant_id IS NULL, mandant_id, art_nielsen_id IS NULL, art_nielsen_id) AS rang
FROM `_distinct_nl_arts`
WHERE (
    mandant_id, gtin_id) IN (
    SELECT (mandant_id, gtin_id)
    FROM `_distinct_nl_arts`
    WHERE (
        mandant_id, gtin_id) NOT IN (
        SELECT (mandant_id, gtin_id)
        FROM dbp_etl_process.art_art_nielsen_matching_zu_kmo_1
        WHERE
            kjwo_update IN (
                SELECT MAX(kjwo_update) AS a1290333724
                FROM dbp_etl_process.art_art_nielsen_matching_zu_kmo_1
            )
    )
    GROUP BY
        mandant_id,
        gtin_id
    HAVING COUNT(*) = 1
);


TRUNCATE TABLE `_nielsen_kl_matching`;


INSERT INTO `_nielsen_kl_matching` (mandant_id, matching_id, art_nielsen_id, art_id, gtin_id)
(SELECT
    mandant_id,
    art_matching_id + rang,
    art_nielsen_id,
    art_id,
    gtin_id
FROM `_upd_new_match` AS A);


INSERT INTO dbp_etl_process.art_art_nielsen_matching_zu_kmo_1
(SELECT
    mandant_id,
    matching_id,
    art_id,
    art_nielsen_id,
    gtin_id,
    0,
    0,
    0,
    0,
    1,
    'N',
    CAST(NULL AS STRING),
    0,
    (
        SELECT MAX(kjwo_update)
        FROM dbp_etl_process.art_art_nielsen_matching_zu_kmo_1
    ),
    CURRENT_TIMESTAMP(),
    CURRENT_TIMESTAMP()
FROM `_nielsen_kl_matching`
WHERE (
    mandant_id, matching_id) NOT IN (
    SELECT (mandant_id, art_matching_id)
    FROM dbp_etl_process.art_art_nielsen_matching_zu_kmo_1
    WHERE
        kjwo_update IN (
            SELECT MAX(kjwo_update) AS a1290333724
            FROM dbp_etl_process.art_art_nielsen_matching_zu_kmo_1
        )
)
AND (mandant_id, matching_id, art_id, art_nielsen_id, gtin_id) NOT IN (SELECT (
    mandant_id, art_matching_id, art_id,
    art_nielsen_id, gtin_id
)
FROM dbp_etl_process.art_art_nielsen_matching_zu_kmo_1
WHERE kjwo_update IN (
    SELECT MAX(kjwo_update) AS a1290333724
    FROM dbp_etl_process.art_art_nielsen_matching_zu_kmo_1
)));
