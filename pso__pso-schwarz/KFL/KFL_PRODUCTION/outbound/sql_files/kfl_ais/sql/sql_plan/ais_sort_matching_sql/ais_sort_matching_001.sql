DELETE FROM dbp_etl.art_matching_nielsen_per
WHERE kjwo_update < (
    SELECT MAX(kjwo_update)
    FROM dbp_etl.art_matching_nielsen_per
);


CREATE OR REPLACE TEMPORARY TABLE _art_nielsen AS
SELECT *
FROM dbp_data.art_nielsen
WHERE dat_bis = DATE '9999-12-31';


CREATE OR REPLACE TEMPORARY TABLE _kl_facts AS
SELECT
    mandant_id,
    art_id
FROM dbp_etl.kl_basis_listung AS A
UNION DISTINCT
SELECT
    A.mandant_id,
    A.art_id
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
        FROM dbp_msi_data.ek_sort_sortiment_mat_zeitraum AS A0
        INNER JOIN (SELECT
            mandant_id,
            MAX(kjmo) AS kjmo
        FROM dbp_data.sortiment_leistung
        WHERE mandant_id = 1
        GROUP BY mandant_id) AS b ON A0.kjmo_sort = b.kjmo
        INNER JOIN dbp_data.woche AS C ON A0.kjwo_bis >= C.kjwo
        QUALIFY ((RANK() OVER (
            PARTITION BY
                b.mandant_id ORDER BY
                b.mandant_id IS NULL, b.mandant_id, C.kjwo IS NULL DESC,
                C.kjwo DESC
        )) * -1) BETWEEN -52 AND (-1)
    ) AS t7
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
HAVING SUM(A.menge) > 0;


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
    FROM `_kl_facts` AS A
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


INSERT INTO `_nielsen_kl_matching`
(SELECT
    mandant_id,
    -1 AS matching_id,
    art_nielsen_id,
    art_id,
    gtin_id
FROM `_article_matching0`);


MERGE INTO `_nielsen_kl_matching` AS A
USING (
    SELECT
        mandant_id,
        art_matching_id,
        art_nielsen_id,
        art_id,
        gtin_id
    FROM dbp_etl.art_matching_nielsen_per
    GROUP BY
        mandant_id,
        art_matching_id,
        art_id,
        art_nielsen_id,
        gtin_id
) AS b
    ON A.mandant_id = b.mandant_id AND A.art_id = b.art_id AND A.art_nielsen_id = b.art_nielsen_id AND A.gtin_id = b.gtin_id

WHEN MATCHED THEN UPDATE SET
    matching_id = b.art_matching_id;


--EXECUTE IMMEDIATE CONVERTED BLOCK - START
BEGIN
    DECLARE loop_counter1 INT64 DEFAULT 1;
    DECLARE loop_counter2 INT64 DEFAULT 1;
    DECLARE loop_counter3 INT64 DEFAULT 1;
    DECLARE loop_counter_value INT64 DEFAULT 0;

    WHILE ((loop_counter1 + loop_counter2 + loop_counter3) > 0) DO
        UPDATE _nielsen_kl_matching
        SET matching_id = b.art_matching_id

        FROM (select
            mandant_id,
            max(matching_id) as art_matching_id,
            art_id
        from _nielsen_kl_matching
        where
            matching_id <> -1 and
            art_id <> -1
        group by 1, 3) b
        WHERE
            _nielsen_kl_matching.mandant_id = b.mandant_id and
            _nielsen_kl_matching.art_id = b.art_id and
            _nielsen_kl_matching.matching_id = -1;


        SET loop_counter1 = @@row_count;

        UPDATE _nielsen_kl_matching
        SET matching_id = b.art_matching_id

        FROM (select
            mandant_id,
            max(matching_id) as art_matching_id,
            art_nielsen_id
        from _nielsen_kl_matching
        where
            matching_id <> -1 and
            art_nielsen_id <> -1
        group by 1, 3) b
        WHERE
            _nielsen_kl_matching.mandant_id = b.mandant_id and
            _nielsen_kl_matching.art_nielsen_id = b.art_nielsen_id and
            _nielsen_kl_matching.matching_id = -1;


        SET loop_counter2 = @@row_count;

        UPDATE _nielsen_kl_matching
        SET matching_id = b.art_matching_id

        FROM (select
            mandant_id,
            max(matching_id) as art_matching_id,
            gtin_id
        from _nielsen_kl_matching
        where
            matching_id <> -1 and
            gtin_id not in (-9999, -9998)
        group by 1, 3) b
        WHERE
            _nielsen_kl_matching.mandant_id = b.mandant_id and
            _nielsen_kl_matching.gtin_id = b.gtin_id and
            _nielsen_kl_matching.matching_id = -1;


        SET loop_counter3 = @@row_count;
        SET loop_counter_value = loop_counter_value + 1;
    END WHILE;

    SELECT loop_counter_value;

END;
--EXECUTE IMMEDIATE CONVERTED BLOCK - END


UPDATE `_nielsen_kl_matching` SET
    matching_id = b.art_matching_id FROM (
    SELECT
        mandant_id,
        MAX(art_matching_id) AS art_matching_id,
        gtin_id
    FROM dbp_etl.art_matching_nielsen_per
    WHERE
        art_id <> -1
        AND status = 'T'
        AND gtin_id NOT IN (-9999, -9998)
    GROUP BY
        mandant_id,
        gtin_id
) AS b
WHERE
    `_nielsen_kl_matching`.mandant_id = b.mandant_id AND `_nielsen_kl_matching`.gtin_id = b.gtin_id AND
    `_nielsen_kl_matching`.matching_id = -1;


UPDATE `_nielsen_kl_matching` SET
    matching_id = b.art_matching_id FROM (
    SELECT
        mandant_id,
        MAX(art_matching_id) AS art_matching_id,
        gtin_id
    FROM dbp_etl.art_matching_nielsen_per
    WHERE
        art_id <> -1
        AND status = 'N'
        AND gtin_id NOT IN (-9999, -9998)
    GROUP BY
        mandant_id,
        gtin_id
) AS b
WHERE
    `_nielsen_kl_matching`.mandant_id = b.mandant_id AND `_nielsen_kl_matching`.gtin_id = b.gtin_id AND
    `_nielsen_kl_matching`.matching_id = -1;


UPDATE `_nielsen_kl_matching` AS `_nielsen_kl_matching0` SET
    matching_id = b.art_matching_id FROM (
    SELECT
        mandant_id,
        MAX(matching_id) AS art_matching_id,
        art_id
    FROM `_nielsen_kl_matching`
    WHERE
        matching_id <> -1
        AND art_id <> -1
    GROUP BY
        mandant_id,
        art_id
) AS b
WHERE
    `_nielsen_kl_matching0`.mandant_id = b.mandant_id AND `_nielsen_kl_matching0`.art_id = b.art_id AND
    `_nielsen_kl_matching0`.matching_id = -1;


UPDATE `_nielsen_kl_matching` AS `_nielsen_kl_matching0` SET
    matching_id = b.art_matching_id FROM (
    SELECT
        mandant_id,
        MAX(matching_id) AS art_matching_id,
        art_nielsen_id
    FROM `_nielsen_kl_matching`
    WHERE
        matching_id <> -1
        AND art_nielsen_id <> -1
    GROUP BY
        mandant_id,
        art_nielsen_id
) AS b
WHERE
    `_nielsen_kl_matching0`.mandant_id = b.mandant_id AND `_nielsen_kl_matching0`.art_nielsen_id = b.art_nielsen_id
    AND `_nielsen_kl_matching0`.matching_id = -1;


CREATE OR REPLACE TEMPORARY TABLE _nielsen_kl_matching_final AS
SELECT *
FROM `_nielsen_kl_matching`
WHERE matching_id <> -1;


DELETE FROM `_nielsen_kl_matching`
WHERE matching_id <> -1;


-- 1st run for kl-/nl-articles


CREATE OR REPLACE TEMPORARY TABLE _upd_new_match AS
SELECT
    mandant_id,
    (
        SELECT MAX(matching_id)
        FROM `_nielsen_kl_matching_final`
        WHERE mandant_id = 1
    ) AS art_matching_id,
    art_nielsen_id,
    art_id,
    gtin_id,
    DENSE_RANK() OVER (ORDER BY mandant_id IS NULL, mandant_id, art_id IS NULL, art_id) AS rang
FROM `_nielsen_kl_matching`
WHERE
    art_id <> -1
    AND art_nielsen_id <> -1;


INSERT INTO `_nielsen_kl_matching_final` (mandant_id, matching_id, art_nielsen_id, art_id, gtin_id)
(SELECT
    mandant_id,
    art_matching_id + rang,
    art_nielsen_id,
    art_id,
    gtin_id
FROM `_upd_new_match` AS A);


DELETE FROM `_nielsen_kl_matching`
WHERE (
    mandant_id, art_id) IN (
    SELECT (mandant_id, art_id)
    FROM `_nielsen_kl_matching_final`
    WHERE
        art_id <> -1
        AND art_nielsen_id <> -1
);


-- 2nd run for kl-articles


