CREATE OR REPLACE TEMPORARY TABLE _art_nielsen_mgtin AS
SELECT DISTINCT
    mandant_id,
    art_nielsen_id,
    gtin_id
FROM dbp_data.art_nielsen_2
WHERE dat_bis = DATE '9999-12-31'
UNION DISTINCT
SELECT DISTINCT
    mandant_id,
    art_nielsen_id,
    gtin_ref_id AS gtin_id
FROM dbp_etl_process.art_nielsen_gtin_zu_2;


CREATE OR REPLACE TEMPORARY TABLE _mgtin AS
SELECT DISTINCT
    A.mandant_id,
    A.art_nielsen_id,
    A.gtin_id,
    B.gtin_ref_id
FROM `_art_nielsen_mgtin` AS A
INNER JOIN dbp_data.art_nielsen_2 AS B ON A.mandant_id = B.mandant_id AND A.art_nielsen_id = B.art_nielsen_id

WHERE B.dat_bis = DATE '9999-12-31';


CREATE OR REPLACE TEMPORARY TABLE _kl_facts AS
SELECT
    t11.mandant_id,
    t11.art_id,
    t11.umsatz_netto
FROM (
    SELECT
        A.mandant_id,
        A.art_id,
        SUM(A.umsatz_netto) AS umsatz_netto,
        SUM(A.menge) AS a0
    FROM dbp_data.artbew_wo_sum_2 AS A
    INNER JOIN dbp_data.woche_kj_kl_2 AS B ON A.kjwo_kl = B.kjwo_kl
    INNER JOIN dbp_data.art_wg_zu_per_2 AS D
        ON
            A.mandant_id = D.mandant_id AND A.art_id = D.art_id AND D.arthiertyp_id
            = 2 AND D.dat_bis = DATE '9999-12-31'
    INNER JOIN (
        SELECT wg_id
        FROM dbp_data.wg_filter_zu_2
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
            FROM dbp_msi_data.ek_sort_sortiment_mat_zeitraum_2 AS A0
            INNER JOIN (SELECT
                mandant_id,
                MAX(kjmo) AS kjmo
            FROM dbp_data.sortiment_leistung_2
            WHERE mandant_id IN (2, 3, 5, 6, 7, 8)
            GROUP BY mandant_id) AS b ON A0.kjmo_sort = b.kjmo
            INNER JOIN dbp_data.woche_2 AS C ON A0.kjwo_bis >= C.kjwo
            QUALIFY ((RANK() OVER (
                PARTITION BY
                    b.mandant_id ORDER BY
                    b.mandant_id IS NULL, b.mandant_id, C.kjwo IS NULL DESC,
                    C.kjwo DESC
            )) * -1) BETWEEN -52 AND (-1)
        ) AS t6
        GROUP BY mandant_id,
        kjwo
    )
    GROUP BY
        A.mandant_id,
        A.art_id
    HAVING a0 > 0
) AS t11;


CREATE OR REPLACE TEMPORARY TABLE _distinct_nl_arts AS
SELECT
    mandant_id,
    art_nielsen_id,
    gtin_id
