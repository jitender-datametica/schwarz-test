CREATE OR REPLACE TEMPORARY TABLE _art_nielsen AS
SELECT *
FROM dbp_data.art_nielsen_2
WHERE dat_bis = DATE '9999-12-31';


DELETE FROM dbp_data.sortiment_leistung_2
WHERE kl_owg_id NOT IN (
    SELECT wg_id
    FROM dbp_data.wg_filter_zu_2
    WHERE wg_filter_id = 11
) AND wg_id NOT IN (146, 147, 185, 186
);


DELETE FROM dbp_data.sortiment_leistung_2
WHERE
    art_id IS NULL AND umsatz_artikel = 0 AND absatz_artikel = 0 AND (umsatz_hr IS NULL OR umsatz_hr = 0) AND
    mandant_id = 1 AND kjwo_update IN (
        SELECT MAX(kjwo_update) AS kjwo_update
        FROM dbp_data.art_kl_preislage_zu_per_2
        WHERE mandant_id = 1
    ) AND wg_id NOT IN (146, 147, 185, 186
    ) AND gtin IS NOT NULL;


UPDATE dbp_data.sortiment_leistung_2 SET
    art_bez = b.art_gruppe_bez FROM (
    SELECT
        A.art_matching_id,
        MAX(C.art_gruppe_bez) AS art_gruppe_bez
    FROM dbp_etl.art_matching_nielsen_per_2 AS A
    INNER JOIN dbp_data.art_gruppe_art_zu_2 AS B ON A.art_id = B.art_id
    INNER JOIN dbp_data.art_gruppe_2 AS C ON B.art_gruppe_id = C.art_gruppe_id
    WHERE A.status_2 = 'G'
    GROUP BY A.art_matching_id
) AS b
WHERE
    sortiment_leistung.matching_id = b.art_matching_id AND sortiment_leistung.mandant_id = 1 AND sortiment_leistung.kjwo_update
    IN (
        SELECT MAX(kjwo_update) AS kjwo_update
        FROM dbp_data.art_kl_preislage_zu_per_2
        WHERE mandant_id = 1
    );


DELETE FROM dbp_data.sortiment_leistung_2
WHERE art_id IN (
    SELECT art_id
    FROM dbp_data.sortiment_leistung_2
    WHERE
        art_id IS NOT NULL
        AND mandant_id = 1
        AND kjwo_update IN (
            SELECT MAX(kjwo_update) AS kjwo_update
            FROM dbp_data.art_kl_preislage_zu_per_2
            WHERE mandant_id = 1
        )
    GROUP BY art_id
    HAVING COUNT(*) > 1) AND mandant_id = 1 AND kjwo_update IN (
    SELECT MAX(kjwo_update) AS kjwo_update
    FROM dbp_data.art_kl_preislage_zu_per_2
    WHERE mandant_id = 1
) AND wg_id NOT IN (146, 147, 185, 186
) AND gtin IS NOT NULL;


DELETE FROM dbp_data.sortiment_leistung_2
WHERE matching_id IN (
    SELECT matching_id
    FROM dbp_data.sortiment_leistung_2
    WHERE
        mandant_id = 1
        AND kjwo_update IN (
            SELECT MAX(kjwo_update) AS kjwo_update
            FROM dbp_data.art_kl_preislage_zu_per_2
            WHERE mandant_id = 1
        )
    GROUP BY matching_id
    HAVING COUNT(*) > 1) AND mandant_id = 1 AND kjwo_update IN (
    SELECT MAX(kjwo_update) AS kjwo_update
    FROM dbp_data.art_kl_preislage_zu_per_2
    WHERE mandant_id = 1
) AND wg_id NOT IN (146, 147, 185, 186
) AND gtin IS NOT NULL;


CREATE OR REPLACE TEMPORARY TABLE _dups_2 AS
SELECT
    mandant_id,
    kjwo_update,
    matching_id,
    COUNT(*) AS anz
FROM dbp_data.sortiment_leistung_2
WHERE
    mandant_id = 1
    AND kjwo_update IN (
        SELECT MAX(kjwo_update) AS kjwo_update
        FROM dbp_data.art_kl_preislage_zu_per_2
        WHERE mandant_id = 1
    )
GROUP BY
    mandant_id,
    matching_id,
    kjwo_update
