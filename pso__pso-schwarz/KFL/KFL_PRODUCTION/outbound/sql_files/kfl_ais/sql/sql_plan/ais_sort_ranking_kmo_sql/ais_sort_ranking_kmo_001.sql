CREATE OR REPLACE TEMPORARY TABLE _art_nielsen AS
SELECT *
FROM dbp_data.art_nielsen
WHERE dat_bis = DATE '9999-12-31';


CREATE OR REPLACE TEMPORARY TABLE _artikel_anteil_uwg_ranking AS
SELECT
    A.mandant_id,
    c.art_matching_id,
    c.kl_wg_id,
    c.kl_owg_id,
    c.kl_uwg_id,
    COUNT(DISTINCT x.kjmo) AS anz,
    SUM(A.distr_gew) / COUNT(DISTINCT x.kjmo) AS distr_gew_,
    SUM(A.menge) AS menge_,
    SUM(A.umsatz_brutto) AS umsatz_,
    SUM(A.menge_af) AS menge_af_,
    SUM(A.umsatz_brutto_af) AS umsatz_af_,
    SUM(A.menge_sa) AS menge_sa_,
    SUM(A.umsatz_brutto_sa) AS umsatz_sa_,
    SUM(0) AS umsatz_anteil_kum_uwg,
    RANK() OVER (
        PARTITION BY
            A.mandant_id, c.kl_wg_id, c.kl_owg_id ORDER BY A.mandant_id IS NULL, A.mandant_id, c.kl_wg_id
        IS NULL, c.kl_wg_id, c.kl_owg_id IS NULL, c.kl_owg_id, SUM(A.umsatz_brutto) IS NULL DESC, SUM(A.umsatz_brutto) DESC
    ) AS rang_umsatz_uwg,
    RANK() OVER (
        PARTITION BY
            A.mandant_id, c.kl_wg_id, c.kl_owg_id ORDER BY
            A.mandant_id IS NULL, A.mandant_id, c.kl_wg_id
            IS NULL, c.kl_wg_id, c.kl_owg_id IS NULL, c.kl_owg_id, SUM(A.menge) IS NULL DESC, SUM(A.menge) DESC
    ) AS
    rang_absatz_uwg,
    RANK() OVER (
        PARTITION BY
            A.mandant_id, c.kl_wg_id ORDER BY
            A.mandant_id IS NULL, A.mandant_id, c.kl_wg_id IS NULL, c.kl_wg_id,
            SUM(A.umsatz_brutto) IS NULL DESC, SUM(A.umsatz_brutto) DESC
    ) AS rang_umsatz_wg
FROM dbp_data.art_nielsen_fakten_kjmo AS A
INNER JOIN (
    SELECT kjmo
    FROM dbp_data.tag
    GROUP BY kjmo
) AS x
    ON A.kjmo = x.kjmo
INNER JOIN `_art_nielsen` AS B ON A.mandant_id = B.mandant_id AND A.art_nielsen_id = B.art_nielsen_id
INNER JOIN (
    SELECT
        mandant_id,
        gtin_id,
        art_matching_id,
        art_nielsen_id,
        kl_wg_id,
        kl_owg_id,
        kl_uwg_id
    FROM dbp_etl.art_matching_nielsen_per_kmo
    WHERE
        kl_owg_id <> -3
        AND mandant_id = ${mandant_id}
    GROUP BY
        mandant_id,
        gtin_id,
        art_matching_id,
        art_nielsen_id,
        kl_wg_id,
        kl_owg_id,
        kl_uwg_id
) AS c ON B.gtin_id = c.gtin_id AND B.mandant_id = c.mandant_id AND B.art_nielsen_id = c.art_nielsen_id
INNER JOIN dbp_data.nielsen_market AS D ON A.mandant_id = D.mandant_id AND A.nielsen_market_id = D.nielsen_market_id

WHERE
    A.mandant_id = ${mandant_id}
    AND A.kjmo IN (
        SELECT kjmo
        FROM dbp_data.art_nielsen_fakten_kjmo
        WHERE mandant_id = ${mandant_id}
        GROUP BY kjmo
        QUALIFY ((RANK() OVER (ORDER BY kjmo IS NULL DESC, kjmo DESC)) * -1) BETWEEN -12 AND (-1)
    )
    AND D.nielsen_market_cluster_id = ${nielsen_market_id}
    AND B.gtin_id NOT IN (-9999, -9998)
GROUP BY
    A.mandant_id,
    c.art_matching_id,
    c.kl_wg_id,
    c.kl_owg_id,
    c.kl_uwg_id;