CREATE OR REPLACE TEMPORARY TABLE _upd_new_match AS
SELECT
    mandant_id,
    (
        SELECT MAX(matching_id)
        FROM `_nielsen_kl_matching_final`
        WHERE mandant_id = 1
    ) AS art_matching_id,
    art_nielsen_id,
    art_id,
    gtin_id,
    DENSE_RANK() OVER (ORDER BY mandant_id IS NULL, mandant_id, art_id IS NULL, art_id) AS rang
FROM `_nielsen_kl_matching`
WHERE art_id <> -1;


INSERT INTO `_nielsen_kl_matching_final` (mandant_id, matching_id, art_nielsen_id, art_id, gtin_id)
(SELECT
    mandant_id,
    art_matching_id + rang,
    art_nielsen_id,
    art_id,
    gtin_id
FROM `_upd_new_match` AS A);


DELETE FROM `_nielsen_kl_matching`
WHERE (
    mandant_id, art_id) IN (
    SELECT (mandant_id, art_id)
    FROM `_nielsen_kl_matching_final`
    WHERE art_id <> -1
);


-- 3rd run for nl-articles


CREATE OR REPLACE TEMPORARY TABLE _upd_new_match AS
SELECT
    B.mandant_id,
    (
        SELECT MAX(matching_id)
        FROM `_nielsen_kl_matching_final`
        WHERE mandant_id = 1
    ) AS art_matching_id,
    B.art_nielsen_id,
    A.art_id,
    A.gtin_id,
    DENSE_RANK() OVER (ORDER BY A.mandant_id IS NULL, A.mandant_id, A.art_nielsen_id IS NULL, A.art_nielsen_id) AS rang
FROM `_nielsen_kl_matching` AS A
INNER JOIN `_art_nielsen` AS B ON A.mandant_id = B.mandant_id AND A.art_nielsen_id = B.art_nielsen_id
WHERE A.art_nielsen_id <> -1;


INSERT INTO `_nielsen_kl_matching_final` (mandant_id, matching_id, art_nielsen_id, art_id, gtin_id)
(SELECT
    mandant_id,
    art_matching_id + rang,
    art_nielsen_id,
    art_id,
    gtin_id
FROM `_upd_new_match` AS A);


DELETE FROM `_nielsen_kl_matching`
WHERE (
    mandant_id, art_nielsen_id) IN (
    SELECT (mandant_id, art_nielsen_id)
    FROM `_nielsen_kl_matching_final`
    WHERE art_nielsen_id <> -1
);


UPDATE `_nielsen_kl_matching_final` AS `_nielsen_kl_matching_final0` SET
    matching_id = b.max_match FROM (SELECT
    mandant_id,
    art_id,
    COUNT(DISTINCT matching_id) AS anz_match,
    MAX(matching_id) AS max_match,
    MIN(art_id) AS min_art_id,
    MAX(art_id) AS max_art_id
FROM `_nielsen_kl_matching_final`
WHERE art_id <> -1
GROUP BY
    mandant_id,
    art_id
HAVING anz_match > 1 AND min_art_id = max_art_id) AS b
WHERE `_nielsen_kl_matching_final0`.mandant_id = b.mandant_id AND `_nielsen_kl_matching_final0`.art_id = b.art_id;


-------------------------------------- INSERT -------------------------------------


CREATE OR REPLACE TABLE dbp_etl.art_matching_nielsen_per_final LIKE dbp_etl.art_matching_nielsen_per;


INSERT INTO dbp_etl.art_matching_nielsen_per_final
(SELECT DISTINCT
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
        SELECT C.kjwo
        FROM dbp_data.woche AS A
        INNER JOIN (
            SELECT MAX(kjwo_update) AS kjwo_update
            FROM dbp_data.sortiment_leistung
            WHERE mandant_id = 1
        ) AS b
            ON A.kjwo = b.kjwo_update
        INNER JOIN dbp_data.woche AS C ON A.akt_wo = C.akt_wo - 1
    ),
    CURRENT_TIMESTAMP(),
    CURRENT_TIMESTAMP()
FROM `_nielsen_kl_matching_final`
WHERE (mandant_id, matching_id, art_nielsen_id, art_id) NOT IN (SELECT (
    mandant_id, art_matching_id, art_nielsen_id,
    art_id
)
FROM dbp_etl.art_matching_nielsen_per_final));


-------------------------------------- TESTING START -------------------------------------


--EXECUTE IMMEDIATE CONVERTED BLOCK - START
BEGIN
    DECLARE loop_counter1 INT64 DEFAULT 1;
    DECLARE loop_counter2 INT64 DEFAULT 1;
    DECLARE loop_counter3 INT64 DEFAULT 1;
    DECLARE loop_counter_value INT64 DEFAULT 0;

    WHILE ((loop_counter1 + loop_counter2 + loop_counter3) > 0) DO
        UPDATE dbp_etl.art_matching_nielsen_per_final AS t
        SET art_matching_id = b.new_art_matching_id

        FROM (select
            mandant_id,
            max(art_matching_id) as new_art_matching_id,
            art_nielsen_id
        from dbp_etl.art_matching_nielsen_per_final
        where art_nielsen_id <> -1
        group by 1, 3
        having count(distinct art_matching_id) > 1) b
        WHERE
            t.mandant_id = b.mandant_id and
            t.art_nielsen_id = b.art_nielsen_id;

        SET loop_counter1 = @@row_count;

        UPDATE dbp_etl.art_matching_nielsen_per_final AS t
        SET art_matching_id = b.new_art_matching_id
        FROM (select
            mandant_id,
            max(art_matching_id) as new_art_matching_id,
            art_id
        from dbp_etl.art_matching_nielsen_per_final
        where art_id <> -1
        group by 1, 3
        having count(distinct art_matching_id) > 1) b
        WHERE
            t.mandant_id = b.mandant_id and
            t.art_id = b.art_id;

        SET loop_counter2 = @@row_count;
        UPDATE dbp_etl.art_matching_nielsen_per_final AS t
        SET art_matching_id = b.new_art_matching_id

        FROM (select
            mandant_id,
            max(art_matching_id) as new_art_matching_id,
            gtin_id
        from dbp_etl.art_matching_nielsen_per_final
        where gtin_id not in (-9999, -9998)
        group by 1, 3
        having count(distinct art_matching_id) > 1) b
        WHERE
            t.mandant_id = b.mandant_id and
            t.gtin_id = b.gtin_id;


        SET loop_counter3 = @@row_count;
        SET loop_counter_value = loop_counter_value + 1;

    END WHILE;
    SELECT loop_counter_value;
END;
--EXECUTE IMMEDIATE CONVERTED BLOCK - END

UPDATE dbp_etl.art_matching_nielsen_per_final SET
    status = b.status FROM (
    SELECT
        mandant_id,
        art_id,
        status
    FROM dbp_etl_process.art_art_nielsen_groups
    WHERE mandant_id = 1
    GROUP BY
        mandant_id,
        art_id,
        status
) AS b
WHERE art_matching_nielsen_per_final.mandant_id = b.mandant_id AND art_matching_nielsen_per_final.art_id = b.art_id;


UPDATE dbp_etl.art_matching_nielsen_per_final SET
    kl_owg_id = b.wg_id,
    kl_uwg_id = b.wug_id FROM (
    SELECT
        mandant_id,
        art_id,
        wg_id,
        wug_id
    FROM dbp_data.art_wg_zu_per
    WHERE
        dat_bis = DATE '9999-12-31'
        AND arthiertyp_id = 2
        AND mandant_id = 1
    GROUP BY
        mandant_id,
        art_id,
        wg_id,
        wug_id
) AS b
WHERE
    art_matching_nielsen_per_final.mandant_id = b.mandant_id AND art_matching_nielsen_per_final.art_id = b.art_id AND
    art_matching_nielsen_per_final.art_id <> -1 AND (
        art_matching_nielsen_per_final.kl_owg_id <> b.wg_id OR
        art_matching_nielsen_per_final.kl_uwg_id <> b.wug_id
    );


UPDATE dbp_etl.art_matching_nielsen_per_final SET
    kl_wg_id = b.owg_id FROM (
    SELECT *
    FROM dbp_data.wg_per
    WHERE
        dat_bis = DATE '9999-12-31'
        AND mandant_id = 1
        AND owg_id <> -1
) AS b
WHERE
    art_matching_nielsen_per_final.mandant_id = b.mandant_id AND art_matching_nielsen_per_final.kl_owg_id = b.wg_id
    AND art_matching_nielsen_per_final.art_id <> -1 AND art_matching_nielsen_per_final.kl_wg_id <> b.owg_id;


-- 03.02.2019, -dbay-
--
-- Warengruppenhierarchie fuer Matchings ueber alle Ebenen sauber
-- hinstellen!

-- 1. OWG


CREATE OR REPLACE TEMPORARY TABLE _track_distinct AS
SELECT
    mandant_id,
    art_matching_id,
    COUNT(*) AS anz,
    COUNT(DISTINCT kl_wg_id) AS anz_wg
FROM dbp_etl.art_matching_nielsen_per_final
GROUP BY
    mandant_id,
    art_matching_id
