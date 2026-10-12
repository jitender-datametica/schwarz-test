CREATE OR REPLACE TEMPORARY TABLE _art_nielsen AS
SELECT *
FROM dbp_data.art_nielsen
WHERE dat_bis = DATE '9999-12-31';


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
            WHERE mandant_id IN (2, 3, 5, 6, 7, 8)
            GROUP BY mandant_id) AS b ON A0.kjmo_sort = b.kjmo
            INNER JOIN dbp_data.woche AS C ON A0.kjwo_bis >= C.kjwo
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
FROM `_art_nielsen` AS A
WHERE mandant_id IN (2, 3, 5, 6, 7, 8)
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
    FROM dbp_etl.kl_basis_listung_kmo AS A
    INNER JOIN (
        SELECT *
        FROM dbp_etl_process.art_gtin AS A
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


--use only articles with WG_FILTER_ID = 47


DELETE FROM `_nielsen_kl_matching_kmo`
WHERE art_id > 0 AND (
    mandant_id, art_id) NOT IN (
    SELECT (t0.mandant_id, t0.art_id)
    FROM (
        SELECT DISTINCT
            D.mandant_id,
            D.art_id
        FROM dbp_data.art_wg_zu_per AS D
        INNER JOIN
            dbp_data.wg_filter_zu
                AS WFZ
            ON
                D.wg_id = WFZ.wg_id AND D.mandant_id = WFZ.mandant_id
                AND WFZ.wg_filter_id = 47 AND WFZ.arthiertyp_id = 2 AND D.dat_bis = PARSE_DATE('%F', '9999-12-31') AND D.arthiertyp_id
                = 2
    ) AS t0
);


--set matching_id based on previous data


MERGE INTO `_nielsen_kl_matching_kmo` AS A
USING (
    SELECT
        mandant_id,
        MAX(art_matching_id) AS art_matching_id,
        art_nielsen_id,
        art_id,
        gtin_id
    FROM dbp_etl.art_matching_nielsen_per_kmo
    WHERE
        kjwo_update = (
            SELECT MAX(kjwo_update)
            FROM dbp_etl.art_matching_nielsen_per_kmo
        )
    GROUP BY
        mandant_id,
        art_id,
        art_nielsen_id,
        gtin_id
) AS b
    ON A.mandant_id = b.mandant_id AND A.art_id = b.art_id AND A.art_nielsen_id = b.art_nielsen_id AND A.gtin_id = b.gtin_id

WHEN MATCHED THEN UPDATE SET
    matching_id = b.art_matching_id;


--check if something has been removed compared to the previous data, if so, reset the matching_id if the change is to art_id


CREATE OR REPLACE TEMPORARY TABLE _combined_data AS
WITH distinct_arts AS (
    SELECT DISTINCT
        mandant_id,
        art_matching_id,
        art_id
    FROM dbp_etl.art_matching_nielsen_per_kmo
    WHERE kjwo_update = (
        SELECT MAX(kjwo_update)
        FROM dbp_etl.art_matching_nielsen_per_kmo
    )
)

SELECT
    mandant_id,
    art_matching_id,
    STRING_AGG(CAST(art_id AS STRING), ',' ORDER BY art_id IS NULL, art_id) AS art_id
FROM distinct_arts
GROUP BY
    mandant_id,
    art_matching_id;


CREATE OR REPLACE TEMPORARY TABLE _merge_combined_data AS
WITH distinct_arts AS (
    SELECT DISTINCT
        mandant_id,
        matching_id AS art_matching_id,
        art_id
    FROM `_nielsen_kl_matching_kmo`
    WHERE matching_id <> -1
)

SELECT
    mandant_id,
    art_matching_id,
    STRING_AGG(CAST(art_id AS STRING), ',' ORDER BY art_id IS NULL, art_id) AS art_id
FROM distinct_arts
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


--EXECUTE IMMEDIATE CONVERTED BLOCK - START
BEGIN
    DECLARE loop_counter1 INT64 DEFAULT 1;
    DECLARE loop_counter2 INT64 DEFAULT 1;
    DECLARE loop_counter3 INT64 DEFAULT 1;
    DECLARE loop_counter_value INT64 DEFAULT 0;

    WHILE ((loop_counter1 + loop_counter2 + loop_counter3) > 0) DO

        UPDATE _nielsen_kl_matching_kmo
        SET matching_id = b.art_matching_id

        FROM (select
            mandant_id,
            max(matching_id) as art_matching_id,
            art_id
        from _nielsen_kl_matching_kmo
        where
            matching_id <> -1 and
            art_id <> -1
        group by 1, 3) b
        WHERE
            _nielsen_kl_matching_kmo.mandant_id = b.mandant_id and
            _nielsen_kl_matching_kmo.art_id = b.art_id and
            _nielsen_kl_matching_kmo.matching_id = -1;


        SET loop_counter1 = @@row_count;

        UPDATE _nielsen_kl_matching_kmo
        SET matching_id = b.art_matching_id

        FROM (select
            mandant_id,
            max(matching_id) as art_matching_id,
            art_nielsen_id
        from _nielsen_kl_matching_kmo
        where
            matching_id <> -1 and
            art_nielsen_id <> -1
        group by 1, 3) b
        WHERE
            _nielsen_kl_matching_kmo.mandant_id = b.mandant_id and
            _nielsen_kl_matching_kmo.art_nielsen_id = b.art_nielsen_id and
            _nielsen_kl_matching_kmo.matching_id = -1;


        SET loop_counter2 = @@row_count;

        UPDATE _nielsen_kl_matching_kmo
        SET matching_id = b.art_matching_id

        FROM (select
            mandant_id,
            max(matching_id) as art_matching_id,
            gtin_id
        from _nielsen_kl_matching_kmo
        where
            matching_id <> -1 and
            gtin_id not in (-9999, -9998)
        group by 1, 3) b
        WHERE
            _nielsen_kl_matching_kmo.mandant_id = b.mandant_id and
            _nielsen_kl_matching_kmo.gtin_id = b.gtin_id and
            _nielsen_kl_matching_kmo.matching_id = -1;


        SET loop_counter3 = @@row_count;
        SET loop_counter_value = loop_counter_value + 1;
    END WHILE;

    SELECT loop_counter_value;

END;
--EXECUTE IMMEDIATE CONVERTED BLOCK - END


UPDATE `_nielsen_kl_matching_kmo` AS `_nielsen_kl_matching_kmo0` SET
    matching_id = b.art_matching_id FROM (
    SELECT
        mandant_id,
        MAX(matching_id) AS art_matching_id,
        art_id
    FROM `_nielsen_kl_matching_kmo`
    WHERE
        matching_id <> -1
        AND art_id <> -1
    GROUP BY
        mandant_id,
        art_id
) AS b
WHERE
    `_nielsen_kl_matching_kmo0`.mandant_id = b.mandant_id AND `_nielsen_kl_matching_kmo0`.art_id = b.art_id AND
    `_nielsen_kl_matching_kmo0`.matching_id = -1;


UPDATE `_nielsen_kl_matching_kmo` AS `_nielsen_kl_matching_kmo0` SET
    matching_id = b.art_matching_id FROM (
    SELECT
        mandant_id,
        MAX(matching_id) AS art_matching_id,
        art_nielsen_id
    FROM `_nielsen_kl_matching_kmo`
    WHERE
        matching_id <> -1
        AND art_nielsen_id <> -1
    GROUP BY
        mandant_id,
        art_nielsen_id
) AS b
WHERE
    `_nielsen_kl_matching_kmo0`.mandant_id = b.mandant_id AND `_nielsen_kl_matching_kmo0`.art_nielsen_id = b.art_nielsen_id
    AND `_nielsen_kl_matching_kmo0`.matching_id = -1;


CREATE OR REPLACE TEMPORARY TABLE _nielsen_kl_matching_kmo_final AS
SELECT *
FROM `_nielsen_kl_matching_kmo`
WHERE matching_id <> -1;


DELETE FROM `_nielsen_kl_matching_kmo`
WHERE matching_id <> -1;


-- 1st run for kl-/nl-articles


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
    DENSE_RANK() OVER (ORDER BY mandant_id IS NULL, mandant_id, art_id IS NULL, art_id) AS rang
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
    DENSE_RANK() OVER (ORDER BY mandant_id IS NULL, mandant_id, art_id IS NULL, art_id) AS rang
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
    DENSE_RANK() OVER (ORDER BY A.mandant_id IS NULL, A.mandant_id, A.art_nielsen_id IS NULL, A.art_nielsen_id) AS rang
FROM `_nielsen_kl_matching_kmo` AS A
INNER JOIN `_art_nielsen` AS B ON A.mandant_id = B.mandant_id AND A.art_nielsen_id = B.art_nielsen_id
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
    mandant_id, art_nielsen_id) IN (
    SELECT (mandant_id, art_nielsen_id)
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


-------------------------------------- INSERT -------------------------------------


CREATE OR REPLACE TABLE dbp_etl.art_matching_nielsen_per_kmo_final LIKE dbp_etl.art_matching_nielsen_per_kmo;


INSERT INTO dbp_etl.art_matching_nielsen_per_kmo_final
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
            WHERE mandant_id > 1
        ) AS b
            ON A.kjwo = b.kjwo_update
        INNER JOIN dbp_data.woche AS C ON A.akt_wo = C.akt_wo - 1
    ),
    CURRENT_TIMESTAMP(),
    CURRENT_TIMESTAMP()
