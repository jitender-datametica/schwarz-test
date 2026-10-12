CREATE OR REPLACE TEMPORARY TABLE _art_nielsen AS
SELECT *
FROM dbp_data.art_nielsen
WHERE dat_bis = DATE '9999-12-31';


CREATE OR REPLACE TEMPORARY TABLE _artikel_anteil_uwg_ranking_1st_base AS
SELECT
    A.mandant_id,
    c.art_matching_id,
    c.kl_wg_id,
    c.kl_owg_id,
    c.kl_uwg_id,
    COUNT(DISTINCT x.kjwo) AS anz,
    SUM(A.distr_gew) / COUNT(DISTINCT x.kjwo) AS distr_gew_,
    SUM(A.menge) AS menge_,
    SUM(A.umsatz_brutto) AS umsatz_,
    SUM(A.menge_af) AS menge_af_,
    SUM(A.umsatz_brutto_af) AS umsatz_af_,
    SUM(A.menge_sa) AS menge_sa_,
    SUM(A.umsatz_brutto_sa) AS umsatz_sa_,
    SUM(0) AS umsatz_anteil_kum_uwg,
    RANK() OVER (
        PARTITION BY
            c.kl_wg_id, c.kl_owg_id ORDER BY
            c.kl_wg_id IS NULL, c.kl_wg_id, c.kl_owg_id IS NULL, c.kl_owg_id,
            SUM(A.umsatz_brutto) IS NULL DESC, SUM(A.umsatz_brutto) DESC
    ) AS rang_umsatz_uwg,
    RANK() OVER (
        PARTITION BY
            c.kl_wg_id, c.kl_owg_id ORDER BY
            c.kl_wg_id IS NULL, c.kl_wg_id, c.kl_owg_id IS NULL, c.kl_owg_id,
            SUM(A.menge) IS NULL DESC, SUM(A.menge) DESC
    ) AS rang_absatz_uwg,
    RANK() OVER (PARTITION BY c.kl_wg_id ORDER BY c.kl_wg_id IS NULL, c.kl_wg_id, SUM(
        A.umsatz_brutto) IS NULL DESC, SUM(
        A.umsatz_brutto
    ) DESC) AS rang_umsatz_wg
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
        gtin_id,
        art_matching_id,
        kl_wg_id,
        kl_owg_id,
        kl_uwg_id
    FROM dbp_etl.art_matching_nielsen_per
    GROUP BY
        mandant_id,
        gtin_id,
        art_matching_id,
        kl_wg_id,
        kl_owg_id,
        kl_uwg_id
) AS c ON B.gtin_id = c.gtin_id AND B.mandant_id = c.mandant_id
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
    c.kl_uwg_id;