HAVING anz > 1;


DELETE FROM dbp_data.sortiment_leistung_2
WHERE (
    mandant_id, kjwo_update, matching_id) IN (
    SELECT (mandant_id, kjwo_update, matching_id)
    FROM `_dups_2`
) AND art_id IS NULL AND mandant_id = 1;


CREATE OR REPLACE TEMPORARY TABLE _dups1 AS
SELECT
    mandant_id,
    kjwo_update,
    matching_id,
    COUNT(*) AS anz
FROM dbp_data.sortiment_leistung_2
WHERE
    mandant_id = 1
    AND kjwo_update IN (
        SELECT MAX(kjwo_update) AS kjwo_update
        FROM dbp_data.art_kl_preislage_zu_per_2
        WHERE mandant_id = 1
    )
GROUP BY
    mandant_id,
    matching_id,
    kjwo_update
HAVING anz > 1;


DELETE FROM dbp_data.sortiment_leistung_2
WHERE (
    mandant_id, kjwo_update, matching_id) IN (
    SELECT (mandant_id, kjwo_update, matching_id)
    FROM `_dups1`
) AND mandant_id = 1;


CREATE OR REPLACE TEMPORARY TABLE _summary_potentials AS
SELECT
    mandant_id,
    kjwo_update,
    matching_id,
    gtin
FROM dbp_data.sortiment_leistung_2
WHERE
    mandant_id = 1
    AND kjwo_update IN (
        SELECT MAX(kjwo_update) AS kjwo_update
        FROM dbp_data.art_kl_preislage_zu_per_2
        WHERE mandant_id = 1
    )
    AND art_id IS NULL
    AND CAST(gtin AS INTEGER) NOT IN (-9999, -9998)
GROUP BY
    mandant_id,
    kjwo_update,
    matching_id,
    gtin;


CREATE OR REPLACE TEMPORARY TABLE _summary_kl AS
SELECT
    A.mandant_id,
    A.kjwo_update,
    A.matching_id,
    B.gtin_id
FROM dbp_data.sortiment_leistung_2 AS A
INNER JOIN dbp_etl.art_matching_nielsen_per_2 AS B ON A.mandant_id = B.mandant_id AND A.matching_id = B.art_matching_id

WHERE
    A.mandant_id = 1
    AND A.kjwo_update IN (
        SELECT MAX(kjwo_update) AS kjwo_update
        FROM dbp_data.art_kl_preislage_zu_per_2
        WHERE mandant_id = 1
    )
    AND A.art_id IS NOT NULL
GROUP BY
    A.mandant_id,
    A.kjwo_update,
    A.matching_id,
    B.gtin_id;


DELETE FROM dbp_data.sortiment_leistung_2
WHERE (
    mandant_id, kjwo_update, matching_id, gtin) IN (
    SELECT (mandant_id, kjwo_update, matching_id, gtin)
    FROM `_summary_potentials`
    WHERE (mandant_id, kjwo_update, ROUND(
        CAST(gtin AS BIGNUMERIC), 0)) IN (SELECT (mandant_id, kjwo_update, CAST(gtin_id AS BIGNUMERIC)
    )
    FROM `_summary_kl`)
) AND wg_id NOT IN (146, 147, 185, 186
);


CREATE OR REPLACE TEMPORARY TABLE _summary_potentials_1 AS
SELECT
    A.mandant_id,
    A.art_nielsen_id,
    B.gtin_id
FROM dbp_data.art_nielsen_wug_zu_pflege_2 AS A
INNER JOIN `_art_nielsen` AS B ON A.mandant_id = B.mandant_id AND A.art_nielsen_id = B.art_nielsen_id
WHERE
    A.mandant_id = 1
    AND B.gtin_id NOT IN (-9999, -9998)
GROUP BY
    A.mandant_id,
    A.art_nielsen_id,
    B.gtin_id;


CREATE OR REPLACE TEMPORARY TABLE _summary_kl_1 AS
SELECT
    A.mandant_id,
    A.kjwo_update,
    A.matching_id,
    B.gtin_id
FROM dbp_data.sortiment_leistung_2 AS A
INNER JOIN dbp_etl.art_matching_nielsen_per_2 AS B ON A.mandant_id = B.mandant_id AND A.matching_id = B.art_matching_id

