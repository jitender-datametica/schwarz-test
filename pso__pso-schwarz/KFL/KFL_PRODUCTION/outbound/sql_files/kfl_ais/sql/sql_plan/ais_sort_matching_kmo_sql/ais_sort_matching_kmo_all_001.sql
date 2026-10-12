CREATE OR REPLACE TEMPORARY TABLE _art_nielsen AS
SELECT *
FROM dbp_data.art_nielsen
WHERE dat_bis = DATE '9999-12-31';


DELETE FROM dbp_etl.art_matching_nielsen_per_kmo_final
WHERE (
    mandant_id, art_nielsen_id, gtin_id) IN (
    SELECT (mandant_id, art_nielsen_id, gtin_id)
    FROM (SELECT DISTINCT
        mandant_id,
        art_nielsen_id,
        gtin_id
    FROM dbp_etl.art_matching_nielsen_per_kmo_mgtin) AS t0
);


DELETE FROM dbp_etl.art_matching_nielsen_per_kmo_final
WHERE (
    mandant_id, art_id, gtin_id) IN (
    SELECT (mandant_id, art_id, gtin_id)
    FROM (SELECT DISTINCT
        mandant_id,
        art_id,
        gtin_id
    FROM dbp_etl.art_matching_nielsen_per_kmo_mgtin) AS t0
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
    td_insert,
    td_update
FROM dbp_etl.art_matching_nielsen_per_kmo_mgtin);


--EXECUTE IMMEDIATE CONVERTED BLOCK - START
BEGIN
    DECLARE loop_counter1 INT64 DEFAULT 1;
    DECLARE loop_counter2 INT64 DEFAULT 1;
    DECLARE loop_counter3 INT64 DEFAULT 1;
    DECLARE loop_counter_value INT64 DEFAULT 0;

    WHILE ((loop_counter1 + loop_counter2 + loop_counter3) > 0) DO
        update dbp_etl.art_matching_nielsen_per_kmo_final a
        set a.art_matching_id = b.art_matching_id1
        from (select
            mandant_id,
            max(art_matching_id) as art_matching_id1,
            art_nielsen_id
        from dbp_etl.art_matching_nielsen_per_kmo_final
        where art_nielsen_id <> -1
        group by 1, 3
        having count(distinct art_matching_id) > 1) b
        where
            a.mandant_id = b.mandant_id and
            a.art_nielsen_id = b.art_nielsen_id;

        --loop_counter1 := (SELECT * FROM TABLE(RESULT_SCAN(LAST_QUERY_ID())));
        SET loop_counter1 = @@row_count;

        update dbp_etl.art_matching_nielsen_per_kmo_final a
        set a.art_matching_id = b.art_matching_id1
        from (select
            mandant_id,
            max(art_matching_id) as art_matching_id1,
            art_id
        from dbp_etl.art_matching_nielsen_per_kmo_final
        where art_id <> -1
        group by 1, 3
        having count(distinct art_matching_id) > 1) b

        where
            a.mandant_id = b.mandant_id and
            a.art_id = b.art_id;

        --loop_counter2 := (SELECT * FROM TABLE(RESULT_SCAN(LAST_QUERY_ID())));
        SET loop_counter2 = @@row_count;

        update dbp_etl.art_matching_nielsen_per_kmo_final a
        set a.art_matching_id = b.art_matching_id1
        from (select
            mandant_id,
            max(art_matching_id) as art_matching_id1,
            gtin_id
        from dbp_etl.art_matching_nielsen_per_kmo_final
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


CREATE OR REPLACE TEMPORARY TABLE _trash AS
SELECT *
FROM dbp_etl.art_matching_nielsen_per_kmo_final
WHERE (
    mandant_id, art_matching_id, art_id, gtin_id) IN (
    SELECT (mandant_id, art_matching_id, art_id, gtin_id)
    FROM dbp_etl.art_matching_nielsen_per_kmo_final
    GROUP BY
        mandant_id,
        art_matching_id,
        art_id,
        gtin_id
    HAVING
        COUNT(DISTINCT art_nielsen_id) > 1 AND SUM(CASE
            WHEN art_nielsen_id = -1
                THEN 1
            ELSE 0
        END) > 0
)
ORDER BY
    mandant_id NULLS LAST,
    art_matching_id NULLS LAST;


DELETE FROM dbp_etl.art_matching_nielsen_per_kmo_final
WHERE (mandant_id, art_matching_id, art_id, art_nielsen_id, gtin_id) IN (SELECT (
    mandant_id, art_matching_id, art_id,
    art_nielsen_id, gtin_id
)
FROM (SELECT DISTINCT
    mandant_id,
    art_matching_id,
    art_id,
    art_nielsen_id,
    gtin_id
FROM `_trash`
WHERE art_nielsen_id = -1) AS t2);


UPDATE dbp_etl.art_matching_nielsen_per_kmo_final SET
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
        AND mandant_id > 1
    GROUP BY
        mandant_id,
        art_id,
        wg_id,
        wug_id
) AS b
WHERE
    art_matching_nielsen_per_kmo_final.mandant_id = b.mandant_id AND art_matching_nielsen_per_kmo_final.art_id = b.art_id
    AND art_matching_nielsen_per_kmo_final.art_id <> -1 AND (
        art_matching_nielsen_per_kmo_final.kl_owg_id <> b.wg_id
        OR art_matching_nielsen_per_kmo_final.kl_uwg_id <> b.wug_id
    );


UPDATE dbp_etl.art_matching_nielsen_per_kmo_final SET
    kl_wg_id = b.owg_id FROM (
    SELECT *
    FROM dbp_data.wg_per
    WHERE
        dat_bis = DATE '9999-12-31'
        AND mandant_id > 1
        AND owg_id <> -1
) AS b
WHERE
    art_matching_nielsen_per_kmo_final.mandant_id = b.mandant_id AND art_matching_nielsen_per_kmo_final.kl_owg_id = b.wg_id AND art_matching_nielsen_per_kmo_final.art_id <> -1 AND art_matching_nielsen_per_kmo_final.kl_wg_id <> b.owg_id;


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
FROM dbp_etl.art_matching_nielsen_per_kmo_final
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
FROM dbp_etl.art_matching_nielsen_per_kmo_final AS A
INNER JOIN `_track_distinct` AS B ON A.mandant_id = B.mandant_id AND A.art_matching_id = B.art_matching_id
WHERE A.art_id <> -1
GROUP BY
    A.mandant_id,
    A.art_matching_id,
    A.kl_wg_id,
    A.kl_owg_id,
    A.kl_uwg_id;


UPDATE dbp_etl.art_matching_nielsen_per_kmo_final SET
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

    WHERE A.kl_wg_id <> -3
    GROUP BY
        A.mandant_id,
        A.art_matching_id
) AS x
WHERE
    art_matching_nielsen_per_kmo_final.mandant_id = x.mandant_id AND art_matching_nielsen_per_kmo_final.art_matching_id
    = x.art_matching_id;


-- 2. WG


CREATE OR REPLACE TEMPORARY TABLE _track_distinct_owg_1 AS
SELECT
    mandant_id,
    art_matching_id,
    kl_wg_id,
    COUNT(*) AS anz,
    COUNT(DISTINCT kl_owg_id) AS anz_owg