HAVING anz_wg > 1;


CREATE OR REPLACE TEMPORARY TABLE _track_distinct2 AS
SELECT
    A.mandant_id,
    A.art_matching_id,
    A.kl_wg_id,
    A.kl_owg_id,
    A.kl_uwg_id,
    COUNT(*) AS anzahl
FROM dbp_etl.art_matching_nielsen_per_final AS A
INNER JOIN `_track_distinct` AS B ON A.mandant_id = B.mandant_id AND A.art_matching_id = B.art_matching_id
WHERE
    A.art_id NOT IN (
        SELECT art_id
        FROM dbp_data.art
        WHERE
            mandant_id = 1
            AND TRIM(loesch_id) IN ('L', 'R')
    )
GROUP BY
    A.mandant_id,
    A.art_matching_id,
    A.kl_wg_id,
    A.kl_owg_id,
    A.kl_uwg_id;


UPDATE dbp_etl.art_matching_nielsen_per_final SET
    kl_wg_id = x.kl_wg_id,
    kl_owg_id = x.kl_owg_id,
    kl_uwg_id = x.kl_uwg_id FROM (
    SELECT
        A.mandant_id,
        A.art_matching_id,
        MIN(A.kl_wg_id) AS kl_wg_id,
        MIN(A.kl_owg_id) AS kl_owg_id,
        MIN(A.kl_uwg_id) AS kl_uwg_id
    FROM `_track_distinct2` AS A
    INNER JOIN (
        SELECT
            mandant_id,
            art_matching_id,
            MAX(anzahl) AS anzahl
        FROM `_track_distinct2`
        WHERE kl_wg_id <> -3
        GROUP BY
            mandant_id,
            art_matching_id
    ) AS b ON A.mandant_id = b.mandant_id AND A.art_matching_id = b.art_matching_id AND A.anzahl = b.anzahl

    WHERE
        A.kl_wg_id > 0
        AND A.kl_owg_id > 0
        AND A.kl_uwg_id > 0
    GROUP BY
        A.mandant_id,
        A.art_matching_id
) AS x
WHERE art_matching_nielsen_per_final.mandant_id = x.mandant_id AND art_matching_nielsen_per_final.art_matching_id = x.art_matching_id;


-- 2. WG


CREATE OR REPLACE TEMPORARY TABLE _track_distinct_owg_1 AS
SELECT
    mandant_id,
    art_matching_id,
    kl_wg_id,
    COUNT(*) AS anz,
    COUNT(DISTINCT kl_owg_id) AS anz_owg
FROM dbp_etl.art_matching_nielsen_per_final
GROUP BY
    mandant_id,
    art_matching_id,
    kl_wg_id
HAVING anz_owg > 1;


CREATE OR REPLACE TEMPORARY TABLE _track_distinct_owg_2 AS
SELECT
    A.mandant_id,
    A.art_matching_id,
    A.kl_wg_id,
    A.kl_owg_id,
    A.kl_uwg_id,
    COUNT(*) AS anzahl
FROM dbp_etl.art_matching_nielsen_per_final AS A
INNER JOIN `_track_distinct_owg_1` AS B ON A.mandant_id = B.mandant_id AND A.art_matching_id = B.art_matching_id
WHERE
    A.art_id NOT IN (
        SELECT art_id
        FROM dbp_data.art
        WHERE
            mandant_id = 1
            AND TRIM(loesch_id) IN ('L', 'R')
    )
GROUP BY
    A.mandant_id,
    A.art_matching_id,
    A.kl_wg_id,
    A.kl_owg_id,
    A.kl_uwg_id;


UPDATE dbp_etl.art_matching_nielsen_per_final SET
    kl_owg_id = x.kl_owg_id,
    kl_uwg_id = x.kl_uwg_id FROM (
    SELECT
        A.mandant_id,
        A.art_matching_id,
        A.kl_wg_id,
        MIN(A.kl_owg_id) AS kl_owg_id,
        MIN(A.kl_uwg_id) AS kl_uwg_id
    FROM `_track_distinct_owg_2` AS A
    INNER JOIN (
        SELECT
            mandant_id,
            art_matching_id,
            kl_wg_id,
            MAX(anzahl) AS anzahl
        FROM `_track_distinct_owg_2`
        WHERE kl_owg_id <> -3
        GROUP BY
            mandant_id,
            art_matching_id,
            kl_wg_id
    ) AS b
        ON
            A.mandant_id = b.mandant_id AND A.art_matching_id = b.art_matching_id AND A.anzahl = b.anzahl AND
            A.kl_wg_id = b.kl_wg_id
    WHERE
        A.kl_wg_id > 0
        AND A.kl_owg_id > 0
        AND A.kl_uwg_id > 0
    GROUP BY
        A.mandant_id,
        A.art_matching_id,
        A.kl_wg_id
) AS x
WHERE art_matching_nielsen_per_final.mandant_id = x.mandant_id AND art_matching_nielsen_per_final.art_matching_id = x.art_matching_id;


-- 3. WGI


CREATE OR REPLACE TEMPORARY TABLE _track_distinct_uwg_1 AS
SELECT
    mandant_id,
    art_matching_id,
    kl_wg_id,
    kl_owg_id,
    COUNT(*) AS anz,
    COUNT(DISTINCT kl_uwg_id) AS anz_uwg
FROM dbp_etl.art_matching_nielsen_per_final
GROUP BY
    mandant_id,
    art_matching_id,
    kl_wg_id,
    kl_owg_id
HAVING anz_uwg > 1;


CREATE OR REPLACE TEMPORARY TABLE _track_distinct_uwg_2 AS
SELECT
    A.mandant_id,
    A.art_matching_id,
    A.kl_wg_id,
    A.kl_owg_id,
    A.kl_uwg_id,
    COUNT(*) AS anzahl
FROM dbp_etl.art_matching_nielsen_per_final AS A
INNER JOIN `_track_distinct_uwg_1` AS B
    ON
        A.mandant_id = B.mandant_id AND A.art_matching_id = B.art_matching_id AND A.kl_wg_id = B.kl_wg_id AND A.kl_owg_id = B.kl_owg_id
WHERE
    A.art_id NOT IN (
        SELECT art_id
        FROM dbp_data.art
        WHERE
            mandant_id = 1
            AND TRIM(loesch_id) IN ('L', 'R')
    )
GROUP BY
    A.mandant_id,
    A.art_matching_id,
    A.kl_wg_id,
    A.kl_owg_id,
    A.kl_uwg_id;


UPDATE dbp_etl.art_matching_nielsen_per_final SET
    kl_uwg_id = x.kl_uwg_id FROM (
    SELECT
        A.mandant_id,
        A.art_matching_id,
        A.kl_wg_id,
        A.kl_owg_id,
        MIN(A.kl_uwg_id) AS kl_uwg_id
    FROM `_track_distinct_uwg_2` AS A
    INNER JOIN (
        SELECT
            mandant_id,
            art_matching_id,
            kl_wg_id,
            kl_owg_id,
            MAX(anzahl) AS anzahl
        FROM `_track_distinct_uwg_2`
        WHERE kl_uwg_id <> -3
        GROUP BY
            mandant_id,
            art_matching_id,
            kl_wg_id,
            kl_owg_id
    ) AS b
        ON
            A.mandant_id = b.mandant_id AND A.art_matching_id = b.art_matching_id AND A.anzahl = b.anzahl
            AND A.kl_wg_id = b.kl_wg_id AND A.kl_owg_id = b.kl_owg_id
    WHERE
        A.kl_wg_id > 0
        AND A.kl_owg_id > 0
        AND A.kl_uwg_id > 0
    GROUP BY
        A.mandant_id,
        A.art_matching_id,
        A.kl_wg_id,
        A.kl_owg_id
) AS x
WHERE art_matching_nielsen_per_final.mandant_id = x.mandant_id AND art_matching_nielsen_per_final.art_matching_id = x.art_matching_id;


-- 03.02.2019, -dbay-
--
-- Warengruppen von BI gepflegt muessen hier angezogen werden.


CREATE OR REPLACE TEMPORARY TABLE _sort_pflege_fehler AS
SELECT
    A.mandant_id,
    A.art_nielsen_id,
    A.art_nielsen_bez,
    A.fb_pflege_wg_id,
    A.fb_pflege_wug_id,
    A.nielsen_abteilung_bez,
    A.nielsen_wg_bez,
    A.nielsen_uwg1_bez,
    A.nielsen_uwg2_bez,
    A.kalk_vorschl_wg_id,
    A.kalk_vorschl_wug_id,
    A.datzeit_letzte_eintragung_fb_pflege,
    A.td_update,
    A.td_insert
FROM dbp_data.art_nielsen_wug_zu_pflege AS A
LEFT JOIN (
    SELECT
        A0.mandant_id,
        A0.wg_id,
        MAX(WFZ.wug_id) AS wug_id
    FROM dbp_data.wg_per AS A0
    INNER JOIN dbp_data.wg_filter_zu AS WFZ
        ON
            A0.wg_id = WFZ.wg_id AND A0.mandant_id = WFZ.mandant_id AND
            WFZ.wg_filter_id = 11 AND WFZ.arthiertyp_id = 2
    GROUP BY
        A0.mandant_id,
        A0.wg_id
) AS b ON A.mandant_id = b.mandant_id AND A.fb_pflege_wg_id = b.wg_id
WHERE
    b.wug_id IS NULL
    AND A.kalk_vorschl_wg_id <> -1
    AND A.fb_pflege_wg_id <> -1;