FROM `_art_nielsen_mgtin` AS A
WHERE mandant_id IN (2, 3, 5, 6, 7, 8)
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
    FROM dbp_etl_process.art_gtin_2 AS A
    WHERE mandant_id IN (2, 3, 5, 6, 7, 8)
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
    FROM dbp_etl.kl_basis_listung_kmo_2 AS A
    INNER JOIN (
        SELECT *
        FROM dbp_etl_process.art_gtin_2 AS A
        WHERE mandant_id IN (2, 3, 5, 6, 7, 8)
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


CREATE OR REPLACE TEMPORARY TABLE _nielsen_kl_matching_kmo (
    mandant_id INTEGER NOT NULL,
    matching_id INTEGER NOT NULL,
    art_nielsen_id INTEGER NOT NULL,
    art_id INTEGER NOT NULL,
    gtin_id INTEGER NOT NULL
);


INSERT INTO `_nielsen_kl_matching_kmo`
(SELECT
    mandant_id,
    -1 AS matching_id,
    art_nielsen_id,
    art_id,
    gtin_id
FROM `_article_matching0`);


DELETE FROM `_nielsen_kl_matching_kmo`
WHERE art_id > 0 AND (
    mandant_id, art_id) NOT IN (
    SELECT (t0.mandant_id, t0.art_id)
    FROM (
        SELECT DISTINCT
            D.mandant_id,
            D.art_id
        FROM dbp_data.art_wg_zu_per_2 AS D
        INNER JOIN
            dbp_data.wg_filter_zu_2
                AS WFZ
            ON
                D.wg_id = WFZ.wg_id AND D.mandant_id = WFZ.mandant_id
                AND WFZ.wg_filter_id = 47 AND WFZ.arthiertyp_id = 2 AND D.dat_bis = PARSE_DATE('%F', '9999-12-31') AND D.arthiertyp_id
                = 2
    ) AS t0
);


MERGE INTO `_nielsen_kl_matching_kmo` AS A
USING (
    SELECT
        mandant_id,
        MAX(art_matching_id) AS art_matching_id,
        art_nielsen_id,
        art_id,
        gtin_id
    FROM dbp_etl.art_matching_nielsen_per_kmo_final_2
    GROUP BY
        mandant_id,
        art_id,
        art_nielsen_id,
        gtin_id
) AS b
    ON A.mandant_id = b.mandant_id AND A.art_id = b.art_id AND A.art_nielsen_id = b.art_nielsen_id AND A.gtin_id = b.gtin_id

WHEN MATCHED THEN UPDATE SET
    matching_id = b.art_matching_id;


CREATE OR REPLACE TEMPORARY TABLE _combined_data AS
SELECT
    mandant_id,
    art_matching_id,
    STRING_AGG(DISTINCT CAST(art_id AS STRING), ',' ORDER BY CAST(art_id AS STRING)) AS art_id
FROM dbp_etl.art_matching_nielsen_per_kmo_final_2
WHERE
    kjwo_update = (
        SELECT MAX(kjwo_update)
        FROM dbp_etl.art_matching_nielsen_per_kmo_final_2
    )
GROUP BY
    mandant_id,
    art_matching_id;


CREATE OR REPLACE TEMPORARY TABLE _merge_combined_data AS
SELECT
    mandant_id,
    matching_id AS art_matching_id,
    STRING_AGG(DISTINCT CAST(art_id AS STRING), ',' ORDER BY CAST(art_id AS STRING)) AS art_id
FROM `_nielsen_kl_matching_kmo`
WHERE matching_id <> -1
GROUP BY
    mandant_id,
    art_matching_id;


CREATE OR REPLACE TEMPORARY TABLE _delete_unchanged AS
SELECT
    A.mandant_id,
    A.art_matching_id,
    A.art_id,
    B.art_id AS combi_art_id
FROM `_combined_data` AS A
INNER JOIN `_merge_combined_data` AS B ON A.mandant_id = B.mandant_id AND A.art_matching_id = B.art_matching_id
WHERE A.art_id <> B.art_id;


UPDATE `_nielsen_kl_matching_kmo` SET
    matching_id = -1 FROM (SELECT
    mandant_id,
    art_matching_id,
    art_id,
    CAST(-1 AS STRING) || ',' || combi_art_id AS combi_art_id_2
FROM `_delete_unchanged`
WHERE art_id <> CAST(-1 AS STRING) || ',' || combi_art_id) AS b
WHERE `_nielsen_kl_matching_kmo`.mandant_id = b.mandant_id AND `_nielsen_kl_matching_kmo`.matching_id = b.art_matching_id;


-- only art_id trigger matching_id change


UPDATE `_nielsen_kl_matching_kmo` AS `_nielsen_kl_matching_kmo2` SET
    matching_id = b.ori_matching_id FROM (
    SELECT
        a.mandant_id,
        a.matching_id,
        a.art_nielsen_id,
        a.art_id,
        a.gtin_id,
        MAX(B.art_nielsen_id) AS ori_art_nielsen_id,
        B.art_matching_id AS ori_matching_id
    FROM (
        SELECT *
        FROM `_nielsen_kl_matching_kmo`
        WHERE (
            mandant_id, art_id) IN (
            SELECT (mandant_id, art_id)
            FROM `_nielsen_kl_matching_kmo`
            WHERE art_id <> -1
            GROUP BY
                mandant_id,
                art_id
            HAVING
                COUNT(DISTINCT matching_id) = 1 AND SUM(DISTINCT CASE
                    WHEN matching_id = -1
                        THEN 0
                    ELSE 1
                END) = 0
        )
    ) AS a
    INNER JOIN dbp_etl.art_matching_nielsen_per_kmo_final_2 AS B
        ON
            a.mandant_id = B.mandant_id AND a.art_id
            = B.art_id AND a.gtin_id = B.gtin_id
    WHERE
        a.art_nielsen_id <> B.art_nielsen_id
        AND (
            a.mandant_id, a.art_nielsen_id) NOT IN (
            SELECT (mandant_id, art_nielsen_id)
            FROM `_nielsen_kl_matching_kmo`
            WHERE art_nielsen_id <> -1
            GROUP BY
                mandant_id,
                art_nielsen_id
            HAVING COUNT(DISTINCT matching_id) > 1 AND COUNT(DISTINCT art_id) > 1
        )
    GROUP BY
        a.mandant_id,
        a.matching_id,
        a.art_nielsen_id,
        a.art_id,
        a.gtin_id,
        ori_matching_id
) AS b
WHERE
    `_nielsen_kl_matching_kmo2`.matching_id = -1 AND `_nielsen_kl_matching_kmo2`.art_id = b.art_id AND
    `_nielsen_kl_matching_kmo2`.gtin_id = b.gtin_id AND `_nielsen_kl_matching_kmo2`.art_nielsen_id = b.art_nielsen_id
    AND `_nielsen_kl_matching_kmo2`.mandant_id = b.mandant_id;


UPDATE `_nielsen_kl_matching_kmo` AS `_nielsen_kl_matching_kmo0` SET
    matching_id = b.matching_id FROM (SELECT
    mandant_id,
    matching_id,
    art_id
FROM (SELECT
    mandant_id,
    art_id,
    MAX(matching_id) AS matching_id,
    COUNT(DISTINCT matching_id) AS a0
FROM `_nielsen_kl_matching_kmo`
WHERE art_id <> -1
GROUP BY
    mandant_id,
    art_id
HAVING a0 > 1) AS t1_2) AS b
WHERE `_nielsen_kl_matching_kmo0`.mandant_id = b.mandant_id AND `_nielsen_kl_matching_kmo0`.art_id = b.art_id;


UPDATE `_nielsen_kl_matching_kmo` AS `_nielsen_kl_matching_kmo0` SET
    matching_id = b.matching_id FROM (SELECT
    mandant_id,
    matching_id,
    art_nielsen_id
FROM (SELECT
    mandant_id,
    art_nielsen_id,
    MAX(matching_id) AS matching_id,
    COUNT(DISTINCT matching_id) AS a0
FROM `_nielsen_kl_matching_kmo`
WHERE art_id <> -1
GROUP BY
    mandant_id,
    art_nielsen_id
HAVING a0 = 1 AND matching_id <> -1) AS t1_2) AS b
WHERE `_nielsen_kl_matching_kmo0`.mandant_id = b.mandant_id AND `_nielsen_kl_matching_kmo0`.art_nielsen_id = b.art_nielsen_id;


UPDATE `_nielsen_kl_matching_kmo` AS `_nielsen_kl_matching_kmo0` SET
    matching_id = b.matching_id FROM (SELECT
    mandant_id,
    matching_id,
    art_nielsen_id
FROM (SELECT
    mandant_id,
    art_nielsen_id,
    MAX(matching_id) AS matching_id,
    COUNT(DISTINCT matching_id) AS a0
FROM `_nielsen_kl_matching_kmo`
WHERE art_nielsen_id <> -1
GROUP BY
    mandant_id,
    art_nielsen_id
HAVING a0 > 1) AS t1_2) AS b
WHERE
    `_nielsen_kl_matching_kmo0`.mandant_id = b.mandant_id AND `_nielsen_kl_matching_kmo0`.art_nielsen_id = b.art_nielsen_id
    AND `_nielsen_kl_matching_kmo0`.art_id = -1;


UPDATE `_nielsen_kl_matching_kmo` SET
    matching_id = b.art_matching_id FROM (
    SELECT
        A.mandant_id,
        MAX(A.art_matching_id) AS art_matching_id,
        A.art_id,
        B.art_nielsen_id,
        A.gtin_id
    FROM dbp_etl.art_matching_nielsen_per_kmo_final_2 AS A
    INNER JOIN `_nielsen_kl_matching_kmo` AS B ON A.art_id = B.art_id AND A.gtin_id = B.gtin_id AND A.mandant_id = B.mandant_id

    WHERE B.matching_id = -1
    GROUP BY
        A.mandant_id,
        A.art_id,
        A.gtin_id,
        B.art_nielsen_id
) AS b
WHERE
    `_nielsen_kl_matching_kmo`.art_id = b.art_id AND `_nielsen_kl_matching_kmo`.gtin_id = b.gtin_id AND
    `_nielsen_kl_matching_kmo`.art_nielsen_id = b.art_nielsen_id AND `_nielsen_kl_matching_kmo`.mandant_id = b.mandant_id
    AND `_nielsen_kl_matching_kmo`.matching_id = -1;


--EXECUTE IMMEDIATE CONVERTED BLOCK - START
BEGIN
    DECLARE loop_counter1 INT64 DEFAULT 1;
    DECLARE loop_counter2 INT64 DEFAULT 1;
    DECLARE loop_counter_value INT64 DEFAULT 0;
    DECLARE loop_counter3 INT64 DEFAULT 1;
    WHILE ((loop_counter1 + loop_counter2) > 0) DO

        UPDATE _nielsen_kl_matching_kmo AS t
        SET matching_id = b.matching_id1
        FROM (
            SELECT
                mandant_id,
                MAX(matching_id) AS matching_id1,
                art_nielsen_id,
                art_id
            FROM _nielsen_kl_matching_kmo
            WHERE art_nielsen_id <> -1
            GROUP BY mandant_id, art_nielsen_id, art_id
            HAVING COUNT(DISTINCT matching_id) > 1
        ) AS b
        WHERE
            t.mandant_id = b.mandant_id
            AND t.art_nielsen_id = b.art_nielsen_id
            AND t.art_id = b.art_id;

        --loop_counter1 := (SELECT * FROM TABLE(RESULT_SCAN(LAST_QUERY_ID())));
        SET loop_counter1 = @@row_count;

        UPDATE _nielsen_kl_matching_kmo AS t
        SET matching_id = b.matching_id1
        FROM (
            SELECT
                mandant_id,
                MAX(matching_id) AS matching_id1,
                gtin_id
            FROM _nielsen_kl_matching_kmo
            WHERE gtin_id NOT IN (-9999, -9998)
            GROUP BY mandant_id, gtin_id
            HAVING COUNT(DISTINCT matching_id) > 1
        ) AS b
        WHERE
            t.mandant_id = b.mandant_id
            AND t.gtin_id = b.gtin_id;

        --loop_counter2 := (SELECT * FROM TABLE(RESULT_SCAN(LAST_QUERY_ID())));
        SET loop_counter2 = @@row_count;

        SET loop_counter_value = loop_counter_value + 1;
    END WHILE;

    SELECT loop_counter_value;

END;
--EXECUTE IMMEDIATE CONVERTED BLOCK - END


UPDATE `_nielsen_kl_matching_kmo` AS `_nielsen_kl_matching_kmo1` SET
    matching_id = b.matching_id FROM (
    SELECT
        mandant_id,
        art_nielsen_id,
        MAX(matching_id) AS matching_id
    FROM `_nielsen_kl_matching_kmo`
    WHERE
        art_id <> -1
        AND (
            mandant_id, art_nielsen_id) IN (
            SELECT (mandant_id, art_nielsen_id)
            FROM `_nielsen_kl_matching_kmo`
            GROUP BY
                mandant_id,
                art_nielsen_id
            HAVING
                COUNT(DISTINCT art_id) = 2 AND SUM(CASE
                    WHEN art_id = -1
                        THEN 1
                    ELSE 0
                END) > 0 AND COUNT(DISTINCT matching_id) = 2
        )
    GROUP BY
        mandant_id,
        art_nielsen_id
) AS b
WHERE `_nielsen_kl_matching_kmo1`.mandant_id = b.mandant_id AND `_nielsen_kl_matching_kmo1`.art_nielsen_id = b.art_nielsen_id;


UPDATE `_nielsen_kl_matching_kmo` AS `_nielsen_kl_matching_kmo0` SET
    matching_id = -1 FROM (
    SELECT DISTINCT
        A.mandant_id,
        A.matching_id,
        A.art_id,
        A.art_nielsen_id,
        A.gtin_id,
        b.art_matching_id AS art_matching_id_old
    FROM `_nielsen_kl_matching_kmo` AS A
    INNER JOIN (
        SELECT *
        FROM dbp_etl.art_matching_nielsen_per_kmo_final_2
        WHERE kjwo_update = (
            SELECT MAX(kjwo_update)
            FROM dbp_etl.art_matching_nielsen_per_kmo_final_2
        )
    ) AS b
        ON
            A.art_id = b.art_id AND A.gtin_id = b.gtin_id
            AND A.mandant_id = b.mandant_id
    WHERE (
        A.mandant_id, A.matching_id) IN (
        SELECT (mandant_id, matching_id)
        FROM `_nielsen_kl_matching_kmo`
        WHERE
            matching_id <> -1
            AND art_id <> -1
        GROUP BY
            mandant_id,
            matching_id
        HAVING COUNT(DISTINCT art_id) > 1
    )
    AND A.matching_id <> b.art_matching_id
    AND A.art_id <> -1
) AS b
WHERE
    `_nielsen_kl_matching_kmo0`.mandant_id = b.mandant_id AND `_nielsen_kl_matching_kmo0`.art_id = b.art_id AND
    `_nielsen_kl_matching_kmo0`.art_nielsen_id = b.art_nielsen_id AND `_nielsen_kl_matching_kmo0`.gtin_id = b.gtin_id
    AND `_nielsen_kl_matching_kmo0`.matching_id = b.matching_id;


UPDATE `_nielsen_kl_matching_kmo` AS `_nielsen_kl_matching_kmo0` SET
    matching_id = -1 FROM (
    SELECT DISTINCT
        A.mandant_id,
        A.matching_id,
        A.art_id,
        A.art_nielsen_id,
        A.gtin_id,
        b.art_matching_id AS art_matching_id_old
    FROM `_nielsen_kl_matching_kmo` AS A
    INNER JOIN (
        SELECT *
        FROM dbp_etl.art_matching_nielsen_per_kmo_final_2
        WHERE kjwo_update = (
            SELECT MAX(kjwo_update)
            FROM dbp_etl.art_matching_nielsen_per_kmo_final_2
        )
    ) AS b
        ON
            A.art_id = b.art_id AND A.gtin_id = b.gtin_id
            AND A.mandant_id = b.mandant_id
    WHERE (
        A.mandant_id, A.art_nielsen_id) IN (
        SELECT (mandant_id, art_nielsen_id)
        FROM `_nielsen_kl_matching_kmo`
        WHERE
            matching_id <> -1
            AND art_id <> -1
            AND art_nielsen_id <> -1
        GROUP BY
            mandant_id,
            art_nielsen_id
        HAVING COUNT(DISTINCT art_id) > 1
    )
    AND A.matching_id <> -1
) AS b
WHERE
    `_nielsen_kl_matching_kmo0`.mandant_id = b.mandant_id AND `_nielsen_kl_matching_kmo0`.art_id = b.art_id AND
    `_nielsen_kl_matching_kmo0`.art_nielsen_id = b.art_nielsen_id AND `_nielsen_kl_matching_kmo0`.gtin_id = b.gtin_id
    AND `_nielsen_kl_matching_kmo0`.matching_id = b.matching_id;


CREATE OR REPLACE TEMPORARY TABLE _nielsen_kl_matching_kmo_final AS
SELECT *
FROM `_nielsen_kl_matching_kmo`
WHERE matching_id <> -1;


DELETE FROM `_nielsen_kl_matching_kmo`
WHERE matching_id <> -1;


CREATE OR REPLACE TEMPORARY TABLE _upd_new_match AS
SELECT
    mandant_id,
    (
        SELECT MAX(matching_id)
        FROM `_nielsen_kl_matching_kmo_final`
    ) AS art_matching_id,
    art_nielsen_id,
    art_id,
    gtin_id,
    DENSE_RANK() OVER (ORDER BY mandant_id IS NULL, mandant_id, CAST(art_id AS STRING)) AS rang
FROM `_nielsen_kl_matching_kmo`
WHERE
    art_id <> -1
    AND art_nielsen_id <> -1;


INSERT INTO `_nielsen_kl_matching_kmo_final` (mandant_id, matching_id, art_nielsen_id, art_id, gtin_id)
(SELECT
    mandant_id,
    art_matching_id + rang,
    art_nielsen_id,
    art_id,
    gtin_id
FROM `_upd_new_match` AS A);


DELETE FROM `_nielsen_kl_matching_kmo`
WHERE (
    mandant_id, art_id) IN (
    SELECT (mandant_id, art_id)
    FROM `_nielsen_kl_matching_kmo_final`
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
        FROM `_nielsen_kl_matching_kmo_final`
    ) AS art_matching_id,
    art_nielsen_id,
    art_id,
    gtin_id,
    DENSE_RANK() OVER (ORDER BY mandant_id IS NULL, mandant_id, CAST(art_id AS STRING)) AS rang
FROM `_nielsen_kl_matching_kmo`
WHERE art_id <> -1;


INSERT INTO `_nielsen_kl_matching_kmo_final` (mandant_id, matching_id, art_nielsen_id, art_id, gtin_id)
(SELECT
    mandant_id,
    art_matching_id + rang,
    art_nielsen_id,
    art_id,
    gtin_id
FROM `_upd_new_match` AS A);


DELETE FROM `_nielsen_kl_matching_kmo`
WHERE (
    mandant_id, art_id) IN (
    SELECT (mandant_id, art_id)
    FROM `_nielsen_kl_matching_kmo_final`
    WHERE art_id <> -1
);


-- 3rd run for nl-articles


CREATE OR REPLACE TEMPORARY TABLE _upd_new_match AS
SELECT
    B.mandant_id,
    (
        SELECT MAX(matching_id)
        FROM `_nielsen_kl_matching_kmo_final`
    ) AS art_matching_id,
    B.art_nielsen_id,
    A.art_id,
    A.gtin_id,
    DENSE_RANK() OVER (ORDER BY A.mandant_id IS NULL, A.mandant_id, B.gtin_ref_id IS NULL, B.gtin_ref_id) AS rang
FROM `_nielsen_kl_matching_kmo` AS A
INNER JOIN `_mgtin` AS B ON A.mandant_id = B.mandant_id AND A.art_nielsen_id = B.art_nielsen_id AND A.gtin_id = B.gtin_id

WHERE A.art_nielsen_id <> -1;


INSERT INTO `_nielsen_kl_matching_kmo_final` (mandant_id, matching_id, art_nielsen_id, art_id, gtin_id)
(SELECT
    mandant_id,
    art_matching_id + rang,
    art_nielsen_id,
    art_id,
    gtin_id
FROM `_upd_new_match` AS A);


DELETE FROM `_nielsen_kl_matching_kmo`
WHERE (
    mandant_id, art_nielsen_id, gtin_id) IN (
    SELECT (mandant_id, art_nielsen_id, gtin_id)
    FROM `_nielsen_kl_matching_kmo_final`
    WHERE art_nielsen_id <> -1
);


UPDATE `_nielsen_kl_matching_kmo_final` AS `_nielsen_kl_matching_kmo_final0` SET
    matching_id = b.max_match FROM (SELECT
    mandant_id,
    art_id,
    COUNT(DISTINCT matching_id) AS anz_match,
    MAX(matching_id) AS max_match,
    MIN(art_id) AS min_art_id,
    MAX(art_id) AS max_art_id
FROM `_nielsen_kl_matching_kmo_final`
WHERE art_id <> -1
GROUP BY
    mandant_id,
    art_id
HAVING anz_match > 1 AND min_art_id = max_art_id) AS b
WHERE `_nielsen_kl_matching_kmo_final0`.mandant_id = b.mandant_id AND `_nielsen_kl_matching_kmo_final0`.art_id = b.art_id;


UPDATE `_nielsen_kl_matching_kmo_final` AS `_nielsen_kl_matching_kmo_final0` SET
    matching_id = b.max_match FROM (SELECT
    mandant_id,
    art_id,
    COUNT(DISTINCT matching_id) AS anz_match,
    MAX(matching_id) AS max_match,
    MIN(art_id) AS min_art_id,
    MAX(art_id) AS max_art_id
FROM `_nielsen_kl_matching_kmo_final`
WHERE art_id <> -1
GROUP BY
    mandant_id,
    art_id
HAVING anz_match > 1 AND min_art_id = max_art_id) AS b
WHERE `_nielsen_kl_matching_kmo_final0`.mandant_id = b.mandant_id AND `_nielsen_kl_matching_kmo_final0`.art_id = b.art_id;


CREATE OR REPLACE TABLE dbp_etl.art_matching_nielsen_per_kmo_mgtin_2 LIKE dbp_etl.art_matching_nielsen_per_kmo_2;


INSERT INTO dbp_etl.art_matching_nielsen_per_kmo_mgtin_2
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
        FROM dbp_data.woche_2 AS A
        INNER JOIN (
            SELECT MAX(kjwo_update) AS kjwo_update
            FROM dbp_data.sortiment_leistung_2
            WHERE mandant_id > 1
        ) AS b
            ON A.kjwo = b.kjwo_update
        INNER JOIN dbp_data.woche_2 AS C ON A.akt_wo = C.akt_wo - 1
    ),
    CURRENT_TIMESTAMP(),
    CURRENT_TIMESTAMP()