FROM dbp_etl.art_matching_nielsen_per_kmo_final
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
FROM dbp_etl.art_matching_nielsen_per_kmo_final AS A
INNER JOIN `_track_distinct_owg_1` AS B ON A.mandant_id = B.mandant_id AND A.art_matching_id = B.art_matching_id
WHERE A.art_id <> -1
GROUP BY
    A.mandant_id,
    A.art_matching_id,
    A.kl_wg_id,
    A.kl_owg_id,
    A.kl_uwg_id;


UPDATE dbp_etl.art_matching_nielsen_per_kmo_final SET
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
    WHERE A.kl_owg_id <> -3
    GROUP BY
        A.mandant_id,
        A.art_matching_id,
        A.kl_wg_id
) AS x
WHERE
    art_matching_nielsen_per_kmo_final.mandant_id = x.mandant_id AND art_matching_nielsen_per_kmo_final.art_matching_id
    = x.art_matching_id;


-- 3. WGI


CREATE OR REPLACE TEMPORARY TABLE _track_distinct_uwg_1 AS
SELECT
    mandant_id,
    art_matching_id,
    kl_wg_id,
    kl_owg_id,
    COUNT(*) AS anz,
    COUNT(DISTINCT kl_uwg_id) AS anz_uwg
FROM dbp_etl.art_matching_nielsen_per_kmo_final
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
FROM dbp_etl.art_matching_nielsen_per_kmo_final AS A
INNER JOIN `_track_distinct_uwg_1` AS B
    ON
        A.mandant_id = B.mandant_id AND A.art_matching_id = B.art_matching_id AND A.kl_wg_id = B.kl_wg_id AND A.kl_owg_id = B.kl_owg_id
WHERE A.art_id <> -1
GROUP BY
    A.mandant_id,
    A.art_matching_id,
    A.kl_wg_id,
    A.kl_owg_id,
    A.kl_uwg_id;


UPDATE dbp_etl.art_matching_nielsen_per_kmo_final SET
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
    WHERE A.kl_uwg_id <> -3
    GROUP BY
        A.mandant_id,
        A.art_matching_id,
        A.kl_wg_id,
        A.kl_owg_id
) AS x
WHERE
    art_matching_nielsen_per_kmo_final.mandant_id = x.mandant_id AND art_matching_nielsen_per_kmo_final.art_matching_id
    = x.art_matching_id;


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
        A0.wg_id
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
    b.wg_id IS NULL
    AND A.kalk_vorschl_wg_id <> -1;


UPDATE dbp_data.art_nielsen_wug_zu_pflege SET
    fb_pflege_wg_id = -1,
    fb_pflege_wug_id = -1
FROM `_sort_pflege_fehler` AS b
WHERE art_nielsen_wug_zu_pflege.mandant_id = b.mandant_id AND art_nielsen_wug_zu_pflege.art_nielsen_id = b.art_nielsen_id;


UPDATE dbp_etl.art_matching_nielsen_per_kmo_final SET
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
FROM dbp_data.art_nielsen_wug_zu_pflege) AS b
WHERE
    art_matching_nielsen_per_kmo_final.mandant_id = b.mandant_id AND art_matching_nielsen_per_kmo_final.art_nielsen_id
    = b.art_nielsen_id AND art_matching_nielsen_per_kmo_final.art_id = -1;


UPDATE dbp_etl.art_matching_nielsen_per_kmo_final SET
    kl_wg_id = b.owg_id FROM (
    SELECT *
    FROM dbp_data.wg_per
    WHERE
        dat_bis = DATE '9999-12-31'
        AND owg_id > 0
) AS b
WHERE
    art_matching_nielsen_per_kmo_final.mandant_id = b.mandant_id AND art_matching_nielsen_per_kmo_final.kl_owg_id = b.wg_id;


CREATE OR REPLACE TEMPORARY TABLE _potenzial_hier AS
SELECT
    mandant_id,
    art_matching_id,
    gtin_id,
    MAX(kl_wg_id) AS kl_wg_id,
    MAX(kl_owg_id) AS kl_owg_id,
    MAX(kl_uwg_id) AS kl_uwg_id