UPDATE dbp_data.art_nielsen_wug_zu_pflege SET
    fb_pflege_wg_id = -1,
    fb_pflege_wug_id = -1
FROM `_sort_pflege_fehler` AS b
WHERE art_nielsen_wug_zu_pflege.mandant_id = b.mandant_id AND art_nielsen_wug_zu_pflege.art_nielsen_id = b.art_nielsen_id;


UPDATE dbp_etl.art_matching_nielsen_per_final SET
    kl_owg_id = b.wg_id_neu,
    kl_uwg_id = b.wug_id_neu FROM (SELECT
    mandant_id,
    art_nielsen_id,
    CASE
        WHEN fb_pflege_wg_id = -1
            THEN kalk_vorschl_wg_id
        ELSE fb_pflege_wg_id
    END AS wg_id_neu,
    CASE
        WHEN fb_pflege_wug_id = -1
            THEN kalk_vorschl_wug_id
        ELSE fb_pflege_wug_id
    END AS wug_id_neu
FROM dbp_data.art_nielsen_wug_zu_pflege
WHERE mandant_id = 1) AS b
WHERE
    art_matching_nielsen_per_final.mandant_id = b.mandant_id AND art_matching_nielsen_per_final.art_nielsen_id = b.art_nielsen_id
    AND art_matching_nielsen_per_final.art_id = -1 AND (
        art_matching_nielsen_per_final.kl_owg_id <> b.wg_id_neu OR
        art_matching_nielsen_per_final.kl_uwg_id <> b.wug_id_neu
    );


UPDATE dbp_etl.art_matching_nielsen_per_final SET
    kl_wg_id = b.owg_id FROM (
    SELECT *
    FROM dbp_data.wg_per
    WHERE
        dat_bis = DATE '9999-12-31'
        AND owg_id > 0
) AS b
WHERE art_matching_nielsen_per_final.mandant_id = b.mandant_id AND art_matching_nielsen_per_final.kl_owg_id = b.wg_id;


CREATE OR REPLACE TEMPORARY TABLE _potenzial_hier AS
SELECT
    mandant_id,
    art_matching_id,
    gtin_id,
    MAX(kl_wg_id) AS kl_wg_id,
    MAX(kl_owg_id) AS kl_owg_id,
    MAX(kl_uwg_id) AS kl_uwg_id
FROM dbp_etl.art_matching_nielsen_per_final
WHERE (
    mandant_id, gtin_id) IN (
    SELECT (mandant_id, gtin_id)
    FROM dbp_etl.art_matching_nielsen_per_final
    WHERE
        art_id = -1
        AND gtin_id NOT IN (-9999, -9998)
    GROUP BY
        mandant_id,
        gtin_id
    HAVING COUNT(*) > 1
)
GROUP BY
    mandant_id,
    art_matching_id,
    gtin_id;


UPDATE dbp_etl.art_matching_nielsen_per_final SET
    kl_wg_id = b.kl_wg_id,
    kl_owg_id = b.kl_owg_id,
    kl_uwg_id = b.kl_uwg_id
FROM `_potenzial_hier` AS b
WHERE
    art_matching_nielsen_per_final.mandant_id = b.mandant_id AND art_matching_nielsen_per_final.art_matching_id = b.art_matching_id
    AND art_matching_nielsen_per_final.gtin_id = b.gtin_id;


-- 31.05.2019, -dbay-
--
-- An dieser Stelle wird das Listungskennzeichen platziert.


UPDATE dbp_etl.art_matching_nielsen_per_final SET
    list_kz = b.list_kz FROM (
    SELECT
        mandant_id,
        art_id,
        MIN(list_kz) AS list_kz
    FROM dbp_etl.kl_basis_listung
    GROUP BY
        mandant_id,
        art_id
) AS b
WHERE art_matching_nielsen_per_final.art_id = b.art_id AND art_matching_nielsen_per_final.mandant_id = b.mandant_id;


UPDATE dbp_etl.art_matching_nielsen_per_final SET
    komponente_fg = 0
WHERE TRUE;


UPDATE dbp_etl.art_matching_nielsen_per_final SET
    kl_owg_id = b.wg_id,
    kl_uwg_id = b.wug_id FROM (
    SELECT
        mandant_id,
        art_id,
        wg_id,
        wug_id
    FROM dbp_data.art_wg_zu_per
    WHERE
        dat_bis = DATE '9999-12-31'
        AND arthiertyp_id = 2
        AND mandant_id = 1
    GROUP BY
        mandant_id,
        art_id,
        wg_id,
        wug_id
) AS b
WHERE
    art_matching_nielsen_per_final.mandant_id = b.mandant_id AND art_matching_nielsen_per_final.art_id = b.art_id AND
    art_matching_nielsen_per_final.art_id <> -1 AND (
        art_matching_nielsen_per_final.kl_owg_id <> b.wg_id OR
        art_matching_nielsen_per_final.kl_uwg_id <> b.wug_id
    );


UPDATE dbp_etl.art_matching_nielsen_per_final SET
    kl_wg_id = b.owg_id FROM (
    SELECT *
    FROM dbp_data.wg_per
    WHERE
        dat_bis = DATE '9999-12-31'
        AND mandant_id = 1
        AND owg_id <> -1
) AS b
WHERE
    art_matching_nielsen_per_final.mandant_id = b.mandant_id AND art_matching_nielsen_per_final.kl_owg_id = b.wg_id
    AND art_matching_nielsen_per_final.art_id <> -1 AND art_matching_nielsen_per_final.kl_wg_id <> b.owg_id;


-- 03.02.2019, -dbay-
--
-- Warengruppenhierarchie fuer Matchings ueber alle Ebenen sauber
-- hinstellen!

-- 1. OWG


CREATE OR REPLACE TEMPORARY TABLE _track_distinct AS
SELECT
    mandant_id,
    art_matching_id,
    COUNT(*) AS anz,
    COUNT(DISTINCT kl_wg_id) AS anz_wg
FROM dbp_etl.art_matching_nielsen_per_final
GROUP BY
    mandant_id,
    art_matching_id
HAVING anz_wg > 1;


CREATE OR REPLACE TEMPORARY TABLE _track_distinct2 AS
SELECT
    A.mandant_id,
    A.art_matching_id,
    A.kl_wg_id,
    A.kl_owg_id,
    A.kl_uwg_id,
    COUNT(*) AS anzahl
FROM dbp_etl.art_matching_nielsen_per_final AS A
INNER JOIN `_track_distinct` AS B ON A.mandant_id = B.mandant_id AND A.art_matching_id = B.art_matching_id
WHERE
    A.art_id NOT IN (
        SELECT art_id
        FROM dbp_data.art
        WHERE
            mandant_id = 1
            AND TRIM(loesch_id) IN ('L', 'R')
    )
GROUP BY
    A.mandant_id,
    A.art_matching_id,
    A.kl_wg_id,
    A.kl_owg_id,
    A.kl_uwg_id;


UPDATE dbp_etl.art_matching_nielsen_per_final SET
    kl_wg_id = x.kl_wg_id,
    kl_owg_id = x.kl_owg_id,
    kl_uwg_id = x.kl_uwg_id FROM (
    SELECT
        A.mandant_id,
        A.art_matching_id,
        MIN(A.kl_wg_id) AS kl_wg_id,
        MIN(A.kl_owg_id) AS kl_owg_id,
        MIN(A.kl_uwg_id) AS kl_uwg_id
    FROM `_track_distinct2` AS A
    INNER JOIN (
        SELECT
            mandant_id,
            art_matching_id,
            MAX(anzahl) AS anzahl
        FROM `_track_distinct2`
        WHERE kl_wg_id <> -3
        GROUP BY
            mandant_id,
            art_matching_id
    ) AS b ON A.mandant_id = b.mandant_id AND A.art_matching_id = b.art_matching_id AND A.anzahl = b.anzahl

    WHERE
        A.kl_wg_id > 0
        AND A.kl_owg_id > 0
        AND A.kl_uwg_id > 0
    GROUP BY
        A.mandant_id,
        A.art_matching_id
) AS x
WHERE art_matching_nielsen_per_final.mandant_id = x.mandant_id AND art_matching_nielsen_per_final.art_matching_id = x.art_matching_id;


-- 2. WG


CREATE OR REPLACE TEMPORARY TABLE _track_distinct_owg_1 AS
SELECT
    mandant_id,
    art_matching_id,
    kl_wg_id,
    COUNT(*) AS anz,
    COUNT(DISTINCT kl_owg_id) AS anz_owg
FROM dbp_etl.art_matching_nielsen_per_final
GROUP BY
    mandant_id,
    art_matching_id,
    kl_wg_id
HAVING anz_owg > 1;