FROM `_nielsen_kl_matching_kmo_final`
WHERE (mandant_id, matching_id, art_nielsen_id, art_id) NOT IN (SELECT (
    mandant_id, art_matching_id, art_nielsen_id,
    art_id
)
FROM dbp_etl.art_matching_nielsen_per_kmo_final));


-------------------------------------- TESTING START -------------------------------------


--EXECUTE IMMEDIATE CONVERTED BLOCK - START
BEGIN
    DECLARE loop_counter1 INT64 DEFAULT 1;
    DECLARE loop_counter2 INT64 DEFAULT 1;
    DECLARE loop_counter3 INT64 DEFAULT 1;
    DECLARE loop_counter_value INT64 DEFAULT 0;

    WHILE ((loop_counter1 + loop_counter2 + loop_counter3) > 0) DO
        UPDATE dbp_etl.art_matching_nielsen_per_kmo_final AS t
        SET art_matching_id = b.new_art_matching_id

        FROM (select
            mandant_id,
            max(art_matching_id) as new_art_matching_id,
            art_nielsen_id
        from dbp_etl.art_matching_nielsen_per_kmo_final
        where art_nielsen_id <> -1
        group by 1, 3
        having count(distinct art_matching_id) > 1) b
        WHERE
            t.mandant_id = b.mandant_id and
            t.art_nielsen_id = b.art_nielsen_id;

        SET loop_counter1 = @@row_count;

        UPDATE dbp_etl.art_matching_nielsen_per_kmo_final AS t
        SET art_matching_id = b.new_art_matching_id

        FROM (select
            mandant_id,
            max(art_matching_id) as new_art_matching_id,
            art_id
        from dbp_etl.art_matching_nielsen_per_kmo_final
        where art_id <> -1
        group by 1, 3
        having count(distinct art_matching_id) > 1) b
        WHERE
            t.mandant_id = b.mandant_id and
            t.art_id = b.art_id;

        SET loop_counter2 = @@row_count;

        UPDATE dbp_etl.art_matching_nielsen_per_kmo_final AS t
        SET art_matching_id = b.new_art_matching_id

        FROM (select
            mandant_id,
            max(art_matching_id) as new_art_matching_id,
            gtin_id
        from dbp_etl.art_matching_nielsen_per_kmo_final
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


--text based tracking for all-kmo countries


CREATE OR REPLACE TEMPORARY TABLE _track_text1 AS
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
    A.td_insert,
    A.td_update,
    B.art_nielsen_bez
FROM dbp_etl.art_matching_nielsen_per_kmo_final AS A
INNER JOIN `_art_nielsen` AS B ON A.mandant_id = B.mandant_id AND A.art_nielsen_id = B.art_nielsen_id
WHERE
    A.art_nielsen_id <> -1
    AND B.gtin_id <> -9999
    AND B.art_nielsen_bez <> 'NO DESCRIPTION';


UPDATE `_track_text1` SET
    status = NULL
WHERE TRUE;


UPDATE `_track_text1` AS `_track_text10` SET
    status = 'N' FROM (SELECT
    mandant_id,
    art_nielsen_bez,
    COUNT(DISTINCT art_matching_id) AS anz1,
    COUNT(DISTINCT CASE
        WHEN art_id = -1
            THEN NULL
        ELSE art_id
    END) AS anz_kl,
    COUNT(DISTINCT CASE
        WHEN art_nielsen_id = -1
            THEN NULL
        ELSE art_nielsen_id
    END) AS anz_nl
FROM `_track_text1`
GROUP BY
    mandant_id,
    art_nielsen_bez
HAVING anz_kl IN (0, 1) AND anz_nl = 1) AS b
WHERE `_track_text10`.mandant_id = b.mandant_id AND `_track_text10`.art_nielsen_bez = b.art_nielsen_bez;


UPDATE `_track_text1` AS `_track_text10` SET
    status = 'T' FROM (SELECT
    mandant_id,
    art_nielsen_bez,
    COUNT(DISTINCT art_matching_id) AS anz1,
    COUNT(DISTINCT CASE
        WHEN art_id = -1
            THEN NULL
        ELSE art_id
    END) AS anz_kl,
    COUNT(DISTINCT CASE
        WHEN art_nielsen_id = -1
            THEN NULL
        ELSE art_nielsen_id
    END) AS anz_nl
FROM `_track_text1`
GROUP BY
    mandant_id,
    art_nielsen_bez
HAVING anz_kl = 0 AND anz_nl > 1 OR anz_kl > 1) AS b
WHERE
    `_track_text10`.mandant_id = b.mandant_id AND `_track_text10`.art_nielsen_bez = b.art_nielsen_bez AND
    `_track_text10`.status IS NULL;


CREATE OR REPLACE TEMPORARY TABLE _murks_x AS
SELECT
    A.mandant_id,
    c.max_match AS art_matching_id,
    A.art_id,
    B.art_nielsen_id,
    B.gtin_id,
    0 AS kl_art_kat_id,
    MAX(A.kl_wg_id) AS kl_wg_id,
    MAX(A.kl_owg_id) AS kl_owg_id,
    MAX(A.kl_uwg_id) AS kl_uwg_id,
    MIN(A.umrech_faktor) AS umrech_faktor,
    'T' AS status,
    MIN(A.list_kz) AS list_kz,
    0 AS komponente_fg,
    A.kjwo_update
FROM `_track_text1` AS A
INNER JOIN `_art_nielsen` AS B
    ON
        A.mandant_id = B.mandant_id AND A.art_nielsen_bez = B.art_nielsen_bez AND A.art_nielsen_id
        = B.art_nielsen_id
INNER JOIN (
    SELECT
        mandant_id,
        art_nielsen_bez,
        MAX(art_matching_id) AS max_match
    FROM `_track_text1`
    GROUP BY
        mandant_id,
        art_nielsen_bez
) AS c ON A.mandant_id = c.mandant_id AND A.art_nielsen_bez = c.art_nielsen_bez
WHERE A.status = 'T'
GROUP BY
    A.mandant_id,
    art_matching_id,
    A.art_id,
    B.art_nielsen_id,
    B.gtin_id,
    kl_art_kat_id,
    status,
    komponente_fg,
    A.kjwo_update;


INSERT INTO `_murks_x`
(
    SELECT
        A.mandant_id,
        c.max_match AS art_matching_id,
        MAX(A.art_id) AS art_id,
        B.art_nielsen_id,
        B.gtin_id,
        0 AS kl_art_kat_id,
        MAX(A.kl_wg_id) AS kl_wg_id,
        MAX(A.kl_owg_id) AS kl_owg_id,
        MAX(A.kl_uwg_id) AS kl_uwg_id,
        MIN(A.umrech_faktor) AS umrech_faktor,
        'N' AS status,
        MIN(A.list_kz) AS list_kz,
        0 AS komponente_fg,
        A.kjwo_update
    FROM `_track_text1` AS A
    INNER JOIN (
        SELECT
            mandant_id,
            art_nielsen_bez,
            MAX(art_matching_id) AS max_match
        FROM `_track_text1`
        GROUP BY
            mandant_id,
            art_nielsen_bez
    ) AS c ON A.mandant_id = c.mandant_id AND A.art_nielsen_bez = c.art_nielsen_bez
    INNER JOIN `_art_nielsen` AS B
        ON
            A.mandant_id = B.mandant_id AND A.art_nielsen_bez = B.art_nielsen_bez AND A.art_nielsen_id
            = B.art_nielsen_id
    WHERE A.status = 'N'
    GROUP BY
        A.mandant_id,
        art_matching_id,
        B.art_nielsen_id,
        B.gtin_id,
        kl_art_kat_id,
        status,
        komponente_fg,
        A.kjwo_update
);


UPDATE `_murks_x` AS `_murks_x1` SET
    art_matching_id = b.max_art_matching_id FROM (
    SELECT
        mandant_id,
        art_id,
        MAX(art_matching_id) AS max_art_matching_id
    FROM `_murks_x`
    WHERE (
        mandant_id, art_id) IN (
        SELECT (mandant_id, art_id)
        FROM `_murks_x`
        WHERE art_id <> -1
        GROUP BY
            mandant_id,
            art_id
        HAVING COUNT(*) > 1 AND COUNT(DISTINCT art_matching_id) > 1
    )
    GROUP BY
        mandant_id,
        art_id
) AS b
WHERE `_murks_x1`.mandant_id = b.mandant_id AND `_murks_x1`.art_id = b.art_id;


DELETE FROM dbp_etl.art_matching_nielsen_per_kmo_final
WHERE (
    mandant_id, art_nielsen_id, art_id, gtin_id) IN (
    SELECT (mandant_id, art_nielsen_id, art_id, gtin_id)
    FROM `_murks_x`
);


INSERT INTO dbp_etl.art_matching_nielsen_per_kmo_final
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
    umrech_faktor,
    status,
    list_kz,
    komponente_fg,
    kjwo_update,
    CURRENT_TIMESTAMP(),
    CURRENT_TIMESTAMP()
FROM `_murks_x`);
