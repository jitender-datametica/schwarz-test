CREATE OR REPLACE TEMPORARY TABLE _art_nielsen AS
SELECT *
FROM dbp_data.art_nielsen
WHERE dat_bis = DATE '9999-12-31';


DELETE FROM dbp_etl_process.art_art_nielsen_matching_zu
WHERE kjwo_update IN (
    SELECT kjwo
    FROM dbp_data.woche
    WHERE akt_wo = 0
);


INSERT INTO dbp_etl_process.art_art_nielsen_matching_zu (
    mandant_id, art_matching_id, art_id,
    art_nielsen_id, gtin_id, kl_art_kat_id, kl_wg_id, kl_owg_id, kl_uwg_id, umrech_faktor, status, list_kz, komponente_fg,
    kjwo_update
)
(SELECT
    mandant_id,
    art_matching_id,
    art_id,
    art_nielsen_id,
    gtin_id,
    kl_art_kat_id,
    kl_wg_id,
    kl_owg_id,
    kl_uwg_id,
    ROUND(CAST(umrech_faktor AS NUMERIC), 5) AS umrech_faktor,
    status,
    list_kz,
    komponente_fg,
    (
        SELECT kjwo
        FROM dbp_data.woche
        WHERE akt_wo = 0
    ) AS kjwo_update
FROM dbp_etl.art_matching_nielsen_per);


DELETE FROM dbp_etl_process.art_art_nielsen_matching_zu
WHERE kjwo_update IN (
    SELECT kjwo
    FROM dbp_data.woche
    WHERE akt_wo = 1
);


INSERT INTO dbp_etl_process.art_art_nielsen_matching_zu (
    mandant_id, art_matching_id, art_id,
    art_nielsen_id, gtin_id, kl_art_kat_id, kl_wg_id, kl_owg_id, kl_uwg_id, umrech_faktor, status, list_kz, komponente_fg,
    kjwo_update
)
(
    SELECT
        A.mandant_id,
        A.art_matching_id,
        A.art_id,
        A.art_nielsen_id,
        A.gtin_id,
        A.kl_art_kat_id,
        A.kl_wg_id,
        A.kl_owg_id,
        A.kl_uwg_id,
        A.umrech_faktor,
        A.status,
        A.list_kz,
        A.komponente_fg,
        B.kjwo AS kjwo_update
    FROM dbp_etl_process.art_art_nielsen_matching_zu AS A
    INNER JOIN dbp_data.woche AS B ON TRUE
    WHERE
        B.akt_wo = 1
        AND A.kjwo_update IN (
            SELECT MAX(kjwo_update) AS a1290333724
            FROM dbp_etl_process.art_art_nielsen_matching_zu
        )
);


UPDATE dbp_etl_process.art_art_nielsen_groups SET
    kjwo_update = (
        SELECT MAX(kjwo_update)
        FROM dbp_etl_process.art_art_nielsen_matching_zu
    )
WHERE TRUE;


CREATE OR REPLACE TEMPORARY TABLE _distinct_nl_arts AS
SELECT
    A.mandant_id,
    A.art_nielsen_id,
    B.gtin_id,
    SUM(A.menge) AS menge
FROM dbp_data.art_nielsen_fakten_kjwo AS A
INNER JOIN `_art_nielsen` AS B ON A.mandant_id = B.mandant_id AND A.art_nielsen_id = B.art_nielsen_id
INNER JOIN dbp_data.nielsen_market AS C ON A.mandant_id = C.mandant_id AND A.nielsen_market_id = C.nielsen_market_id

WHERE
    A.kjwo IN (
        SELECT kjwo
        FROM dbp_data.art_nielsen_fakten_kjwo
        WHERE mandant_id = 1
        GROUP BY kjwo
        QUALIFY ((RANK() OVER (ORDER BY kjwo IS NULL DESC, kjwo DESC)) * -1) BETWEEN -52 AND (-1)
    )
    AND A.mandant_id = 1
    AND C.nielsen_market_cluster_id IN (1, 2)