CREATE OR REPLACE TEMPORARY TABLE _track_distinct_owg_2 AS
SELECT
    A.mandant_id,
    A.art_matching_id,
    A.kl_wg_id,
    A.kl_owg_id,
    A.kl_uwg_id,
    COUNT(*) AS anzahl
FROM dbp_etl.art_matching_nielsen_per_final AS A
INNER JOIN `_track_distinct_owg_1` AS B ON A.mandant_id = B.mandant_id AND A.art_matching_id = B.art_matching_id
WHERE
    A.art_id NOT IN (
        SELECT art_id
        FROM dbp_data.art
        WHERE
            mandant_id = 1
            AND TRIM(loesch_id) IN ('L', 'R')
    )
GROUP BY
    A.mandant_id,
    A.art_matching_id,
    A.kl_wg_id,
    A.kl_owg_id,
    A.kl_uwg_id;


UPDATE dbp_etl.art_matching_nielsen_per_final SET
    kl_owg_id = x.kl_owg_id,
    kl_uwg_id = x.kl_uwg_id FROM (
    SELECT
        A.mandant_id,
        A.art_matching_id,
        A.kl_wg_id,
        MIN(A.kl_owg_id) AS kl_owg_id,
        MIN(A.kl_uwg_id) AS kl_uwg_id
    FROM `_track_distinct_owg_2` AS A
    INNER JOIN (
        SELECT
            mandant_id,
            art_matching_id,
            kl_wg_id,
            MAX(anzahl) AS anzahl
        FROM `_track_distinct_owg_2`
        WHERE kl_owg_id <> -3
        GROUP BY
            mandant_id,
            art_matching_id,
            kl_wg_id
    ) AS b
        ON
            A.mandant_id = b.mandant_id AND A.art_matching_id = b.art_matching_id AND A.anzahl = b.anzahl AND
            A.kl_wg_id = b.kl_wg_id
    WHERE
        A.kl_wg_id > 0
        AND A.kl_owg_id > 0
        AND A.kl_uwg_id > 0
    GROUP BY
        A.mandant_id,
        A.art_matching_id,
        A.kl_wg_id
) AS x
WHERE art_matching_nielsen_per_final.mandant_id = x.mandant_id AND art_matching_nielsen_per_final.art_matching_id = x.art_matching_id;


-- 3. WGI


CREATE OR REPLACE TEMPORARY TABLE _track_distinct_uwg_1 AS
SELECT
    mandant_id,
    art_matching_id,
    kl_wg_id,
    kl_owg_id,
    COUNT(*) AS anz,
    COUNT(DISTINCT kl_uwg_id) AS anz_uwg
FROM dbp_etl.art_matching_nielsen_per_final
GROUP BY
    mandant_id,
    art_matching_id,
    kl_wg_id,
    kl_owg_id
HAVING anz_uwg > 1;


CREATE OR REPLACE TEMPORARY TABLE _track_distinct_uwg_2 AS
SELECT
    A.mandant_id,
    A.art_matching_id,
    A.kl_wg_id,
    A.kl_owg_id,
    A.kl_uwg_id,
    COUNT(*) AS anzahl
FROM dbp_etl.art_matching_nielsen_per_final AS A
INNER JOIN `_track_distinct_uwg_1` AS B
    ON
        A.mandant_id = B.mandant_id AND A.art_matching_id = B.art_matching_id AND A.kl_wg_id = B.kl_wg_id AND A.kl_owg_id = B.kl_owg_id
WHERE
    A.art_id NOT IN (
        SELECT art_id
        FROM dbp_data.art
        WHERE
            mandant_id = 1
            AND TRIM(loesch_id) IN ('L', 'R')
    )
GROUP BY
    A.mandant_id,
    A.art_matching_id,
    A.kl_wg_id,
    A.kl_owg_id,
    A.kl_uwg_id;


UPDATE dbp_etl.art_matching_nielsen_per_final SET
    kl_uwg_id = x.kl_uwg_id FROM (
    SELECT
        A.mandant_id,
        A.art_matching_id,
        A.kl_wg_id,
        A.kl_owg_id,
        MIN(A.kl_uwg_id) AS kl_uwg_id
    FROM `_track_distinct_uwg_2` AS A
    INNER JOIN (
        SELECT
            mandant_id,
            art_matching_id,
            kl_wg_id,
            kl_owg_id,
            MAX(anzahl) AS anzahl
        FROM `_track_distinct_uwg_2`
        WHERE kl_uwg_id <> -3
        GROUP BY
            mandant_id,
            art_matching_id,
            kl_wg_id,
            kl_owg_id
    ) AS b
        ON
            A.mandant_id = b.mandant_id AND A.art_matching_id = b.art_matching_id AND A.anzahl = b.anzahl
            AND A.kl_wg_id = b.kl_wg_id AND A.kl_owg_id = b.kl_owg_id
    WHERE
        A.kl_wg_id > 0
        AND A.kl_owg_id > 0
        AND A.kl_uwg_id > 0
    GROUP BY
        A.mandant_id,
        A.art_matching_id,
        A.kl_wg_id,
        A.kl_owg_id
) AS x
WHERE art_matching_nielsen_per_final.mandant_id = x.mandant_id AND art_matching_nielsen_per_final.art_matching_id = x.art_matching_id;


-- correct state settings, only differentiated between 'N' (regular) and 'T' (tupel)


UPDATE dbp_etl.art_matching_nielsen_per_final AS art_matching_nielsen_per_final0 SET
    status = 'N' FROM (
    SELECT
        art_matching_id,
        COUNT(DISTINCT CASE
            WHEN art_id = -1
                THEN NULL
            ELSE art_id
        END) AS anz_art,
        COUNT(DISTINCT CASE
            WHEN art_nielsen_id = -1
                THEN NULL
            ELSE art_nielsen_id
        END) AS anz_art_nielsen
    FROM dbp_etl.art_matching_nielsen_per_final
    WHERE mandant_id = 1
    GROUP BY art_matching_id
    HAVING
        anz_art = 0 AND anz_art_nielsen = 1 OR anz_art = 1 AND anz_art_nielsen = 0 OR anz_art = 1 AND anz_art_nielsen =
        1
) AS b
WHERE
    art_matching_nielsen_per_final0.art_matching_id = b.art_matching_id AND art_matching_nielsen_per_final0.mandant_id
    = 1;


UPDATE dbp_etl.art_matching_nielsen_per_final AS art_matching_nielsen_per_final0 SET
    status = 'T' FROM (SELECT
    art_matching_id,
    COUNT(DISTINCT CASE
        WHEN art_id = -1
            THEN NULL
        ELSE art_id
    END) AS anz_art,
    COUNT(DISTINCT CASE
        WHEN art_nielsen_id = -1
            THEN NULL
        ELSE art_nielsen_id
    END) AS anz_art_nielsen
FROM dbp_etl.art_matching_nielsen_per_final
WHERE mandant_id = 1
GROUP BY art_matching_id
HAVING anz_art > 1) AS b
WHERE
    art_matching_nielsen_per_final0.art_matching_id = b.art_matching_id AND art_matching_nielsen_per_final0.mandant_id
    = 1;


-- That's it --


CREATE OR REPLACE TEMPORARY TABLE _get_it_straight AS
SELECT
    mandant_id,
    art_nielsen_id,
    MAX(art_id) AS max_art_id,
    MIN(art_matching_id) AS min_match,
    MAX(art_matching_id) AS max_match,
    COUNT(DISTINCT art_matching_id) AS anz_match,
    COUNT(DISTINCT CASE
        WHEN art_id = -1
            THEN NULL
        ELSE art_id
    END) AS anz_art,
    MAX(kl_wg_id) AS kl_wg_id,
    MAX(kl_owg_id) AS kl_owg_id,
    MAX(kl_uwg_id) AS kl_uwg_id
FROM dbp_etl.art_matching_nielsen_per_final
GROUP BY
    mandant_id,
    art_nielsen_id
HAVING anz_match > 1 AND anz_art = 1;


UPDATE dbp_etl.art_matching_nielsen_per_final SET
    art_matching_id = b.min_match,
    art_id = b.max_art_id,
    kl_wg_id = b.kl_wg_id,
    kl_owg_id = b.kl_owg_id,
    kl_uwg_id = b.kl_uwg_id
FROM `_get_it_straight` AS b
WHERE art_matching_nielsen_per_final.mandant_id = b.mandant_id AND art_matching_nielsen_per_final.art_nielsen_id = b.art_nielsen_id;


UPDATE dbp_etl.art_matching_nielsen_per_final AS art_matching_nielsen_per_final0 SET
    kl_wg_id = b.max_kl_wg_id,
    kl_owg_id = b.max_kl_owg_id,
    kl_uwg_id = b.max_kl_uwg_id FROM (SELECT
    mandant_id,
    art_matching_id,
    MAX(kl_wg_id) AS max_kl_wg_id,
    MAX(kl_owg_id) AS max_kl_owg_id,
    MIN(kl_uwg_id) AS max_kl_uwg_id
FROM dbp_etl.art_matching_nielsen_per_final
GROUP BY
    mandant_id,
    art_matching_id
HAVING COUNT(DISTINCT kl_wg_id) > 1 OR COUNT(DISTINCT kl_owg_id) > 1 OR COUNT(DISTINCT kl_uwg_id) > 1) AS b
WHERE
    art_matching_nielsen_per_final0.mandant_id = b.mandant_id AND art_matching_nielsen_per_final0.art_matching_id = b.art_matching_id;