WHERE
    A.mandant_id = 1
    AND A.kjwo_update IN (
        SELECT MAX(kjwo_update) AS kjwo_update
        FROM dbp_data.art_kl_preislage_zu_per_2
        WHERE mandant_id = 1
    )
    AND A.art_id IS NOT NULL
GROUP BY
    A.mandant_id,
    A.kjwo_update,
    A.matching_id,
    B.gtin_id;


DELETE FROM dbp_data.art_nielsen_wug_zu_pflege_2
WHERE (
    mandant_id, art_nielsen_id) IN (
    SELECT (mandant_id, art_nielsen_id)
    FROM `_summary_potentials_1`
    WHERE (
        mandant_id, gtin_id) IN (
        SELECT (mandant_id, gtin_id)
        FROM `_summary_kl_1`
    )
) AND fb_pflege_wg_id NOT IN (146, 147, 185, 186
);


DELETE FROM dbp_data.sortiment_leistung_2
WHERE mandant_id = 1 AND kjwo_update IN (
    SELECT MAX(kjwo_update) AS a1290333724
    FROM dbp_data.art_kl_preislage_zu_per_2
    WHERE mandant_id = 1) AND (mandant_id, art_id) IN (
    SELECT (mandant_id, art_id)
    FROM dbp_data.art_gp_zu_per_2
    WHERE
        mandant_id = 1
        AND gp_id = 5059720
        AND dat_bis = PARSE_DATE('%F', '9999-12-31')
);


CREATE OR REPLACE TEMPORARY TABLE _upd_rank AS
SELECT
    matching_id,
    kl_owg_id,
    rang_umsatz_uwg,
    rang_absatz_uwg,
    ROW_NUMBER() OVER (PARTITION BY kl_owg_id ORDER BY rang_umsatz_uwg IS NULL, rang_umsatz_uwg) AS rang_umsatz_uwg_,
    ROW_NUMBER() OVER (PARTITION BY kl_owg_id ORDER BY rang_absatz_uwg IS NULL, rang_absatz_uwg) AS rang_absatz_uwg_
FROM dbp_data.sortiment_leistung_2
WHERE kjwo_update IN (
    SELECT MAX(kjwo_update) AS a1290333724
    FROM dbp_data.art_kl_preislage_zu_per_2
    WHERE mandant_id = 1
)
AND mandant_id = 1;


UPDATE dbp_data.sortiment_leistung_2 SET
    rang_umsatz_uwg = b.rang_umsatz_uwg_,
    rang_absatz_uwg = b.rang_absatz_uwg_
FROM `_upd_rank` AS b
WHERE sortiment_leistung.kjwo_update IN (
    SELECT MAX(kjwo_update) AS a1290333724
    FROM dbp_data.art_kl_preislage_zu_per_2
    WHERE mandant_id = 1
) AND sortiment_leistung.mandant_id = 1 AND sortiment_leistung.matching_id = b.matching_id AND
sortiment_leistung.rang_umsatz_uwg = b.rang_umsatz_uwg AND sortiment_leistung.rang_absatz_uwg = b.rang_absatz_uwg;


CREATE OR REPLACE TEMPORARY TABLE _upd_rank_wg AS
SELECT
    matching_id,
    kl_wg_id,
    rang_umsatz_wg,
    ROW_NUMBER() OVER (PARTITION BY kl_wg_id ORDER BY rang_umsatz_wg IS NULL, rang_umsatz_wg) AS rang_umsatz_wg_
FROM dbp_data.sortiment_leistung_2
WHERE kjwo_update IN (
    SELECT MAX(kjwo_update) AS a1290333724
    FROM dbp_data.art_kl_preislage_zu_per_2
    WHERE mandant_id = 1
)
AND mandant_id = 1;


UPDATE dbp_data.sortiment_leistung_2 SET
    rang_umsatz_wg = b.rang_umsatz_wg_
FROM `_upd_rank_wg` AS b
WHERE sortiment_leistung.kjwo_update IN (
    SELECT MAX(kjwo_update) AS a1290333724
    FROM dbp_data.art_kl_preislage_zu_per_2
    WHERE mandant_id = 1
) AND sortiment_leistung.mandant_id = 1 AND sortiment_leistung.matching_id = b.matching_id AND
sortiment_leistung.rang_umsatz_wg = b.rang_umsatz_wg;