GROUP BY
    A.mandant_id,
    A.art_nielsen_id,
    B.gtin_id;


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
    FROM dbp_etl_process.art_gtin AS A
    WHERE
        mandant_id = 1
        AND (
            mandant_id, art_id) NOT IN (
            SELECT (mandant_id, art_id)
            FROM dbp_data.art_gp_zu_per
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


-- step2 for kl-articles


INSERT INTO `_article_matching0`
(
    SELECT
        A.mandant_id,
        -1 AS art_nielsen_id,
        A.art_id,
        b.gtin_id
    FROM dbp_etl.kl_basis_listung AS A
    INNER JOIN (
        SELECT *
        FROM dbp_etl_process.art_gtin AS A
        WHERE
            mandant_id = 1
            AND (
                mandant_id, art_id) NOT IN (
                SELECT (mandant_id, art_id)
                FROM dbp_data.art_gp_zu_per
                WHERE
                    mandant_id = 1
                    AND gp_id = 5059720
                    AND dat_bis = DATE '9999-12-31'
                GROUP BY mandant_id,
                art_id
            )
    ) AS b
        ON A.art_id = b.art_id AND A.mandant_id = b.mandant_id
    WHERE (
        A.mandant_id, A.art_id) NOT IN (
        SELECT (mandant_id, art_id)
        FROM `_article_matching0`
    )
    GROUP BY
        A.mandant_id,
        art_nielsen_id,
        A.art_id,
        b.gtin_id
);


-- step3 for nl-articles


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
    FROM dbp_etl_process.art_art_nielsen_matching_zu
    WHERE (
        mandant_id, art_id, art_nielsen_id) IN (
        SELECT (mandant_id, art_id, art_nielsen_id)
        FROM `_article_matching0`
    )
    AND kjwo_update IN (
        SELECT MAX(kjwo_update) AS a1290333724
        FROM dbp_etl_process.art_art_nielsen_matching_zu
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
    FROM dbp_etl_process.art_art_nielsen_matching_zu
    WHERE (
        mandant_id, art_nielsen_id) IN (
        SELECT (mandant_id, art_nielsen_id)
        FROM `_article_matching0`
        WHERE art_nielsen_id <> -1
    )
    AND kjwo_update IN (
        SELECT MAX(kjwo_update) AS a1290333724
        FROM dbp_etl_process.art_art_nielsen_matching_zu
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
    FROM dbp_etl_process.art_art_nielsen_matching_zu
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
        FROM dbp_etl_process.art_art_nielsen_matching_zu
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
    FROM dbp_etl_process.art_art_nielsen_matching_zu
    WHERE (
        mandant_id, art_id) IN (
        SELECT (mandant_id, art_id)
        FROM `_article_matching0`
        WHERE art_id <> -1
    )
    AND kjwo_update IN (
        SELECT MAX(kjwo_update) AS a1290333724
        FROM dbp_etl_process.art_art_nielsen_matching_zu
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
    FROM dbp_etl_process.art_art_nielsen_matching_zu
    WHERE (
        mandant_id, gtin_id) IN (
        SELECT (mandant_id, gtin_id)
        FROM `_article_matching0`
        WHERE gtin_id NOT IN (-9999, -9998)
    )
    AND kjwo_update IN (
        SELECT MAX(kjwo_update) AS a1290333724
        FROM dbp_etl_process.art_art_nielsen_matching_zu
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


-- 1st for regular gtins


CREATE OR REPLACE TEMPORARY TABLE _upd_new_match AS
SELECT
    B.mandant_id,
    (
        SELECT MAX(art_matching_id)
        FROM dbp_etl_process.art_art_nielsen_matching_zu
        WHERE
            mandant_id = 1
            AND kjwo_update IN (
                SELECT MAX(kjwo_update) AS a1290333724
                FROM dbp_etl_process.art_art_nielsen_matching_zu
            )
    ) AS art_matching_id,
    B.art_nielsen_id,
    A.art_id,
    A.gtin_id,
    DENSE_RANK() OVER (ORDER BY A.mandant_id IS NULL, A.mandant_id, A.gtin_id IS NULL, A.gtin_id) AS rang
FROM `_article_matching0` AS A
INNER JOIN `_art_nielsen` AS B ON A.mandant_id = B.mandant_id AND A.art_nielsen_id = B.art_nielsen_id
WHERE A.gtin_id NOT IN (-9999, -9998);


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


-- 2nd for company brandings


CREATE OR REPLACE TEMPORARY TABLE _upd_new_match AS
SELECT
    B.mandant_id,
    (
        SELECT MAX(matching_id)
        FROM `_nielsen_kl_matching`
        WHERE mandant_id = 1
    ) AS art_matching_id,
    B.art_nielsen_id,
    A.art_id,
    A.gtin_id,
    DENSE_RANK() OVER (ORDER BY A.mandant_id IS NULL, A.mandant_id, A.art_nielsen_id IS NULL, A.art_nielsen_id) AS rang
FROM `_article_matching0` AS A
INNER JOIN `_art_nielsen` AS B ON A.mandant_id = B.mandant_id AND A.art_nielsen_id = B.art_nielsen_id
WHERE A.gtin_id IN (-9999, -9998);


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


-- 3rd run for kl-articles


CREATE OR REPLACE TEMPORARY TABLE _upd_new_match AS
SELECT
    mandant_id,
    (
        SELECT MAX(matching_id)
        FROM `_nielsen_kl_matching`
        WHERE mandant_id = 1
    ) AS art_matching_id,
    art_nielsen_id,
    art_id,
    gtin_id,
    DENSE_RANK() OVER (ORDER BY mandant_id IS NULL, mandant_id, art_id IS NULL, art_id) AS rang
FROM `_article_matching0`;


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
    mandant_id, art_id) IN (
    SELECT (mandant_id, art_id)
    FROM `_nielsen_kl_matching`
);


-- start of integrating new article references


DELETE FROM `_nielsen_kl_matching`
WHERE (
    mandant_id, matching_id) IN (
    SELECT (mandant_id, art_matching_id)
    FROM dbp_etl_process.art_art_nielsen_matching_zu
    WHERE
        kjwo_update IN (
            SELECT MAX(kjwo_update) AS a1290333724
            FROM dbp_etl_process.art_art_nielsen_matching_zu
        )
);


INSERT INTO dbp_etl_process.art_art_nielsen_matching_zu
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
        B.status,
        B.list_kz,
        B.komponente_fg,
        B.kjwo_update,
        CURRENT_TIMESTAMP(),
        CURRENT_TIMESTAMP()
    FROM `_nielsen_kl_matching` AS A
    INNER JOIN dbp_etl_process.art_art_nielsen_matching_zu AS B
        ON
            A.mandant_id = B.mandant_id AND A.gtin_id
            = B.gtin_id AND A.art_nielsen_id = B.art_nielsen_id
    WHERE
        B.kjwo_update IN (
            SELECT MAX(kjwo_update) AS a1290333724
            FROM dbp_etl_process.art_art_nielsen_matching_zu
        )
        AND (
            A.mandant_id, A.art_id) NOT IN (
            SELECT (mandant_id, art_id)
            FROM dbp_etl_process.art_art_nielsen_matching_zu
            WHERE
                kjwo_update IN (
                    SELECT MAX(kjwo_update) AS a1290333724
                    FROM dbp_etl_process.art_art_nielsen_matching_zu
                )
        )
);


INSERT INTO dbp_etl_process.art_art_nielsen_matching_zu
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
        FROM dbp_etl_process.art_art_nielsen_matching_zu
    ),
    CURRENT_TIMESTAMP(),
    CURRENT_TIMESTAMP()
FROM `_nielsen_kl_matching`
WHERE (
    mandant_id, matching_id) NOT IN (
    SELECT (mandant_id, art_matching_id)
    FROM dbp_etl_process.art_art_nielsen_matching_zu
    WHERE
        kjwo_update IN (
            SELECT MAX(kjwo_update) AS a1290333724
            FROM dbp_etl_process.art_art_nielsen_matching_zu
        )
)
AND (mandant_id, matching_id, art_id, art_nielsen_id, gtin_id) NOT IN (SELECT (
    mandant_id, art_matching_id, art_id,
    art_nielsen_id, gtin_id
)
FROM dbp_etl_process.art_art_nielsen_matching_zu
WHERE kjwo_update IN (
    SELECT MAX(kjwo_update) AS a1290333724
    FROM dbp_etl_process.art_art_nielsen_matching_zu
)));


-- retracking of eventually missing rows on nl-side
--
-- 1st on single gtins


CREATE OR REPLACE TEMPORARY TABLE _upd_new_match AS
SELECT
    mandant_id,
    (
        SELECT MAX(art_matching_id)
        FROM dbp_etl_process.art_art_nielsen_matching_zu
        WHERE mandant_id = 1
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
        FROM dbp_etl_process.art_art_nielsen_matching_zu
        WHERE
            kjwo_update IN (
                SELECT MAX(kjwo_update) AS a1290333724
                FROM dbp_etl_process.art_art_nielsen_matching_zu
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


INSERT INTO dbp_etl_process.art_art_nielsen_matching_zu
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
        FROM dbp_etl_process.art_art_nielsen_matching_zu
    ),
    CURRENT_TIMESTAMP(),
    CURRENT_TIMESTAMP()
FROM `_nielsen_kl_matching`
WHERE (
    mandant_id, matching_id) NOT IN (
    SELECT (mandant_id, art_matching_id)
    FROM dbp_etl_process.art_art_nielsen_matching_zu
    WHERE
        kjwo_update IN (
            SELECT MAX(kjwo_update) AS a1290333724
            FROM dbp_etl_process.art_art_nielsen_matching_zu
        )
)
AND (mandant_id, matching_id, art_id, art_nielsen_id, gtin_id) NOT IN (SELECT (
    mandant_id, art_matching_id, art_id,
    art_nielsen_id, gtin_id
)
FROM dbp_etl_process.art_art_nielsen_matching_zu
WHERE kjwo_update IN (
    SELECT MAX(kjwo_update) AS a1290333724
    FROM dbp_etl_process.art_art_nielsen_matching_zu
)));


-- 2nd on multiple gtins


CREATE OR REPLACE TEMPORARY TABLE _upd_new_match AS
SELECT
    mandant_id,
    (
        SELECT MAX(art_matching_id)
        FROM dbp_etl_process.art_art_nielsen_matching_zu
        WHERE mandant_id = 1
    ) AS art_matching_id,
    art_nielsen_id,
    -1 AS art_id,
    gtin_id,
    DENSE_RANK() OVER (ORDER BY mandant_id IS NULL, mandant_id, gtin_id IS NULL, gtin_id) AS rang
FROM `_distinct_nl_arts`
WHERE (
    mandant_id, gtin_id) IN (
    SELECT (mandant_id, gtin_id)
    FROM `_distinct_nl_arts`
    WHERE (
        mandant_id, gtin_id) NOT IN (
        SELECT (mandant_id, gtin_id)
        FROM dbp_etl_process.art_art_nielsen_matching_zu
        WHERE
            kjwo_update IN (
                SELECT MAX(kjwo_update) AS a1290333724
                FROM dbp_etl_process.art_art_nielsen_matching_zu
            )
    )
    GROUP BY
        mandant_id,
        gtin_id
    HAVING COUNT(*) > 1
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


INSERT INTO dbp_etl_process.art_art_nielsen_matching_zu
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
        FROM dbp_etl_process.art_art_nielsen_matching_zu
    ),
    CURRENT_TIMESTAMP(),
    CURRENT_TIMESTAMP()
FROM `_nielsen_kl_matching`
WHERE (
    mandant_id, matching_id) NOT IN (
    SELECT (mandant_id, art_matching_id)
    FROM dbp_etl_process.art_art_nielsen_matching_zu
    WHERE
        kjwo_update IN (
            SELECT MAX(kjwo_update) AS a1290333724
            FROM dbp_etl_process.art_art_nielsen_matching_zu
        )
)
AND (mandant_id, matching_id, art_id, art_nielsen_id, gtin_id) NOT IN (SELECT (
    mandant_id, art_matching_id, art_id,
    art_nielsen_id, gtin_id
)
FROM dbp_etl_process.art_art_nielsen_matching_zu
WHERE kjwo_update IN (
    SELECT MAX(kjwo_update) AS a1290333724
    FROM dbp_etl_process.art_art_nielsen_matching_zu
)));