INSERT INTO `_artikel_anteil_uwg_ranking`
(
    SELECT
        A.mandant_id,
        t2.art_matching_id,
        t2.kl_wg_id,
        t2.kl_owg_id,
        t2.kl_uwg_id,
        COUNT(DISTINCT x.kjmo) AS anz,
        SUM(A.distr_gew) / COUNT(DISTINCT x.kjmo) AS distr_gew_,
        SUM(A.menge) AS menge_,
        SUM(A.umsatz_brutto) AS umsatz_,
        SUM(A.menge_af) AS menge_af_,
        SUM(A.umsatz_brutto_af) AS umsatz_af_,
        SUM(A.menge_sa) AS menge_sa_,
        SUM(A.umsatz_brutto_sa) AS umsatz_sa_,
        SUM(0) AS umsatz_anteil_kum_uwg,
        RANK() OVER (
            PARTITION BY
                A.mandant_id, t2.kl_wg_id, t2.kl_owg_id ORDER BY
                A.mandant_id IS NULL, A.mandant_id, t2.kl_wg_id
                IS NULL, t2.kl_wg_id, t2.kl_owg_id IS NULL, t2.kl_owg_id, SUM(A.umsatz_brutto) IS NULL DESC, SUM(A.umsatz_brutto)
                DESC
        ) AS rang_umsatz_uwg,
        RANK() OVER (
            PARTITION BY
                A.mandant_id, t2.kl_wg_id, t2.kl_owg_id ORDER BY
                A.mandant_id IS NULL, A.mandant_id, t2.kl_wg_id
                IS NULL, t2.kl_wg_id, t2.kl_owg_id IS NULL, t2.kl_owg_id, SUM(A.menge) IS NULL DESC, SUM(A.menge) DESC
        ) AS
        rang_absatz_uwg,
        RANK() OVER (
            PARTITION BY
                A.mandant_id, t2.kl_wg_id ORDER BY
                A.mandant_id IS NULL, A.mandant_id, t2.kl_wg_id IS NULL,
                t2.kl_wg_id, SUM(A.umsatz_brutto) IS NULL DESC, SUM(A.umsatz_brutto) DESC
        ) AS rang_umsatz_wg
    FROM dbp_data.art_nielsen_fakten_kjmo AS A
    INNER JOIN (
        SELECT kjmo
        FROM dbp_data.tag
        GROUP BY kjmo
    ) AS x
        ON A.kjmo = x.kjmo
    INNER JOIN `_art_nielsen` AS B ON A.mandant_id = B.mandant_id AND A.art_nielsen_id = B.art_nielsen_id
    INNER JOIN (
        SELECT
            mandant_id,
            art_nielsen_id,
            art_matching_id,
            kl_wg_id,
            kl_owg_id,
            kl_uwg_id
        FROM dbp_etl.art_matching_nielsen_per_kmo
        WHERE
            kl_owg_id <> -3
            AND mandant_id = ${mandant_id}
        GROUP BY
            mandant_id,
            art_matching_id,
            art_nielsen_id,
            kl_wg_id,
            kl_owg_id,
            kl_uwg_id
    ) AS t2 ON B.art_nielsen_id = t2.art_nielsen_id AND B.mandant_id = t2.mandant_id
    INNER JOIN dbp_data.nielsen_market AS D ON A.mandant_id = D.mandant_id AND A.nielsen_market_id = D.nielsen_market_id

    WHERE
        A.mandant_id = ${mandant_id}
        AND A.kjmo IN (
            SELECT kjmo
            FROM dbp_data.art_nielsen_fakten_kjmo
            WHERE mandant_id = ${mandant_id}
            GROUP BY kjmo
            QUALIFY ((RANK() OVER (ORDER BY kjmo IS NULL DESC, kjmo DESC)) * -1) BETWEEN -12 AND (-1)
        )
        AND D.nielsen_market_cluster_id = ${nielsen_market_id}
        AND B.gtin_id IN (-9999, -9998)
    GROUP BY
        A.mandant_id,
        t2.art_matching_id,
        t2.kl_wg_id,
        t2.kl_owg_id,
        t2.kl_uwg_id
);


CREATE OR REPLACE TEMPORARY TABLE _artikel_anteil_uwg_ranking2 AS
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
FROM `_artikel_anteil_uwg_ranking` AS A
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
WHERE mandant_id = ${mandant_id} AND kjwo_update IN (
    SELECT MAX(kjwo_update) AS a1290333724
    FROM dbp_data.art_kl_preislage_zu_per
    WHERE mandant_id = ${mandant_id}
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
    FROM `_artikel_anteil_uwg_ranking2` AS A
    INNER JOIN (SELECT
        mandant_id,
        art_matching_id
    FROM `_artikel_anteil_uwg_ranking2`
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
        WHERE mandant_id = ${mandant_id}
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
    WHERE mandant_id = ${mandant_id}
)
AND mandant_id = ${mandant_id}
AND rang_umsatz_uwg IS NOT NULL;


UPDATE dbp_data.sortiment_leistung SET
    rang_umsatz_uwg = b.rang_umsatz_uwg_,
    rang_absatz_uwg = b.rang_absatz_uwg_
FROM `_upd_rank` AS b
WHERE sortiment_leistung.kjwo_update IN (
    SELECT MAX(kjwo_update) AS a1290333724
    FROM dbp_data.art_kl_preislage_zu_per
    WHERE mandant_id = ${mandant_id}
) AND sortiment_leistung.mandant_id = ${mandant_id} AND sortiment_leistung.matching_id = b.matching_id
AND sortiment_leistung.rang_umsatz_uwg = b.rang_umsatz_uwg AND sortiment_leistung.rang_absatz_uwg = b.rang_absatz_uwg;


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
    WHERE mandant_id = ${mandant_id}
)
AND mandant_id = ${mandant_id}
AND rang_umsatz_wg IS NOT NULL;


UPDATE dbp_data.sortiment_leistung SET
    rang_umsatz_wg = b.rang_umsatz_wg_
FROM `_upd_rank_wg` AS b
WHERE sortiment_leistung.kjwo_update IN (
    SELECT MAX(kjwo_update) AS a1290333724
    FROM dbp_data.art_kl_preislage_zu_per
    WHERE mandant_id = ${mandant_id}
) AND sortiment_leistung.mandant_id = ${mandant_id} AND sortiment_leistung.matching_id = b.matching_id
AND sortiment_leistung.rang_umsatz_wg = b.rang_umsatz_wg;