CREATE OR REPLACE TEMPORARY TABLE _artikel_anteil_uwg_ranking_1st_base AS
SELECT
    A.mandant_id,
    MAX(B.art_nielsen_id) AS art_nielsen_id,
    c.art_matching_id,
    c.kl_wg_id,
    c.kl_owg_id,
    c.kl_uwg_id,
    B.gtin_id,
    c.art_id,
    COUNT(DISTINCT x.kjwo) AS anz,
    SUM(A.distr_gew) / COUNT(DISTINCT x.kjwo) AS distr_gew_,
    SUM(A.menge) AS menge_,
    SUM(A.umsatz_brutto) AS umsatz_,
    SUM(A.menge_af) AS menge_af_,
    SUM(A.umsatz_brutto_af) AS umsatz_af_,
    SUM(A.menge_sa) AS menge_sa_,
    SUM(A.umsatz_brutto_sa) AS umsatz_sa_,
    SUM(0) AS umsatz_anteil_kum_uwg,
    DENSE_RANK()
        OVER (PARTITION BY c.kl_owg_id ORDER BY SUM(A.umsatz_brutto) IS NULL DESC, SUM(A.umsatz_brutto) DESC) AS
    rang_umsatz_uwg,
    DENSE_RANK() OVER (PARTITION BY c.kl_owg_id ORDER BY SUM(A.menge) IS NULL DESC, SUM(A.menge) DESC) AS rang_absatz_uwg,
    0 AS rang_umsatz_wg
FROM dbp_data.art_nielsen_fakten_kjwo_2 AS A
INNER JOIN (SELECT
    kjwo,
    MIN(kjmo) AS kjmo
FROM dbp_data.tag_2
GROUP BY kjwo) AS x ON A.kjwo = x.kjwo
INNER JOIN `_art_nielsen` AS B ON A.mandant_id = B.mandant_id AND A.art_nielsen_id = B.art_nielsen_id
INNER JOIN (
    SELECT
        mandant_id,
        art_nielsen_id,
        art_matching_id,
        art_id,
        kl_wg_id,
        kl_owg_id,
        kl_uwg_id
    FROM dbp_etl.art_matching_nielsen_per_2
    WHERE kl_owg_id <> -3
    GROUP BY
        mandant_id,
        art_nielsen_id,
        art_matching_id,
        art_id,
        kl_wg_id,
        kl_owg_id,
        kl_uwg_id
) AS c ON B.art_nielsen_id = c.art_nielsen_id AND B.mandant_id = c.mandant_id
INNER JOIN dbp_data.nielsen_market_2 AS D ON A.mandant_id = D.mandant_id AND A.nielsen_market_id = D.nielsen_market_id

INNER JOIN (
    SELECT *
    FROM dbp_data.sortiment_leistung_2 AS ZZ
    WHERE kjwo_update IN (
        SELECT MAX(kjwo_update) AS kjwo_update
        FROM dbp_data.art_kl_preislage_zu_per_2
        WHERE mandant_id = 1
    )
) AS t6
    ON A.mandant_id = t6.mandant_id AND c.art_matching_id = t6.matching_id
WHERE
    A.kjwo IN (
        SELECT kjwo
        FROM dbp_data.art_nielsen_fakten_kjwo_2
        WHERE mandant_id = 1
        GROUP BY kjwo
        QUALIFY ((RANK() OVER (ORDER BY kjwo IS NULL DESC, kjwo DESC)) * -1) BETWEEN -52 AND (-1)
    )
    AND D.nielsen_market_cluster_id = 2
    AND A.mandant_id = 1
    AND B.gtin_id NOT IN (-9999, -9998)
GROUP BY
    A.mandant_id,
    c.art_matching_id,
    c.kl_wg_id,
    c.kl_owg_id,
    c.kl_uwg_id,
    B.gtin_id,
    c.art_id;