FROM dbp_etl.art_matching_nielsen_per_kmo_final
WHERE (
    mandant_id, gtin_id) IN (
    SELECT (mandant_id, gtin_id)
    FROM dbp_etl.art_matching_nielsen_per_kmo_final
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


UPDATE dbp_etl.art_matching_nielsen_per_kmo_final SET
    kl_wg_id = b.kl_wg_id,
    kl_owg_id = b.kl_owg_id,
    kl_uwg_id = b.kl_uwg_id
FROM `_potenzial_hier` AS b
WHERE
    art_matching_nielsen_per_kmo_final.mandant_id = b.mandant_id AND art_matching_nielsen_per_kmo_final.art_matching_id
    = b.art_matching_id AND art_matching_nielsen_per_kmo_final.gtin_id = b.gtin_id;


-- 31.05.2019, -dbay-
--
-- An dieser Stelle wird das Listungskennzeichen platziert.


UPDATE dbp_etl.art_matching_nielsen_per_kmo_final SET
    list_kz = NULL
WHERE kjwo_update IN (
    SELECT MAX(kjwo_update) AS a1290333724
    FROM dbp_etl.art_matching_nielsen_per_kmo_final
);


UPDATE dbp_etl.art_matching_nielsen_per_kmo_final SET
    list_kz = b.list_kz FROM (SELECT DISTINCT
    mandant_id,
    art_id,
    list_kz
FROM dbp_etl.kl_basis_listung_kmo
WHERE list_kz IN ('A', 'B')) AS b
WHERE
    art_matching_nielsen_per_kmo_final.art_id = b.art_id AND art_matching_nielsen_per_kmo_final.mandant_id = b.mandant_id
    AND art_matching_nielsen_per_kmo_final.kjwo_update IN (
        SELECT MAX(kjwo_update) AS a1290333724
        FROM dbp_etl.art_matching_nielsen_per_kmo_final
    );


UPDATE dbp_etl.art_matching_nielsen_per_kmo_final SET
    list_kz = b.list_kz FROM (
    SELECT DISTINCT *
    FROM dbp_etl.kl_basis_listung_kmo
    WHERE art_nielsen_id IS NULL
) AS b
WHERE
    art_matching_nielsen_per_kmo_final.art_id = b.art_id AND art_matching_nielsen_per_kmo_final.mandant_id = b.mandant_id
    AND art_matching_nielsen_per_kmo_final.list_kz IS NULL AND art_matching_nielsen_per_kmo_final.kjwo_update IN (
        SELECT MAX(kjwo_update) AS a1290333724
        FROM dbp_etl.art_matching_nielsen_per_kmo_final
    );


UPDATE dbp_etl.art_matching_nielsen_per_kmo_final SET
    list_kz = b.list_kz FROM (
    SELECT DISTINCT *
    FROM dbp_etl.kl_basis_listung_kmo
    WHERE art_nielsen_id IS NOT NULL
) AS b
WHERE
    art_matching_nielsen_per_kmo_final.art_id = b.art_id AND art_matching_nielsen_per_kmo_final.mandant_id = b.mandant_id
    AND art_matching_nielsen_per_kmo_final.art_nielsen_id = b.art_nielsen_id AND art_matching_nielsen_per_kmo_final.list_kz
    IS NULL AND art_matching_nielsen_per_kmo_final.kjwo_update IN (
        SELECT MAX(kjwo_update) AS a1290333724
        FROM dbp_etl.art_matching_nielsen_per_kmo_final
    );


--for products that are not occur in listing tables


CREATE OR REPLACE TEMPORARY TABLE _artikel_nielsen_agg AS
SELECT
    A.mandant_id,
    c.art_nielsen_id,
    SUM(A.menge) AS menge_,
    SUM(A.umsatz_brutto) AS umsatz_
FROM dbp_data.art_nielsen_fakten_kjmo AS A
INNER JOIN (
    SELECT kjmo
    FROM dbp_data.tag
    GROUP BY kjmo
) AS x
    ON A.kjmo = x.kjmo
INNER JOIN (
    SELECT
        mandant_id,
        art_nielsen_id,
        art_matching_id
    FROM dbp_etl.art_matching_nielsen_per_kmo
    WHERE art_nielsen_id > -1
    GROUP BY
        mandant_id,
        art_nielsen_id,
        art_matching_id
) AS c ON A.mandant_id = c.mandant_id AND A.art_nielsen_id = c.art_nielsen_id
INNER JOIN dbp_data.nielsen_market AS D ON A.mandant_id = D.mandant_id AND A.nielsen_market_id = D.nielsen_market_id

WHERE (
    A.mandant_id, A.kjmo) IN (
    SELECT (mandant_id, kjmo)
    FROM dbp_data.art_nielsen_fakten_kjmo
    WHERE mandant_id > 1
    GROUP BY
        mandant_id,
        kjmo
    QUALIFY ((
        RANK()
            OVER (PARTITION BY mandant_id ORDER BY mandant_id IS NULL, mandant_id, kjmo IS NULL DESC, kjmo DESC
            )
    ) * -1) BETWEEN -12 AND (-1)
)
AND D.nielsen_market_cluster_id = 1
AND A.mandant_id > 1
GROUP BY
    A.mandant_id,
    c.art_nielsen_id;


UPDATE dbp_etl.art_matching_nielsen_per_kmo_final AS art_matching_nielsen_per_kmo_final0 SET
    list_kz = 'D1' FROM (
    SELECT DISTINCT
        mandant_id,
        art_id,
        art_nielsen_id
    FROM dbp_etl.art_matching_nielsen_per_kmo_final
    WHERE
        list_kz = 'D2'
        AND art_nielsen_id <> -1
        AND (
            mandant_id, art_nielsen_id) IN (
            SELECT (mandant_id, art_nielsen_id)
            FROM (SELECT DISTINCT
                mandant_id,
                art_nielsen_id
            FROM `_artikel_nielsen_agg`) AS t1
        )
) AS b
WHERE
    art_matching_nielsen_per_kmo_final0.art_id = b.art_id AND art_matching_nielsen_per_kmo_final0.mandant_id = b.mandant_id
    AND art_matching_nielsen_per_kmo_final0.art_nielsen_id = b.art_nielsen_id AND art_matching_nielsen_per_kmo_final0.kjwo_update
    IN (
        SELECT MAX(kjwo_update) AS a1290333724
        FROM dbp_etl.art_matching_nielsen_per_kmo_final
    );


UPDATE dbp_etl.art_matching_nielsen_per_kmo_final SET
    list_kz = 'D2'
WHERE list_kz IS NULL AND art_id <> -1 AND art_nielsen_id = -1 AND kjwo_update IN (SELECT
    MAX(
        kjwo_update) AS
    a1290333724
FROM dbp_etl.art_matching_nielsen_per_kmo_final);


UPDATE dbp_etl.art_matching_nielsen_per_kmo_final SET
    list_kz = 'D2'
WHERE list_kz IS NULL AND art_id <> -1 AND art_nielsen_id <> -1 AND kjwo_update IN (SELECT
    MAX(
        kjwo_update) AS
    a1290333724
FROM dbp_etl.art_matching_nielsen_per_kmo_final);


-- correct state settings, only differentiated between 'N' (regular) and 'T' (tupel)


UPDATE dbp_etl.art_matching_nielsen_per_kmo_final AS art_matching_nielsen_per_kmo_final0 SET
    status = 'N' FROM (
    SELECT
        mandant_id,
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
    FROM dbp_etl.art_matching_nielsen_per_kmo_final
    WHERE mandant_id IN (2, 3, 5, 7, 8)
    GROUP BY
        mandant_id,
        art_matching_id
    HAVING
        anz_art = 0 AND anz_art_nielsen = 1 OR anz_art = 1 AND anz_art_nielsen = 0 OR anz_art = 1 AND anz_art_nielsen =
        1
) AS b
WHERE
    art_matching_nielsen_per_kmo_final0.art_matching_id = b.art_matching_id AND art_matching_nielsen_per_kmo_final0.mandant_id
    = b.mandant_id;


UPDATE dbp_etl.art_matching_nielsen_per_kmo_final AS art_matching_nielsen_per_kmo_final0 SET
    status = 'T' FROM (SELECT
    mandant_id,
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
FROM dbp_etl.art_matching_nielsen_per_kmo_final
WHERE mandant_id IN (2, 3, 5, 7, 8)
GROUP BY
    mandant_id,
    art_matching_id
HAVING anz_art > 1) AS b
WHERE
    art_matching_nielsen_per_kmo_final0.art_matching_id = b.art_matching_id AND art_matching_nielsen_per_kmo_final0.mandant_id
    = b.mandant_id;


-- That's it --


CREATE OR REPLACE TEMPORARY TABLE _upd_stable_xxx AS
SELECT
    mandant_id,
    art_matching_id,
    COUNT(DISTINCT kl_wg_id) AS anz1,
    COUNT(DISTINCT kl_owg_id) AS anz2,
    COUNT(DISTINCT kl_uwg_id) AS anz3
FROM dbp_etl.art_matching_nielsen_per_kmo_final
GROUP BY
    mandant_id,
    art_matching_id
HAVING anz1 > 1 OR anz2 > 1 OR anz3 > 1;


UPDATE dbp_etl.art_matching_nielsen_per_kmo_final SET
    kl_owg_id = b.kl_owg_id FROM (
    SELECT
        A.mandant_id,
        A.art_matching_id,
        MAX(A.kl_owg_id) AS kl_owg_id
    FROM dbp_etl.art_matching_nielsen_per_kmo_final AS A
    INNER JOIN `_upd_stable_xxx` AS B ON A.mandant_id = B.mandant_id AND A.art_matching_id = B.art_matching_id
    WHERE B.anz2 > 1
    GROUP BY
        A.mandant_id,
        A.art_matching_id
) AS b
WHERE
    art_matching_nielsen_per_kmo_final.mandant_id = b.mandant_id AND art_matching_nielsen_per_kmo_final.art_matching_id
    = b.art_matching_id;


UPDATE dbp_etl.art_matching_nielsen_per_kmo_final SET
    kl_uwg_id = b.kl_uwg_id FROM (
    SELECT
        A.mandant_id,
        A.art_matching_id,
        MIN(A.kl_uwg_id) AS kl_uwg_id
    FROM dbp_etl.art_matching_nielsen_per_kmo_final AS A
    INNER JOIN `_upd_stable_xxx` AS B ON A.mandant_id = B.mandant_id AND A.art_matching_id = B.art_matching_id
    WHERE
        B.anz3 > 1
        AND A.kl_uwg_id > 0
    GROUP BY
        A.mandant_id,
        A.art_matching_id
) AS b
WHERE
    art_matching_nielsen_per_kmo_final.mandant_id = b.mandant_id AND art_matching_nielsen_per_kmo_final.art_matching_id
    = b.art_matching_id;


UPDATE dbp_etl.art_matching_nielsen_per_kmo_final SET
    kl_wg_id = b.owg_id FROM (
    SELECT *
    FROM dbp_data.wg_per
    WHERE
        dat_bis = DATE '9999-12-31'
        AND mandant_id > 1
        AND owg_id NOT IN (-1, -3)
) AS b
WHERE
    art_matching_nielsen_per_kmo_final.mandant_id = b.mandant_id AND art_matching_nielsen_per_kmo_final.kl_owg_id = b.wg_id;


UPDATE dbp_etl.art_matching_nielsen_per_kmo_final SET
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
        AND mandant_id > 1
    GROUP BY
        mandant_id,
        art_id,
        wg_id,
        wug_id
) AS b
WHERE
    art_matching_nielsen_per_kmo_final.mandant_id = b.mandant_id AND art_matching_nielsen_per_kmo_final.art_id = b.art_id
    AND art_matching_nielsen_per_kmo_final.art_id <> -1 AND (
        art_matching_nielsen_per_kmo_final.kl_owg_id <> b.wg_id
        OR art_matching_nielsen_per_kmo_final.kl_uwg_id <> b.wug_id
    );