UPDATE dbp_data.sortiment_leistung AS sortiment_leistung0 SET
    rang_umsatz_uwg = b.next_rang_ums_uwg,
    rang_absatz_uwg = b.next_rang_abs_uwg FROM (SELECT
    kl_owg_id,
    MAX(rang_umsatz_uwg) + 1 AS next_rang_ums_uwg,
    MAX(rang_absatz_uwg) + 1 AS next_rang_abs_uwg
FROM dbp_data.sortiment_leistung
WHERE
    rang_umsatz_uwg IS NOT NULL
    AND mandant_id = ${mandant_id}
    AND kjwo_update IN (
        SELECT MAX(kjwo_update) AS a1290333724
        FROM dbp_data.art_kl_preislage_zu_per
        WHERE mandant_id = ${mandant_id}
    )
GROUP BY kl_owg_id) AS b
WHERE
    sortiment_leistung0.kl_owg_id = b.kl_owg_id AND sortiment_leistung0.rang_umsatz_uwg IS NULL AND
    sortiment_leistung0.rang_absatz_uwg IS NULL AND sortiment_leistung0.mandant_id = ${mandant_id} AND sortiment_leistung0.kjwo_update
    IN (
        SELECT MAX(kjwo_update) AS a1290333724
        FROM dbp_data.art_kl_preislage_zu_per
        WHERE mandant_id = ${mandant_id}
    );


UPDATE dbp_data.sortiment_leistung AS sortiment_leistung0 SET
    rang_umsatz_wg = b.next_rang_ums_wg FROM (SELECT
    kl_wg_id,
    MAX(rang_umsatz_wg) + 1 AS next_rang_ums_wg
FROM dbp_data.sortiment_leistung
WHERE
    rang_umsatz_wg IS NOT NULL
    AND mandant_id = ${mandant_id}
    AND kjwo_update IN (
        SELECT MAX(kjwo_update) AS a1290333724
        FROM dbp_data.art_kl_preislage_zu_per
        WHERE mandant_id = ${mandant_id}
    )
GROUP BY kl_wg_id) AS b
WHERE
    sortiment_leistung0.kl_wg_id = b.kl_wg_id AND sortiment_leistung0.rang_umsatz_wg IS NULL AND sortiment_leistung0.mandant_id
    = ${mandant_id} AND sortiment_leistung0.kjwo_update IN (
        SELECT MAX(kjwo_update) AS a1290333724
        FROM dbp_data.art_kl_preislage_zu_per
        WHERE mandant_id = ${mandant_id}
    );


UPDATE dbp_data.sortiment_leistung AS sortiment_leistung1 SET
    rang_umsatz_uwg = b.next_rang_ums_uwg,
    rang_absatz_uwg = b.next_rang_abs_uwg FROM (SELECT
    kl_owg_id,
    COALESCE(MAX(rang_umsatz_uwg), 0) + 1 AS next_rang_ums_uwg,
    COALESCE(MAX(rang_absatz_uwg), 0) + 1 AS next_rang_abs_uwg
FROM dbp_data.sortiment_leistung
WHERE
    mandant_id = ${mandant_id}
    AND kl_owg_id IN (
        SELECT kl_owg_id
        FROM (SELECT
            kl_owg_id,
            MAX(CASE
                WHEN rang_umsatz_uwg IS NULL
                    THEN 1
                ELSE 2
            END) AS rang_xxx
        FROM dbp_data.sortiment_leistung
        WHERE
            mandant_id = ${mandant_id}
            AND kjwo_update IN (
                SELECT MAX(kjwo_update) AS a1290333724
                FROM dbp_data.art_kl_preislage_zu_per
                WHERE mandant_id = ${mandant_id}
            )
        GROUP BY kl_owg_id
        HAVING rang_xxx = 1) AS x
    )
    AND kjwo_update IN (
        SELECT MAX(kjwo_update) AS a1290333724
        FROM dbp_data.art_kl_preislage_zu_per
        WHERE mandant_id = ${mandant_id}
    )
GROUP BY kl_owg_id) AS b
WHERE
    sortiment_leistung1.kl_owg_id = b.kl_owg_id AND sortiment_leistung1.rang_umsatz_uwg IS NULL AND
    sortiment_leistung1.mandant_id = ${mandant_id} AND sortiment_leistung1.kjwo_update IN (
        SELECT MAX(kjwo_update) AS a1290333724
        FROM dbp_data.art_kl_preislage_zu_per
        WHERE mandant_id = ${mandant_id}
    );


UPDATE dbp_data.sortiment_leistung AS sortiment_leistung0 SET
    rang_umsatz_wg = b.next_rang_ums_wg FROM (SELECT
    kl_wg_id,
    COALESCE(MAX(rang_umsatz_wg), 0) + 1 AS next_rang_ums_wg
FROM dbp_data.sortiment_leistung
WHERE
    mandant_id = ${mandant_id}
    AND kjwo_update IN (
        SELECT MAX(kjwo_update) AS a1290333724
        FROM dbp_data.art_kl_preislage_zu_per
        WHERE mandant_id = ${mandant_id}
    )
GROUP BY kl_wg_id) AS b
WHERE
    sortiment_leistung0.kl_wg_id = b.kl_wg_id AND sortiment_leistung0.rang_umsatz_wg IS NULL AND sortiment_leistung0.mandant_id
    = ${mandant_id} AND sortiment_leistung0.kjwo_update IN (
        SELECT MAX(kjwo_update) AS a1290333724
        FROM dbp_data.art_kl_preislage_zu_per
        WHERE mandant_id = ${mandant_id}
    );