-- 3rd on art_nielsen_id


CREATE OR REPLACE TEMPORARY TABLE _upd_new_match AS
SELECT
    mandant_id,
    (
        SELECT MAX(art_matching_id)
        FROM dbp_etl_process.art_art_nielsen_matching_zu
        WHERE mandant_id = 1
    ) AS art_matching_id,
    art_nielsen_id,
    -1 AS art_id,
    gtin_id,
    DENSE_RANK() OVER (ORDER BY mandant_id IS NULL, mandant_id, gtin_id IS NULL, gtin_id) AS rang
FROM `_distinct_nl_arts`
WHERE (
    mandant_id, art_nielsen_id) IN (
    SELECT (mandant_id, art_nielsen_id)
    FROM `_distinct_nl_arts`
    WHERE (
        mandant_id, art_nielsen_id) NOT IN (
        SELECT (mandant_id, art_nielsen_id)
        FROM dbp_etl_process.art_art_nielsen_matching_zu
        WHERE
            kjwo_update IN (
                SELECT MAX(kjwo_update) AS a1290333724
                FROM dbp_etl_process.art_art_nielsen_matching_zu
            )
    )
    GROUP BY mandant_id,
    art_nielsen_id
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


INSERT INTO dbp_etl_process.art_art_nielsen_matching_zu
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
        FROM dbp_etl_process.art_art_nielsen_matching_zu
    ),
    CURRENT_TIMESTAMP(),
    CURRENT_TIMESTAMP()
