CREATE OR REPLACE TEMPORARY TABLE _art_nielsen AS
SELECT *
FROM dbp_data.art_nielsen
WHERE dat_bis = DATE '9999-12-31';


CREATE OR REPLACE TEMPORARY TABLE _sort_matching_copy AS
SELECT
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
    td_update,
    td_insert,
    '-' AS potential_article
FROM dbp_etl.art_matching_nielsen_per AS A;


UPDATE `_sort_matching_copy` SET
    potential_article = 'x' FROM (SELECT
    mandant_id,
    art_matching_id
FROM dbp_etl.art_matching_nielsen_per
GROUP BY
    mandant_id,
    art_matching_id
HAVING COUNT(DISTINCT CASE
    WHEN art_id = -1
        THEN NULL
    ELSE art_id
END) = 0) AS b
WHERE `_sort_matching_copy`.mandant_id = b.mandant_id AND `_sort_matching_copy`.art_matching_id = b.art_matching_id;

/*

-------------------------------------------------

DROP TABLE IF EXISTS dbp_etl.sortiment_potenziale;

-------------------------------------------------*/

CREATE TABLE IF NOT EXISTS dbp_etl.sortiment_potenziale (
    art_matching_id INTEGER,
    kjmo INTEGER,
    art_nielsen_id INTEGER,
    art_id INTEGER,
    kl_art_id STRING(300),
    kl_wg_id INTEGER,
    kl_owg_id INTEGER,
    kl_uwg_id INTEGER,
    rang_umsatz_wg INTEGER,
    rang_umsatz_uwg INTEGER,
    rang_absatz_uwg INTEGER,
    art_nielsen_bez STRING(300) COLLATE 'und:ci',
    gtin_id STRING(300) COLLATE 'und:ci',
    distr_gew NUMERIC(29, 4),
    umsatz_anteil_uwg NUMERIC(29, 4),
    umsatz_anteil_uwg_kumuliert NUMERIC(29, 4),
    durchschnitt_anz_maerkte INTEGER,
    durchschnitt_preis NUMERIC(29, 4),
    kl_markt_anteil_owg NUMERIC(29, 4),
    umsatz_artikel NUMERIC(29, 4),
    absatz_artikel NUMERIC(29, 4),
    anz_monate INTEGER,
    anz_wochen INTEGER,
    eigenmarke_fg INTEGER
);