-------- FINAL STEP FOR GROUPS -----------


CREATE OR REPLACE TEMPORARY TABLE _gp AS
SELECT
    mandant_id,
    art_id
FROM dbp_data.art_gp_zu_per
WHERE
    mandant_id = 1
    AND gp_id = 5059720
    AND dat_bis = DATE '9999-12-31'
GROUP BY
    mandant_id,
    art_id;


CREATE OR REPLACE TEMPORARY TABLE _track_artikel AS
SELECT
    B.art_gruppe_id,
    B.mandant_id,
    B.art_id,
    B.umrech_faktor,
    B.td_update,
    B.td_insert
FROM dbp_data.art_gruppe AS A
INNER JOIN dbp_data.art_gruppe_art_zu AS B ON A.art_gruppe_id = B.art_gruppe_id
WHERE
    A.art_gruppe_kategorie = 'Sortimentstool'
    AND B.mandant_id = 1
    AND A.art_gruppe_id IN (
        SELECT B0.art_gruppe_id
        FROM dbp_data.art_gruppe AS A0
        INNER JOIN dbp_data.art_gruppe_art_zu AS B0 ON A0.art_gruppe_id = B0.art_gruppe_id
        WHERE
            A0.art_gruppe_kategorie = 'Sortimentstool'
            AND B0.mandant_id = 1
        GROUP BY B0.art_gruppe_id
    )
    AND B.art_id NOT IN (
        SELECT art_id
        FROM `_gp`
    );


INSERT INTO dbp_etl.art_matching_nielsen_per_final (
    mandant_id, art_matching_id, art_id, art_nielsen_id,
    gtin_id, kl_art_kat_id, kl_wg_id, kl_owg_id, kl_uwg_id, umrech_faktor, status, list_kz, komponente_fg, kjwo_update
)
(
    SELECT DISTINCT
        B.mandant_id,
        B.art_matching_id,
        B.art_id,
        -1 AS art_nielsen_id,
        c.gtin_id,
        0 AS kl_art_kat_id,
        0 AS kl_wg_id,
        0 AS kl_owg_id,
        0 AS kl_uwg_id,
        CAST(B.umrech_faktor AS FLOAT64) AS umrech_faktor,
        'N' AS status,
        'A' AS list_kz,
        0 AS komponente_fg,
        (
            SELECT MAX(kjwo_update)
            FROM dbp_etl.art_matching_nielsen_per_final
        ) AS kjwo_update
    FROM (
        SELECT art_id
        FROM `_track_artikel`
        WHERE
            art_id NOT IN (
                SELECT art_id
                FROM dbp_etl.art_matching_nielsen_per_final
            )
        GROUP BY art_id
    ) AS bx
    INNER JOIN dbp_etl_process.art_art_nielsen_groups AS B ON bx.art_id = B.art_id
    INNER JOIN (
        SELECT
            mandant_id,
            art_id,
            MAX(gtin_id) AS gtin_id
        FROM dbp_etl_process.art_gtin
        WHERE mandant_id = 1
        GROUP BY
            art_id,
            mandant_id
    ) AS c ON B.mandant_id = c.mandant_id AND B.art_id = c.art_id
);