UPDATE dbp_etl.art_matching_nielsen_per_kmo_final SET
    kl_wg_id = b.owg_id FROM (
    SELECT *
    FROM dbp_data.wg_per
    WHERE
        dat_bis = DATE '9999-12-31'
        AND mandant_id > 1
        AND owg_id <> -1
) AS b
WHERE
    art_matching_nielsen_per_kmo_final.mandant_id = b.mandant_id AND art_matching_nielsen_per_kmo_final.kl_owg_id = b.wg_id AND art_matching_nielsen_per_kmo_final.art_id <> -1 AND art_matching_nielsen_per_kmo_final.kl_wg_id <> b.owg_id;


--


CREATE OR REPLACE TEMPORARY TABLE _track_distinct AS
SELECT
    mandant_id,
    art_matching_id,
    COUNT(*) AS anz,
    COUNT(DISTINCT kl_wg_id) AS anz_wg
FROM dbp_etl.art_matching_nielsen_per_kmo_final
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
FROM dbp_etl.art_matching_nielsen_per_kmo_final AS A
INNER JOIN `_track_distinct` AS B ON A.mandant_id = B.mandant_id AND A.art_matching_id = B.art_matching_id
WHERE A.art_id <> -1
GROUP BY
    A.mandant_id,
    A.art_matching_id,
    A.kl_wg_id,
    A.kl_owg_id,
    A.kl_uwg_id;


UPDATE dbp_etl.art_matching_nielsen_per_kmo_final SET
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

    WHERE A.kl_wg_id <> -3
    GROUP BY
        A.mandant_id,
        A.art_matching_id
) AS x
WHERE
    art_matching_nielsen_per_kmo_final.mandant_id = x.mandant_id AND art_matching_nielsen_per_kmo_final.art_matching_id
    = x.art_matching_id;


-- 2. WG


CREATE OR REPLACE TEMPORARY TABLE _track_distinct_owg_1 AS
SELECT
    mandant_id,
    art_matching_id,
    kl_wg_id,
    COUNT(*) AS anz,
    COUNT(DISTINCT kl_owg_id) AS anz_owg
FROM dbp_etl.art_matching_nielsen_per_kmo_final
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
FROM dbp_etl.art_matching_nielsen_per_kmo_final AS A
INNER JOIN `_track_distinct_owg_1` AS B ON A.mandant_id = B.mandant_id AND A.art_matching_id = B.art_matching_id
WHERE A.art_id <> -1
GROUP BY
    A.mandant_id,
    A.art_matching_id,
    A.kl_wg_id,
    A.kl_owg_id,
    A.kl_uwg_id;


UPDATE dbp_etl.art_matching_nielsen_per_kmo_final SET
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
    WHERE A.kl_owg_id <> -3
    GROUP BY
        A.mandant_id,
        A.art_matching_id,
        A.kl_wg_id
) AS x
WHERE
    art_matching_nielsen_per_kmo_final.mandant_id = x.mandant_id AND art_matching_nielsen_per_kmo_final.art_matching_id
    = x.art_matching_id;


-- 3. WGI


CREATE OR REPLACE TEMPORARY TABLE _track_distinct_uwg_1 AS
SELECT
    mandant_id,
    art_matching_id,
    kl_wg_id,
    kl_owg_id,
    COUNT(*) AS anz,
    COUNT(DISTINCT kl_uwg_id) AS anz_uwg
FROM dbp_etl.art_matching_nielsen_per_kmo_final
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
FROM dbp_etl.art_matching_nielsen_per_kmo_final AS A
INNER JOIN `_track_distinct_uwg_1` AS B
    ON
        A.mandant_id = B.mandant_id AND A.art_matching_id = B.art_matching_id AND A.kl_wg_id = B.kl_wg_id AND A.kl_owg_id = B.kl_owg_id
WHERE A.art_id <> -1
GROUP BY
    A.mandant_id,
    A.art_matching_id,
    A.kl_wg_id,
    A.kl_owg_id,
    A.kl_uwg_id;


UPDATE dbp_etl.art_matching_nielsen_per_kmo_final SET
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
    WHERE A.kl_uwg_id <> -3
    GROUP BY
        A.mandant_id,
        A.art_matching_id,
        A.kl_wg_id,
        A.kl_owg_id
) AS x
WHERE
    art_matching_nielsen_per_kmo_final.mandant_id = x.mandant_id AND art_matching_nielsen_per_kmo_final.art_matching_id
    = x.art_matching_id;


CREATE OR REPLACE TEMPORARY TABLE _kill_dups AS
SELECT
    mandant_id,
    art_nielsen_id,
    COUNT(DISTINCT art_matching_id) AS anz,
    MIN(art_matching_id) AS min_match,
    MIN(status) AS min_status,
    MAX(status) AS max_status
FROM dbp_etl.art_matching_nielsen_per_kmo_final
WHERE art_nielsen_id <> -1
GROUP BY
    mandant_id,
    art_nielsen_id
HAVING anz > 1;


DELETE FROM dbp_etl.art_matching_nielsen_per_kmo_final
WHERE (
    mandant_id, art_nielsen_id, art_matching_id) IN (
    SELECT (mandant_id, art_nielsen_id, min_match)
    FROM `_kill_dups`
);


UPDATE dbp_etl.art_matching_nielsen_per_kmo_final AS art_matching_nielsen_per_kmo_final0 SET
    art_matching_id = b.max_match,
    status = b.max_status FROM (SELECT
    mandant_id,
    art_id,
    COUNT(DISTINCT art_matching_id) AS anz_match,
    MAX(art_matching_id) AS max_match,
    MIN(art_matching_id) AS min_match,
    MIN(status) AS min_status,
    MAX(status) AS max_status
FROM dbp_etl.art_matching_nielsen_per_kmo_final
WHERE art_id <> -1
GROUP BY
    mandant_id,
    art_id
HAVING anz_match > 1) AS b
WHERE
    art_matching_nielsen_per_kmo_final0.mandant_id = b.mandant_id AND art_matching_nielsen_per_kmo_final0.art_id = b.art_id
    AND art_matching_nielsen_per_kmo_final0.art_matching_id <> b.max_match;