FROM `_nielsen_kl_matching`
WHERE (
    mandant_id, matching_id) NOT IN (
    SELECT (mandant_id, art_matching_id)
    FROM dbp_etl_process.art_art_nielsen_matching_zu
    WHERE
        kjwo_update IN (
            SELECT MAX(kjwo_update) AS a1290333724
            FROM dbp_etl_process.art_art_nielsen_matching_zu
        )
)
AND (mandant_id, matching_id, art_id, art_nielsen_id, gtin_id) NOT IN (SELECT (
    mandant_id, art_matching_id, art_id,
    art_nielsen_id, gtin_id
)
FROM dbp_etl_process.art_art_nielsen_matching_zu
WHERE kjwo_update IN (
    SELECT MAX(kjwo_update) AS a1290333724
    FROM dbp_etl_process.art_art_nielsen_matching_zu
)));


-- 4th on art_id


CREATE OR REPLACE TEMPORARY TABLE _upd_new_match AS
SELECT
    mandant_id,
    (
        SELECT MAX(art_matching_id)
        FROM dbp_etl_process.art_art_nielsen_matching_zu
        WHERE mandant_id = 1
    ) AS art_matching_id,
    art_nielsen_id,
    art_id,
    gtin_id,
    DENSE_RANK() OVER (ORDER BY mandant_id IS NULL, mandant_id, art_id IS NULL, art_id) AS rang