UPDATE dbp_etl.art_matching_nielsen_per_final SET
    art_matching_id = b.max_match FROM (
    SELECT
        mandant_id,
        art_matching_id,
        MAX(max_match) AS max_match
    FROM (SELECT
        t0.mandant_id,
        t0.art_matching_id,
        MAX(t0.art_matching_id) OVER (PARTITION BY
            t0.mandant_id, t0.art_gruppe_id ORDER BY
            t0.mandant_id IS NULL, t0.mandant_id,
            t0.art_gruppe_id IS NULL, t0.art_gruppe_id
        RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS max_match
    FROM (
        SELECT
            A.mandant_id,
            A.art_gruppe_id,
            B.art_matching_id
        FROM dbp_etl_process.art_art_nielsen_groups AS A
        INNER JOIN dbp_etl.art_matching_nielsen_per_final AS B
            ON
                A.mandant_id = B.mandant_id AND A.art_id
                = B.art_id
        GROUP BY
            A.mandant_id,
            A.art_gruppe_id,
            B.art_matching_id
    ) AS t0) AS x
    GROUP BY
        mandant_id,
        art_matching_id
) AS b
WHERE
    art_matching_nielsen_per_final.mandant_id = b.mandant_id AND art_matching_nielsen_per_final.art_matching_id = b.art_matching_id
    AND art_matching_nielsen_per_final.art_matching_id <> b.max_match;


UPDATE dbp_etl.art_matching_nielsen_per_final AS art_matching_nielsen_per_final0 SET
    art_matching_id = b.art_matching_id FROM (SELECT
    mandant_id,
    art_matching_id,
    gtin_id
FROM (SELECT
    mandant_id,
    gtin_id,
    MAX(art_matching_id) AS art_matching_id,
    COUNT(DISTINCT art_matching_id) AS a0
FROM dbp_etl.art_matching_nielsen_per_final
WHERE gtin_id NOT IN (-9999, -9998)
GROUP BY
    mandant_id,
    gtin_id
HAVING a0 > 1) AS t1) AS b
WHERE
    art_matching_nielsen_per_final0.mandant_id = b.mandant_id AND art_matching_nielsen_per_final0.gtin_id = b.gtin_id
    AND art_matching_nielsen_per_final0.art_matching_id <> b.art_matching_id;


UPDATE dbp_etl.art_matching_nielsen_per_final AS art_matching_nielsen_per_final0 SET
    art_matching_id = b.max_match FROM (SELECT
    mandant_id,
    art_id,
    MIN(art_matching_id) AS min_match,
    MAX(art_matching_id) AS max_match
FROM dbp_etl.art_matching_nielsen_per_final
WHERE art_id <> -1
GROUP BY
    mandant_id,
    art_id
HAVING COUNT(DISTINCT art_matching_id) > 1) AS b
WHERE art_matching_nielsen_per_final0.mandant_id = b.mandant_id AND art_matching_nielsen_per_final0.art_id = b.art_id;


UPDATE dbp_etl.art_matching_nielsen_per_final AS art_matching_nielsen_per_final0 SET
    art_matching_id = b.art_matching_id FROM (SELECT
    mandant_id,
    art_matching_id,
    gtin_id
FROM (SELECT
    mandant_id,
    gtin_id,
    MAX(art_matching_id) AS art_matching_id,
    COUNT(DISTINCT art_matching_id) AS a0
FROM dbp_etl.art_matching_nielsen_per_final
WHERE gtin_id NOT IN (-9999, -9998)
GROUP BY
    mandant_id,
    gtin_id
HAVING a0 > 1) AS t1) AS b
WHERE
    art_matching_nielsen_per_final0.mandant_id = b.mandant_id AND art_matching_nielsen_per_final0.gtin_id = b.gtin_id
    AND art_matching_nielsen_per_final0.art_matching_id <> b.art_matching_id;


UPDATE dbp_etl.art_matching_nielsen_per_final AS art_matching_nielsen_per_final0 SET
    art_matching_id = b.art_matching_id FROM (SELECT
    mandant_id,
    art_matching_id,
    art_id
FROM (SELECT
    mandant_id,
    art_id,
    MAX(art_matching_id) AS art_matching_id,
    COUNT(DISTINCT art_matching_id) AS a0
FROM dbp_etl.art_matching_nielsen_per_final
WHERE art_id <> -1
GROUP BY
    mandant_id,
    art_id
HAVING a0 > 1) AS t1) AS b
WHERE
    art_matching_nielsen_per_final0.mandant_id = b.mandant_id AND art_matching_nielsen_per_final0.art_id = b.art_id
    AND art_matching_nielsen_per_final0.art_matching_id <> b.art_matching_id;


UPDATE dbp_etl.art_matching_nielsen_per_final AS art_matching_nielsen_per_final0 SET
    art_matching_id = b.art_matching_id FROM (SELECT
    mandant_id,
    art_matching_id,
    gtin_id
FROM (SELECT
    mandant_id,
    gtin_id,
    MAX(art_matching_id) AS art_matching_id,
    COUNT(DISTINCT art_matching_id) AS a0
FROM dbp_etl.art_matching_nielsen_per_final
WHERE gtin_id NOT IN (-9999, -9998)
GROUP BY
    mandant_id,
    gtin_id
HAVING a0 > 1) AS t1) AS b
WHERE
    art_matching_nielsen_per_final0.mandant_id = b.mandant_id AND art_matching_nielsen_per_final0.gtin_id = b.gtin_id
    AND art_matching_nielsen_per_final0.art_matching_id <> b.art_matching_id;


UPDATE dbp_etl.art_matching_nielsen_per_final AS art_matching_nielsen_per_final0 SET
    art_matching_id = b.art_matching_id FROM (SELECT
    mandant_id,
    art_matching_id,
    art_id
FROM (SELECT
    mandant_id,
    art_id,
    MAX(art_matching_id) AS art_matching_id,
    COUNT(DISTINCT art_matching_id) AS a0
FROM dbp_etl.art_matching_nielsen_per_final
WHERE art_id <> -1
GROUP BY
    mandant_id,
    art_id
HAVING a0 > 1) AS t1) AS b
WHERE
    art_matching_nielsen_per_final0.mandant_id = b.mandant_id AND art_matching_nielsen_per_final0.art_id = b.art_id
    AND art_matching_nielsen_per_final0.art_matching_id <> b.art_matching_id;


UPDATE dbp_etl.art_matching_nielsen_per_final SET
    art_matching_id = b.max_match FROM (
    SELECT
        mandant_id,
        art_matching_id,
        MAX(max_match) AS max_match
    FROM (SELECT
        t0.mandant_id,
        t0.art_matching_id,
        MAX(t0.art_matching_id) OVER (PARTITION BY
            t0.mandant_id, t0.art_gruppe_id ORDER BY
            t0.mandant_id IS NULL, t0.mandant_id,
            t0.art_gruppe_id IS NULL, t0.art_gruppe_id
        RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS max_match
    FROM (
        SELECT
            A.mandant_id,
            A.art_gruppe_id,
            B.art_matching_id
        FROM dbp_etl_process.art_art_nielsen_groups AS A
        INNER JOIN dbp_etl.art_matching_nielsen_per_final AS B
            ON
                A.mandant_id = B.mandant_id AND A.art_id
                = B.art_id
        GROUP BY
            A.mandant_id,
            A.art_gruppe_id,
            B.art_matching_id
    ) AS t0) AS x
    GROUP BY
        mandant_id,
        art_matching_id
) AS b
WHERE
    art_matching_nielsen_per_final.mandant_id = b.mandant_id AND art_matching_nielsen_per_final.art_matching_id = b.art_matching_id
    AND art_matching_nielsen_per_final.art_matching_id <> b.max_match;


--custom article grouping for beers


CREATE OR REPLACE TEMPORARY TABLE _part AS
SELECT
    B.art_gruppe_id,
    B.mandant_id,
    B.art_id,
    B.umrech_faktor,
    B.td_update,
    B.td_insert,
    A.art_matching_id
FROM dbp_etl.art_matching_nielsen_per_final AS A
INNER JOIN `_track_artikel` AS B ON A.mandant_id = B.mandant_id AND A.art_id = B.art_id;


CREATE OR REPLACE TEMPORARY TABLE _part_2 AS
SELECT DISTINCT
    (
        SELECT MAX(art_matching_id)
        FROM dbp_etl.art_matching_nielsen_per_final
        WHERE mandant_id = 1
    ) AS new_matching_id,
    art_matching_id,
    art_gruppe_id,
    mandant_id,
    art_id,
    DENSE_RANK() OVER (ORDER BY mandant_id IS NULL, mandant_id, art_gruppe_id IS NULL, art_gruppe_id) AS rang
FROM `_part`;


CREATE OR REPLACE TEMPORARY TABLE _part_3 AS
SELECT DISTINCT
    new_matching_id + rang AS new_matching_id,
    art_matching_id,
    art_gruppe_id,
    mandant_id,
    art_id
FROM `_part_2`;


UPDATE dbp_etl.art_matching_nielsen_per_final SET
    art_matching_id = b.new_matching_id
FROM `_part_3` AS b
WHERE
    art_matching_nielsen_per_final.mandant_id = b.mandant_id AND art_matching_nielsen_per_final.art_matching_id = b.art_matching_id
    AND art_matching_nielsen_per_final.art_id = b.art_id;


--bookkeeping of matching_id and unification


CREATE OR REPLACE TEMPORARY TABLE _group1 AS
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
    A.kjwo_update,
    A.td_update,
    A.td_insert,
    B.art_gruppe_id,
    COUNT(*) OVER (
        PARTITION BY A.art_matching_id, B.art_gruppe_id RANGE BETWEEN UNBOUNDED PRECEDING AND
        UNBOUNDED FOLLOWING
    ) AS num
FROM dbp_etl.art_matching_nielsen_per_final AS A
LEFT JOIN `_track_artikel` AS B ON A.mandant_id = B.mandant_id AND A.art_id = B.art_id
WHERE B.art_gruppe_id IS NOT NULL;


CREATE OR REPLACE TEMPORARY TABLE _group2 AS
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
    A.kjwo_update,
    A.td_update,
    A.td_insert,
    B.art_gruppe_id,
    COUNT(*) OVER (
        PARTITION BY A.art_matching_id, B.art_gruppe_id RANGE BETWEEN UNBOUNDED PRECEDING AND
        UNBOUNDED FOLLOWING
    ) AS num
FROM dbp_etl.art_matching_nielsen_per AS A
LEFT JOIN `_track_artikel` AS B ON A.mandant_id = B.mandant_id AND A.art_id = B.art_id
WHERE A.kjwo_update = (
    SELECT MAX(kjwo_update)
    FROM dbp_etl.art_matching_nielsen_per
)
AND B.art_gruppe_id IS NOT NULL;


UPDATE `_group1` SET
    art_matching_id = b.art_matching_id FROM (
    SELECT *
    FROM `_group2`
    WHERE art_gruppe_id IS NOT NULL
) AS b
WHERE
    `_group1`.mandant_id = b.mandant_id AND `_group1`.art_id = b.art_id AND `_group1`.art_nielsen_id = b.art_nielsen_id
    AND `_group1`.gtin_id = b.gtin_id AND `_group1`.art_gruppe_id = b.art_gruppe_id AND `_group1`.num = b.num;


UPDATE dbp_etl.art_matching_nielsen_per_final SET
    art_matching_id = b.art_matching_id FROM (
    SELECT *
    FROM `_group1`
    WHERE art_gruppe_id IS NOT NULL
) AS b
WHERE
    art_matching_nielsen_per_final.mandant_id = b.mandant_id AND art_matching_nielsen_per_final.art_id = b.art_id AND
    art_matching_nielsen_per_final.art_nielsen_id = b.art_nielsen_id AND art_matching_nielsen_per_final.gtin_id = b.gtin_id;


--UMRECH_FAKTOR


UPDATE dbp_etl.art_matching_nielsen_per_final SET
    umrech_faktor = CAST(b.umrech_faktor AS FLOAT64)
FROM `_track_artikel` AS b
WHERE art_matching_nielsen_per_final.mandant_id = b.mandant_id AND art_matching_nielsen_per_final.art_id = b.art_id;


UPDATE dbp_etl.art_matching_nielsen_per_final SET
    status = 'N'
WHERE TRUE;


UPDATE dbp_etl.art_matching_nielsen_per_final AS art_matching_nielsen_per_final0 SET
    status = 'T' FROM (SELECT
    art_matching_id,
    COUNT(DISTINCT CASE
        WHEN art_id = -1
            THEN NULL
        ELSE art_id
    END) AS anz_art,
    COUNT(DISTINCT CASE
        WHEN art_nielsen_id = -1
            THEN NULL
        ELSE art_nielsen_id
    END) AS anz_art_nielsen
FROM dbp_etl.art_matching_nielsen_per_final
WHERE mandant_id = 1
GROUP BY art_matching_id
HAVING anz_art > 1) AS b
WHERE
    art_matching_nielsen_per_final0.art_matching_id = b.art_matching_id AND art_matching_nielsen_per_final0.mandant_id
    = 1;


--- Historisierung ---


CREATE OR REPLACE TEMPORARY TABLE _ek_sort_art_matching_zu_tmp (
    mandant_id INTEGER,
    art_matching_id INTEGER,
    kombi_art_id STRING(5000),
    kombi_art_nielsen_id STRING(5000),
    kombi_gtin_id STRING(5000),
    dat_von DATE,
    dat_bis DATE
);


INSERT INTO _ek_sort_art_matching_zu_tmp (
    mandant_id,
    art_matching_id,
    kombi_art_id,
    kombi_art_nielsen_id,
    kombi_gtin_id,
    dat_von,
    dat_bis
)
SELECT
    mandant_id,
    art_matching_id,
    SUBSTR(REPLACE(TRIM(STRING_AGG(CAST(CAST(art_id AS INT64) AS STRING), ',' ORDER BY FLOOR(CAST(art_id AS FLOAT64)))), ' ', ''), 1, 5000) AS art_id,
    SUBSTR(REPLACE(TRIM(STRING_AGG(CAST(CAST(art_nielsen_id AS INT64) AS STRING), ',' ORDER BY FLOOR(CAST(art_nielsen_id AS FLOAT64)))), ' ', ''), 1, 5000) AS art_nielsen_id,
    SUBSTR(REPLACE(TRIM(STRING_AGG(CAST(CAST(gtin_id AS INT64) AS STRING), ',' ORDER BY FLOOR(CAST(gtin_id AS FLOAT64)))), ' ', ''), 1, 5000) AS gtin_id,
    DATE '1900-01-01',
    DATE '9999-12-31'
FROM dbp_etl.art_matching_nielsen_per_final
GROUP BY 1, 2;


UPDATE dbp_etl_process.ek_sort_art_matching_zu AS ek_sort_art_matching_zu0 SET
    dat_bis = DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 1 DAY) FROM (
    SELECT
        mandant_id,
        art_matching_id
    FROM dbp_etl_process.ek_sort_art_matching_zu
    WHERE
        dat_bis = DATE '9999-12-31'
        AND (
            mandant_id, art_matching_id) NOT IN (
            SELECT (mandant_id, art_matching_id)
            FROM `_ek_sort_art_matching_zu_tmp`
        )
) AS b
WHERE
    ek_sort_art_matching_zu0.mandant_id = b.mandant_id AND ek_sort_art_matching_zu0.art_matching_id = b.art_matching_id
    AND ek_sort_art_matching_zu0.dat_bis = DATE '9999-12-31';


CREATE OR REPLACE TEMPORARY TABLE _changes AS
SELECT
    A.mandant_id,
    A.art_matching_id,
    A.kombi_art_id,
    A.kombi_art_nielsen_id,
    A.kombi_gtin_id,
    A.dat_von,
    A.dat_bis
FROM dbp_etl_process.ek_sort_art_matching_zu AS A
LEFT JOIN `_ek_sort_art_matching_zu_tmp` AS B
    ON
        A.mandant_id = B.mandant_id AND A.art_matching_id = B.art_matching_id
        AND A.kombi_art_id = B.kombi_art_id AND A.kombi_art_nielsen_id = B.kombi_art_nielsen_id
WHERE
    B.dat_von IS NULL
    AND A.dat_bis = DATE '9999-12-31';


CREATE OR REPLACE TEMPORARY TABLE _news AS
SELECT *
FROM `_ek_sort_art_matching_zu_tmp`
WHERE (
    mandant_id, art_matching_id) IN (
    SELECT (mandant_id, art_matching_id)
    FROM `_changes`
);


UPDATE dbp_etl_process.ek_sort_art_matching_zu SET
    dat_bis = DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 1 DAY)
