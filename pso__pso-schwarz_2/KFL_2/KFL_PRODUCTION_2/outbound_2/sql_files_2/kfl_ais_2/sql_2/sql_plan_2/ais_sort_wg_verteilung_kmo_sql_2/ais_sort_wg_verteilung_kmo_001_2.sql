CREATE OR REPLACE TEMPORARY TABLE _art_nielsen AS
SELECT *
FROM dbp_data.art_nielsen_2
WHERE dat_bis = DATE '9999-12-31';


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


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
FROM dbp_data.art_nielsen_fakten_kjmo_2 AS A
INNER JOIN `_art_nielsen` AS B ON A.art_nielsen_id = B.art_nielsen_id AND A.mandant_id = B.mandant_id
INNER JOIN (
    SELECT
        mandant_id,
        art_nielsen_id,
        kl_wg_id,
        kl_owg_id,
        kl_uwg_id
    FROM dbp_etl.art_matching_nielsen_per_kmo_2 AS A
    GROUP BY
        mandant_id,
        art_nielsen_id,
        kl_wg_id,
        kl_owg_id,
        kl_uwg_id
) AS c ON B.art_nielsen_id = c.art_nielsen_id AND B.mandant_id = c.mandant_id
INNER JOIN dbp_data.nielsen_market_2 AS D ON A.mandant_id = D.mandant_id AND A.nielsen_market_id = D.nielsen_market_cluster_id

WHERE
    A.kjmo IN (
        SELECT kjmo
        FROM dbp_data.art_nielsen_fakten_kjmo_2
        WHERE mandant_id = ${mandant_id}
        GROUP BY kjmo
        QUALIFY ((RANK() OVER (ORDER BY kjmo IS NULL DESC, kjmo DESC)) * -1) BETWEEN -12 AND (-1)
    )
    AND D.nielsen_market_cluster_id = 1
    AND -- muss angepasst werden, wenn Wessam die Maerkte bzw. Custer hat!
    A.mandant_id = ${mandant_id}
GROUP BY
    A.mandant_id,
    B.art_nielsen_id,
    c.kl_wg_id,
    c.kl_owg_id,
    c.kl_uwg_id,
    B.gtin_id;


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


CREATE OR REPLACE TEMPORARY TABLE _wg_verteilung_gesamt_nielsen AS
SELECT
    A.mandant_id,
    D.nielsen_market_cluster_id,
    c.kl_wg_id,
    CAST(COUNT(DISTINCT B.art_nielsen_id) AS FLOAT64) AS anz_artikel_,
    SUM(CAST(A.umsatz_brutto AS FLOAT64)) AS umsatz_
FROM dbp_data.art_nielsen_fakten_kjmo_2 AS A
INNER JOIN `_art_nielsen` AS B ON A.art_nielsen_id = B.art_nielsen_id AND A.mandant_id = B.mandant_id
INNER JOIN (
    SELECT
        mandant_id,
        art_nielsen_id,
        kl_wg_id,
        kl_owg_id,
        kl_uwg_id
    FROM dbp_etl.art_matching_nielsen_per_kmo_2
    GROUP BY
        mandant_id,
        art_nielsen_id,
        kl_wg_id,
        kl_owg_id,
        kl_uwg_id
) AS c ON B.art_nielsen_id = c.art_nielsen_id AND B.mandant_id = c.mandant_id
INNER JOIN dbp_data.nielsen_market_2 AS D ON A.mandant_id = D.mandant_id AND A.nielsen_market_id = D.nielsen_market_cluster_id

WHERE
    A.kjmo IN (
        SELECT kjmo
        FROM dbp_data.art_nielsen_fakten_kjmo_2
        WHERE mandant_id = ${mandant_id}
        GROUP BY kjmo
        QUALIFY ((RANK() OVER (ORDER BY kjmo IS NULL DESC, kjmo DESC)) * -1) BETWEEN -12 AND (-1)
    )
    AND D.nielsen_market_cluster_id = 1
    AND -- muss angepasst werden, wenn Wessam die Maerkte bzw. Custer hat!
    A.mandant_id = ${mandant_id}
GROUP BY
    A.mandant_id,
    D.nielsen_market_cluster_id,
    c.kl_wg_id;


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


CREATE OR REPLACE TEMPORARY TABLE _wg_verteilung_base2 AS
SELECT
    A.mandant_id,
    A.kl_wg_id,
    A.kl_owg_id,
    A.kl_uwg_id,
    IFNULL(MAX(A.umsatz_owg_) / IF(MAX(B.umsatz_) = 0, NULL, MAX(B.umsatz_)), 0) AS umsatz_anteil_owg,
    IFNULL(MAX(A.umsatz_uwg_) / IF(MAX(B.umsatz_) = 0, NULL, MAX(B.umsatz_)), 0) AS umsatz_anteil_uwg,
    IFNULL(
        MAX(CAST(A.anz_artikel_owg_ AS FLOAT64)) / IF(MAX(B.anz_artikel_) = 0, NULL, MAX(B.anz_artikel_)), 0) AS
    artikel_anteil_owg,
    IFNULL(MAX(CAST(A.anz_artikel_uwg_ AS FLOAT64)) / IF(MAX(B.anz_artikel_) = 0, NULL, MAX(B.anz_artikel_)), 0)
        AS
        artikel_anteil_uwg