CREATE OR REPLACE TEMPORARY TABLE _artikel_anteil_uwg_ranking_kl AS
SELECT
    A.mandant_id,
    B.art_nielsen_id,
    c.kl_wg_id,
    c.kl_owg_id,
    c.kl_uwg_id,
    B.gtin_id,
    COUNT(DISTINCT x.kjmo) AS anz,
    COUNT(DISTINCT A.kjmo) AS anz_wochen,
    SUM(A.distr_gew) / COUNT(DISTINCT A.kjmo) AS distr_gew_,
    SUM(A.menge) AS menge_,
    SUM(A.umsatz_brutto) AS umsatz_,
    SUM(A.anz_maerkte) AS anz_maerkte,
    SUM(0) AS umsatz_anteil_kum_uwg,
    DENSE_RANK() OVER (
        PARTITION BY
            A.mandant_id, c.kl_owg_id ORDER BY
            SUM(A.umsatz_brutto) IS NULL DESC, SUM(A.umsatz_brutto
            ) DESC
    ) AS rang_umsatz_uwg,
    DENSE_RANK()
        OVER (PARTITION BY A.mandant_id, c.kl_owg_id ORDER BY SUM(A.menge) IS NULL DESC, SUM(A.menge) DESC) AS
    rang_absatz_uwg,
    0 AS rang_umsatz_wg
FROM dbp_data.art_nielsen_fakten_kjmo AS A
INNER JOIN (
    SELECT kjmo
    FROM dbp_data.tag
    GROUP BY kjmo
) AS x
    ON A.kjmo = x.kjmo
INNER JOIN `_art_nielsen` AS B ON A.mandant_id = B.mandant_id AND A.art_nielsen_id = B.art_nielsen_id
INNER JOIN (
    SELECT
        mandant_id,
        art_nielsen_id,
        kl_wg_id,
        kl_owg_id,
        kl_uwg_id
    FROM dbp_etl.art_matching_nielsen_per_kmo
    GROUP BY
        mandant_id,
        art_nielsen_id,
        kl_wg_id,
        kl_owg_id,
        kl_uwg_id
) AS c ON B.art_nielsen_id = c.art_nielsen_id AND B.mandant_id = c.mandant_id
INNER JOIN dbp_data.nielsen_market AS D ON A.mandant_id = D.mandant_id AND A.nielsen_market_id = D.nielsen_market_id

WHERE
    A.kjmo IN (
        SELECT kjmo
        FROM dbp_data.art_nielsen_fakten_kjmo
        WHERE mandant_id = ${mandant_id}
        GROUP BY kjmo
        QUALIFY ((RANK() OVER (ORDER BY kjmo IS NULL DESC, kjmo DESC)) * -1) BETWEEN -12 AND (-1)
    )
    AND D.nielsen_market_cluster_id = ${nielsen_market_id}
    AND A.mandant_id = ${mandant_id}
GROUP BY
    A.mandant_id,
    B.art_nielsen_id,
    c.kl_wg_id,
    c.kl_owg_id,
    c.kl_uwg_id,
    B.gtin_id;


CREATE OR REPLACE TEMPORARY TABLE _artikel_anteil_uwg_ranking_x AS
SELECT
    A.mandant_id,
    B.art_nielsen_id,
    c.kl_wg_id,
    c.kl_owg_id,
    c.kl_uwg_id,
    B.gtin_id,
    COUNT(DISTINCT x.kjmo) AS anz,
    SUM(A.distr_gew) / COUNT(DISTINCT x.kjmo) AS distr_gew_,
    SUM(A.menge) AS menge_,
    SUM(A.umsatz_brutto) AS umsatz_,
    SUM(A.menge_af) AS menge_af_,
    SUM(A.umsatz_brutto_af) AS umsatz_af_,
    SUM(A.menge_sa) AS menge_sa_,
    SUM(A.umsatz_brutto_sa) AS umsatz_sa_,
    SUM(0) AS umsatz_anteil_kum_uwg,
    DENSE_RANK() OVER (
        PARTITION BY
            A.mandant_id, c.kl_owg_id ORDER BY
            SUM(A.umsatz_brutto) IS NULL DESC, SUM(A.umsatz_brutto
            ) DESC
    ) AS rang_umsatz_uwg,
    DENSE_RANK()
        OVER (PARTITION BY A.mandant_id, c.kl_owg_id ORDER BY SUM(A.menge) IS NULL DESC, SUM(A.menge) DESC) AS
    rang_absatz_uwg,
    0 AS rang_umsatz_wg
FROM dbp_data.art_nielsen_fakten_kjmo AS A
INNER JOIN (
    SELECT kjmo
    FROM dbp_data.tag
    GROUP BY kjmo
) AS x
    ON A.kjmo = x.kjmo
INNER JOIN `_art_nielsen` AS B ON A.mandant_id = B.mandant_id AND A.art_nielsen_id = B.art_nielsen_id
INNER JOIN (
    SELECT
        mandant_id,
        art_nielsen_id,
        kl_wg_id,
        kl_owg_id,
        kl_uwg_id
    FROM dbp_etl.art_matching_nielsen_per_kmo
    GROUP BY
        mandant_id,
        art_nielsen_id,
        kl_wg_id,
        kl_owg_id,
        kl_uwg_id
) AS c ON B.art_nielsen_id = c.art_nielsen_id AND B.mandant_id = c.mandant_id
INNER JOIN dbp_data.nielsen_market AS D ON A.mandant_id = D.mandant_id AND A.nielsen_market_id = D.nielsen_market_id

WHERE
    A.kjmo IN (
        SELECT kjmo
        FROM dbp_data.art_nielsen_fakten_kjmo
        WHERE mandant_id = ${mandant_id}
        GROUP BY kjmo
        QUALIFY ((RANK() OVER (ORDER BY kjmo IS NULL DESC, kjmo DESC)) * -1) BETWEEN -12 AND (-1)
    )
    AND D.nielsen_market_cluster_id = 2
    AND A.mandant_id = ${mandant_id}
GROUP BY
    A.mandant_id,
    B.art_nielsen_id,
    c.kl_wg_id,
    c.kl_owg_id,
    c.kl_uwg_id,
    B.gtin_id;