FROM `_article_matching0`
WHERE (
    mandant_id, art_id) IN (
    SELECT (mandant_id, art_id)
    FROM `_article_matching0`
    WHERE (
        mandant_id, art_id) NOT IN (
        SELECT (mandant_id, art_id)
        FROM dbp_etl_process.art_art_nielsen_matching_zu
        WHERE
            kjwo_update IN (
                SELECT MAX(kjwo_update) AS a1290333724
                FROM dbp_etl_process.art_art_nielsen_matching_zu
            )
    )
    GROUP BY mandant_id,
    art_id
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


INSERT INTO dbp_etl_process.art_art_nielsen_matching_zu
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
        FROM dbp_etl_process.art_art_nielsen_matching_zu
    ),
    CURRENT_TIMESTAMP(),
    CURRENT_TIMESTAMP()
FROM `_nielsen_kl_matching`
WHERE (
    mandant_id, matching_id) NOT IN (
    SELECT (mandant_id, art_matching_id)
    FROM dbp_etl_process.art_art_nielsen_matching_zu
    WHERE
        kjwo_update IN (
            SELECT MAX(kjwo_update) AS a1290333724
            FROM dbp_etl_process.art_art_nielsen_matching_zu
        )
)
AND (mandant_id, matching_id, art_id, art_nielsen_id, gtin_id) NOT IN (SELECT (
    mandant_id, art_matching_id, art_id,
    art_nielsen_id, gtin_id
)
FROM dbp_etl_process.art_art_nielsen_matching_zu
WHERE kjwo_update IN (
    SELECT MAX(kjwo_update) AS a1290333724
    FROM dbp_etl_process.art_art_nielsen_matching_zu
)));