FROM `_changes` AS b
WHERE
    ek_sort_art_matching_zu.mandant_id = b.mandant_id AND ek_sort_art_matching_zu.art_matching_id = b.art_matching_id
    AND ek_sort_art_matching_zu.dat_bis = DATE '9999-12-31';


INSERT INTO dbp_etl_process.ek_sort_art_matching_zu (
    mandant_id, art_matching_id, kombi_art_id,
    kombi_art_nielsen_id, kombi_gtin_id, dat_von, dat_bis
)
(SELECT
    mandant_id,
    art_matching_id,
    kombi_art_id,
    kombi_art_nielsen_id,
    kombi_gtin_id,
    CURRENT_DATE("Europe/Berlin") AS dat_von,
    DATE('9999-12-31') AS dat_bis
FROM `_news`);


--- final exchange

--- 1st: keeping the old, useless records for frontend purpose


INSERT INTO dbp_etl.art_matching_nielsen_per_olds
(
    SELECT *
    FROM dbp_etl.art_matching_nielsen_per
    WHERE (
        mandant_id, art_matching_id) NOT IN (
        SELECT (mandant_id, art_matching_id)
        FROM dbp_etl.art_matching_nielsen_per_final
    )
);


-- maintenance


DELETE FROM dbp_etl.art_matching_nielsen_per_olds
WHERE kjwo_update NOT IN (
    SELECT kjwo
    FROM dbp_data.woche
    WHERE akt_wo BETWEEN -6 AND 1
);


--- 2nd: new registration


TRUNCATE TABLE dbp_etl.art_matching_nielsen_per;


INSERT INTO dbp_etl.art_matching_nielsen_per
(
    SELECT *
    FROM dbp_etl.art_matching_nielsen_per_final
);


-- start --

-- correct product groups before transformation


CREATE OR REPLACE TEMPORARY TABLE _track_distinct AS
SELECT
    A.mandant_id,
    A.art_matching_id,
    MAX(D.owg_id) AS kl_wg_id,
    MAX(C.wg_id) AS kl_owg_id,
    MIN(C.wug_id) AS kl_uwg_id
FROM dbp_etl.art_matching_nielsen_per AS A
INNER JOIN (SELECT
    mandant_id,
    art_matching_id
FROM dbp_etl.art_matching_nielsen_per
GROUP BY
    mandant_id,
    art_matching_id
HAVING COUNT(DISTINCT kl_wg_id) > 1 OR COUNT(DISTINCT kl_owg_id) > 1 OR COUNT(DISTINCT kl_uwg_id) > 1) AS b
    ON
        A.mandant_id
        = b.mandant_id AND A.art_matching_id = b.art_matching_id
INNER JOIN dbp_data.art_wg_zu_per AS C
    ON
        A.mandant_id = C.mandant_id AND A.art_id = C.art_id AND C.dat_bis
        = DATE '9999-12-31' AND C.arthiertyp_id = 2
INNER JOIN dbp_data.wg_per AS D
    ON
        A.mandant_id = D.mandant_id AND C.wg_id = D.wg_id AND D.arthiertyp_id
        = 2 AND D.dat_bis = DATE '9999-12-31'
WHERE
    C.wg_id IN (
        SELECT wg_id
        FROM dbp_data.wg_filter_zu
        WHERE wg_filter_id = 11
        GROUP BY wg_id
    )
GROUP BY
    A.mandant_id,
    A.art_matching_id;


UPDATE dbp_etl.art_matching_nielsen_per SET
    kl_wg_id = b.kl_wg_id,
    kl_owg_id = b.kl_owg_id,
    kl_uwg_id = b.kl_uwg_id FROM (SELECT
    mandant_id,
    art_matching_id,
    kl_wg_id,
    kl_owg_id,
    kl_uwg_id
FROM `_track_distinct`) AS b
WHERE art_matching_nielsen_per.mandant_id = b.mandant_id AND art_matching_nielsen_per.art_matching_id = b.art_matching_id;


CREATE OR REPLACE TEMPORARY TABLE _track_distinct AS
SELECT
    A.mandant_id,
    A.art_matching_id,
    MAX(A.kl_wg_id) AS kl_wg_id,
    MAX(A.kl_owg_id) AS kl_owg_id,
    MIN(A.kl_uwg_id) AS kl_uwg_id
FROM dbp_etl.art_matching_nielsen_per AS A
INNER JOIN (SELECT
    mandant_id,
    art_matching_id
FROM dbp_etl.art_matching_nielsen_per
GROUP BY
    mandant_id,
    art_matching_id
HAVING COUNT(DISTINCT kl_wg_id) > 1 OR COUNT(DISTINCT kl_owg_id) > 1 OR COUNT(DISTINCT kl_uwg_id) > 1) AS b
    ON
        A.mandant_id
        = b.mandant_id AND A.art_matching_id = b.art_matching_id
WHERE
    A.kl_owg_id IN (
        SELECT wg_id
        FROM dbp_data.wg_filter_zu
        WHERE wg_filter_id = 11
        GROUP BY wg_id
    )
GROUP BY
    A.mandant_id,
    A.art_matching_id;


UPDATE dbp_etl.art_matching_nielsen_per SET
    kl_wg_id = b.kl_wg_id,
    kl_owg_id = b.kl_owg_id,
    kl_uwg_id = b.kl_uwg_id FROM (SELECT
    mandant_id,
    art_matching_id,
    kl_wg_id,
    kl_owg_id,
    kl_uwg_id
FROM `_track_distinct`) AS b
WHERE art_matching_nielsen_per.mandant_id = b.mandant_id AND art_matching_nielsen_per.art_matching_id = b.art_matching_id;


CREATE OR REPLACE TEMPORARY TABLE _track_distinct AS
SELECT
    A.mandant_id,
    A.art_matching_id,
    MAX(A.kl_wg_id) AS kl_wg_id,
    MAX(A.kl_owg_id) AS kl_owg_id,
    MIN(A.kl_uwg_id) AS kl_uwg_id
FROM dbp_etl.art_matching_nielsen_per AS A
INNER JOIN (SELECT
    mandant_id,
    art_matching_id
FROM dbp_etl.art_matching_nielsen_per
GROUP BY
    mandant_id,
    art_matching_id
HAVING COUNT(DISTINCT kl_wg_id) > 1 OR COUNT(DISTINCT kl_owg_id) > 1 OR COUNT(DISTINCT kl_uwg_id) > 1) AS b
    ON
        A.mandant_id
        = b.mandant_id AND A.art_matching_id = b.art_matching_id
GROUP BY
    A.mandant_id,
    A.art_matching_id;


UPDATE dbp_etl.art_matching_nielsen_per SET
    kl_wg_id = b.kl_wg_id,
    kl_owg_id = b.kl_owg_id,
    kl_uwg_id = b.kl_uwg_id FROM (SELECT
    mandant_id,
    art_matching_id,
    kl_wg_id,
    kl_owg_id,
    kl_uwg_id
FROM `_track_distinct`) AS b
WHERE art_matching_nielsen_per.mandant_id = b.mandant_id AND art_matching_nielsen_per.art_matching_id = b.art_matching_id;


-- end --;