CREATE OR REPLACE TEMPORARY TABLE _xxx AS
SELECT
    mandant_id,
    gtin_id,
    COUNT(DISTINCT art_matching_id) AS anz_match,
    COUNT(DISTINCT CASE
        WHEN art_id = -1
            THEN NULL
        ELSE art_id
    END) AS anz_art_id,
    COUNT(DISTINCT CASE
        WHEN art_nielsen_id = -1
            THEN NULL
        ELSE art_nielsen_id
    END) AS anz_art_nielsen_id,
    MIN(art_matching_id) AS min_match,
    MAX(art_matching_id) AS max_match,
    MIN(art_id) AS min_art,
    MAX(art_id) AS max_art,
    MIN(art_nielsen_id) AS min_art_nielsen,
    MAX(art_nielsen_id) AS max_art_nielsen
FROM dbp_etl.art_matching_nielsen_per_kmo_final
WHERE gtin_id NOT IN (-9999, -9998)
GROUP BY
    mandant_id,
    gtin_id
HAVING anz_match > 1;


UPDATE dbp_etl.art_matching_nielsen_per_kmo_final SET
    art_matching_id = b.min_match,
    status = 'N',
    art_nielsen_id = b.min_art_nielsen FROM (
    SELECT *
    FROM `_xxx`
    WHERE
        anz_art_id = 0
        AND anz_art_nielsen_id = 1
) AS b
WHERE art_matching_nielsen_per_kmo_final.mandant_id = b.mandant_id AND art_matching_nielsen_per_kmo_final.gtin_id = b.gtin_id;


DELETE FROM `_xxx`
WHERE anz_art_id = 0 AND anz_art_nielsen_id = 1;


UPDATE dbp_etl.art_matching_nielsen_per_kmo_final SET
    art_matching_id = b.min_match,
    status = 'N' FROM (
    SELECT *
    FROM `_xxx`
    WHERE anz_art_id = 0
) AS b
WHERE art_matching_nielsen_per_kmo_final.mandant_id = b.mandant_id AND art_matching_nielsen_per_kmo_final.gtin_id = b.gtin_id;


DELETE FROM `_xxx`
WHERE anz_art_id = 0;


CREATE OR REPLACE TEMPORARY TABLE _distinct_recs AS
SELECT
    mandant_id,
    MIN(art_matching_id) AS art_matching_id,
    MAX(art_id) AS art_id,
    MAX(art_nielsen_id) AS art_nielsen_id,
    gtin_id,
    MAX(kl_art_kat_id) AS kl_art_kat_id,
    MAX(kl_wg_id) AS kl_wg_id,
    MAX(kl_owg_id) AS kl_owg_id,
    MAX(kl_uwg_id) AS kl_uwg_id,
    MAX(umrech_faktor) AS umrech_faktor,
    MAX(status) AS status,
    MAX(list_kz) AS list_kz,
    MAX(komponente_fg) AS komponente_fg,
    MAX(kjwo_update) AS kjwo_update,
    MAX(td_insert) AS td_insert,
    MAX(td_update) AS td_update
FROM dbp_etl.art_matching_nielsen_per_kmo_final AS A
WHERE (
    mandant_id, gtin_id) IN (
    SELECT (mandant_id, gtin_id)
    FROM `_xxx`
    WHERE
        anz_art_id = 1
        AND anz_art_nielsen_id = 1
        AND min_art = -1
        AND min_art_nielsen = -1
)
GROUP BY
    mandant_id,
    gtin_id;


DELETE FROM dbp_etl.art_matching_nielsen_per_kmo_final
WHERE (
    mandant_id, gtin_id) IN (
    SELECT (mandant_id, gtin_id)
    FROM `_xxx`
    WHERE
        anz_art_id = 1
        AND anz_art_nielsen_id = 1
        AND min_art = -1
        AND min_art_nielsen = -1
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
    td_insert,
    td_update
FROM `_distinct_recs`);


DELETE FROM `_xxx`
WHERE anz_art_id = 1 AND anz_art_nielsen_id = 1 AND min_art = -1 AND min_art_nielsen = -1;


UPDATE dbp_etl.art_matching_nielsen_per_kmo_final SET
    art_matching_id = b.min_match,
    status = 'N',
    art_id = b.max_art FROM (
    SELECT *
    FROM `_xxx`
    WHERE anz_art_id = 1
) AS b
WHERE art_matching_nielsen_per_kmo_final.mandant_id = b.mandant_id AND art_matching_nielsen_per_kmo_final.gtin_id = b.gtin_id;


DELETE FROM `_xxx`
WHERE anz_art_id = 1;


UPDATE dbp_etl.art_matching_nielsen_per_kmo_final SET
    art_matching_id = b.min_match,
    status = 'T',
    art_nielsen_id = b.max_art_nielsen FROM (
    SELECT *
    FROM `_xxx`
    WHERE
        anz_art_nielsen_id = 1
        AND anz_art_id > 1
) AS b
WHERE art_matching_nielsen_per_kmo_final.mandant_id = b.mandant_id AND art_matching_nielsen_per_kmo_final.gtin_id = b.gtin_id;


DELETE FROM `_xxx`
WHERE anz_art_nielsen_id = 1 AND anz_art_id > 1;


UPDATE dbp_etl.art_matching_nielsen_per_kmo_final SET
    art_matching_id = b.min_match,
    status = 'T' FROM (
    SELECT *
    FROM `_xxx`
    WHERE anz_art_id > 1
) AS b
WHERE art_matching_nielsen_per_kmo_final.mandant_id = b.mandant_id AND art_matching_nielsen_per_kmo_final.gtin_id = b.gtin_id;


DELETE FROM `_xxx`
WHERE anz_art_nielsen_id = 1 AND anz_art_id > 1;


CREATE OR REPLACE TEMPORARY TABLE _ek_sort_art_matching_zu_kmo_tmp (
    mandant_id INTEGER,
    art_matching_id INTEGER,
    kombi_art_id STRING(5000),
    kombi_art_nielsen_id STRING(5000),
    kombi_gtin_id STRING(5000),
    dat_von DATE,
    dat_bis DATE
);


INSERT INTO _ek_sort_art_matching_zu_kmo_tmp
SELECT
    mandant_id,
    art_matching_id,
    SUBSTR(REPLACE(STRING_AGG(CAST(art_id AS STRING), ',' ORDER BY art_id), ',', ''), 1, 5000) AS art_id,
    SUBSTR(REPLACE(STRING_AGG(CAST(art_nielsen_id AS STRING), ',' ORDER BY art_nielsen_id), ',', ''), 1, 5000) AS art_nielsen_id,
    SUBSTR(REPLACE(STRING_AGG(CAST(gtin_id AS STRING), ',' ORDER BY gtin_id), ',', ''), 1, 5000) AS gtin_id,
    CAST('1900-01-01' AS DATE),
    CAST('9999-12-31' AS DATE)
FROM dbp_etl.art_matching_nielsen_per_kmo_final
GROUP BY 1, 2;