-- retracking eventually missing rows on kl-side


CREATE OR REPLACE TEMPORARY TABLE _kl_facts AS
SELECT
    t13.mandant_id,
    t13.art_id,
    t13.umsatz_netto
FROM (
    SELECT
        A.mandant_id,
        A.art_id,
        SUM(A.umsatz_netto) AS umsatz_netto,
        SUM(A.menge) AS a0
    FROM dbp_data.artbew_wo_sum AS A
    INNER JOIN dbp_data.woche_kj_kl AS B ON A.kjwo_kl = B.kjwo_kl
    INNER JOIN dbp_data.art_wg_zu_per AS D
        ON
            A.mandant_id = D.mandant_id AND A.art_id = D.art_id AND D.arthiertyp_id
            = 2 AND D.dat_bis = DATE '9999-12-31'
    INNER JOIN (
        SELECT wg_id
        FROM dbp_data.wg_filter_zu
        WHERE wg_filter_id = 47
        GROUP BY wg_id
    ) AS e
        ON D.wg_id = e.wg_id
    WHERE (
        A.mandant_id, B.kjwo) IN (
        SELECT (mandant_id, kjwo)
        FROM (
            SELECT
                b.mandant_id,
                C.kjwo,
                (RANK() OVER (
                    PARTITION BY
                        b.mandant_id ORDER BY
                        b.mandant_id IS NULL, b.mandant_id, C.kjwo IS NULL DESC, C.kjwo
                        DESC
                )) * -1 AS akt_wo
            FROM dbp_etl_process.sort_monat_woche AS A0
            INNER JOIN (SELECT
                mandant_id,
                MAX(kjmo) AS kjmo
            FROM dbp_data.sortiment_leistung
            WHERE mandant_id = 1
            GROUP BY mandant_id) AS b ON A0.kjmo_sort = b.kjmo
            INNER JOIN dbp_data.woche AS C ON A0.kjwo_sort_bis >= C.kjwo
            QUALIFY ((RANK() OVER (
                PARTITION BY
                    b.mandant_id ORDER BY
                    b.mandant_id IS NULL, b.mandant_id, C.kjwo IS NULL DESC,
                    C.kjwo DESC
            )) * -1) BETWEEN -52 AND (-1)
        ) AS t4
        GROUP BY mandant_id,
        kjwo
    )
    AND (
        A.mandant_id, A.art_id) NOT IN (
        SELECT (mandant_id, art_id)
        FROM dbp_data.art_gp_zu_per
        WHERE
            mandant_id = 1
            AND gp_id = 5059720
            AND dat_bis = DATE '9999-12-31'
        GROUP BY mandant_id,
        art_id
    )
    GROUP BY
        A.mandant_id,
        A.art_id
    HAVING a0 > 0
) AS t13;


CREATE OR REPLACE TEMPORARY TABLE _miss1 AS
SELECT
    mandant_id,
    NULL AS art_matching_id,
    art_id,
    NULL AS art_nielsen_id,
    NULL AS gtin_id
FROM `_kl_facts`
WHERE (
    mandant_id, art_id) NOT IN (
    SELECT (mandant_id, art_id)
    FROM dbp_etl.art_matching_nielsen_per
);


UPDATE `_miss1` SET
    gtin_id = t1.gtin_id FROM (
    SELECT
        mandant_id,
        art_id,
        MAX(gtin_id) AS gtin_id
    FROM dbp_etl_process.art_gtin
    WHERE mandant_id = 1
    GROUP BY
        art_id,
        mandant_id
) AS t1
WHERE `_miss1`.mandant_id = t1.mandant_id AND `_miss1`.art_id = t1.art_id;