CREATE OR REPLACE TEMPORARY TABLE _kl_ma_owg_1 AS
SELECT
    a.mandant_id,
    a.kl_owg_id,
    SUM(a.umsatz__) AS umsatz_x,
    SUM(b.umsatz_kl) AS umsatz_kl_x,
    IFNULL(SUM(b.umsatz_kl) / IF(SUM(a.umsatz__) = 0, NULL, SUM(a.umsatz__)), 0) * 100.00 AS marktanteil_owg
FROM (
    SELECT
        mandant_id,
        kl_owg_id,
        SUM(umsatz_) AS umsatz__
    FROM `_artikel_anteil_uwg_ranking_x`
    GROUP BY
        mandant_id,
        kl_owg_id
) AS a
INNER JOIN (
    SELECT
        mandant_id,
        kl_owg_id,
        SUM(umsatz_) AS umsatz_kl
    FROM `_artikel_anteil_uwg_ranking_kl`
    GROUP BY
        mandant_id,
        kl_owg_id
) AS b ON a.kl_owg_id = b.kl_owg_id AND a.mandant_id = b.mandant_id
GROUP BY
    a.mandant_id,
    a.kl_owg_id;


CREATE OR REPLACE TEMPORARY TABLE _kl_ma_uwg_1 AS
SELECT
    a.mandant_id,
    a.kl_owg_id,
    a.kl_uwg_id,
    SUM(a.umsatz__) AS umsatz_x,
    SUM(b.umsatz_kl) AS umsatz_kl_x,
    IFNULL(SUM(b.umsatz_kl) / IF(SUM(a.umsatz__) = 0, NULL, SUM(a.umsatz__)), 0) * 100.00 AS marktanteil_uwg
FROM (
    SELECT
        mandant_id,
        kl_owg_id,
        kl_uwg_id,
        SUM(umsatz_) AS umsatz__
    FROM `_artikel_anteil_uwg_ranking_x`
    GROUP BY
        mandant_id,
        kl_owg_id,
        kl_uwg_id
) AS a
INNER JOIN (
    SELECT
        mandant_id,
        kl_owg_id,
        kl_uwg_id,
        SUM(umsatz_) AS umsatz_kl
    FROM `_artikel_anteil_uwg_ranking_kl`
    GROUP BY
        mandant_id,
        kl_owg_id,
        kl_uwg_id
) AS b ON a.kl_owg_id = b.kl_owg_id AND a.kl_uwg_id = b.kl_uwg_id AND a.mandant_id = b.mandant_id
GROUP BY
    a.mandant_id,
    a.kl_owg_id,
    a.kl_uwg_id;


UPDATE dbp_data.sortiment_leistung SET
    marktanteilbewertung = b.indexpunkt FROM (
    SELECT
        A.mandant_id,
        B.kl_owg_id,
        B.kl_uwg_id,
        A.marktanteil_owg,
        B.marktanteil_uwg,
        IFNULL(B.marktanteil_uwg / IF(A.marktanteil_owg = 0, NULL, A.marktanteil_owg), 0) AS indexpunkt
    FROM `_kl_ma_owg_1` AS A
    INNER JOIN `_kl_ma_uwg_1` AS B ON A.kl_owg_id = B.kl_owg_id AND A.mandant_id = B.mandant_id
) AS b
WHERE sortiment_leistung.mandant_id = b.mandant_id AND sortiment_leistung.kl_uwg_id = b.kl_uwg_id AND sortiment_leistung.kl_owg_id = b.kl_owg_id AND sortiment_leistung.mandant_id = ${mandant_id} AND sortiment_leistung.kjwo_update IN (SELECT
    MAX(kjwo_update
    ) AS a1290333724
FROM dbp_data.art_kl_preislage_zu_per
WHERE mandant_id = ${mandant_id});


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
        WHERE mandant_id = ${mandant_id}
    )
    AND mandant_id = ${mandant_id}
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
WHERE sortiment_leistung.wug_id = b.wug_id AND sortiment_leistung.wg_id = b.wg_id AND sortiment_leistung.mandant_id = b.mandant_id AND sortiment_leistung.kjwo_update IN (
    SELECT MAX(kjwo_update) AS a1290333724
    FROM dbp_data.art_kl_preislage_zu_per
    WHERE mandant_id = ${mandant_id}
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
            WHERE mandant_id = ${mandant_id}
        )
        AND mandant_id = ${mandant_id}
    GROUP BY
        mandant_id,
        kjwo_update,
        wg_id,
        wug_id
) AS b
WHERE sortiment_leistung.wug_id = b.wug_id AND sortiment_leistung.wg_id = b.wg_id AND sortiment_leistung.mandant_id = b.mandant_id AND sortiment_leistung.kjwo_update = b.kjwo_update;


CREATE OR REPLACE TEMPORARY TABLE _artikel_anteil_uwg_ranking_1st_base AS
SELECT
    A.mandant_id,
    c.art_matching_id,
    c.kl_wg_id,
    c.kl_owg_id,
    c.kl_uwg_id,
    COUNT(DISTINCT x.kjmo) AS anz,
    SUM(A.distr_gew) / COUNT(DISTINCT x.kjmo) AS distr_gew_,
    SUM(A.menge) AS menge_,
    SUM(A.umsatz_brutto) AS umsatz_,
    SUM(A.menge_af) AS menge_af_,
    SUM(A.umsatz_brutto_af) AS umsatz_af_,
    SUM(A.menge_sa) AS menge_sa_,
    SUM(A.umsatz_brutto_sa) AS umsatz_sa_,
    SUM(round(NUMERIC '0', 4)) AS umsatz_anteil_kum_uwg,
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
    RANK() OVER (PARTITION BY c.kl_wg_id ORDER BY c.kl_wg_id IS NULL, c.kl_wg_id, SUM(A.umsatz_brutto) IS NULL DESC, SUM(A.umsatz_brutto) DESC) AS rang_umsatz_wg