INSERT INTO `_artikel_anteil_uwg_ranking_1st_base`
(
    SELECT
        mandant_id,
        art_nielsen_id,
        art_matching_id,
        kl_wg_id,
        kl_owg_id,
        kl_uwg_id,
        gtin_id,
        art_id,
        COUNT(DISTINCT kjwo) AS anz,
        SUM(distr_gew) / COUNT(DISTINCT kjwo) AS distr_gew_,
        SUM(menge) AS menge_,
        SUM(umsatz_brutto) AS umsatz_,
        SUM(menge_af) AS menge_af_,
        SUM(umsatz_brutto_af) AS umsatz_af_,
        SUM(menge_sa) AS menge_sa_,
        SUM(umsatz_brutto_sa) AS umsatz_sa_,
        SUM(`A118619`) AS umsatz_anteil_kum_uwg,
        DENSE_RANK()
            OVER (PARTITION BY kl_owg_id ORDER BY SUM(umsatz_brutto) IS NULL DESC, SUM(umsatz_brutto) DESC) AS
        rang_umsatz_uwg,
        DENSE_RANK() OVER (PARTITION BY kl_owg_id ORDER BY SUM(menge) IS NULL DESC, SUM(menge) DESC) AS rang_absatz_uwg,
        0 AS rang_umsatz_wg
    FROM (SELECT
        mandant_id,
        art_nielsen_id,
        art_matching_id,
        kl_wg_id,
        kl_owg_id,
        kl_uwg_id,
        gtin_id,
        art_id,
        kjwo,
        distr_gew,
        menge,
        umsatz_brutto,
        menge_af,
        umsatz_brutto_af,
        menge_sa,
        umsatz_brutto_sa,
        0 AS `A118619`
    FROM (
        SELECT
            A.mandant_id,
            A.art_nielsen_id,
            t2.art_matching_id,
            t2.kl_wg_id,
            t2.kl_owg_id,
            t2.kl_uwg_id,
            B.gtin_id,
            t2.art_id,
            A.kjwo,
            A.distr_gew,
            A.menge,
            A.umsatz_brutto,
            A.menge_af,
            A.umsatz_brutto_af,
            A.menge_sa,
            A.umsatz_brutto_sa,
            A.nielsen_market_id,
            D.nielsen_market_cluster_id
        FROM dbp_data.art_nielsen_fakten_kjwo_2 AS A
        INNER JOIN (SELECT
            kjwo,
            MIN(kjmo) AS kjmo
        FROM dbp_data.tag_2
        GROUP BY kjwo) AS x ON A.kjwo = x.kjwo
        INNER JOIN `_art_nielsen` AS B ON A.mandant_id = B.mandant_id AND A.art_nielsen_id = B.art_nielsen_id
        INNER JOIN (
            SELECT
                mandant_id,
                art_matching_id,
                art_nielsen_id,
                art_id,
                kl_wg_id,
                kl_owg_id,
                kl_uwg_id
            FROM dbp_etl.art_matching_nielsen_per_2
            WHERE kl_owg_id <> -3
            GROUP BY
                mandant_id,
                art_matching_id,
                art_id,
                art_nielsen_id,
                kl_wg_id,
                kl_owg_id,
                kl_uwg_id
        ) AS t2 ON B.art_nielsen_id = t2.art_nielsen_id AND B.mandant_id = t2.mandant_id
        INNER JOIN dbp_data.nielsen_market_2 AS D
            ON
                A.mandant_id = D.mandant_id AND A.nielsen_market_id = D.nielsen_market_id
        INNER JOIN (
            SELECT *
            FROM dbp_data.sortiment_leistung_2 AS ZZ
            WHERE kjwo_update IN (
                SELECT MAX(kjwo_update) AS kjwo_update
                FROM dbp_data.art_kl_preislage_zu_per_2
                WHERE mandant_id = 1
            )
        ) AS t5
            ON TRUE
        WHERE
            A.mandant_id = t5.mandant_id
            AND t2.art_matching_id = t5.matching_id
    ) AS t6
    WHERE t6.kjwo IN (
        SELECT kjwo
        FROM dbp_data.art_nielsen_fakten_kjwo_2
        WHERE mandant_id = 1
        GROUP BY kjwo
        QUALIFY ((RANK() OVER (ORDER BY kjwo IS NULL DESC, kjwo DESC)) * -1) BETWEEN -52 AND (-1)
    )
    AND t6.nielsen_market_cluster_id = 2
    AND t6.gtin_id IN (-9999, -9998)
    AND t6.mandant_id = 1) AS t13
    GROUP BY
        mandant_id,
        art_nielsen_id,
        art_matching_id,
        kl_wg_id,
        kl_owg_id,
        kl_uwg_id,
        gtin_id,
        art_id
);