-- 1st run...standard update with matching_id and art_nielsen_id coming from former matching references


UPDATE `_miss1` AS `_miss10` SET
    art_matching_id = b.art_matching_id,
    art_nielsen_id = b.art_nielsen_id FROM (
    SELECT
        mandant_id,
        gtin_id,
        MAX(art_matching_id) AS art_matching_id,
        MAX(art_nielsen_id) AS art_nielsen_id
    FROM dbp_etl.art_matching_nielsen_per
    WHERE
        gtin_id IN (
            SELECT gtin_id 
            FROM `_miss1`
        )
        AND art_matching_id NOT IN (
            SELECT art_matching_id
            FROM dbp_etl_process.art_art_nielsen_groups
        )
        AND art_id NOT IN (
            SELECT art_id
            FROM dbp_etl_process.art_art_nielsen_groups
        )
    GROUP BY
        mandant_id,
        gtin_id
) AS b
WHERE `_miss10`.mandant_id = b.mandant_id AND `_miss10`.gtin_id = b.gtin_id;


TRUNCATE TABLE `_nielsen_kl_matching`;


INSERT INTO `_nielsen_kl_matching` (mandant_id, matching_id, art_nielsen_id, art_id, gtin_id)
(
    SELECT
        mandant_id,
        art_matching_id,
        art_nielsen_id,
        art_id,
        gtin_id
    FROM `_miss1` AS A
    WHERE
        art_matching_id IS NOT NULL
        AND art_nielsen_id IS NOT NULL
);


INSERT INTO dbp_etl_process.art_art_nielsen_matching_zu
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
        FROM dbp_etl_process.art_art_nielsen_matching_zu
    ),
    CURRENT_TIMESTAMP(),
    CURRENT_TIMESTAMP()
FROM `_nielsen_kl_matching`
WHERE (mandant_id, matching_id, art_id, art_nielsen_id, gtin_id) NOT IN (SELECT (
    mandant_id, art_matching_id, art_id,
    art_nielsen_id, gtin_id
)
FROM dbp_etl_process.art_art_nielsen_matching_zu
WHERE kjwo_update IN (
    SELECT MAX(kjwo_update) AS a1290333724
    FROM dbp_etl_process.art_art_nielsen_matching_zu
)));


DELETE FROM `_miss1`
WHERE art_matching_id IS NOT NULL AND art_nielsen_id IS NOT NULL;


-- 2nd run...update with references to article groups only with art_nielsen_id. important!


UPDATE `_miss1` AS `_miss10` SET
    art_nielsen_id = b.art_nielsen_id FROM (
    SELECT
        mandant_id,
        gtin_id,
        MAX(art_nielsen_id) AS art_nielsen_id
    FROM dbp_etl.art_matching_nielsen_per
    WHERE
        gtin_id IN (
            SELECT gtin_id 
            FROM `_miss1`
        )
        AND art_id IN (
            SELECT art_id
            FROM dbp_etl_process.art_art_nielsen_groups
        )
    GROUP BY
        mandant_id,
        gtin_id
) AS b
WHERE `_miss10`.mandant_id = b.mandant_id AND `_miss10`.gtin_id = b.gtin_id;


CREATE OR REPLACE TEMPORARY TABLE _upd_new_match AS
SELECT
    mandant_id,
    (
        SELECT MAX(art_matching_id)
        FROM dbp_etl_process.art_art_nielsen_matching_zu
        WHERE mandant_id = 1
    ) AS art_matching_id,
    art_nielsen_id,
    art_id,
    gtin_id,
    DENSE_RANK() OVER (ORDER BY mandant_id IS NULL, mandant_id, art_id IS NULL, art_id) AS rang
FROM `_miss1`
WHERE (
    mandant_id, art_id) IN (
    SELECT (mandant_id, art_id)
    FROM `_miss1`
    WHERE (
        mandant_id, art_id) NOT IN (
        SELECT (mandant_id, art_id)
        FROM dbp_etl_process.art_art_nielsen_matching_zu
        WHERE
            kjwo_update IN (
                SELECT MAX(kjwo_update) AS a1290333724
                FROM dbp_etl_process.art_art_nielsen_matching_zu
            )
    )
    GROUP BY mandant_id,
    art_id
)
AND art_nielsen_id IS NOT NULL;