FROM dbp_data.art_nielsen_fakten_kjmo AS A
INNER JOIN (
    SELECT kjmo
    FROM dbp_data.tag
    GROUP BY kjmo
) AS x
    ON A.kjmo = x.kjmo
INNER JOIN `_art_nielsen` AS B ON A.mandant_id = B.mandant_id AND A.art_nielsen_id = B.art_nielsen_id
INNER JOIN (
    SELECT
        mandant_id,
        gtin_id,
        art_matching_id,
        art_nielsen_id,
        kl_wg_id,
        kl_owg_id,
        kl_uwg_id
    FROM dbp_etl.art_matching_nielsen_per_kmo
    WHERE kl_owg_id <> -3
    GROUP BY
        mandant_id,
        gtin_id,
        art_matching_id,
        art_nielsen_id,
        kl_wg_id,
        kl_owg_id,
        kl_uwg_id
) AS c ON B.gtin_id = c.gtin_id AND B.mandant_id = c.mandant_id AND B.art_nielsen_id = c.art_nielsen_id
INNER JOIN dbp_data.nielsen_market AS D ON A.mandant_id = D.mandant_id AND A.nielsen_market_id = D.nielsen_market_id

INNER JOIN (
    SELECT *
    FROM dbp_data.sortiment_leistung AS ZZ
    WHERE kjwo_update IN (
        SELECT MAX(kjwo_update) AS kjwo_update
        FROM dbp_data.art_kl_preislage_zu_per
        WHERE mandant_id = ${mandant_id}
    )
) AS t6
    ON A.mandant_id = t6.mandant_id AND c.art_matching_id = t6.matching_id
WHERE
    A.kjmo IN (
        SELECT kjmo
        FROM dbp_data.art_nielsen_fakten_kjmo
        WHERE mandant_id = ${mandant_id}
        GROUP BY kjmo
        QUALIFY ((RANK() OVER (ORDER BY kjmo IS NULL DESC, kjmo DESC)) * -1) BETWEEN -12 AND (-1)
    )
    AND D.nielsen_market_cluster_id = ${nielsen_market_id}
    AND A.mandant_id = ${mandant_id}
    AND B.gtin_id NOT IN (-9999, -9998)
GROUP BY
    A.mandant_id,
    c.art_matching_id,
    c.kl_wg_id,
    c.kl_owg_id,
    c.kl_uwg_id;


INSERT INTO _artikel_anteil_uwg_ranking_1st_base
with target_kjmo as (
    SELECT X.KJMO
    FROM
        (
            SELECT
                KJMO,
                rank() OVER (ORDER BY if(KJMO IS NULL, 0, 1), KJMO DESC) * -NUMERIC '1' AS AKT_MO
            FROM
                dbp_data.art_nielsen_fakten_kjmo
            WHERE MANDANT_ID = ${mandant_id}
            GROUP BY 1
        ) AS X
    WHERE X.AKT_MO BETWEEN -NUMERIC '12' AND -NUMERIC '1'
)

SELECT
    A.MANDANT_ID,
    C.ART_MATCHING_ID,
    C.KL_WG_ID,
    C.KL_OWG_ID,
    C.KL_UWG_ID,
    count(DISTINCT X.KJMO) AS ANZ,
    sum(A.DISTR_GEW) / count(DISTINCT X.KJMO) AS DISTR_GEW_,
    sum(A.MENGE) AS MENGE_,
    sum(A.UMSATZ_BRUTTO) AS UMSATZ_,
    sum(A.MENGE_AF) AS MENGE_AF_,
    sum(A.UMSATZ_BRUTTO_AF) AS UMSATZ_AF_,
    sum(A.MENGE_SA) AS MENGE_SA_,
    sum(A.UMSATZ_BRUTTO_SA) AS UMSATZ_SA_,
    sum(round(NUMERIC '0', 4)) AS UMSATZ_ANTEIL_KUM_UWG,
    rank() OVER (PARTITION BY C.KL_WG_ID, C.KL_OWG_ID ORDER BY if(C.KL_WG_ID IS NULL, 0, 1) DESC, C.KL_WG_ID, if(C.KL_OWG_ID IS NULL, 0, 1) DESC, C.KL_OWG_ID, if(sum(A.UMSATZ_BRUTTO) IS NULL, 0, 1), sum(A.UMSATZ_BRUTTO) DESC) AS RANG_UMSATZ_UWG,
    rank() OVER (PARTITION BY C.KL_WG_ID, C.KL_OWG_ID ORDER BY if(C.KL_WG_ID IS NULL, 0, 1) DESC, C.KL_WG_ID, if(C.KL_OWG_ID IS NULL, 0, 1) DESC, C.KL_OWG_ID, if(sum(A.MENGE) IS NULL, 0, 1), sum(A.MENGE) DESC) AS RANG_ABSATZ_UWG,
    rank() OVER (PARTITION BY C.KL_WG_ID ORDER BY if(C.KL_WG_ID IS NULL, 0, 1) DESC, C.KL_WG_ID, if(sum(A.UMSATZ_BRUTTO) IS NULL, 0, 1), sum(A.UMSATZ_BRUTTO) DESC) AS RANG_UMSATZ_WG
FROM
    dbp_data.art_nielsen_fakten_kjmo AS A
INNER JOIN (
    SELECT TAG.KJMO AS KJMO
    FROM
        dbp_data.tag
    GROUP BY 1
) AS X ON A.KJMO = X.KJMO
INNER JOIN _art_nielsen AS B
    ON
        A.MANDANT_ID = B.MANDANT_ID
        AND A.ART_NIELSEN_ID = B.ART_NIELSEN_ID