CREATE OR REPLACE TEMPORARY TABLE _artikel_anteil_uwg_ranking AS
SELECT
    mandant_id,
    art_matching_id,
    kl_wg_id,
    kl_owg_id,
    kl_uwg_id,
    MAX(anz) AS anz,
    SUM(distr_gew_) AS distr_gew_,
    SUM(menge_) AS menge__,
    SUM(umsatz_) AS umsatz__,
    SUM(menge_af_) AS menge_af_,
    SUM(umsatz_af_) AS umsatz_af_,
    SUM(menge_sa_) AS menge_sa_,
    SUM(umsatz_sa_) AS umsatz_sa_,
    SUM(CAST(0 AS NUMERIC)) AS umsatz_anteil_kum_uwg,
    DENSE_RANK() OVER (PARTITION BY kl_owg_id ORDER BY SUM(umsatz_) IS NULL DESC, SUM(umsatz_) DESC) AS rang_umsatz_uwg,
    DENSE_RANK() OVER (PARTITION BY kl_owg_id ORDER BY SUM(menge_) IS NULL DESC, SUM(menge_) DESC) AS rang_absatz_uwg,
    0 AS rang_umsatz_wg
FROM `_artikel_anteil_uwg_ranking_1st_base` AS A
GROUP BY
    mandant_id,
    art_matching_id,
    kl_wg_id,
    kl_owg_id,
    kl_uwg_id;


CREATE OR REPLACE TEMPORARY TABLE _murks_2 AS
SELECT
    mandant_id,
    matching_id,
    gtin,
    kjwo_update,
    umsatz_artikel,
    kl_wg_id,
    kl_owg_id,
    kl_uwg_id,
    rang_umsatz_wg,
    rang_umsatz_uwg,
    CAST(0 AS NUMERIC) AS umsatz_gesamt,
    CAST(0 AS NUMERIC) AS umsatz_anteil_uwg,
    CAST(100 AS NUMERIC) AS umsatz_anteil_kum_uwg
FROM dbp_data.sortiment_leistung_2
WHERE kjwo_update IN (
    SELECT MAX(kjwo_update) AS kjwo_update
    FROM dbp_data.art_kl_preislage_zu_per_2
    WHERE mandant_id = 1
)
AND mandant_id = 1
AND gtin IS NOT NULL;


CREATE OR REPLACE TEMPORARY TABLE _gesamt_uwg AS
SELECT
    kl_owg_id,
    kl_uwg_id,
    SUM(umsatz__) AS umsatz
FROM `_artikel_anteil_uwg_ranking`
GROUP BY
    kl_owg_id,
    kl_uwg_id;


UPDATE `_murks_2` SET
    umsatz_gesamt = b.umsatz,
    umsatz_anteil_uwg = CAST(ROUND(
        CAST(`_murks_2`.umsatz_artikel AS FLOAT64) / IF(CAST(b.umsatz AS FLOAT64) = 0, NULL, CAST(b.umsatz AS FLOAT64)
        ) * 100.00, 16
    ) AS NUMERIC)
FROM (
    SELECT *
    FROM `_gesamt_uwg`
    GROUP BY
        kl_owg_id,
        kl_uwg_id,
        umsatz
) AS b
WHERE `_murks_2`.kl_uwg_id = b.kl_uwg_id AND `_murks_2`.kl_owg_id = b.kl_owg_id;


UPDATE `_artikel_anteil_uwg_ranking` SET
    umsatz_anteil_kum_uwg = CAST(ROUND(CAST(
        `_artikel_anteil_uwg_ranking`.umsatz__ AS FLOAT64) / IF(
        CAST(b.umsatz AS FLOAT64) =
        0, NULL, CAST(b.umsatz AS FLOAT64)
    ) * 100.00, 5) AS NUMERIC)
FROM (
    SELECT *
    FROM `_gesamt_uwg`
    GROUP BY
        kl_owg_id,
        kl_uwg_id,
        umsatz
) AS b
WHERE `_artikel_anteil_uwg_ranking`.kl_uwg_id = b.kl_uwg_id AND `_artikel_anteil_uwg_ranking`.kl_owg_id = b.kl_owg_id;