INSERT INTO `_artikel_anteil_uwg_ranking_1st_base`
(
    SELECT
        A.mandant_id,
        c.art_matching_id,
        c.kl_wg_id,
        c.kl_owg_id,
        c.kl_uwg_id,
        COUNT(DISTINCT x.kjwo) AS anz,
        SUM(A.distr_gew) / COUNT(DISTINCT x.kjwo) AS distr_gew_,
        SUM(A.menge) AS menge_,
        SUM(A.umsatz_brutto) AS umsatz_,
        SUM(A.menge_af) AS menge_af_,
        SUM(A.umsatz_brutto_af) AS umsatz_af_,
        SUM(A.menge_sa) AS menge_sa_,
        SUM(A.umsatz_brutto_sa) AS umsatz_sa_,
        SUM(0) AS umsatz_anteil_kum_uwg,
        RANK() OVER (
            PARTITION BY
                c.kl_wg_id, c.kl_owg_id ORDER BY
                c.kl_wg_id IS NULL, c.kl_wg_id, c.kl_owg_id IS NULL, c.kl_owg_id,
                SUM(A.umsatz_brutto) IS NULL DESC, SUM(A.umsatz_brutto) DESC
        ) AS rang_umsatz_uwg,
        RANK() OVER (
            PARTITION BY
                c.kl_wg_id, c.kl_owg_id ORDER BY
                c.kl_wg_id IS NULL, c.kl_wg_id, c.kl_owg_id IS NULL, c.kl_owg_id,
                SUM(A.menge) IS NULL DESC, SUM(A.menge) DESC
        ) AS rang_absatz_uwg,
        RANK() OVER (PARTITION BY c.kl_wg_id ORDER BY c.kl_wg_id IS NULL, c.kl_wg_id, SUM(
            A.umsatz_brutto) IS NULL DESC, SUM(
            A.umsatz_brutto
        ) DESC) AS rang_umsatz_wg
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
        c.art_matching_id,
        c.kl_wg_id,
        c.kl_owg_id,
        c.kl_uwg_id
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
    RANK() OVER (
        PARTITION BY
            kl_wg_id, kl_owg_id ORDER BY
            kl_wg_id IS NULL, kl_wg_id, kl_owg_id IS NULL, kl_owg_id, SUM(umsatz_
            ) IS NULL DESC, SUM(umsatz_) DESC
    ) AS rang_umsatz_uwg,
    RANK() OVER (
        PARTITION BY
            kl_wg_id, kl_owg_id ORDER BY
            kl_wg_id IS NULL, kl_wg_id, kl_owg_id IS NULL, kl_owg_id, SUM(menge_
            ) IS NULL DESC, SUM(menge_) DESC
    ) AS rang_absatz_uwg,
    RANK() OVER (PARTITION BY kl_wg_id ORDER BY kl_wg_id IS NULL, kl_wg_id, SUM(umsatz_) IS NULL DESC, SUM(umsatz_) DESC)
        AS rang_umsatz_wg
FROM `_artikel_anteil_uwg_ranking_1st_base` AS A
GROUP BY
    mandant_id,
    art_matching_id,
    kl_wg_id,
    kl_owg_id,
    kl_uwg_id;


UPDATE dbp_data.sortiment_leistung SET
    rang_umsatz_wg = NULL,
    rang_umsatz_uwg = NULL,
    rang_absatz_uwg = NULL
WHERE mandant_id = 1 AND kjwo_update IN (
    SELECT MAX(kjwo_update) AS a1290333724
    FROM dbp_data.art_kl_preislage_zu_per
    WHERE mandant_id = 1
);


UPDATE dbp_data.sortiment_leistung SET
    rang_umsatz_wg = b.rang_umsatz_wg,
    rang_umsatz_uwg = b.rang_umsatz_uwg,
    rang_absatz_uwg = b.rang_absatz_uwg FROM (
    SELECT
        A.mandant_id,
        A.art_matching_id,
        A.kl_wg_id,
        A.kl_owg_id,
        A.kl_uwg_id,
        A.anz,
        A.distr_gew_,
        A.menge__,
        A.umsatz__,
        A.menge_af_,
        A.umsatz_af_,
        A.menge_sa_,
        A.umsatz_sa_,
        A.umsatz_anteil_kum_uwg,
        A.rang_umsatz_uwg,
        A.rang_absatz_uwg,
        A.rang_umsatz_wg
    FROM `_artikel_anteil_uwg_ranking` AS A
    INNER JOIN (SELECT
        mandant_id,
        art_matching_id
    FROM `_artikel_anteil_uwg_ranking`
    GROUP BY
        mandant_id,
        art_matching_id
    HAVING COUNT(*) = 1) AS b ON A.mandant_id = b.mandant_id AND A.art_matching_id = b.art_matching_id
) AS b
WHERE
    sortiment_leistung.mandant_id = b.mandant_id AND sortiment_leistung.matching_id = b.art_matching_id AND
    sortiment_leistung.kjwo_update IN (
        SELECT MAX(kjwo_update) AS a1290333724
        FROM dbp_data.art_kl_preislage_zu_per
        WHERE mandant_id = 1
    );


CREATE OR REPLACE TEMPORARY TABLE _upd_rank AS
SELECT
    matching_id,
    kl_owg_id,
    rang_umsatz_uwg,
    rang_absatz_uwg,
    ROW_NUMBER() OVER (
        PARTITION BY
            kl_owg_id ORDER BY
            kl_owg_id IS NULL, kl_owg_id, rang_umsatz_uwg IS NULL,
            rang_umsatz_uwg
    ) AS rang_umsatz_uwg_,
    ROW_NUMBER() OVER (
        PARTITION BY
            kl_owg_id ORDER BY
            kl_owg_id IS NULL, kl_owg_id, rang_absatz_uwg IS NULL,
            rang_absatz_uwg
    ) AS rang_absatz_uwg_
FROM dbp_data.sortiment_leistung
WHERE kjwo_update IN (
    SELECT MAX(kjwo_update) AS a1290333724
    FROM dbp_data.art_kl_preislage_zu_per
    WHERE mandant_id = 1
)
AND mandant_id = 1
AND rang_umsatz_uwg IS NOT NULL;


UPDATE dbp_data.sortiment_leistung SET
    rang_umsatz_uwg = b.rang_umsatz_uwg_,
    rang_absatz_uwg = b.rang_absatz_uwg_
FROM `_upd_rank` AS b
WHERE sortiment_leistung.kjwo_update IN (
    SELECT MAX(kjwo_update) AS a1290333724
    FROM dbp_data.art_kl_preislage_zu_per
    WHERE mandant_id = 1
) AND sortiment_leistung.mandant_id = 1 AND sortiment_leistung.matching_id = b.matching_id AND
sortiment_leistung.rang_umsatz_uwg = b.rang_umsatz_uwg AND sortiment_leistung.rang_absatz_uwg = b.rang_absatz_uwg;


CREATE OR REPLACE TEMPORARY TABLE _upd_rank_wg AS
SELECT
    matching_id,
    kl_wg_id,
    rang_umsatz_wg,
    ROW_NUMBER() OVER (PARTITION BY kl_wg_id ORDER BY kl_wg_id IS NULL, kl_wg_id, rang_umsatz_wg IS NULL, rang_umsatz_wg)
        AS rang_umsatz_wg_
FROM dbp_data.sortiment_leistung
WHERE kjwo_update IN (
    SELECT MAX(kjwo_update) AS a1290333724
    FROM dbp_data.art_kl_preislage_zu_per
    WHERE mandant_id = 1
)
AND mandant_id = 1
AND rang_umsatz_wg IS NOT NULL;


UPDATE dbp_data.sortiment_leistung SET
    rang_umsatz_wg = b.rang_umsatz_wg_
FROM `_upd_rank_wg` AS b
WHERE sortiment_leistung.kjwo_update IN (
    SELECT MAX(kjwo_update) AS a1290333724
    FROM dbp_data.art_kl_preislage_zu_per
    WHERE mandant_id = 1
) AND sortiment_leistung.mandant_id = 1 AND sortiment_leistung.matching_id = b.matching_id AND
sortiment_leistung.rang_umsatz_wg = b.rang_umsatz_wg;


UPDATE dbp_data.sortiment_leistung AS sortiment_leistung0 SET
    rang_umsatz_uwg = b.next_rang_ums_uwg,
    rang_absatz_uwg = b.next_rang_abs_uwg FROM (SELECT
    kl_owg_id,
    MAX(rang_umsatz_uwg) + 1 AS next_rang_ums_uwg,
    MAX(rang_absatz_uwg) + 1 AS next_rang_abs_uwg
FROM dbp_data.sortiment_leistung
WHERE
    rang_umsatz_uwg IS NOT NULL
    AND mandant_id = 1
    AND kjwo_update IN (
        SELECT MAX(kjwo_update) AS a1290333724
        FROM dbp_data.art_kl_preislage_zu_per
        WHERE mandant_id = 1
    )
GROUP BY kl_owg_id) AS b
WHERE
    sortiment_leistung0.kl_owg_id = b.kl_owg_id AND sortiment_leistung0.rang_umsatz_uwg IS NULL AND
    sortiment_leistung0.rang_absatz_uwg IS NULL AND sortiment_leistung0.mandant_id = 1 AND sortiment_leistung0.kjwo_update
    IN (
        SELECT MAX(kjwo_update) AS a1290333724
        FROM dbp_data.art_kl_preislage_zu_per
        WHERE mandant_id = 1
    );


UPDATE dbp_data.sortiment_leistung AS sortiment_leistung0 SET
    rang_umsatz_wg = b.next_rang_ums_wg FROM (SELECT
    kl_wg_id,
    MAX(rang_umsatz_wg) + 1 AS next_rang_ums_wg
FROM dbp_data.sortiment_leistung
WHERE
    rang_umsatz_wg IS NOT NULL
    AND mandant_id = 1
    AND kjwo_update IN (
        SELECT MAX(kjwo_update) AS a1290333724
        FROM dbp_data.art_kl_preislage_zu_per
        WHERE mandant_id = 1
    )
GROUP BY kl_wg_id) AS b
WHERE
    sortiment_leistung0.kl_wg_id = b.kl_wg_id AND sortiment_leistung0.rang_umsatz_wg IS NULL AND sortiment_leistung0.mandant_id
    = 1 AND sortiment_leistung0.kjwo_update IN (
        SELECT MAX(kjwo_update) AS a1290333724
        FROM dbp_data.art_kl_preislage_zu_per
        WHERE mandant_id = 1
    );


UPDATE dbp_data.sortiment_leistung AS sortiment_leistung0 SET
    rang_umsatz_wg = b.next_rang_ums_wg FROM (SELECT
    owg_id,
    COALESCE(MAX(rang_umsatz_wg), 0) + 1 AS next_rang_ums_wg
FROM dbp_data.sortiment_leistung
WHERE
    mandant_id = 1
    AND kjwo_update IN (
        SELECT MAX(kjwo_update) AS a1290333724
        FROM dbp_data.art_kl_preislage_zu_per
        WHERE mandant_id = 1
    )
GROUP BY owg_id) AS b
WHERE
    sortiment_leistung0.owg_id = b.owg_id AND sortiment_leistung0.rang_umsatz_wg IS NULL AND sortiment_leistung0.mandant_id
    = 1 AND sortiment_leistung0.kjwo_update IN (
        SELECT MAX(kjwo_update) AS a1290333724
        FROM dbp_data.art_kl_preislage_zu_per
        WHERE mandant_id = 1
    );


UPDATE dbp_data.sortiment_leistung AS sortiment_leistung0 SET
    rang_umsatz_uwg = b.next_rang_ums_uwg,
    rang_absatz_uwg = b.next_rang_abs_uwg FROM (SELECT
    wg_id,
    COALESCE(MAX(rang_umsatz_uwg), 0) + 1 AS next_rang_ums_uwg,
    COALESCE(MAX(rang_absatz_uwg), 0) + 1 AS next_rang_abs_uwg
FROM dbp_data.sortiment_leistung
WHERE
    mandant_id = 1
    AND kjwo_update IN (
        SELECT MAX(kjwo_update) AS a1290333724
        FROM dbp_data.art_kl_preislage_zu_per
        WHERE mandant_id = 1
    )
GROUP BY wg_id) AS b
WHERE
    sortiment_leistung0.wg_id = b.wg_id AND sortiment_leistung0.rang_umsatz_uwg IS NULL AND sortiment_leistung0.mandant_id
    = 1 AND sortiment_leistung0.kjwo_update IN (
        SELECT MAX(kjwo_update) AS a1290333724
        FROM dbp_data.art_kl_preislage_zu_per
        WHERE mandant_id = 1
    );


CREATE OR REPLACE TEMPORARY TABLE _artikel_anteil_uwg_ranking_kl AS
SELECT
    B.art_nielsen_id,
    c.kl_wg_id,
    c.kl_owg_id,
    c.kl_uwg_id,
    B.gtin_id,
    COUNT(DISTINCT x.kjmo) AS anz,
    COUNT(DISTINCT A.kjwo) AS anz_wochen,
    SUM(A.distr_gew) / COUNT(DISTINCT A.kjwo) AS distr_gew_,
    SUM(A.menge) AS menge_,
    SUM(A.umsatz_brutto) AS umsatz_,
    SUM(A.anz_maerkte) AS anz_maerkte,
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
        kl_wg_id,
        kl_owg_id,
        kl_uwg_id
    FROM dbp_etl.art_matching_nielsen_per
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
GROUP BY
    B.art_nielsen_id,
    c.kl_wg_id,
    c.kl_owg_id,
    c.kl_uwg_id,
    B.gtin_id;


CREATE OR REPLACE TEMPORARY TABLE _artikel_anteil_uwg_ranking_x AS
SELECT
    B.art_nielsen_id,
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
        kl_wg_id,
        kl_owg_id,
        kl_uwg_id
    FROM dbp_etl.art_matching_nielsen_per
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
    B.art_nielsen_id,
    c.kl_wg_id,
    c.kl_owg_id,
    c.kl_uwg_id,
    B.gtin_id;


CREATE OR REPLACE TEMPORARY TABLE _kl_ma_owg_1 AS
SELECT
    a.kl_owg_id,
    SUM(a.umsatz__) AS umsatz_x,
    SUM(b.umsatz_kl) AS umsatz_kl_x,
    IFNULL(SUM(b.umsatz_kl) / IF(SUM(a.umsatz__) = 0, NULL, SUM(a.umsatz__)), 0) * 100.00 AS marktanteil_owg
FROM (SELECT
    kl_owg_id,
    SUM(umsatz_) AS umsatz__
FROM `_artikel_anteil_uwg_ranking_x`
GROUP BY kl_owg_id) AS a
INNER JOIN (SELECT
    kl_owg_id,
    SUM(umsatz_) AS umsatz_kl
FROM `_artikel_anteil_uwg_ranking_kl`
GROUP BY kl_owg_id) AS b ON a.kl_owg_id = b.kl_owg_id
GROUP BY a.kl_owg_id;


CREATE OR REPLACE TEMPORARY TABLE _kl_ma_uwg_1 AS
SELECT
    a.kl_owg_id,
    a.kl_uwg_id,
    SUM(a.umsatz__) AS umsatz_x,
    SUM(b.umsatz_kl) AS umsatz_kl_x,
    IFNULL(SUM(b.umsatz_kl) / IF(SUM(a.umsatz__) = 0, NULL, SUM(a.umsatz__)), 0) * 100.00 AS marktanteil_uwg
FROM (
    SELECT
        kl_owg_id,
        kl_uwg_id,
        SUM(umsatz_) AS umsatz__
    FROM `_artikel_anteil_uwg_ranking_x`
    GROUP BY
        kl_owg_id,
        kl_uwg_id
) AS a
INNER JOIN (
    SELECT
        kl_owg_id,
        kl_uwg_id,
        SUM(umsatz_) AS umsatz_kl
    FROM `_artikel_anteil_uwg_ranking_kl`
    GROUP BY
        kl_owg_id,
        kl_uwg_id
) AS b ON a.kl_owg_id = b.kl_owg_id AND a.kl_uwg_id = b.kl_uwg_id
GROUP BY
    a.kl_owg_id,
    a.kl_uwg_id;


UPDATE dbp_data.sortiment_leistung SET
    marktanteilbewertung = b.indexpunkt FROM (
    SELECT
        B.kl_owg_id,
        B.kl_uwg_id,
        A.marktanteil_owg,
        B.marktanteil_uwg,
        IFNULL(B.marktanteil_uwg / IF(A.marktanteil_owg = 0, NULL, A.marktanteil_owg), 0) AS indexpunkt
    FROM `_kl_ma_owg_1` AS A
    INNER JOIN `_kl_ma_uwg_1` AS B ON A.kl_owg_id = B.kl_owg_id
) AS b
WHERE
    sortiment_leistung.kl_uwg_id = b.kl_uwg_id AND sortiment_leistung.kl_owg_id = b.kl_owg_id AND sortiment_leistung.mandant_id
    = 1 AND sortiment_leistung.kjwo_update IN (
        SELECT MAX(kjwo_update) AS a1290333724
        FROM dbp_data.art_kl_preislage_zu_per
        WHERE mandant_id = 1
    );


CREATE OR REPLACE TEMPORARY TABLE _fix_it AS
SELECT
    mandant_id,
    wg_id,
    wug_id,
    COUNT(DISTINCT marktanteilbewertung) AS anz
FROM dbp_data.sortiment_leistung
WHERE
    kjwo_update IN (
        SELECT MAX(kjwo_update) AS a1290333724
        FROM dbp_data.art_kl_preislage_zu_per
        WHERE mandant_id = 1
    )
    AND mandant_id = 1
    AND marktanteilbewertung IS NOT NULL
GROUP BY
    mandant_id,
    wg_id,
    wug_id
HAVING anz > 1;


UPDATE dbp_data.sortiment_leistung SET
    marktanteilbewertung = b.marktanteilbewertung FROM (
    SELECT
        A.mandant_id,
        A.wg_id,
        A.wug_id,
        MAX(A.marktanteilbewertung) AS marktanteilbewertung
    FROM dbp_data.sortiment_leistung AS A
    INNER JOIN `_fix_it` AS B ON A.mandant_id = B.mandant_id AND A.wg_id = B.wg_id AND A.wug_id = B.wug_id
    GROUP BY
        A.mandant_id,
        A.wg_id,
        A.wug_id
) AS b
WHERE
    sortiment_leistung.wug_id = b.wug_id AND sortiment_leistung.wg_id = b.wg_id AND sortiment_leistung.mandant_id = b.mandant_id AND sortiment_leistung.kjwo_update IN (
        SELECT MAX(kjwo_update) AS a1290333724
        FROM dbp_data.art_kl_preislage_zu_per
        WHERE mandant_id = 1
    );


UPDATE dbp_data.sortiment_leistung SET
    marktanteilbewertung = b.marktanteilbewertung FROM (
    SELECT
        mandant_id,
        kjwo_update,
        wg_id,
        wug_id,
        MAX(COALESCE(marktanteilbewertung, 0)) AS marktanteilbewertung
    FROM dbp_data.sortiment_leistung AS A
    WHERE
        kjwo_update IN (
            SELECT MAX(kjwo_update) AS a1290333724
            FROM dbp_data.art_kl_preislage_zu_per
            WHERE mandant_id = 1
        )
        AND mandant_id = 1
    GROUP BY
        mandant_id,
        kjwo_update,
        wg_id,
        wug_id
) AS b
WHERE
    sortiment_leistung.wug_id = b.wug_id AND sortiment_leistung.wg_id = b.wg_id AND sortiment_leistung.mandant_id = b.mandant_id AND sortiment_leistung.kjwo_update = b.kjwo_update;


CREATE OR REPLACE TEMPORARY TABLE _artikel_anteil_uwg_ranking_1st_base AS
SELECT
    A.mandant_id,
    c.art_matching_id,
    c.kl_wg_id,
    c.kl_owg_id,
    c.kl_uwg_id,
    COUNT(DISTINCT x.kjwo) AS anz,
    SUM(A.distr_gew) / COUNT(DISTINCT x.kjwo) AS distr_gew_,
    SUM(A.menge) AS menge_,
    SUM(A.umsatz_brutto) AS umsatz_,
    SUM(A.menge_af) AS menge_af_,
    SUM(A.umsatz_brutto_af) AS umsatz_af_,
    SUM(A.menge_sa) AS menge_sa_,
    SUM(A.umsatz_brutto_sa) AS umsatz_sa_,
    SUM(0) AS umsatz_anteil_kum_uwg,
    RANK() OVER (
        PARTITION BY
            c.kl_wg_id, c.kl_owg_id ORDER BY
            c.kl_wg_id IS NULL, c.kl_wg_id, c.kl_owg_id IS NULL, c.kl_owg_id,
            SUM(A.umsatz_brutto) IS NULL DESC, SUM(A.umsatz_brutto) DESC
    ) AS rang_umsatz_uwg,
    RANK() OVER (
        PARTITION BY
            c.kl_wg_id, c.kl_owg_id ORDER BY
            c.kl_wg_id IS NULL, c.kl_wg_id, c.kl_owg_id IS NULL, c.kl_owg_id,
            SUM(A.menge) IS NULL DESC, SUM(A.menge) DESC
    ) AS rang_absatz_uwg,
    RANK() OVER (PARTITION BY c.kl_wg_id ORDER BY c.kl_wg_id IS NULL, c.kl_wg_id, SUM(
        A.umsatz_brutto) IS NULL DESC, SUM(
        A.umsatz_brutto
    ) DESC) AS rang_umsatz_wg
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
        gtin_id,
        art_matching_id,
        kl_wg_id,
        kl_owg_id,
        kl_uwg_id
    FROM dbp_etl.art_matching_nielsen_per
    GROUP BY
        mandant_id,
        gtin_id,
        art_matching_id,
        kl_wg_id,
        kl_owg_id,
        kl_uwg_id
) AS c ON B.gtin_id = c.gtin_id AND B.mandant_id = c.mandant_id
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
    c.kl_uwg_id;


