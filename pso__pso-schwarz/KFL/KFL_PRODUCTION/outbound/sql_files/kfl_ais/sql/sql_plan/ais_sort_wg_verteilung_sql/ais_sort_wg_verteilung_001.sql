CREATE OR REPLACE TEMPORARY TABLE _art_nielsen AS
SELECT *
FROM dbp_data.art_nielsen
WHERE dat_bis = DATE '9999-12-31';


CREATE OR REPLACE TEMPORARY TABLE _wg_verteilung_base1 AS
SELECT
    A.mandant_id,
    B.art_nielsen_id,
    c.kl_wg_id,
    c.kl_owg_id,
    c.kl_uwg_id,
    B.gtin_id,
    SUM(A.umsatz_brutto) AS umsatz_,
    SUM(CAST(
        SUM(A.umsatz_brutto) AS FLOAT64)) OVER (
        PARTITION BY c.kl_owg_id RANGE BETWEEN UNBOUNDED PRECEDING AND
        UNBOUNDED FOLLOWING
    ) AS umsatz_owg_,
    SUM(CAST(
        SUM(A.umsatz_brutto) AS FLOAT64)) OVER (
        PARTITION BY c.kl_owg_id, c.kl_uwg_id RANGE BETWEEN
        UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS umsatz_uwg_,
    COUNT(
        B.art_nielsen_id) OVER (PARTITION BY c.kl_owg_id RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS
    anz_artikel_owg_,
    COUNT(B.art_nielsen_id) OVER (
        PARTITION BY c.kl_owg_id, c.kl_uwg_id RANGE BETWEEN UNBOUNDED PRECEDING AND
        UNBOUNDED FOLLOWING
    ) AS anz_artikel_uwg_
FROM dbp_data.art_nielsen_fakten_kjwo AS A
INNER JOIN `_art_nielsen` AS B ON A.art_nielsen_id = B.art_nielsen_id AND A.mandant_id = B.mandant_id
INNER JOIN (
    SELECT
        mandant_id,
        art_nielsen_id,
        kl_wg_id,
        kl_owg_id,
        kl_uwg_id
    FROM dbp_etl.art_matching_nielsen_per AS A
    GROUP BY
        mandant_id,
        art_nielsen_id,
        kl_wg_id,
        kl_owg_id,
        kl_uwg_id
) AS c ON B.art_nielsen_id = c.art_nielsen_id AND B.mandant_id = c.mandant_id
INNER JOIN dbp_data.nielsen_market AS D ON A.mandant_id = D.mandant_id AND A.nielsen_market_id = D.nielsen_market_id

WHERE
    A.kjwo IN (
        SELECT kjwo
        FROM dbp_data.art_nielsen_fakten_kjwo
        WHERE mandant_id = 1
        GROUP BY kjwo
        QUALIFY ((RANK() OVER (ORDER BY kjwo IS NULL DESC, kjwo DESC)) * -1) BETWEEN -52 AND (-1)
    )
    AND D.nielsen_market_cluster_id = 2
    AND A.mandant_id = 1
GROUP BY
    A.mandant_id,
    B.art_nielsen_id,
    c.kl_wg_id,
    c.kl_owg_id,
    c.kl_uwg_id,
    B.gtin_id;


CREATE OR REPLACE TEMPORARY TABLE _wg_verteilung_gesamt_nielsen AS
SELECT
    A.mandant_id,
    D.nielsen_market_id,
    c.kl_wg_id,
    CAST(COUNT(DISTINCT B.art_nielsen_id) AS FLOAT64) AS anz_artikel_,
    SUM(CAST(A.umsatz_brutto AS FLOAT64)) AS umsatz_
FROM dbp_data.art_nielsen_fakten_kjwo AS A
INNER JOIN `_art_nielsen` AS B ON A.art_nielsen_id = B.art_nielsen_id AND A.mandant_id = B.mandant_id
INNER JOIN (
    SELECT
        mandant_id,
        art_nielsen_id,
        kl_wg_id,
        kl_owg_id,
        kl_uwg_id
    FROM dbp_etl.art_matching_nielsen_per
    WHERE kl_wg_id <> -3
    GROUP BY
        mandant_id,
        art_nielsen_id,
        kl_wg_id,
        kl_owg_id,
        kl_uwg_id
) AS c ON B.art_nielsen_id = c.art_nielsen_id AND B.mandant_id = c.mandant_id
INNER JOIN dbp_data.nielsen_market AS D ON A.mandant_id = D.mandant_id AND A.nielsen_market_id = D.nielsen_market_id

WHERE
    A.kjwo IN (
        SELECT kjwo
        FROM dbp_data.art_nielsen_fakten_kjwo
        WHERE mandant_id = 1
        GROUP BY kjwo
        QUALIFY ((RANK() OVER (ORDER BY kjwo IS NULL DESC, kjwo DESC)) * -1) BETWEEN -52 AND (-1)
    )
    AND D.nielsen_market_cluster_id = 2
    AND A.mandant_id = 1
GROUP BY
    A.mandant_id,
    D.nielsen_market_id,
    c.kl_wg_id;


CREATE OR REPLACE TEMPORARY TABLE _wg_verteilung_base2 AS
SELECT
    A.mandant_id,
    A.kl_wg_id,
    A.kl_owg_id,
    A.kl_uwg_id,
    MAX(A.umsatz_owg_) / MAX(B.umsatz_) AS umsatz_anteil_owg,
    MAX(A.umsatz_uwg_) / MAX(B.umsatz_) AS umsatz_anteil_uwg,
    MAX(CAST(A.anz_artikel_owg_ AS FLOAT64)) / MAX(B.anz_artikel_) AS artikel_anteil_owg,
    MAX(CAST(A.anz_artikel_uwg_ AS FLOAT64)) / MAX(B.anz_artikel_) AS artikel_anteil_uwg
FROM `_wg_verteilung_base1` AS A
INNER JOIN `_wg_verteilung_gesamt_nielsen` AS B ON A.kl_wg_id = B.kl_wg_id AND A.mandant_id = B.mandant_id
GROUP BY
    A.mandant_id,
    A.kl_wg_id,
    A.kl_owg_id,
    A.kl_uwg_id;


CREATE OR REPLACE TEMPORARY TABLE _wg_verteilung_kl_base1 AS
SELECT
    mandant_id,
    art_id,
    MAX(kl_wg_id) OVER (
        PARTITION BY art_matching_id ORDER BY kl_wg_id IS NULL, kl_wg_id RANGE BETWEEN UNBOUNDED PRECEDING
        AND CURRENT ROW
    ) AS kl_wg_id,
    MAX(kl_owg_id) OVER (
        PARTITION BY art_matching_id ORDER BY kl_owg_id IS NULL, kl_owg_id RANGE BETWEEN
        UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS kl_owg_id,
    MAX(kl_uwg_id) OVER (
        PARTITION BY art_matching_id ORDER BY kl_owg_id IS NULL, kl_owg_id, kl_uwg_id IS NULL, kl_uwg_id
        RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS kl_uwg_id
FROM dbp_etl.art_matching_nielsen_per
WHERE CAST(
    FLOOR(art_id / 100) AS INTEGER) IN (
    SELECT ROUND(CAST(art_nr AS BIGNUMERIC), 0) AS a254989150
    FROM dbp_etl.bf_sort_sal_export
    GROUP BY a254989150
    HAVING SUM(total_absatz) > 0
)
AND art_id <> -1;


CREATE OR REPLACE TEMPORARY TABLE _wg_verteilung_kl_base2 AS
SELECT
    1 AS mandant_id,
    b.art_id,
    b.kl_art_id,
    b.kl_wg_id,
    b.kl_owg_id,
    b.kl_uwg_id,
    SUM(A.af_re_mep_mt_wo + A.sa_re_mep) AS ertrag_,
    SUM(A.kassenumsatz) AS umsatz_,
    SUM(CAST(
        SUM(A.af_re_mep_mt_wo + A.sa_re_mep) AS FLOAT64)) OVER (
        PARTITION BY b.kl_owg_id RANGE BETWEEN
        UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS ertrag_owg_,
    SUM(CAST(
        SUM(A.af_re_mep_mt_wo + A.sa_re_mep) AS FLOAT64)) OVER (
        PARTITION BY b.kl_owg_id, b.kl_uwg_id RANGE BETWEEN
        UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS ertrag_uwg_,
    SUM(CAST(
        SUM(A.kassenumsatz) AS FLOAT64)) OVER (
        PARTITION BY b.kl_owg_id RANGE BETWEEN UNBOUNDED PRECEDING AND
        UNBOUNDED FOLLOWING
    ) AS umsatz_owg_,
    SUM(CAST(
        SUM(A.kassenumsatz) AS FLOAT64)) OVER (
        PARTITION BY b.kl_owg_id, b.kl_uwg_id RANGE BETWEEN UNBOUNDED PRECEDING
        AND UNBOUNDED FOLLOWING
    ) AS umsatz_uwg_,
    COUNT(
        b.art_id) OVER (PARTITION BY b.kl_owg_id RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS
    anz_artikel_owg_,
    COUNT(b.art_id) OVER (PARTITION BY b.kl_uwg_id RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
        AS
        anz_artikel_uwg_
FROM dbp_etl.bf_sort_sal_export AS A
INNER JOIN (
    SELECT
        mandant_id,
        CAST(FLOOR(art_id / 100) AS INTEGER) AS kl_art_id,
        art_id,
        kl_wg_id,
        kl_owg_id,
        kl_uwg_id
    FROM `_wg_verteilung_kl_base1`
    GROUP BY
        mandant_id,
        kl_art_id,
        art_id,
        kl_wg_id,
        kl_owg_id,
        kl_uwg_id
) AS b
    ON
        ROUND(CAST(A.art_nr AS BIGNUMERIC), 0
        ) = b.kl_art_id
GROUP BY
    mandant_id,
    b.art_id,
    b.kl_art_id,
    b.kl_wg_id,
    b.kl_owg_id,
    b.kl_uwg_id;


CREATE OR REPLACE TEMPORARY TABLE _wg_verteilung_kl_gesamt AS
SELECT
    1 AS mandant_id,
    b.kl_wg_id,
    SUM(A.af_re_mep_mt_wo + A.sa_re_mep) AS ertrag_,
    SUM(A.kassenumsatz) AS umsatz_,
    CAST(COUNT(DISTINCT b.art_id) AS FLOAT64) AS anz_artikel_
FROM dbp_etl.bf_sort_sal_export AS A
INNER JOIN (
    SELECT
        mandant_id,
        CAST(FLOOR(art_id / 100) AS INTEGER) AS kl_art_id,
        art_id,
        kl_wg_id,
        kl_owg_id,
        kl_uwg_id
    FROM `_wg_verteilung_kl_base1`
    GROUP BY
        mandant_id,
        kl_art_id,
        art_id,
        kl_wg_id,
        kl_owg_id,
        kl_uwg_id
) AS b
    ON
        ROUND(CAST(A.art_nr AS BIGNUMERIC), 0
        ) = b.kl_art_id
GROUP BY
    mandant_id,
    b.kl_wg_id;


CREATE OR REPLACE TEMPORARY TABLE _wg_verteilung_kl_base3 AS
SELECT
    A.mandant_id,
    A.kl_wg_id,
    A.kl_owg_id,
    A.kl_uwg_id,
    MAX(A.ertrag_owg_) / MAX(B.ertrag_) AS ertrag_anteil_owg,
    MAX(A.ertrag_uwg_) / MAX(B.ertrag_) AS ertrag_anteil_uwg,
    MAX(A.umsatz_owg_) / MAX(B.umsatz_) AS umsatz_anteil_owg,
    MAX(A.umsatz_uwg_) / MAX(B.umsatz_) AS umsatz_anteil_uwg,
    MAX(CAST(A.anz_artikel_owg_ AS FLOAT64)) / MAX(B.anz_artikel_) AS artikel_anteil_owg,
    MAX(CAST(A.anz_artikel_uwg_ AS FLOAT64)) / MAX(B.anz_artikel_) AS artikel_anteil_uwg
FROM `_wg_verteilung_kl_base2` AS A
INNER JOIN `_wg_verteilung_kl_gesamt` AS B ON A.kl_wg_id = B.kl_wg_id AND A.mandant_id = B.mandant_id
GROUP BY
    A.mandant_id,
    A.kl_wg_id,
    A.kl_owg_id,
    A.kl_uwg_id;


CREATE OR REPLACE TEMPORARY TABLE _wg_verteilung_final AS
SELECT
    x.kjmo,
    A.mandant_id,
    A.kl_wg_id,
    A.kl_owg_id,
    A.kl_uwg_id,
    A.umsatz_anteil_owg AS nielsen_umsatz_anteil_owg,
    A.umsatz_anteil_uwg AS nielsen_umsatz_anteil_uwg,
    A.artikel_anteil_owg AS nielsen_artikel_anteil_owg,
    A.artikel_anteil_uwg AS nielsen_artikel_anteil_uwg,
    COALESCE(b.umsatz_anteil_owg, 0) AS kl_umsatz_anteil_owg,
    COALESCE(c.umsatz_anteil_uwg, 0) AS kl_umsatz_anteil_uwg,
    COALESCE(b.artikel_anteil_owg, 0) AS kl_artikel_anteil_owg,
    COALESCE(c.artikel_anteil_uwg, 0) AS kl_artikel_anteil_uwg,
    COALESCE(b.ertrag_anteil_owg, 0) AS kl_ertrag_anteil_owg,
    COALESCE(c.ertrag_anteil_uwg, 0) AS kl_ertrag_anteil_uwg
FROM `_wg_verteilung_base2` AS A
LEFT JOIN (
    SELECT
        mandant_id,
        kl_owg_id,
        MAX(ertrag_anteil_owg) AS ertrag_anteil_owg,
        MAX(umsatz_anteil_owg) AS umsatz_anteil_owg,
        MAX(artikel_anteil_owg) AS artikel_anteil_owg
    FROM `_wg_verteilung_kl_base3`
    GROUP BY
        mandant_id,
        kl_owg_id
) AS b ON A.kl_owg_id = b.kl_owg_id AND A.mandant_id = b.mandant_id
LEFT JOIN (
    SELECT
        mandant_id,
        kl_owg_id,
        kl_uwg_id,
        MAX(ertrag_anteil_uwg) AS ertrag_anteil_uwg,
        MAX(umsatz_anteil_uwg) AS umsatz_anteil_uwg,
        MAX(artikel_anteil_uwg) AS artikel_anteil_uwg
    FROM `_wg_verteilung_kl_base3`
    GROUP BY
        mandant_id,
        kl_owg_id,
        kl_uwg_id
) AS c ON A.kl_uwg_id = c.kl_uwg_id AND A.kl_owg_id = c.kl_owg_id AND A.mandant_id = c.mandant_id
INNER JOIN (
    SELECT MIN(B.kjmo) AS kjmo
    FROM (
        SELECT MAX(kjwo) AS kjwo
        FROM dbp_data.art_nielsen_fakten_kjwo
        WHERE mandant_id = 1
    ) AS a
    INNER JOIN dbp_data.tag AS B ON a.kjwo = B.kjwo
) AS x
    ON A.kl_wg_id <> -1;


DELETE FROM dbp_data.sortiment_kl_wg_verteilung
WHERE kjmo IN (
    SELECT MIN(B.kjmo) AS kjmo
    FROM (
        SELECT MAX(kjwo) AS kjwo
        FROM dbp_data.art_nielsen_fakten_kjwo
        WHERE mandant_id = 1
    ) AS a
    INNER JOIN dbp_data.tag AS B ON a.kjwo = B.kjwo
) AND mandant_id = 1;


INSERT INTO dbp_data.sortiment_kl_wg_verteilung (
    mandant_id, kjmo, kl_uwg_id, kl_wg_id, kl_owg_id,
    nielsen_umsatz_anteil_owg, nielsen_umsatz_anteil_uwg, nielsen_artikel_anteil_owg, nielsen_artikel_anteil_uwg,
    kl_umsatz_anteil_owg, kl_umsatz_anteil_uwg, kl_artikel_anteil_owg, kl_artikel_anteil_uwg, kl_ertrag_anteil_owg,
    kl_ertrag_anteil_uwg
)
(SELECT
    mandant_id,
    kjmo,
    kl_uwg_id,
    kl_wg_id,
    kl_owg_id,
    ROUND(CAST(nielsen_umsatz_anteil_owg AS NUMERIC), 5) AS nielsen_umsatz_anteil_owg,
    ROUND(CAST(nielsen_umsatz_anteil_uwg AS NUMERIC), 5) AS nielsen_umsatz_anteil_uwg,
    ROUND(CAST(nielsen_artikel_anteil_owg AS NUMERIC), 5) AS nielsen_artikel_anteil_owg,
    ROUND(CAST(nielsen_artikel_anteil_uwg AS NUMERIC), 5) AS nielsen_artikel_anteil_uwg,
    ROUND(CAST(kl_umsatz_anteil_owg AS NUMERIC), 5) AS kl_umsatz_anteil_owg,
    ROUND(CAST(kl_umsatz_anteil_uwg AS NUMERIC), 5) AS kl_umsatz_anteil_uwg,
    ROUND(CAST(kl_artikel_anteil_owg AS NUMERIC), 5) AS kl_artikel_anteil_owg,
    ROUND(CAST(kl_artikel_anteil_uwg AS NUMERIC), 5) AS kl_artikel_anteil_uwg,
    ROUND(CAST(kl_ertrag_anteil_owg AS NUMERIC), 5) AS kl_ertrag_anteil_owg,
    ROUND(CAST(kl_ertrag_anteil_uwg AS NUMERIC), 5) AS kl_ertrag_anteil_uwg
FROM `_wg_verteilung_final`);


DELETE FROM dbp_data.sortiment_wg_verteilung
WHERE kjmo IN (
    SELECT MIN(B.kjmo) AS kjmo
    FROM (
        SELECT MAX(kjwo) AS kjwo
        FROM dbp_data.art_nielsen_fakten_kjwo
        WHERE mandant_id = 1
    ) AS a
    INNER JOIN dbp_data.tag AS B ON a.kjwo = B.kjwo
) AND mandant_id = 1;


INSERT INTO dbp_data.sortiment_wg_verteilung (
    mandant_id, kjmo, wg_id, wug_id, hwg_id, owg_id,
    nielsen_umsatz_anteil_owg, nielsen_umsatz_anteil_uwg, nielsen_artikel_anteil_owg, nielsen_artikel_anteil_uwg,
    kl_umsatz_anteil_owg, kl_umsatz_anteil_uwg, kl_artikel_anteil_owg, kl_artikel_anteil_uwg, kl_ertrag_anteil_owg,
    kl_ertrag_anteil_uwg
)
(SELECT
    mandant_id,
    kjmo,
    kl_owg_id AS wg_id,
    kl_uwg_id AS wug_id,
    0 AS hwg_id,
    kl_wg_id AS owg_id,
    ROUND(CAST(nielsen_umsatz_anteil_owg AS NUMERIC), 5) AS nielsen_umsatz_anteil_owg,
    ROUND(CAST(nielsen_umsatz_anteil_uwg AS NUMERIC), 5) AS nielsen_umsatz_anteil_uwg,
    ROUND(CAST(nielsen_artikel_anteil_owg AS NUMERIC), 5) AS nielsen_artikel_anteil_owg,
    ROUND(CAST(nielsen_artikel_anteil_uwg AS NUMERIC), 5) AS nielsen_artikel_anteil_uwg,
    ROUND(CAST(kl_umsatz_anteil_owg AS NUMERIC), 5) AS kl_umsatz_anteil_owg,
    ROUND(CAST(kl_umsatz_anteil_uwg AS NUMERIC), 5) AS kl_umsatz_anteil_uwg,
    ROUND(CAST(kl_artikel_anteil_owg AS NUMERIC), 5) AS kl_artikel_anteil_owg,
    ROUND(CAST(kl_artikel_anteil_uwg AS NUMERIC), 5) AS kl_artikel_anteil_uwg,
    ROUND(CAST(kl_ertrag_anteil_owg AS NUMERIC), 5) AS kl_ertrag_anteil_owg,
    ROUND(CAST(kl_ertrag_anteil_uwg AS NUMERIC), 5) AS kl_ertrag_anteil_uwg
FROM `_wg_verteilung_final`);