UPDATE `_murks_2` SET
    umsatz_anteil_kum_uwg = b.umsatz_anteil_kum FROM (SELECT
    art_matching_id,
    kl_owg_id,
    kl_uwg_id,
    SUM(umsatz_anteil_kum_uwg) OVER (
        PARTITION BY kl_owg_id, kl_uwg_id ORDER BY rang_umsatz_uwg IS NULL, rang_umsatz_uwg
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS umsatz_anteil_kum
FROM `_artikel_anteil_uwg_ranking`) AS b
WHERE `_murks_2`.matching_id = b.art_matching_id AND `_murks_2`.kl_uwg_id = b.kl_uwg_id AND `_murks_2`.kl_owg_id = b.kl_owg_id;


UPDATE dbp_data.sortiment_leistung_2 SET
    umsatz_anteil_uwg = b.umsatz_anteil_uwg,
    umsatz_anteil_uwg_kumuliert = b.umsatz_anteil_kum_uwg FROM (
    SELECT
        mandant_id,
        matching_id,
        kjwo_update,
        MAX(umsatz_anteil_uwg) AS umsatz_anteil_uwg,
        MAX(umsatz_anteil_kum_uwg) AS umsatz_anteil_kum_uwg
    FROM `_murks_2`
    GROUP BY
        mandant_id,
        matching_id,
        kjwo_update
) AS b
WHERE
    sortiment_leistung.mandant_id = b.mandant_id AND sortiment_leistung.kjwo_update = b.kjwo_update AND
    sortiment_leistung.matching_id = b.matching_id;


UPDATE dbp_data.sortiment_leistung_2 SET
    ost_basis = 'X'
WHERE mandant_id = 1 AND ARRAY_LENGTH(REGEXP_EXTRACT_ALL(ost_basis, '^[0-9]+$')) > 0;


UPDATE dbp_data.sortiment_leistung_2 SET
    ost_gross = 'X'
WHERE mandant_id = 1 AND ARRAY_LENGTH(REGEXP_EXTRACT_ALL(ost_gross, '^[0-9]+$')) > 0;


UPDATE dbp_data.sortiment_leistung_2 SET
    sued_west = 'X'
WHERE mandant_id = 1 AND ARRAY_LENGTH(REGEXP_EXTRACT_ALL(sued_west, '^[0-9]+$')) > 0;


UPDATE dbp_data.sortiment_leistung_2 SET
    sued_ost = 'X'
WHERE mandant_id = 1 AND ARRAY_LENGTH(REGEXP_EXTRACT_ALL(sued_ost, '^[0-9]+$')) > 0;


UPDATE dbp_data.sortiment_leistung_2 SET
    west = 'X'
WHERE mandant_id = 1 AND ARRAY_LENGTH(REGEXP_EXTRACT_ALL(west, '^[0-9]+$')) > 0;


UPDATE dbp_data.sortiment_leistung_2 SET
    nord = 'X'
WHERE mandant_id = 1 AND ARRAY_LENGTH(REGEXP_EXTRACT_ALL(nord, '^[0-9]+$')) > 0;


UPDATE dbp_data.sortiment_leistung_2 SET
    bonreichweite_af = 0,
    bonreichweite_sa = 0,
    cherrypicker_quote = 0,
    restbon = 0
WHERE mandant_id = 1 AND (absatz_total IS NULL OR absatz_total = 0) AND restbon <> 0 AND art_id IS NOT NULL;


DELETE FROM dbp_etl.not_listed_basis_2
WHERE art_matching_id IN (
    SELECT A.art_matching_id
    FROM dbp_etl.not_listed_basis_2 AS A
    INNER JOIN (SELECT
        art_id,
        MIN(list_kz) AS list_kz
    FROM dbp_etl.art_matching_nielsen_per_2
    GROUP BY art_id) AS b ON A.art_id = b.art_id
    WHERE b.list_kz = 'A'
);


DELETE FROM dbp_etl.not_listed_basis_2
WHERE art_id IN (
    SELECT art_id
    FROM dbp_data.sortiment_leistung_2
    WHERE kjwo_update IN (
        SELECT MAX(kjwo_update) AS a1290333724
        FROM dbp_data.art_kl_preislage_zu_per_2
        WHERE mandant_id = 1
    )
    AND mandant_id = 1
    AND (listung_sst_mvke <> 'N/A' OR (listung_sst_mvke IS NULL OR listung_sst_mvke = 'N/A') AND GREATEST(COALESCE(
        ost_basis,
        ''), COALESCE(ost_gross, ''), COALESCE(sued_ost, ''), COALESCE(sued_west, ''), COALESCE(west, ''), COALESCE(
        nord,
        ''
    )) = 'X')
    AND art_id IS NOT NULL
    AND gtin IS NOT NULL
);


UPDATE dbp_data.sortiment_leistung_2 SET
    listungsaktion = 'Keine Veränderung'
WHERE mandant_id = 1 AND kjwo_update IN (
    SELECT MAX(kjwo_update) AS a1290333724
    FROM dbp_data.art_kl_preislage_zu_per_2
    WHERE mandant_id = 1
) AND CAST(gtin AS INTEGER
) IN (-9999, -9998
);


CREATE OR REPLACE TEMPORARY TABLE _art_bez1 AS
SELECT
    c.status_2,
    A.mandant_id,
    A.kjwo_update,
    A.matching_id,
    CAST(A.art_bez AS STRING) AS art_bez_alt,
    CAST(B.art_bez AS STRING) AS art_bez_neu
FROM dbp_data.sortiment_leistung_2 AS A
INNER JOIN dbp_data.art_spr_zu_2 AS B
    ON
        A.mandant_id = B.mandant_id AND A.art_id = B.art_id AND B.spr_id
        = 22
INNER JOIN (
    SELECT
        art_matching_id,
        status_2
    FROM dbp_etl.art_matching_nielsen_per_2
    GROUP BY
        art_matching_id,
        status_2
) AS c ON A.matching_id = c.art_matching_id
WHERE
    (A.art_bez <> B.art_bez OR A.art_bez IS NULL AND B.art_bez IS NOT NULL)
    AND A.mandant_id = 1
    AND A.kjwo_update IN (
        SELECT MAX(kjwo_update) AS a1290333724
        FROM dbp_data.art_kl_preislage_zu_per_2
        WHERE mandant_id = 1
    )
    AND c.status_2 <> 'G';


INSERT INTO `_art_bez1` (status_2, mandant_id, kjwo_update, matching_id, art_bez_alt, art_bez_neu)
(
    SELECT
        'G' AS status_2,
        A.mandant_id,
        A.kjwo_update,
        A.matching_id,
        A.art_bez AS art_bez_alt,
        c.art_gruppe_bez AS art_bez_neu
    FROM dbp_data.sortiment_leistung_2 AS A
    INNER JOIN (
        SELECT
            A0.art_matching_id,
            MAX(C.art_gruppe_bez) AS art_gruppe_bez
        FROM dbp_etl.art_matching_nielsen_per_2 AS A0
        INNER JOIN dbp_data.art_gruppe_art_zu_2 AS B ON A0.art_id = B.art_id
        INNER JOIN dbp_data.art_gruppe_2 AS C ON B.art_gruppe_id = C.art_gruppe_id
        WHERE A0.status_2 = 'G'
        GROUP BY A0.art_matching_id
    ) AS c ON A.matching_id = c.art_matching_id
    WHERE
        (A.art_bez <> c.art_gruppe_bez OR A.art_bez IS NULL AND c.art_gruppe_bez IS NOT NULL)
        AND A.mandant_id = 1
        AND A.kjwo_update IN (
            SELECT MAX(kjwo_update) AS a1290333724
            FROM dbp_data.art_kl_preislage_zu_per_2
            WHERE mandant_id = 1
        )
);


UPDATE dbp_data.sortiment_leistung_2 SET
    art_bez = b.art_bez_neu FROM (
    SELECT
        mandant_id,
        kjwo_update,
        matching_id,
        MAX(art_bez_alt) AS art_bez_alt,
        MAX(art_bez_neu) AS art_bez_neu
    FROM `_art_bez1`
    GROUP BY
        mandant_id,
        kjwo_update,
        matching_id
) AS b
WHERE
    sortiment_leistung.matching_id = b.matching_id AND sortiment_leistung.mandant_id = 1 AND sortiment_leistung.kjwo_update
    = b.kjwo_update AND COALESCE(sortiment_leistung.art_bez, 'murks') = COALESCE(b.art_bez_alt, 'murks');