INNER JOIN (
    SELECT
        ART_MATCHING_NIELSEN_PER_KMO.MANDANT_ID,
        ART_MATCHING_NIELSEN_PER_KMO.ART_NIELSEN_ID,
        ART_MATCHING_NIELSEN_PER_KMO.ART_MATCHING_ID,
        ART_MATCHING_NIELSEN_PER_KMO.KL_WG_ID,
        ART_MATCHING_NIELSEN_PER_KMO.KL_OWG_ID,
        ART_MATCHING_NIELSEN_PER_KMO.KL_UWG_ID
    FROM
        dbp_etl.art_matching_nielsen_per_kmo
    WHERE ART_MATCHING_NIELSEN_PER_KMO.KL_OWG_ID <> -NUMERIC '3'
    GROUP BY 1, 2, 3, 4, 5, 6
) AS C
    ON
        B.ART_NIELSEN_ID = C.ART_NIELSEN_ID
        AND B.MANDANT_ID = C.MANDANT_ID
INNER JOIN dbp_data.nielsen_market AS D
    ON
        A.MANDANT_ID = D.MANDANT_ID
        AND A.NIELSEN_MARKET_ID = D.NIELSEN_MARKET_ID
INNER JOIN dbp_data.sortiment_leistung AS ZZ
    ON
        A.MANDANT_ID = ZZ.MANDANT_ID
        AND C.ART_MATCHING_ID = ZZ.MATCHING_ID
WHERE
    A.KJMO IN (Select KJMO from target_kjmo)
    AND D.NIELSEN_MARKET_CLUSTER_ID = ${nielsen_market_id}
    AND B.GTIN_ID IN (
        -9999, -9998
    )
    AND A.MANDANT_ID = ${mandant_id}
    AND ZZ.KJWO_UPDATE IN (
        SELECT max(KJWO_UPDATE) AS KJWO_UPDATE
        FROM
            dbp_data.art_kl_preislage_zu_per
        WHERE MANDANT_ID = ${mandant_id}
    )
GROUP BY 1, 2, 3, 4, 5;


CREATE OR REPLACE TEMPORARY TABLE _artikel_anteil_uwg_ranking2 AS
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
        mandant_id = ${mandant_id}
        AND kjwo_update IN (
            SELECT MAX(kjwo_update) AS kjwo_update
            FROM dbp_data.art_kl_preislage_zu_per
            WHERE mandant_id = ${mandant_id}
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
    WHERE mandant_id = ${mandant_id}
)
AND mandant_id = ${mandant_id};


UPDATE `_murks` SET
    umsatz_artikel = b.umsatz_artikel FROM (
    SELECT
        mandant_id,
        art_matching_id,
        SUM(umsatz__) AS umsatz_artikel
    FROM `_artikel_anteil_uwg_ranking2`
    GROUP BY
        mandant_id,
        art_matching_id
) AS b
WHERE `_murks`.mandant_id = b.mandant_id AND `_murks`.matching_id = b.art_matching_id;


CREATE OR REPLACE TEMPORARY TABLE _gesamt_uwg AS
SELECT
    mandant_id,
    kl_owg_id,
    kl_uwg_id,
    SUM(umsatz__) AS umsatz
FROM `_artikel_anteil_uwg_ranking2`
GROUP BY
    mandant_id,
    kl_owg_id,
    kl_uwg_id;


UPDATE `_murks` SET
    umsatz_gesamt = CAST(b.umsatz AS INTEGER),
    umsatz_anteil_uwg = CAST(ROUND(
        CAST(`_murks`.umsatz_artikel AS FLOAT64) / IF(CAST(b.umsatz AS FLOAT64) = 0, NULL, CAST(b.umsatz AS FLOAT64)
        ) * 100.00, 16
    ) AS INTEGER)
FROM (
    SELECT *
    FROM `_gesamt_uwg`
    GROUP BY
        mandant_id,
        kl_owg_id,
        kl_uwg_id,
        umsatz
) AS b
WHERE `_murks`.kl_uwg_id = b.kl_uwg_id AND `_murks`.kl_owg_id = b.kl_owg_id AND `_murks`.mandant_id = b.mandant_id;


UPDATE `_artikel_anteil_uwg_ranking2` SET
    umsatz_anteil_kum_uwg = CAST(ROUND(CAST(
        `_artikel_anteil_uwg_ranking2`.umsatz__ AS FLOAT64) / IF(
        CAST(b.umsatz AS FLOAT64) =
        0, NULL, CAST(b.umsatz AS FLOAT64)
    ) * 100.00, 5) AS INTEGER)
FROM (
    SELECT *
    FROM `_gesamt_uwg`
    GROUP BY
        mandant_id,
        kl_owg_id,
        kl_uwg_id,
        umsatz
) AS b
WHERE
    `_artikel_anteil_uwg_ranking2`.kl_uwg_id = b.kl_uwg_id AND `_artikel_anteil_uwg_ranking2`.kl_owg_id = b.kl_owg_id
    AND `_artikel_anteil_uwg_ranking2`.mandant_id = b.mandant_id;