FROM `_nielsen_kl_matching_kmo_final`
WHERE (mandant_id, matching_id, art_nielsen_id, art_id) NOT IN (SELECT (
    mandant_id, art_matching_id, art_nielsen_id,
    art_id
)
FROM dbp_etl.art_matching_nielsen_per_kmo_mgtin_2));

--EXECUTE IMMEDIATE CONVERTED BLOCK - START
BEGIN
    DECLARE loop_counter1 INT64 DEFAULT 1;
    DECLARE loop_counter2 INT64 DEFAULT 1;
    DECLARE loop_counter_value INT64 DEFAULT 0;
    DECLARE loop_counter3 INT64 DEFAULT 1;

    WHILE ((loop_counter1 + loop_counter2 + loop_counter3) > 0) DO
        update dbp_etl.art_matching_nielsen_per_kmo_mgtin_2 a
        set a.art_matching_id = b.art_matching_id1
        from (select
            mandant_id,
            max(art_matching_id) as art_matching_id1,
            art_nielsen_id
        from dbp_etl.art_matching_nielsen_per_kmo_mgtin_2
        where art_nielsen_id <> -1
        group by 1, 3
        having count(distinct art_matching_id) > 1) b
        where
            a.mandant_id = b.mandant_id and
            a.art_nielsen_id = b.art_nielsen_id;

        --loop_counter1 := (SELECT * FROM TABLE(RESULT_SCAN(LAST_QUERY_ID())));
        SET loop_counter1 = @@row_count;

        update dbp_etl.art_matching_nielsen_per_kmo_mgtin_2 a
        set a.art_matching_id = b.art_matching_id1
        from (select
            mandant_id,
            max(art_matching_id) as art_matching_id1,
            art_id
        from dbp_etl.art_matching_nielsen_per_kmo_mgtin_2
        where art_id <> -1
        group by 1, 3
        having count(distinct art_matching_id) > 1) b
        where
            a.mandant_id = b.mandant_id and
            a.art_id = b.art_id;

        --loop_counter2 := (SELECT * FROM TABLE(RESULT_SCAN(LAST_QUERY_ID())));
        SET loop_counter2 = @@row_count;

        update dbp_etl.art_matching_nielsen_per_kmo_mgtin_2 a
        set a.art_matching_id = b.art_matching_id1
        from (select
            mandant_id,
            max(art_matching_id) as art_matching_id1,
            gtin_id
        from dbp_etl.art_matching_nielsen_per_kmo_mgtin_2
        where gtin_id not in (-9999, -9998)
        group by 1, 3
        having count(distinct art_matching_id) > 1) b
        where
            a.mandant_id = b.mandant_id and
            a.gtin_id = b.gtin_id;

        --loop_counter3 := (SELECT * FROM TABLE(RESULT_SCAN(LAST_QUERY_ID())));
        SET loop_counter3 = @@row_count;

        SET loop_counter_value = loop_counter_value + 1;
    END WHILE;

    SELECT loop_counter_value;

END;
--EXECUTE IMMEDIATE CONVERTED BLOCK - END