UPDATE dbp_etl_process.ek_sort_art_matching_zu_kmo AS ek_sort_art_matching_zu_kmo0 SET
    dat_bis = DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 1 DAY) FROM (
    SELECT
        mandant_id,
        art_matching_id
    FROM dbp_etl_process.ek_sort_art_matching_zu_kmo
    WHERE
        dat_bis = DATE '9999-12-31'
        AND (
            mandant_id, art_matching_id) NOT IN (
            SELECT (mandant_id, art_matching_id)
            FROM `_ek_sort_art_matching_zu_kmo_tmp`
        )
) AS b
WHERE
    ek_sort_art_matching_zu_kmo0.mandant_id = b.mandant_id AND ek_sort_art_matching_zu_kmo0.art_matching_id = b.art_matching_id
    AND ek_sort_art_matching_zu_kmo0.dat_bis = DATE '9999-12-31';


CREATE OR REPLACE TEMPORARY TABLE _changes AS
SELECT
    A.mandant_id,
    A.art_matching_id,
    A.kombi_art_id,
    A.kombi_art_nielsen_id,
    A.kombi_gtin_id,
    A.dat_von,
    A.dat_bis
FROM dbp_etl_process.ek_sort_art_matching_zu_kmo AS A
LEFT JOIN `_ek_sort_art_matching_zu_kmo_tmp` AS B
    ON
        A.mandant_id = B.mandant_id AND A.art_matching_id = B.art_matching_id
        AND A.kombi_art_id = B.kombi_art_id AND A.kombi_art_nielsen_id = B.kombi_art_nielsen_id
WHERE
    B.dat_von IS NULL
    AND A.dat_bis = DATE '9999-12-31';


CREATE OR REPLACE TEMPORARY TABLE _news AS
SELECT *
FROM `_ek_sort_art_matching_zu_kmo_tmp`
WHERE (
    mandant_id, art_matching_id) IN (
    SELECT (mandant_id, art_matching_id)
    FROM `_changes`
);


UPDATE dbp_etl_process.ek_sort_art_matching_zu_kmo SET
    dat_bis = DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 1 DAY)
FROM `_changes` AS b
WHERE
    ek_sort_art_matching_zu_kmo.mandant_id = b.mandant_id AND ek_sort_art_matching_zu_kmo.art_matching_id = b.art_matching_id
    AND ek_sort_art_matching_zu_kmo.dat_bis = DATE '9999-12-31';


INSERT INTO dbp_etl_process.ek_sort_art_matching_zu_kmo (
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

--- 1st: keeping the old, useleass records for frontend purpose


INSERT INTO dbp_etl.art_matching_nielsen_per_kmo_olds
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
    CAST(umrech_faktor AS FLOAT64) AS umrech_faktor,
    status,
    list_kz,
    komponente_fg,
    kjwo_update,
    td_insert,
    td_update
FROM dbp_etl.art_matching_nielsen_per_kmo
WHERE (
    mandant_id, art_matching_id) NOT IN (
    SELECT (mandant_id, art_matching_id)
    FROM dbp_etl.art_matching_nielsen_per_kmo_final
));


--- maintenance


DELETE FROM dbp_etl.art_matching_nielsen_per_kmo_olds
WHERE kjwo_update NOT IN (
    SELECT kjwo
    FROM dbp_data.woche
    WHERE akt_wo BETWEEN -6 AND 1
);


--- 2nd: new registration


TRUNCATE TABLE dbp_etl.art_matching_nielsen_per_kmo;


INSERT INTO dbp_etl.art_matching_nielsen_per_kmo
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
    td_insert,
    td_update
FROM dbp_etl.art_matching_nielsen_per_kmo_final);


CREATE OR REPLACE TEMPORARY TABLE _schrott AS
SELECT
    mandant_id,
    art_matching_id,
    COUNT(DISTINCT CASE
        WHEN art_id <> -1
            THEN art_id
        ELSE NULL
    END) AS anz_art
FROM dbp_etl.art_matching_nielsen_per_kmo
WHERE kl_owg_id = 0
GROUP BY
    mandant_id,
    art_matching_id
HAVING anz_art >= 1;


UPDATE dbp_etl.art_matching_nielsen_per_kmo AS art_matching_nielsen_per_kmo0 SET
    kl_owg_id = b.wg_id,
    kl_uwg_id = b.wug_id FROM (
    SELECT
        mandant_id,
        art_id,
        wg_id,
        wug_id
    FROM dbp_data.art_wg_zu_per AS A
    WHERE
        dat_bis = DATE '9999-12-31'
        AND arthiertyp_id = 2
        AND mandant_id > 1
        AND (
            mandant_id, art_id) IN (
            SELECT (mandant_id, art_id)
            FROM dbp_etl.art_matching_nielsen_per_kmo
            WHERE (
                mandant_id, art_matching_id) IN (
                SELECT (mandant_id, art_matching_id)
                FROM `_schrott`
            )
        )
    GROUP BY
        mandant_id,
        art_id,
        wg_id,
        wug_id
) AS b
WHERE
    art_matching_nielsen_per_kmo0.mandant_id = b.mandant_id AND art_matching_nielsen_per_kmo0.art_id = b.art_id AND
    art_matching_nielsen_per_kmo0.art_id <> -1 AND (
        art_matching_nielsen_per_kmo0.kl_owg_id <> b.wg_id OR
        art_matching_nielsen_per_kmo0.kl_uwg_id <> b.wug_id
    );


UPDATE dbp_etl.art_matching_nielsen_per_kmo SET
    kl_wg_id = b.owg_id FROM (
    SELECT *
    FROM dbp_data.wg_per
    WHERE
        dat_bis = DATE '9999-12-31'
        AND mandant_id > 1
        AND owg_id <> -1
) AS b
WHERE
    art_matching_nielsen_per_kmo.mandant_id = b.mandant_id AND art_matching_nielsen_per_kmo.kl_owg_id = b.wg_id AND
    art_matching_nielsen_per_kmo.art_id <> -1 AND art_matching_nielsen_per_kmo.kl_wg_id <> b.owg_id;


-- correct product groups before transformation

-- 1. external matching using wg_filter_id = 47 to get the most best fitting product group


CREATE OR REPLACE TEMPORARY TABLE _track_distinct AS
SELECT
    A.mandant_id,
    A.art_matching_id,
    MAX(D.owg_id) AS kl_wg_id,
    MAX(C.wg_id) AS kl_owg_id,
    MIN(C.wug_id) AS kl_uwg_id
FROM dbp_etl.art_matching_nielsen_per_kmo AS A
INNER JOIN (SELECT
    mandant_id,
    art_matching_id
FROM dbp_etl.art_matching_nielsen_per_kmo
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
        WHERE wg_filter_id = 47
        GROUP BY wg_id
    )
GROUP BY
    A.mandant_id,
    A.art_matching_id;


UPDATE dbp_etl.art_matching_nielsen_per_kmo SET
    kl_wg_id = b.kl_wg_id,
    kl_owg_id = b.kl_owg_id,
    kl_uwg_id = b.kl_uwg_id FROM (SELECT
    mandant_id,
    art_matching_id,
    kl_wg_id,
    kl_owg_id,
    kl_uwg_id
FROM `_track_distinct`) AS b
WHERE art_matching_nielsen_per_kmo.mandant_id = b.mandant_id AND art_matching_nielsen_per_kmo.art_matching_id = b.art_matching_id;


-- 2. internal matching using wg_filter_id = 47