INSERT INTO `_artikel_anteil_uwg_ranking_1st_base`
(
    SELECT
        A.mandant_id,
        c.art_matching_id,
        c.kl_wg_id,
        c.kl_owg_id,
        c.kl_uwg_id,
        COUNT(DISTINCT x.kjwo) AS anz,
        SUM(A.distr_gew) / COUNT(DISTINCT x.kjwo) AS distr_gew_,
        SUM(A.menge) AS menge_,
        SUM(A.umsatz_brutto) AS umsatz_,
        SUM(A.menge_af) AS menge_af_,
        SUM(A.umsatz_brutto_af) AS umsatz_af_,
        SUM(A.menge_sa) AS menge_sa_,
        SUM(A.umsatz_brutto_sa) AS umsatz_sa_,
        SUM(0) AS umsatz_anteil_kum_uwg,
        RANK() OVER (
            PARTITION BY
                c.kl_wg_id, c.kl_owg_id ORDER BY
                c.kl_wg_id IS NULL, c.kl_wg_id, c.kl_owg_id IS NULL, c.kl_owg_id,
                SUM(A.umsatz_brutto) IS NULL DESC, SUM(A.umsatz_brutto) DESC
        ) AS rang_umsatz_uwg,
        RANK() OVER (
            PARTITION BY
                c.kl_wg_id, c.kl_owg_id ORDER BY
                c.kl_wg_id IS NULL, c.kl_wg_id, c.kl_owg_id IS NULL, c.kl_owg_id,
                SUM(A.menge) IS NULL DESC, SUM(A.menge) DESC
        ) AS rang_absatz_uwg,
        RANK() OVER (PARTITION BY c.kl_wg_id ORDER BY c.kl_wg_id IS NULL, c.kl_wg_id, SUM(
            A.umsatz_brutto) IS NULL DESC, SUM(
            A.umsatz_brutto
        ) DESC) AS rang_umsatz_wg
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
        c.art_matching_id,
        c.kl_wg_id,
        c.kl_owg_id,
        c.kl_uwg_id
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
WHERE (
    mandant_id, art_matching_id) IN (
    SELECT (mandant_id, matching_id)
    FROM dbp_data.sortiment_leistung
    WHERE
        mandant_id = 1
        AND kjwo_update IN (
            SELECT MAX(kjwo_update) AS kjwo_update
            FROM dbp_data.art_kl_preislage_zu_per
            WHERE mandant_id = 1
        )
)
GROUP BY
    mandant_id,
    art_matching_id,
    kl_wg_id,
    kl_owg_id,
    kl_uwg_id;


CREATE OR REPLACE TEMPORARY TABLE _murks AS
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
    0 AS umsatz_gesamt,
    0 AS umsatz_anteil_uwg,
    100 AS umsatz_anteil_kum_uwg
FROM dbp_data.sortiment_leistung
WHERE kjwo_update IN (
    SELECT MAX(kjwo_update) AS kjwo_update
    FROM dbp_data.art_kl_preislage_zu_per
    WHERE mandant_id = 1
)
AND mandant_id = 1;


UPDATE `_murks` SET
    umsatz_artikel = b.umsatz_artikel FROM (
    SELECT
        mandant_id,
        art_matching_id,
        SUM(umsatz__) AS umsatz_artikel
    FROM `_artikel_anteil_uwg_ranking`
    GROUP BY
        mandant_id,
        art_matching_id
) AS b
WHERE `_murks`.mandant_id = b.mandant_id AND `_murks`.matching_id = b.art_matching_id;


CREATE OR REPLACE TEMPORARY TABLE _gesamt_uwg AS
SELECT
    kl_owg_id,
    kl_uwg_id,
    SUM(umsatz__) AS umsatz
FROM `_artikel_anteil_uwg_ranking`
GROUP BY
    kl_owg_id,
    kl_uwg_id;


UPDATE `_murks` SET
    umsatz_gesamt = cast(b.umsatz as integer),  
    umsatz_anteil_uwg = cast(ROUND(
        CAST(`_murks`.umsatz_artikel AS FLOAT64) / IF(CAST(b.umsatz AS FLOAT64) = 0, NULL, CAST(b.umsatz AS FLOAT64)
        ) * 100.00, 16
    ) as integer)
FROM (
    SELECT *
    FROM `_gesamt_uwg` 
    GROUP BY
        kl_owg_id,
        kl_uwg_id,
        umsatz
) AS b
WHERE `_murks`.kl_uwg_id = b.kl_uwg_id AND `_murks`.kl_owg_id = b.kl_owg_id;


UPDATE `_artikel_anteil_uwg_ranking` SET
    umsatz_anteil_kum_uwg = cast(ROUND(CAST(
        `_artikel_anteil_uwg_ranking`.umsatz__ AS FLOAT64) / IF(
        CAST(b.umsatz AS FLOAT64) =
        0, NULL, CAST(b.umsatz AS FLOAT64)
    ) * 100.00, 5) as integer)
FROM (
    SELECT *
    FROM `_gesamt_uwg`  
    GROUP BY
        kl_owg_id,
        kl_uwg_id,
        umsatz
) AS b
WHERE `_artikel_anteil_uwg_ranking`.kl_uwg_id = b.kl_uwg_id AND `_artikel_anteil_uwg_ranking`.kl_owg_id = b.kl_owg_id;


UPDATE `_murks` SET
    umsatz_anteil_kum_uwg = b.umsatz_anteil_kum FROM (SELECT
    art_matching_id,
    kl_owg_id,
    kl_uwg_id,
    SUM(umsatz_anteil_kum_uwg) OVER (
        PARTITION BY kl_owg_id, kl_uwg_id ORDER BY rang_umsatz_uwg IS NULL, rang_umsatz_uwg
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS umsatz_anteil_kum
FROM `_artikel_anteil_uwg_ranking`) AS b
WHERE `_murks`.matching_id = b.art_matching_id AND `_murks`.kl_uwg_id = b.kl_uwg_id AND `_murks`.kl_owg_id = b.kl_owg_id;


UPDATE dbp_data.sortiment_leistung SET
    umsatz_artikel = b.umsatz_artikel,
    umsatz_anteil_uwg = b.umsatz_anteil_uwg,
    umsatz_anteil_uwg_kumuliert = b.umsatz_anteil_kum_uwg FROM (
    SELECT
        mandant_id,
        matching_id,
        kjwo_update,
        MAX(umsatz_artikel) AS umsatz_artikel,
        MAX(umsatz_anteil_uwg) AS umsatz_anteil_uwg,
        MAX(umsatz_anteil_kum_uwg) AS umsatz_anteil_kum_uwg
    FROM `_murks`
    GROUP BY
        mandant_id,
        matching_id,
        kjwo_update
) AS b
WHERE
    sortiment_leistung.mandant_id = b.mandant_id AND sortiment_leistung.kjwo_update = b.kjwo_update AND
    sortiment_leistung.matching_id = b.matching_id;