CREATE OR REPLACE TEMPORARY TABLE _artikel_anteil_uwg_ranking_1st_base AS
SELECT
    A.mandant_id,
    MAX(B.art_nielsen_id) AS art_nielsen_id,
    c.art_matching_id,
    c.kl_wg_id,
    c.kl_owg_id,
    c.kl_uwg_id,
    B.gtin_id,
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
FROM dbp_data.art_nielsen_fakten_kjwo AS A
INNER JOIN (SELECT
    kjwo,
    MIN(kjmo) AS kjmo
FROM dbp_data.tag
GROUP BY kjwo) AS x ON A.kjwo = x.kjwo
INNER JOIN `_art_nielsen` AS B ON A.mandant_id = B.mandant_id AND A.art_nielsen_id = B.art_nielsen_id
INNER JOIN (
    SELECT
        mandant_id,
        art_nielsen_id,
        art_matching_id,
        kl_wg_id,
        kl_owg_id,
        kl_uwg_id
    FROM dbp_etl.art_matching_nielsen_per
    WHERE kl_owg_id <> -3
    GROUP BY
        mandant_id,
        art_nielsen_id,
        art_matching_id,
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
    AND B.gtin_id NOT IN (-9999, -9998)
GROUP BY
    A.mandant_id,
    c.art_matching_id,
    c.kl_wg_id,
    c.kl_owg_id,
    c.kl_uwg_id,
    B.gtin_id;


INSERT INTO `_artikel_anteil_uwg_ranking_1st_base`
(
    SELECT
        A.mandant_id,
        B.art_nielsen_id,
        c.art_matching_id,
        c.kl_wg_id,
        c.kl_owg_id,
        c.kl_uwg_id,
        B.gtin_id,
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
        DENSE_RANK() OVER (PARTITION BY c.kl_owg_id ORDER BY SUM(A.menge) IS NULL DESC, SUM(A.menge) DESC) AS rang_absatz_uwg
        ,
        0 AS rang_umsatz_wg
    FROM dbp_data.art_nielsen_fakten_kjwo AS A
    INNER JOIN (SELECT
        kjwo,
        MIN(kjmo) AS kjmo
    FROM dbp_data.tag
    GROUP BY kjwo) AS x ON A.kjwo = x.kjwo
    INNER JOIN `_art_nielsen` AS B ON A.mandant_id = B.mandant_id AND A.art_nielsen_id = B.art_nielsen_id
    INNER JOIN (
        SELECT
            mandant_id,
            art_matching_id,
            art_nielsen_id,
            kl_wg_id,
            kl_owg_id,
            kl_uwg_id
        FROM dbp_etl.art_matching_nielsen_per
        WHERE kl_owg_id <> -3
        GROUP BY
            mandant_id,
            art_matching_id,
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
        AND B.gtin_id IN (-9999, -9998)
        AND A.mandant_id = 1
    GROUP BY
        A.mandant_id,
        B.art_nielsen_id,
        c.art_matching_id,
        c.kl_wg_id,
        c.kl_owg_id,
        c.kl_uwg_id,
        B.gtin_id
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
    SUM(0) AS umsatz_anteil_kum_uwg,
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


CREATE OR REPLACE TEMPORARY TABLE _artikel_anteil_uwg_potenzial_base AS
SELECT
    A.mandant_id,
    c.art_matching_id,
    A.art_nielsen_id,
    c.art_id,
    CAST(NULL AS STRING) AS kl_art_id,
    CAST(c.list_kz AS STRING) AS list_kz,
    c.kl_wg_id,
    c.kl_owg_id,
    c.kl_uwg_id,
    A.gtin_id,
    0 AS distr_gew,
    0 AS umsatz_artikel,
    0 AS absatz_artikel,
    0 AS umsatz_gesamt,
    0 AS umsatz_anteil_uwg,
    100 AS umsatz_anteil_kum_uwg,
    0 AS anz_maerkte,
    0 AS durchschnitt_preis,
    0 AS kl_markt_anteil_owg,
    0 AS anz_monate,
    0 AS anz_wochen,
    NULL AS rang_umsatz_wg,
    NULL AS rang_umsatz_uwg,
    NULL AS rang_absatz_uwg
FROM `_art_nielsen` AS A
INNER JOIN (
    SELECT
        mandant_id,
        art_matching_id,
        art_nielsen_id,
        art_id,
        ' ' AS list_kz,
        kl_wg_id,
        kl_owg_id,
        kl_uwg_id
    FROM `_sort_matching_copy`
    WHERE potential_article = 'x'
    GROUP BY
        mandant_id,
        art_matching_id,
        art_nielsen_id,
        art_id,
        list_kz,
        kl_wg_id,
        kl_owg_id,
        kl_uwg_id
) AS c ON A.art_nielsen_id = c.art_nielsen_id AND A.mandant_id = c.mandant_id
WHERE A.mandant_id = 1
GROUP BY
    A.mandant_id,
    c.art_matching_id,
    A.art_nielsen_id,
    c.art_id,
    kl_art_id,
    list_kz,
    c.kl_wg_id,
    c.kl_owg_id,
    c.kl_uwg_id,
    A.gtin_id;


INSERT INTO `_artikel_anteil_uwg_potenzial_base`
(
    SELECT
        A.mandant_id,
        c.art_matching_id,
        MAX(A.art_nielsen_id) AS art_nielsen_id,
        MAX(c.art_id) AS art_id,
        REPLACE(TRIM(STRING_AGG(LPAD(
            CAST(ROUND(ROUND(CAST(LPAD(CAST(c.kl_art_id AS STRING), 8, '0') AS BIGNUMERIC), 0), 0) AS STRING),          --pe_review
            8, '0'
        ), ','), ','), ' ', '') AS kl_art_id,
        MAX(TRIM(c.list_kz)) AS list_kz,
        MAX(c.kl_wg_id) AS kl_wg_id,
        MAX(c.kl_owg_id) AS kl_owg_id,
        MAX(c.kl_uwg_id) AS kl_uwg_id,
        MAX(A.gtin_id) AS gtin_id,
        0 AS distr_gew,
        0 AS umsatz_artikel,
        0 AS absatz_artikel,
        0 AS umsatz_gesamt,
        0 AS umsatz_anteil_uwg,
        100 AS umsatz_anteil_kum_uwg,
        0 AS anz_maerkte,
        0 AS durchschnitt_preis,
        0 AS kl_markt_anteil_owg,
        0 AS anz_monate,
        0 AS anz_wochen,
        NULL AS rang_umsatz_wg,
        NULL AS rang_umsatz_uwg,
        NULL AS rang_absatz_uwg
    FROM `_art_nielsen` AS A
    INNER JOIN (
        SELECT
            A0.mandant_id,
            A0.art_matching_id,
            A0.art_nielsen_id,
            A0.art_id,
            CAST(FLOOR(A0.art_id / 100) AS INTEGER) AS kl_art_id,
            B.list_kz,
            A0.kl_wg_id,
            A0.kl_owg_id,
            A0.kl_uwg_id
        FROM dbp_etl.art_matching_nielsen_per AS A0
        INNER JOIN dbp_etl.not_listed_basis AS B
            ON
                A0.mandant_id = B.mandant_id AND A0.art_id = B.art_id AND
                A0.gtin_id = B.gtin_id
        WHERE
            A0.kl_owg_id <> -3
            AND A0.status NOT IN ('G')
        GROUP BY
            A0.mandant_id,
            A0.art_matching_id,
            A0.art_nielsen_id,
            A0.art_id,
            kl_art_id,
            B.list_kz,
            A0.kl_wg_id,
            A0.kl_owg_id,
            A0.kl_uwg_id
    ) AS c ON A.art_nielsen_id = c.art_nielsen_id AND A.mandant_id = c.mandant_id
    WHERE
        A.mandant_id = 1
        AND (
            A.mandant_id, c.art_matching_id) NOT IN (
            SELECT (mandant_id, art_matching_id)
            FROM `_artikel_anteil_uwg_potenzial_base`
        )
    GROUP BY
        A.mandant_id,
        c.art_matching_id
);


CREATE OR REPLACE TEMPORARY TABLE _artikel_anteil_wg_ranking AS
SELECT
    art_matching_id,
    MIN(kl_wg_id) AS kl_wg_id_,
    SUM(umsatz__) AS umsatz___,
    DENSE_RANK() OVER (PARTITION BY MIN(kl_wg_id) ORDER BY SUM(umsatz__) IS NULL DESC, SUM(umsatz__) DESC)
        AS
        rang_umsatz_wg
FROM `_artikel_anteil_uwg_ranking`
GROUP BY art_matching_id;


UPDATE `_artikel_anteil_uwg_potenzial_base` SET
    umsatz_artikel = CAST(b.umsatz__ as INT64),          --pe_review
    absatz_artikel = CAST(b.menge__ as INT64),
    anz_monate = b.anz,
    anz_wochen = b.anz,
    distr_gew = CAST(b.distr_gew_ as INT64),          --pe_review
    rang_umsatz_uwg = b.rang_umsatz_uwg,
    rang_absatz_uwg = b.rang_absatz_uwg
FROM `_artikel_anteil_uwg_ranking` AS b
WHERE
    `_artikel_anteil_uwg_potenzial_base`.art_matching_id = b.art_matching_id AND `_artikel_anteil_uwg_potenzial_base`
    .kl_uwg_id = b.kl_uwg_id AND `_artikel_anteil_uwg_potenzial_base`.kl_owg_id = b.kl_owg_id;


UPDATE `_artikel_anteil_uwg_potenzial_base` SET
    rang_umsatz_wg = b.rang_umsatz_wg
FROM `_artikel_anteil_wg_ranking` AS b
WHERE `_artikel_anteil_uwg_potenzial_base`.art_matching_id = b.art_matching_id;


UPDATE `_artikel_anteil_uwg_ranking` SET
    rang_umsatz_wg = b.rang_umsatz_wg
FROM `_artikel_anteil_wg_ranking` AS b
WHERE `_artikel_anteil_uwg_ranking`.art_matching_id = b.art_matching_id;


UPDATE `_artikel_anteil_uwg_potenzial_base` SET
    rang_umsatz_wg = b.next_rang_ums_wg,
    rang_umsatz_uwg = b.next_rang_ums_uwg,
    rang_absatz_uwg = b.next_rang_abs_uwg FROM (SELECT
    kl_owg_id,
    MAX(rang_umsatz_wg) AS next_rang_ums_wg,
    MAX(rang_umsatz_uwg) AS next_rang_ums_uwg,
    MAX(rang_absatz_uwg) AS next_rang_abs_uwg
FROM `_artikel_anteil_uwg_ranking`
GROUP BY kl_owg_id) AS b
WHERE
    `_artikel_anteil_uwg_potenzial_base`.kl_owg_id = b.kl_owg_id AND `_artikel_anteil_uwg_potenzial_base`.rang_umsatz_wg
    IS NULL AND `_artikel_anteil_uwg_potenzial_base`.rang_umsatz_uwg IS NULL AND `_artikel_anteil_uwg_potenzial_base`.rang_absatz_uwg
    IS NULL;


UPDATE `_artikel_anteil_uwg_potenzial_base` SET
    rang_umsatz_wg = b.next_rang_ums_wg FROM (SELECT
    kl_wg_id,
    MAX(rang_umsatz_wg) + 1 AS next_rang_ums_wg
FROM `_artikel_anteil_uwg_ranking`
GROUP BY kl_wg_id) AS b
WHERE
    `_artikel_anteil_uwg_potenzial_base`.kl_wg_id = b.kl_wg_id AND `_artikel_anteil_uwg_potenzial_base`.rang_umsatz_wg
    IS NULL;


UPDATE `_artikel_anteil_uwg_potenzial_base` SET
    rang_umsatz_uwg = CAST(b.next_rang_ums_uwg as INT64), --pe_review
    rang_absatz_uwg = CAST(b.next_rang_abs_uwg as INT64) FROM (SELECT
    kl_owg_id, --pe_review
    COALESCE(CAST(MAX(rang_umsatz_uwg) AS BIGNUMERIC), 0) + 1 AS next_rang_ums_uwg,
    COALESCE(CAST(MAX(rang_absatz_uwg) AS BIGNUMERIC), 0) + 1 AS next_rang_abs_uwg
FROM `_artikel_anteil_uwg_potenzial_base` AS A
WHERE rang_umsatz_uwg IS NULL
GROUP BY kl_owg_id) AS b
WHERE
    `_artikel_anteil_uwg_potenzial_base`.kl_owg_id = b.kl_owg_id AND `_artikel_anteil_uwg_potenzial_base`.rang_umsatz_uwg
    IS NULL AND `_artikel_anteil_uwg_potenzial_base`.rang_absatz_uwg IS NULL;


UPDATE `_artikel_anteil_uwg_potenzial_base` AS `_artikel_anteil_uwg_potenzial_base0` SET
    rang_umsatz_wg = CAST(b.next_rang_ums_wg as INT64) FROM (SELECT
    kl_wg_id,			--pe_review
    MAX(COALESCE(CAST(rang_umsatz_wg AS BIGNUMERIC), 0)) + 1 AS next_rang_ums_wg
FROM `_artikel_anteil_uwg_potenzial_base`
GROUP BY kl_wg_id) AS b
WHERE
    `_artikel_anteil_uwg_potenzial_base0`.kl_wg_id = b.kl_wg_id AND `_artikel_anteil_uwg_potenzial_base0`.rang_umsatz_wg
    IS NULL;


UPDATE `_artikel_anteil_uwg_potenzial_base` AS `_artikel_anteil_uwg_potenzial_base0` SET
    rang_umsatz_uwg = CAST(b.next_rang_ums_uwg as INT64),			--pe_review
    rang_absatz_uwg = CAST(b.next_rang_abs_uwg as INT64) FROM (SELECT
    kl_owg_id,			--pe_review
    MAX(COALESCE(CAST(rang_umsatz_uwg AS BIGNUMERIC), 0)) + 1 AS next_rang_ums_uwg,
    MAX(COALESCE(CAST(rang_absatz_uwg AS BIGNUMERIC), 0)) + 1 AS next_rang_abs_uwg
FROM `_artikel_anteil_uwg_potenzial_base`
GROUP BY kl_owg_id) AS b
WHERE
    `_artikel_anteil_uwg_potenzial_base0`.kl_owg_id = b.kl_owg_id AND `_artikel_anteil_uwg_potenzial_base0`.rang_umsatz_uwg
    IS NULL AND `_artikel_anteil_uwg_potenzial_base0`.rang_absatz_uwg IS NULL;


CREATE OR REPLACE TEMPORARY TABLE _gesamt_uwg AS
SELECT
    kl_owg_id,
    kl_uwg_id,
    SUM(umsatz__) AS umsatz
FROM `_artikel_anteil_uwg_ranking`
GROUP BY
    kl_owg_id,
    kl_uwg_id;


UPDATE `_artikel_anteil_uwg_potenzial_base` SET
    umsatz_gesamt = CAST(b.umsatz as INT64),			--pe_review
    umsatz_anteil_uwg = CAST((`_artikel_anteil_uwg_potenzial_base`.umsatz_artikel / IF(b.umsatz = 0, NULL, b.umsatz) * 100.00) as INT64)			--pe_review
FROM (
    SELECT *
    FROM `_gesamt_uwg`
    GROUP BY
        kl_owg_id,
        kl_uwg_id,
        umsatz
) AS b
WHERE
    `_artikel_anteil_uwg_potenzial_base`.kl_uwg_id = b.kl_uwg_id AND `_artikel_anteil_uwg_potenzial_base`.kl_owg_id =
    b.kl_owg_id;


UPDATE `_artikel_anteil_uwg_ranking` SET
    umsatz_anteil_kum_uwg = CAST((`_artikel_anteil_uwg_ranking`.umsatz__ / IF(b.umsatz = 0, NULL, b.umsatz) * 100.00) as INT64) FROM (
    SELECT			--pe_review
        *
    FROM `_gesamt_uwg`
    GROUP BY
        kl_owg_id,
        kl_uwg_id,
        umsatz
) AS b
WHERE `_artikel_anteil_uwg_ranking`.kl_uwg_id = b.kl_uwg_id AND `_artikel_anteil_uwg_ranking`.kl_owg_id = b.kl_owg_id;


UPDATE `_artikel_anteil_uwg_potenzial_base` SET
    umsatz_anteil_kum_uwg = b.umsatz_anteil_kum FROM (SELECT
    art_matching_id,
    kl_owg_id,
    kl_uwg_id,
    SUM(umsatz_anteil_kum_uwg) OVER (
        PARTITION BY kl_owg_id, kl_uwg_id ORDER BY rang_umsatz_uwg IS NULL, rang_umsatz_uwg
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS umsatz_anteil_kum
FROM `_artikel_anteil_uwg_ranking`) AS b
WHERE
    `_artikel_anteil_uwg_potenzial_base`.art_matching_id = b.art_matching_id AND `_artikel_anteil_uwg_potenzial_base`
    .kl_uwg_id = b.kl_uwg_id AND `_artikel_anteil_uwg_potenzial_base`.kl_owg_id = b.kl_owg_id;


CREATE OR REPLACE TEMPORARY TABLE _kl_owg_umsatz AS
SELECT
    b.kl_owg_id,
    SUM(A.total_umsatz_netto) AS ums_netto,
    SUM(A.anz_listung_as_is) AS anz_listung,
    SUM(A.total_umsatz_netto * A.anz_listung_as_is) AS gew_netto,
    SUM(A.total_umsatz_netto * A.anz_listung_as_is) / SUM(A.total_umsatz_netto) AS anz_maerkte
FROM dbp_etl.bf_sort_sal_export AS A
INNER JOIN (
    SELECT
        art_id,
        kl_owg_id
    FROM dbp_etl.art_matching_nielsen_per
    WHERE kl_owg_id <> -3
    GROUP BY
        art_id,
        kl_owg_id
) AS b
    ON
        ROUND(CAST(A.art_nr AS BIGNUMERIC), 0
        ) = CAST(FLOOR(b.art_id / 100) AS INTEGER
        )
GROUP BY b.kl_owg_id;


CREATE OR REPLACE TEMPORARY TABLE _nielsen_owg_umsatz AS
SELECT
    kl_owg_id,
    SUM(umsatz__) AS umsatz___
FROM `_artikel_anteil_uwg_ranking`
GROUP BY kl_owg_id;


CREATE OR REPLACE TEMPORARY TABLE _nielsen_owg_umsatz_kl AS
SELECT
    c.kl_owg_id,
    SUM(A.umsatz_brutto) AS umsatz_
FROM dbp_data.art_nielsen_fakten_kjwo AS A
INNER JOIN (SELECT
    kjwo,
    MIN(kjmo) AS kjmo
FROM dbp_data.tag
GROUP BY kjwo) AS x ON A.kjwo = x.kjwo
INNER JOIN `_art_nielsen` AS B ON A.mandant_id = B.mandant_id AND A.art_nielsen_id = B.art_nielsen_id
INNER JOIN (
    SELECT
        mandant_id,
        art_nielsen_id,
        kl_wg_id,
        kl_owg_id,
        kl_uwg_id
    FROM dbp_etl.art_matching_nielsen_per
    WHERE kl_owg_id <> -3
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
    AND D.nielsen_market_cluster_id = 1
    AND A.mandant_id = 1
GROUP BY c.kl_owg_id;


UPDATE `_artikel_anteil_uwg_potenzial_base` SET
    anz_maerkte = CAST(ROUND(CAST(b.anz_maerkte AS BIGNUMERIC), 0) as INT64)
FROM `_kl_owg_umsatz` AS b
WHERE `_artikel_anteil_uwg_potenzial_base`.kl_owg_id = b.kl_owg_id;


UPDATE `_artikel_anteil_uwg_potenzial_base` SET
    kl_markt_anteil_owg = CAST(b.anteil as INT64) FROM (
    SELECT
        A.kl_owg_id,
        IFNULL(CAST(A.umsatz_ AS NUMERIC) / CAST(B.umsatz___ AS NUMERIC) * 100, 0) AS anteil
    FROM `_nielsen_owg_umsatz_kl` AS A
    INNER JOIN `_nielsen_owg_umsatz` AS B ON A.kl_owg_id = B.kl_owg_id
) AS b
WHERE `_artikel_anteil_uwg_potenzial_base`.kl_owg_id = b.kl_owg_id;


CREATE OR REPLACE TEMPORARY TABLE _nielsen_preise_1 AS
SELECT
    B.art_nielsen_id,
    SUM(A.menge) AS menge,
    SUM(A.menge_af) AS menge_af,
    SUM(A.menge_sa) AS menge_sa,
    SUM(A.umsatz_brutto) AS umsatz_brutto,
    SUM(A.umsatz_brutto_af) AS umsatz_brutto_af,
    SUM(A.umsatz_brutto_sa) AS umsatz_brutto_sa
FROM dbp_data.art_nielsen_fakten_kjwo AS A
INNER JOIN `_art_nielsen` AS B ON A.mandant_id = B.mandant_id AND A.art_nielsen_id = B.art_nielsen_id
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
GROUP BY B.art_nielsen_id;


CREATE OR REPLACE TEMPORARY TABLE _nielsen_preise2 AS
SELECT
    art_nielsen_id,
    CASE
        WHEN umsatz_brutto_af > 0
            THEN umsatz_brutto_af / IF(menge_af = 0, NULL, menge_af)
        WHEN umsatz_brutto_af = 0 AND umsatz_brutto_sa > 0
            THEN umsatz_brutto_sa / IF(menge_sa = 0, NULL, menge_sa)
        ELSE 0
    END AS durchschnitt_preis_kasse
FROM `_nielsen_preise_1`
WHERE
    umsatz_brutto > 0
    AND menge > 0;


UPDATE `_artikel_anteil_uwg_potenzial_base` SET
    durchschnitt_preis = CAST(b.durchschnitt_preis_kasse AS INT64)
FROM `_nielsen_preise2` AS b			--pe_review
WHERE `_artikel_anteil_uwg_potenzial_base`.art_nielsen_id = b.art_nielsen_id;


INSERT INTO dbp_etl.sortiment_potenziale (
    art_matching_id, kjmo, art_nielsen_id, art_id, kl_art_id,
    kl_wg_id, kl_owg_id, kl_uwg_id, rang_umsatz_wg, rang_umsatz_uwg, rang_absatz_uwg, art_nielsen_bez, gtin_id, distr_gew,
    umsatz_anteil_uwg, umsatz_anteil_uwg_kumuliert, durchschnitt_anz_maerkte, durchschnitt_preis, kl_markt_anteil_owg,
    umsatz_artikel, absatz_artikel, anz_monate, anz_wochen, eigenmarke_fg
)
(
    SELECT
        A.art_matching_id,
        CAST(D.kjmo_sort AS INT64) AS kjmo,			--pe_review
        CAST(A.art_nielsen_id AS INT64),			--pe_review
        A.art_id,
        A.kl_art_id,
        A.kl_wg_id,
        A.kl_owg_id,
        A.kl_uwg_id,
        CAST(A.rang_umsatz_wg AS INTEGER) AS rang_umsatz_wg,
        CAST(A.rang_umsatz_uwg AS INTEGER) AS rang_umsatz_uwg,
        CAST(A.rang_absatz_uwg AS INTEGER) AS rang_absatz_uwg,
        B.art_nielsen_bez,
        CAST(CAST(A.gtin_id AS BIGNUMERIC) AS STRING) AS gtin_id,
        A.distr_gew,
        A.umsatz_anteil_uwg,
        A.umsatz_anteil_kum_uwg AS umsatz_anteil_uwg_kumuliert,
        CAST(A.anz_maerkte AS INTEGER) AS durchschnitt_anz_maerkte,
        A.durchschnitt_preis,
        A.kl_markt_anteil_owg,
        A.umsatz_artikel,
        A.absatz_artikel,
        CAST(A.anz_monate AS INTEGER) AS anz_monate,
        CAST(A.anz_wochen AS INTEGER) AS anz_wochen,
        CASE
            WHEN A.gtin_id IN (-9999, -9998)
                THEN 1
            ELSE 0
        END AS eigenmarke_fg
    FROM `_artikel_anteil_uwg_potenzial_base` AS A
    INNER JOIN `_art_nielsen` AS B ON A.mandant_id = B.mandant_id AND A.art_nielsen_id = B.art_nielsen_id
    INNER JOIN (
        SELECT MAX(kjwo) AS max_kjwo
        FROM dbp_data.art_nielsen_fakten_kjwo
        WHERE mandant_id = 1
    ) AS c
        ON TRUE
    INNER JOIN dbp_msi_data.ek_sort_sortiment_mat_zeitraum AS D ON c.max_kjwo = D.kjwo_bis
);


DELETE FROM dbp_etl_process.matching_art_nielsen_zu
WHERE mandant_id = 1 AND kjwo_update IN (
    SELECT MAX(kjwo_update) AS a1290333724
    FROM dbp_data.art_kl_preislage_zu_per
    WHERE mandant_id = 1
);


INSERT INTO dbp_etl_process.matching_art_nielsen_zu
SELECT
    a.mandant_id,
    a.kjwo_update,
    a.art_matching_id,
    a.art_nielsen_id,
    a.gtin_id
FROM dbp_etl.art_matching_nielsen_per a
JOIN (			--pe_review
    SELECT art_matching_id			--pe_review
    FROM dbp_etl.sortiment_potenziale			--pe_review
    GROUP BY art_matching_id			--pe_review
    HAVING COUNT(*) > 1			--pe_review
) b			--pe_review
    ON a.art_matching_id = b.art_matching_id			--pe_review
WHERE
    a.art_nielsen_id <> -1			--pe_review
    AND a.mandant_id = 1
GROUP BY
    a.mandant_id,
    a.kjwo_update,
    a.art_matching_id,
    a.art_nielsen_id,
    a.gtin_id;


CREATE OR REPLACE TEMPORARY TABLE _sorti_agg AS
SELECT
    art_matching_id,
    kjmo,
    MAX(art_nielsen_id) AS art_nielsen_id,
    MAX(art_id) AS art_id,
    MAX(kl_art_id) AS kl_art_id,
    MAX(kl_wg_id) AS kl_wg_id,
    MAX(kl_owg_id) AS kl_owg_id,
    MAX(kl_uwg_id) AS kl_uwg_id,
    MAX(rang_umsatz_wg) AS rang_umsatz_wg,
    MAX(rang_umsatz_uwg) AS rang_umsatz_uwg,
    MAX(rang_absatz_uwg) AS rang_absatz_uwg,
    MAX(art_nielsen_bez) AS art_nielsen_bez,
    MAX(gtin_id) AS gtin_id,
    MAX(distr_gew) AS distr_gew,
    MAX(umsatz_anteil_uwg) AS umsatz_anteil_uwg,
    MAX(umsatz_anteil_uwg_kumuliert) AS umsatz_anteil_uwg_kumuliert,
    MAX(durchschnitt_anz_maerkte) AS durchschnitt_anz_maerkte,
    MAX(durchschnitt_preis) AS durchschnitt_preis,
    MAX(kl_markt_anteil_owg) AS kl_markt_anteil_owg,
    MAX(umsatz_artikel) AS umsatz_artikel,
    MAX(absatz_artikel) AS absatz_artikel,
    MAX(anz_monate) AS anz_monate,
    MAX(anz_wochen) AS anz_wochen,
    MAX(eigenmarke_fg) AS eigenmarke_fg
FROM dbp_etl.sortiment_potenziale
WHERE
    art_matching_id IN (
        SELECT art_matching_id
        FROM dbp_etl_process.matching_art_nielsen_zu
        WHERE
            mandant_id = 1
            AND kjwo_update IN (
                SELECT MAX(kjwo_update) AS kjwo_update
                FROM dbp_data.art_kl_preislage_zu_per
                WHERE mandant_id = 1
            )
    )
GROUP BY
    art_matching_id,
    kjmo;


DELETE FROM dbp_etl.sortiment_potenziale
WHERE art_matching_id IN (
    SELECT art_matching_id
    FROM `_sorti_agg`
);


INSERT INTO dbp_etl.sortiment_potenziale
(
    SELECT *
    FROM `_sorti_agg` AS A
);