TRUNCATE TABLE `_nielsen_kl_matching`;


INSERT INTO `_nielsen_kl_matching` (mandant_id, matching_id, art_nielsen_id, art_id, gtin_id)
(SELECT
    mandant_id,
    art_matching_id + rang,
    art_nielsen_id,
    art_id,
    gtin_id
FROM `_upd_new_match` AS A
WHERE art_nielsen_id IS NOT NULL);


INSERT INTO dbp_etl_process.art_art_nielsen_matching_zu
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
        FROM dbp_etl_process.art_art_nielsen_matching_zu
    ),
    CURRENT_TIMESTAMP(),
    CURRENT_TIMESTAMP()
FROM `_nielsen_kl_matching`
WHERE (
    mandant_id, matching_id) NOT IN (
    SELECT (mandant_id, art_matching_id)
    FROM dbp_etl_process.art_art_nielsen_matching_zu
    WHERE
        kjwo_update IN (
            SELECT MAX(kjwo_update) AS a1290333724
            FROM dbp_etl_process.art_art_nielsen_matching_zu
        )
)
AND (mandant_id, matching_id, art_id, art_nielsen_id, gtin_id) NOT IN (SELECT (
    mandant_id, art_matching_id, art_id,
    art_nielsen_id, gtin_id
)
FROM dbp_etl_process.art_art_nielsen_matching_zu
WHERE kjwo_update IN (
    SELECT MAX(kjwo_update) AS a1290333724
    FROM dbp_etl_process.art_art_nielsen_matching_zu
)));


DELETE FROM `_miss1`
WHERE art_nielsen_id IS NOT NULL;


CREATE OR REPLACE TEMPORARY TABLE _upd_new_match AS
SELECT
    mandant_id,
    (
        SELECT MAX(art_matching_id)
        FROM dbp_etl_process.art_art_nielsen_matching_zu
        WHERE mandant_id = 1
    ) AS art_matching_id,
    -1 AS art_nielsen_id,
    art_id,
    gtin_id,
    DENSE_RANK() OVER (ORDER BY mandant_id IS NULL, mandant_id, art_id IS NULL, art_id) AS rang
FROM `_miss1`
WHERE (
    mandant_id, art_id) IN (
    SELECT (mandant_id, art_id)
    FROM `_miss1`
    WHERE (
        mandant_id, art_id) NOT IN (
        SELECT (mandant_id, art_id)
        FROM dbp_etl_process.art_art_nielsen_matching_zu
        WHERE
            kjwo_update IN (
                SELECT MAX(kjwo_update) AS a1290333724
                FROM dbp_etl_process.art_art_nielsen_matching_zu
            )
    )
    GROUP BY mandant_id,
    art_id
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


INSERT INTO dbp_etl_process.art_art_nielsen_matching_zu
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
        FROM dbp_etl_process.art_art_nielsen_matching_zu
    ),
    CURRENT_TIMESTAMP(),
    CURRENT_TIMESTAMP()
FROM `_nielsen_kl_matching`
WHERE (
    mandant_id, matching_id) NOT IN (
    SELECT (mandant_id, art_matching_id)
    FROM dbp_etl_process.art_art_nielsen_matching_zu
    WHERE
        kjwo_update IN (
            SELECT MAX(kjwo_update) AS a1290333724
            FROM dbp_etl_process.art_art_nielsen_matching_zu
        )
)
AND (mandant_id, matching_id, art_id, art_nielsen_id, gtin_id) NOT IN (SELECT (
    mandant_id, art_matching_id, art_id,
    art_nielsen_id, gtin_id
)
FROM dbp_etl_process.art_art_nielsen_matching_zu
WHERE kjwo_update IN (
    SELECT MAX(kjwo_update) AS a1290333724
    FROM dbp_etl_process.art_art_nielsen_matching_zu
)));