CREATE OR REPLACE TEMPORARY TABLE _track_distinct AS
SELECT
    A.mandant_id,
    A.art_matching_id,
    MAX(A.kl_wg_id) AS kl_wg_id,
    MAX(A.kl_owg_id) AS kl_owg_id,
    MIN(A.kl_uwg_id) AS kl_uwg_id
FROM dbp_etl.art_matching_nielsen_per_kmo AS A
INNER JOIN (SELECT
    mandant_id,
    art_matching_id
FROM dbp_etl.art_matching_nielsen_per_kmo
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
        WHERE wg_filter_id = 47
        GROUP BY wg_id
    )
GROUP BY
    A.mandant_id,
    A.art_matching_id;


UPDATE dbp_etl.art_matching_nielsen_per_kmo SET
    kl_wg_id = b.kl_wg_id,
    kl_owg_id = b.kl_owg_id,
    kl_uwg_id = b.kl_uwg_id FROM (SELECT
    mandant_id,
    art_matching_id,
    kl_wg_id,
    kl_owg_id,
    kl_uwg_id
FROM `_track_distinct`) AS b
WHERE art_matching_nielsen_per_kmo.mandant_id = b.mandant_id AND art_matching_nielsen_per_kmo.art_matching_id = b.art_matching_id;


-- 3. maybe useless, but you never know...last scan with all product groups


CREATE OR REPLACE TEMPORARY TABLE _track_distinct AS
SELECT
    A.mandant_id,
    A.art_matching_id,
    MAX(A.kl_wg_id) AS kl_wg_id,
    MAX(A.kl_owg_id) AS kl_owg_id,
    MIN(A.kl_uwg_id) AS kl_uwg_id