UPDATE `_murks` SET
    umsatz_anteil_kum_uwg = b.umsatz_anteil_kum FROM (SELECT
    mandant_id,
    art_matching_id,
    kl_owg_id,
    kl_uwg_id,
    SUM(umsatz_anteil_kum_uwg) OVER (
        PARTITION BY kl_owg_id, kl_uwg_id ORDER BY rang_umsatz_uwg IS NULL, rang_umsatz_uwg
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS umsatz_anteil_kum
FROM `_artikel_anteil_uwg_ranking2`) AS b
WHERE
    `_murks`.matching_id = b.art_matching_id AND `_murks`.kl_uwg_id = b.kl_uwg_id AND `_murks`.kl_owg_id = b.kl_owg_id
    AND `_murks`.mandant_id = b.mandant_id;


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


CREATE OR REPLACE TEMPORARY TABLE _kill_wge AS
SELECT
    A.mandant_id,
    A.kjwo_update,
    A.matching_id,
    A.art_id
FROM dbp_data.sortiment_leistung AS A
INNER JOIN dbp_data.art AS B ON A.mandant_id = B.mandant_id AND A.art_id = B.art_id
WHERE
    A.art_id <> -1
    AND A.mandant_id = ${mandant_id}
    AND (B.wg_art_fg = 1 OR B.artikeltyp_id = 12);


DELETE FROM dbp_data.sortiment_leistung
WHERE (
    mandant_id, kjwo_update, matching_id, art_id) IN (
    SELECT (mandant_id, kjwo_update, matching_id, art_id)
    FROM `_kill_wge`
) AND mandant_id = ${mandant_id} AND (umsatz_artikel IS NULL OR umsatz_artikel = 0
);


-- dbay, 31.01.2022
-- missing entries from the past week


CREATE OR REPLACE TEMPORARY TABLE _nl_facts AS
SELECT
    A.mandant_id,
    A.art_nielsen_id,
    C.gtin_id,
    SUM(A.umsatz_brutto) AS umsatz_brutto
FROM dbp_data.art_nielsen_fakten_kjmo AS A
INNER JOIN dbp_data.nielsen_market AS B ON A.mandant_id = B.mandant_id AND A.nielsen_market_id = B.nielsen_market_id

INNER JOIN `_art_nielsen` AS C ON A.mandant_id = C.mandant_id AND A.art_nielsen_id = C.art_nielsen_id
WHERE (
    A.mandant_id, A.kjmo) IN (
    SELECT (mandant_id, kjmo)
    FROM dbp_data.art_nielsen_fakten_kjmo
    WHERE mandant_id = ${mandant_id}
    GROUP BY
        mandant_id,
        kjmo
    QUALIFY ((
        RANK()
            OVER (PARTITION BY mandant_id ORDER BY mandant_id IS NULL, mandant_id, kjmo IS NULL DESC, kjmo DESC
            )
    ) * -1) BETWEEN -12 AND (-1)
)
AND B.nielsen_market_cluster_id = 1
AND A.mandant_id = ${mandant_id}
AND A.umsatz_brutto > 0
GROUP BY
    A.mandant_id,
    A.art_nielsen_id,
    C.gtin_id;


CREATE OR REPLACE TEMPORARY TABLE _track AS
SELECT
    A.mandant_id,
    A.art_nielsen_id,
    B.art_matching_id
FROM `_nl_facts` AS A
LEFT JOIN dbp_etl.art_matching_nielsen_per_kmo AS B
    ON
        A.mandant_id = B.mandant_id AND A.art_nielsen_id
        = B.art_nielsen_id
GROUP BY
    A.mandant_id,
    A.art_nielsen_id,
    B.art_matching_id;


CREATE OR REPLACE TEMPORARY TABLE _misses AS
SELECT
    A.mandant_id,
    A.art_matching_id
FROM `_track` AS A
LEFT JOIN (
    SELECT
        mandant_id,
        matching_id
    FROM dbp_data.sortiment_leistung
    WHERE
        mandant_id = ${mandant_id}
        AND kjwo_update IN (
            SELECT MAX(kjwo_update) AS a1290333724
            FROM dbp_data.sortiment_leistung
        )
    GROUP BY
        mandant_id,
        matching_id
) AS b ON A.mandant_id = b.mandant_id AND A.art_matching_id = b.matching_id
INNER JOIN dbp_etl.art_matching_nielsen_per_kmo AS C
    ON
        A.mandant_id = C.mandant_id AND A.art_matching_id
        = C.art_matching_id
INNER JOIN dbp_data.art_wg_zu_per AS D
    ON
        A.mandant_id = D.mandant_id AND C.art_id = D.art_id AND D.arthiertyp_id
        = 2 AND D.dat_bis = DATE '9999-12-31'
INNER JOIN dbp_data.wg_filter_zu AS WFZ ON D.wg_id = WFZ.wg_id AND A.mandant_id = WFZ.mandant_id AND WFZ.wg_filter_id = 47 AND WFZ.arthiertyp_id = 2
WHERE b.matching_id IS NULL
GROUP BY
    A.mandant_id,
    A.art_matching_id;


CREATE OR REPLACE TEMPORARY TABLE _sl AS
SELECT *
FROM dbp_data.sortiment_leistung
WHERE kjwo_update IN (
    SELECT C.kjwo
    FROM dbp_data.woche AS A
    INNER JOIN (
        SELECT MAX(kjwo_update) AS kjwo
        FROM dbp_data.sortiment_leistung
        WHERE mandant_id = ${mandant_id}
    ) AS b
        ON A.kjwo = b.kjwo
    INNER JOIN dbp_data.woche AS C ON A.akt_wo - 1 = C.akt_wo
)
AND mandant_id = ${mandant_id}
AND (
    mandant_id, matching_id) IN (
    SELECT (mandant_id, art_matching_id)
    FROM `_misses`
);


UPDATE `_sl` SET
    kjwo_update = b.kjwo_update,
    kjmo = b.kjmo FROM (SELECT
    mandant_id,
    MAX(kjmo) AS kjmo,
    MAX(kjwo_update) AS kjwo_update
FROM dbp_data.sortiment_leistung
WHERE mandant_id = ${mandant_id}
GROUP BY mandant_id) AS b
WHERE `_sl`.mandant_id = b.mandant_id;


INSERT INTO dbp_data.sortiment_leistung
(
    SELECT DISTINCT *
    FROM `_sl`
    WHERE (
        mandant_id, matching_id, kjwo_update) NOT IN (
        SELECT (mandant_id, matching_id, kjwo_update)
        FROM dbp_data.sortiment_leistung
    )
);