FROM `_wg_verteilung_base1` AS A
INNER JOIN `_wg_verteilung_gesamt_nielsen` AS B ON A.kl_wg_id = B.kl_wg_id AND A.mandant_id = B.mandant_id
GROUP BY
    A.mandant_id,
    A.kl_wg_id,
    A.kl_owg_id,
    A.kl_uwg_id;


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


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
        PARTITION BY art_matching_id ORDER BY kl_uwg_id IS NULL, kl_uwg_id RANGE BETWEEN
        UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS kl_uwg_id
FROM dbp_etl.art_matching_nielsen_per_kmo_2
WHERE (
    mandant_id, art_id) IN (
    SELECT (mandant_id, art_id)
    FROM dbp_data.sal_kmo_2
    WHERE TRIM(eigenmarke_id) = ''
    GROUP BY
        mandant_id,
        art_id
    HAVING SUM(total_artbew_menge) > 0
)
AND art_id <> -1
AND mandant_id = ${mandant_id};


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


CREATE OR REPLACE TEMPORARY TABLE _wg_verteilung_kl_base2 AS
SELECT
    A.mandant_id,
    b.art_id,
    b.kl_wg_id,
    b.kl_owg_id,
    b.kl_uwg_id,
    SUM(A.total_rohertrag_af + A.total_rohertrag_sa) AS ertrag_,
    SUM(A.total_umsatz_netto) AS umsatz_,
    SUM(CAST(
        SUM(A.total_rohertrag_af + A.total_rohertrag_sa) AS FLOAT64)) OVER (
        PARTITION BY b.kl_owg_id RANGE BETWEEN
        UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS ertrag_owg_,
    SUM(CAST(
        SUM(A.total_rohertrag_af + A.total_rohertrag_sa) AS FLOAT64)) OVER (
        PARTITION BY b.kl_owg_id, b.kl_uwg_id
        RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS ertrag_uwg_,
    SUM(CAST(
        SUM(A.total_umsatz_netto) AS FLOAT64)) OVER (
        PARTITION BY b.kl_owg_id RANGE BETWEEN UNBOUNDED PRECEDING AND
        UNBOUNDED FOLLOWING
    ) AS umsatz_owg_,
    SUM(CAST(
        SUM(A.total_umsatz_netto) AS FLOAT64)) OVER (
        PARTITION BY b.kl_owg_id, b.kl_uwg_id RANGE BETWEEN
        UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS umsatz_uwg_,
    COUNT(
        b.art_id) OVER (PARTITION BY b.kl_owg_id RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS
    anz_artikel_owg_,
    COUNT(b.art_id) OVER (PARTITION BY b.kl_owg_id, b.kl_uwg_id RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
        AS anz_artikel_uwg_
FROM dbp_data.sal_kmo_2 AS A
INNER JOIN (
    SELECT
        mandant_id,
        art_id,
        kl_wg_id,
        kl_owg_id,
        kl_uwg_id
    FROM `_wg_verteilung_kl_base1`
    GROUP BY
        mandant_id,
        art_id,
        kl_wg_id,
        kl_owg_id,
        kl_uwg_id
) AS b ON A.art_id = b.art_id AND A.mandant_id = b.mandant_id
WHERE
    A.mandant_id = ${mandant_id}
    AND TRIM(A.eigenmarke_id) = ''
GROUP BY
    A.mandant_id,
    b.art_id,
    b.kl_wg_id,
    b.kl_owg_id,
    b.kl_uwg_id;


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


CREATE OR REPLACE TEMPORARY TABLE _wg_verteilung_kl_gesamt AS
SELECT
    A.mandant_id,
    b.kl_wg_id,
    SUM(A.total_rohertrag_af + A.total_rohertrag_sa) AS ertrag_,
    SUM(A.total_umsatz_netto) AS umsatz_,
    CAST(COUNT(DISTINCT b.art_id) AS FLOAT64) AS anz_artikel_
FROM dbp_data.sal_kmo_2 AS A
INNER JOIN (
    SELECT
        mandant_id,
        art_id,
        kl_wg_id,
        kl_owg_id,
        kl_uwg_id
    FROM `_wg_verteilung_kl_base1`
    GROUP BY
        mandant_id,
        art_id,
        kl_wg_id,
        kl_owg_id,
        kl_uwg_id
) AS b ON A.art_id = b.art_id AND A.mandant_id = b.mandant_id
WHERE
    A.mandant_id = ${mandant_id}
    AND TRIM(A.eigenmarke_id) = ''
GROUP BY
    A.mandant_id,
    b.kl_wg_id;


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


CREATE OR REPLACE TEMPORARY TABLE _wg_verteilung_kl_base3 AS
SELECT
    A.mandant_id,
    A.kl_wg_id,
    A.kl_owg_id,
    A.kl_uwg_id,
    IFNULL(MAX(A.ertrag_owg_) / IF(MAX(B.ertrag_) = 0, NULL, MAX(B.ertrag_)), 0) AS ertrag_anteil_owg,
    IFNULL(MAX(A.ertrag_uwg_) / IF(MAX(B.ertrag_) = 0, NULL, MAX(B.ertrag_)), 0) AS ertrag_anteil_uwg,
    IFNULL(MAX(A.umsatz_owg_) / IF(MAX(B.umsatz_) = 0, NULL, MAX(B.umsatz_)), 0) AS umsatz_anteil_owg,
    IFNULL(MAX(A.umsatz_uwg_) / IF(MAX(B.umsatz_) = 0, NULL, MAX(B.umsatz_)), 0) AS umsatz_anteil_uwg,
    IFNULL(
        MAX(CAST(A.anz_artikel_owg_ AS FLOAT64)) / IF(MAX(B.anz_artikel_) = 0, NULL, MAX(B.anz_artikel_)), 0) AS
    artikel_anteil_owg,
    IFNULL(MAX(CAST(A.anz_artikel_uwg_ AS FLOAT64)) / IF(MAX(B.anz_artikel_) = 0, NULL, MAX(B.anz_artikel_)), 0)
        AS
        artikel_anteil_uwg
FROM `_wg_verteilung_kl_base2` AS A
INNER JOIN `_wg_verteilung_kl_gesamt` AS B ON A.kl_wg_id = B.kl_wg_id AND A.mandant_id = B.mandant_id
GROUP BY
    A.mandant_id,
    A.kl_wg_id,
    A.kl_owg_id,
    A.kl_uwg_id;


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


CREATE OR REPLACE TEMPORARY TABLE _wg_verteilung_final AS
SELECT
    y.kjmo,
    COALESCE(X.mandant_id, A.mandant_id) AS mandant_id,
    COALESCE(X.kl_wg_id, A.kl_wg_id) AS kl_wg_id,
    COALESCE(X.kl_owg_id, A.kl_owg_id) AS kl_owg_id,
    COALESCE(X.kl_uwg_id, A.kl_uwg_id) AS kl_uwg_id,
    COALESCE(A.umsatz_anteil_owg, 0) AS nielsen_umsatz_anteil_owg,
    COALESCE(A.umsatz_anteil_uwg, 0) AS nielsen_umsatz_anteil_uwg,
    COALESCE(A.artikel_anteil_owg, 0) AS nielsen_artikel_anteil_owg,
    COALESCE(A.artikel_anteil_uwg, 0) AS nielsen_artikel_anteil_uwg,
    COALESCE(b.umsatz_anteil_owg, 0) AS kl_umsatz_anteil_owg,
    COALESCE(c.umsatz_anteil_uwg, 0) AS kl_umsatz_anteil_uwg,
    COALESCE(b.artikel_anteil_owg, 0) AS kl_artikel_anteil_owg,
    COALESCE(c.artikel_anteil_uwg, 0) AS kl_artikel_anteil_uwg,
    COALESCE(b.ertrag_anteil_owg, 0) AS kl_ertrag_anteil_owg,
    COALESCE(c.ertrag_anteil_uwg, 0) AS kl_ertrag_anteil_uwg
FROM `_wg_verteilung_kl_base3` AS X
LEFT JOIN `_wg_verteilung_base2` AS A
    ON
        X.kl_owg_id = A.kl_owg_id AND X.kl_wg_id = A.kl_wg_id AND X.mandant_id = A.mandant_id
        AND X.kl_uwg_id = A.kl_uwg_id
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
) AS b ON X.kl_owg_id = b.kl_owg_id AND X.mandant_id = b.mandant_id
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
) AS c ON X.kl_uwg_id = c.kl_uwg_id AND X.kl_owg_id = c.kl_owg_id AND X.mandant_id = c.mandant_id
INNER JOIN (
    SELECT MAX(kjmo) AS kjmo
    FROM dbp_data.art_nielsen_fakten_kjmo_2
    WHERE mandant_id = ${mandant_id}
) AS y
    ON TRUE;


--[OK] statement is translated correctly (syntax and type checks are fine)


DELETE FROM dbp_data.sortiment_kl_wg_verteilung_2
WHERE kjmo IN (
    SELECT MAX(kjmo) AS kjmo
    FROM dbp_data.art_nielsen_fakten_kjmo_2
    WHERE mandant_id = ${mandant_id}
) AND mandant_id = ${mandant_id};


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


INSERT INTO dbp_data.sortiment_kl_wg_verteilung_2 (
    mandant_id, kjmo, kl_uwg_id, kl_wg_id, kl_owg_id,
    nielsen_umsatz_anteil_owg, nielsen_umsatz_anteil_uwg, nielsen_artikel_anteil_owg, nielsen_artikel_anteil_uwg,
    kl_umsatz_anteil_owg, kl_umsatz_anteil_uwg, kl_artikel_anteil_owg, kl_artikel_anteil_uwg, kl_ertrag_anteil_owg,
    kl_ertrag_anteil_uwg
)
(SELECT
    mandant_id,
    kjmo,
    kl_uwg_id,
    kl_owg_id,
    kl_wg_id,
    ROUND(CAST(nielsen_umsatz_anteil_owg AS NUMERIC), 5) AS nielsen_umsatz_anteil_owg,
    ROUND(CAST(nielsen_umsatz_anteil_uwg AS NUMERIC), 5) AS nielsen_umsatz_anteil_uwg,
    ROUND(CAST(nielsen_artikel_anteil_owg AS NUMERIC), 5) AS nielsen_artikel_anteil_owg,
    ROUND(CAST(nielsen_artikel_anteil_uwg AS NUMERIC), 5) AS nielsen_artikel_anteil_uwg,
    CAST(kl_umsatz_anteil_owg AS NUMERIC) AS kl_umsatz_anteil_owg,
    CAST(kl_umsatz_anteil_uwg AS NUMERIC) AS kl_umsatz_anteil_uwg,
    ROUND(CAST(kl_artikel_anteil_owg AS NUMERIC), 5) AS kl_artikel_anteil_owg,
    ROUND(CAST(kl_artikel_anteil_uwg AS NUMERIC), 5) AS kl_artikel_anteil_uwg,
    CAST(kl_ertrag_anteil_owg AS NUMERIC) AS kl_ertrag_anteil_owg,
    CAST(kl_ertrag_anteil_uwg AS NUMERIC) AS kl_ertrag_anteil_uwg
FROM `_wg_verteilung_final`);


--[OK] statement is translated correctly (syntax and type checks are fine)


DELETE FROM dbp_data.sortiment_wg_verteilung_2
WHERE kjmo IN (
    SELECT MAX(kjmo) AS kjmo
    FROM dbp_data.art_nielsen_fakten_kjmo_2
    WHERE mandant_id = ${mandant_id}
) AND mandant_id = ${mandant_id};


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


INSERT INTO dbp_data.sortiment_wg_verteilung_2 (
    mandant_id, kjmo, wg_id, wug_id, hwg_id, owg_id,
    nielsen_umsatz_anteil_owg, nielsen_umsatz_anteil_uwg, nielsen_artikel_anteil_owg, nielsen_artikel_anteil_uwg,
    kl_umsatz_anteil_owg, kl_umsatz_anteil_uwg, kl_artikel_anteil_owg, kl_artikel_anteil_uwg, kl_ertrag_anteil_owg,
    kl_ertrag_anteil_uwg
)
(SELECT
    mandant_id,
    kjmo,
    kl_owg_id,
    kl_uwg_id,
    0,
    kl_wg_id,
    ROUND(CAST(nielsen_umsatz_anteil_owg AS NUMERIC), 5) AS nielsen_umsatz_anteil_owg,
    ROUND(CAST(nielsen_umsatz_anteil_uwg AS NUMERIC), 5) AS nielsen_umsatz_anteil_uwg,
    ROUND(CAST(nielsen_artikel_anteil_owg AS NUMERIC), 5) AS nielsen_artikel_anteil_owg,
    ROUND(CAST(nielsen_artikel_anteil_uwg AS NUMERIC), 5) AS nielsen_artikel_anteil_uwg,
    CAST(kl_umsatz_anteil_owg AS NUMERIC) AS kl_umsatz_anteil_owg,
    CAST(kl_umsatz_anteil_uwg AS NUMERIC) AS kl_umsatz_anteil_uwg,
    ROUND(CAST(kl_artikel_anteil_owg AS NUMERIC), 5) AS kl_artikel_anteil_owg,
    ROUND(CAST(kl_artikel_anteil_uwg AS NUMERIC), 5) AS kl_artikel_anteil_uwg,
    CAST(kl_ertrag_anteil_owg AS NUMERIC) AS kl_ertrag_anteil_owg,
    CAST(kl_ertrag_anteil_uwg AS NUMERIC)
FROM `_wg_verteilung_final`);