FROM dbp_etl.art_matching_nielsen_per_kmo AS A
INNER JOIN (SELECT
    mandant_id,
    art_matching_id
FROM dbp_etl.art_matching_nielsen_per_kmo
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


UPDATE dbp_etl.art_matching_nielsen_per_kmo SET
    kl_wg_id = b.kl_wg_id,
    kl_owg_id = b.kl_owg_id,
    kl_uwg_id = b.kl_uwg_id FROM (SELECT
    mandant_id,
    art_matching_id,
    kl_wg_id,
    kl_owg_id,
    kl_uwg_id
FROM `_track_distinct`) AS b
WHERE art_matching_nielsen_per_kmo.mandant_id = b.mandant_id AND art_matching_nielsen_per_kmo.art_matching_id = b.art_matching_id;


----

------loading of dbp_data.art_nielsen_art_wg_zu


DELETE FROM dbp_data.art_nielsen_art_wg_zu
WHERE (
    mandant_id, kjwo) IN (
    SELECT (mandant_id, MAX(kjwo_update))
    FROM dbp_etl.art_matching_nielsen_per_kmo
    GROUP BY mandant_id
);


INSERT INTO dbp_data.art_nielsen_art_wg_zu (
    mandant_id, art_nielsen_id, art_id, kjwo, wg_id, wug_id,
    td_update, td_insert
)
(
    SELECT DISTINCT
        A.mandant_id,
        A.art_nielsen_id,
        B.art_id,
        B.kjwo_update,
        -1,
        -1,
        CURRENT_TIMESTAMP(),
        CURRENT_TIMESTAMP()
    FROM dbp_data.art_nielsen AS A
    INNER JOIN dbp_etl.art_matching_nielsen_per_kmo AS B
        ON
            A.mandant_id = B.mandant_id AND A.art_nielsen_id
            = B.art_nielsen_id
    WHERE
        A.dat_bis = DATE '9999-12-31'
        AND B.art_nielsen_id <> -1
        AND B.kjwo_update IN (
            SELECT MAX(kjwo_update) AS a1290333724
            FROM dbp_etl.art_matching_nielsen_per_kmo
        )
);


INSERT INTO dbp_data.art_nielsen_art_wg_zu (
    mandant_id, art_nielsen_id, art_id, kjwo, wg_id, wug_id,
    td_update, td_insert
)
(
    SELECT DISTINCT
        mandant_id,
        art_nielsen_id,
        art_id,
        kjwo_update,
        -1,
        -1,
        CURRENT_TIMESTAMP(),
        CURRENT_TIMESTAMP()
    FROM dbp_etl.art_matching_nielsen_per_kmo
    WHERE
        art_nielsen_id = -1
        AND art_id > -1
        AND kjwo_update IN (
            SELECT MAX(kjwo_update) AS a1290333724
            FROM dbp_etl.art_matching_nielsen_per_kmo
        )
);


--lvl_4


UPDATE dbp_data.art_nielsen_art_wg_zu SET
    wg_id = b.kalk_vorschl_wg_id,
    wug_id = b.kalk_vorschl_wug_id,
    wg_quelle_bez = 'vorschl_dwh',
    wg_quelle_hierarchie_lvl_id = 4 FROM (
    SELECT *
    FROM dbp_data.art_nielsen_wug_zu_pflege
    WHERE mandant_id > 1
) AS b
WHERE
    art_nielsen_art_wg_zu.mandant_id = b.mandant_id AND art_nielsen_art_wg_zu.art_nielsen_id = b.art_nielsen_id AND
    art_nielsen_art_wg_zu.art_id = -1 AND art_nielsen_art_wg_zu.kjwo IN (
        SELECT MAX(kjwo) AS a1886115246
        FROM dbp_data.art_nielsen_art_wg_zu
    );


--lvl_3


UPDATE dbp_data.art_nielsen_art_wg_zu SET
    wg_id = b.nielsen_vorschl_wg_id,
    wug_id = b.nielsen_vorschl_wug_id,
    wg_quelle_bez = 'vorschl_nielsen',
    wg_quelle_hierarchie_lvl_id = 3 FROM (
    SELECT *
    FROM dbp_data.art_nielsen
    WHERE
        dat_bis = DATE '9999-12-31'
        AND mandant_id > 1
        AND nielsen_vorschl_wg_id IS NOT NULL
        AND nielsen_vorschl_wug_id IS NOT NULL
) AS b
WHERE
    art_nielsen_art_wg_zu.mandant_id = b.mandant_id AND art_nielsen_art_wg_zu.art_nielsen_id = b.art_nielsen_id AND
    art_nielsen_art_wg_zu.art_id = -1 AND art_nielsen_art_wg_zu.kjwo IN (
        SELECT MAX(kjwo) AS a1886115246
        FROM dbp_data.art_nielsen_art_wg_zu
    );


--lvl_2


UPDATE dbp_data.art_nielsen_art_wg_zu SET
    wg_id = b.fb_pflege_wg_id,
    wug_id = b.fb_pflege_wug_id,
    wg_quelle_bez = 'fb_pflege',
    wg_quelle_hierarchie_lvl_id = 2 FROM (
    SELECT *
    FROM dbp_data.art_nielsen_wug_zu_pflege
    WHERE fb_pflege_wg_id > -1
) AS b
WHERE
    art_nielsen_art_wg_zu.mandant_id = b.mandant_id AND art_nielsen_art_wg_zu.art_nielsen_id = b.art_nielsen_id AND
    art_nielsen_art_wg_zu.art_id = -1 AND art_nielsen_art_wg_zu.kjwo IN (
        SELECT MAX(kjwo) AS a1886115246
        FROM dbp_data.art_nielsen_art_wg_zu
    );


--lvl_1


UPDATE dbp_data.art_nielsen_art_wg_zu SET
    wg_id = b.wg_id,
    wug_id = b.wug_id,
    wg_quelle_bez = 'kaufland_article',
    wg_quelle_hierarchie_lvl_id = 1 FROM (
    SELECT *
    FROM dbp_data.art_wg_zu_per
    WHERE
        dat_bis = DATE '9999-12-31'
        AND mandant_id > 1
        AND arthiertyp_id = 2
) AS b
WHERE
    art_nielsen_art_wg_zu.mandant_id = b.mandant_id AND art_nielsen_art_wg_zu.art_id = b.art_id AND
    art_nielsen_art_wg_zu.art_id <> -1 AND art_nielsen_art_wg_zu.kjwo IN (
        SELECT MAX(kjwo) AS a1886115246
        FROM dbp_data.art_nielsen_art_wg_zu
    );


CREATE OR REPLACE TEMPORARY TABLE _art_nielsen_category_match_1 AS
SELECT DISTINCT
    B.art_matching_id,
    A.mandant_id,
    A.art_nielsen_id,
    A.art_id,
    A.kjwo,
    A.wg_id,
    A.wug_id,
    A.wg_quelle_bez,
    A.wg_quelle_hierarchie_lvl_id,
    A.td_update,
    A.td_insert
FROM dbp_data.art_nielsen_art_wg_zu AS A
INNER JOIN dbp_etl.art_matching_nielsen_per_kmo AS B
    ON
        A.mandant_id = B.mandant_id AND A.art_id = B.art_id
        AND A.art_nielsen_id = B.art_nielsen_id
WHERE B.kjwo_update IN (
    SELECT MAX(kjwo_update) AS a1290333724
    FROM dbp_etl.art_matching_nielsen_per_kmo
)
AND A.kjwo IN (
    SELECT MAX(kjwo) AS a1886115246
    FROM dbp_data.art_nielsen_art_wg_zu
);


CREATE OR REPLACE TEMPORARY TABLE _art_nielsen_category_match_2 AS
SELECT *
FROM `_art_nielsen_category_match_1`
WHERE (
    mandant_id, art_matching_id) IN (
    SELECT (mandant_id, art_matching_id)
    FROM (
        SELECT DISTINCT
            mandant_id,
            art_matching_id
        FROM `_art_nielsen_category_match_1`
        WHERE
            wg_id = -1
            AND wug_id = -1
    ) AS t1
);


UPDATE `_art_nielsen_category_match_1` SET
    wg_id = b.wg_id,
    wug_id = b.wug_id FROM (
    SELECT
        mandant_id,
        art_matching_id,
        MAX(wg_id) AS wg_id,
        MAX(wug_id) AS wug_id
    FROM `_art_nielsen_category_match_2`
    GROUP BY
        art_matching_id,
        mandant_id
) AS b
WHERE
    `_art_nielsen_category_match_1`.mandant_id = b.mandant_id AND `_art_nielsen_category_match_1`.art_matching_id = b.art_matching_id;


--lvl_5


UPDATE dbp_data.art_nielsen_art_wg_zu SET
    wg_id = b.wg_id,
    wug_id = b.wug_id,
    wg_quelle_bez = 'from matching_id',
    wg_quelle_hierarchie_lvl_id = 5 FROM (
    SELECT *
    FROM `_art_nielsen_category_match_1`
    WHERE
        mandant_id > 1
        AND wg_id <> -1
        AND wug_id <> -1
) AS b
WHERE
    art_nielsen_art_wg_zu.mandant_id = b.mandant_id AND art_nielsen_art_wg_zu.art_nielsen_id = b.art_nielsen_id AND
    art_nielsen_art_wg_zu.art_id = b.art_id AND art_nielsen_art_wg_zu.wg_id = -1 AND art_nielsen_art_wg_zu.wug_id = -1 AND art_nielsen_art_wg_zu.kjwo IN (
        SELECT MAX(kjwo) AS a1886115246
        FROM dbp_data.art_nielsen_art_wg_zu
    );


--update dbp_etl.art_matching_nielsen_per_kmo
--art_id > 0


UPDATE dbp_etl.art_matching_nielsen_per_kmo SET
    kl_owg_id = b.wg_id,
    kl_uwg_id = b.wug_id FROM (
    SELECT DISTINCT
        mandant_id,
        art_id,
        wg_id,
        wug_id,
        kjwo
    FROM dbp_data.art_nielsen_art_wg_zu
    WHERE
        art_id <> -1
        AND kjwo IN (
            SELECT MAX(kjwo) AS a1886115246
            FROM dbp_data.art_nielsen_art_wg_zu
        )
) AS b
WHERE
    art_matching_nielsen_per_kmo.mandant_id = b.mandant_id AND art_matching_nielsen_per_kmo.art_id = b.art_id AND
    art_matching_nielsen_per_kmo.kjwo_update = b.kjwo;


UPDATE dbp_etl.art_matching_nielsen_per_kmo SET
    kl_wg_id = b.owg_id FROM (
    SELECT *
    FROM dbp_data.wg_per
    WHERE
        dat_bis = DATE '9999-12-31'
        AND mandant_id > 1
        AND owg_id <> -1
) AS b
WHERE
    art_matching_nielsen_per_kmo.mandant_id = b.mandant_id AND art_matching_nielsen_per_kmo.kl_owg_id = b.wg_id AND
    art_matching_nielsen_per_kmo.art_id <> -1 AND art_matching_nielsen_per_kmo.kl_wg_id <> b.owg_id AND
    art_matching_nielsen_per_kmo.kjwo_update IN (
        SELECT MAX(kjwo_update) AS a1290333724
        FROM dbp_etl.art_matching_nielsen_per_kmo
    );


--art_id = -1


UPDATE dbp_etl.art_matching_nielsen_per_kmo SET
    kl_owg_id = b.wg_id,
    kl_uwg_id = b.wug_id FROM (
    SELECT *
    FROM dbp_data.art_nielsen_art_wg_zu
    WHERE
        art_id = -1
        AND kjwo IN (
            SELECT MAX(kjwo) AS a1886115246
            FROM dbp_data.art_nielsen_art_wg_zu
        )
) AS b
WHERE
    art_matching_nielsen_per_kmo.mandant_id = b.mandant_id AND art_matching_nielsen_per_kmo.art_nielsen_id = b.art_nielsen_id
    AND art_matching_nielsen_per_kmo.art_id = -1 AND art_matching_nielsen_per_kmo.kjwo_update = b.kjwo;


UPDATE dbp_etl.art_matching_nielsen_per_kmo SET
    kl_wg_id = b.owg_id FROM (
    SELECT *
    FROM dbp_data.wg_per
    WHERE
        dat_bis = DATE '9999-12-31'
        AND mandant_id > 1
        AND owg_id NOT IN (-1, -3)
) AS b
WHERE
    art_matching_nielsen_per_kmo.mandant_id = b.mandant_id AND art_matching_nielsen_per_kmo.kl_owg_id = b.wg_id AND
    art_matching_nielsen_per_kmo.art_id = -1 AND art_matching_nielsen_per_kmo.kl_wg_id <> b.owg_id AND
    art_matching_nielsen_per_kmo.kjwo_update IN (
        SELECT MAX(kjwo_update) AS a1290333724
        FROM dbp_etl.art_matching_nielsen_per_kmo
    );
