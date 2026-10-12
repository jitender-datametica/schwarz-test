---------------------------------------------------------------------
--                                                                 --
--                         P H A S E   0                           --
--                                                                 --
-- Korrekte Warengruppenhierarchie fuer alle KL-Artikel.           --
--                                                                 --
---------------------------------------------------------------------


UPDATE dbp_etl_process.tupel_mat_etl SET
    a7_wg_id = b.wg_id,
    wug_id = b.wug_id FROM (
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
    tupel_mat_etl.mandant_id = b.mandant_id AND tupel_mat_etl.art_id = b.art_id AND tupel_mat_etl.a500_kjwo_update = b.kjwo;


UPDATE dbp_etl_process.tupel_mat_etl SET
    a5_owg_id = b.owg_id FROM (
    SELECT *
    FROM dbp_data.wg_per
    WHERE
        dat_bis = DATE '9999-12-31'
        AND mandant_id > 1
        AND owg_id <> -1
) AS b
WHERE
    tupel_mat_etl.mandant_id = b.mandant_id AND tupel_mat_etl.a7_wg_id = b.wg_id AND tupel_mat_etl.art_id <> -1 AND
    tupel_mat_etl.a5_owg_id <> b.owg_id AND tupel_mat_etl.a500_kjwo_update IN (
        SELECT MAX(kjwo_update) AS a1290333724
        FROM dbp_data.art_kl_preislage_zu_per
        WHERE mandant_id > 1
    );


---------------------------------------------------------------------
--                                                                 --
--                         P H A S E   1                           --
--                                                                 --
-- Beruecksichtigung der Pflege des Fachbereichs.                  --
--                                                                 --
---------------------------------------------------------------------


UPDATE dbp_etl_process.tupel_mat_etl SET
    a7_wg_id = b.wg_id,
    wug_id = b.wug_id FROM (
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
    tupel_mat_etl.mandant_id = b.mandant_id AND tupel_mat_etl.a450_art_nielsen_nr = b.art_nielsen_id AND tupel_mat_etl.art_id IS NULL AND tupel_mat_etl.a500_kjwo_update = b.kjwo;


UPDATE dbp_etl_process.tupel_mat_etl SET
    a5_owg_id = b.owg_id FROM (
    SELECT *
    FROM dbp_data.wg_per
    WHERE
        dat_bis = DATE '9999-12-31'
        AND mandant_id > 1
        AND owg_id NOT IN (-1, -3)
) AS b
WHERE
    tupel_mat_etl.mandant_id = b.mandant_id AND tupel_mat_etl.a7_wg_id = b.wg_id AND tupel_mat_etl.art_id IS NULL AND
    tupel_mat_etl.a5_owg_id <> b.owg_id AND tupel_mat_etl.a500_kjwo_update IN (
        SELECT MAX(kjwo_update) AS a1290333724
        FROM dbp_data.art_kl_preislage_zu_per
        WHERE mandant_id > 1
    );


---------------------------------------------------------------------
--                                                                 --
--                         P H A S E   2                           --
--                                                                 --
-- Umsaetze und Co. fuer alle Artikel in die SL spielen.           --
--                                                                 --
---------------------------------------------------------------------


UPDATE dbp_etl_process.tupel_mat_etl SET
    a2_rang_umsatz_wg = NULL,
    a59_rang_absatz_wg = NULL,
    a58_rang_umsatz_owg = NULL
WHERE a500_kjwo_update IN (
    SELECT MAX(kjwo_update) AS a1290333724
    FROM dbp_data.art_kl_preislage_zu_per
    WHERE mandant_id > 1
) AND mandant_id > 1;


CREATE OR REPLACE TEMPORARY TABLE _artikel_anteil_uwg_ranking_1st_base AS
SELECT
    A.mandant_id,
    c.art_matching_id,
    t13.a5_owg_id,
    t13.a7_wg_id,
    t13.wug_id,
    CASE
        WHEN A.mandant_id NOT IN (2, 3, 5, 6)
            THEN COUNT(DISTINCT CAST(A.mandant_id AS STRING) || CAST(c.art_nielsen_id AS STRING) || CAST(x.kjmo AS STRING))
        ELSE COUNT(CAST(A.mandant_id AS STRING) || CAST(c.art_nielsen_id AS STRING) || CAST(x.kjmo AS STRING))
    END AS anz,
    SUM(A.distr_gew) / CASE
        WHEN A.mandant_id NOT IN (2, 3, 5, 6)
            THEN COUNT(DISTINCT CAST(A.mandant_id AS STRING) || CAST(c.art_nielsen_id AS STRING) || CAST(x.kjmo AS STRING))
        ELSE COUNT(CAST(A.mandant_id AS STRING) || CAST(c.art_nielsen_id AS STRING) || CAST(x.kjmo AS STRING))
    END AS distr_gew_,
    SUM(A.menge) AS menge_,
    SUM(A.umsatz_brutto) AS umsatz_,
    SUM(A.menge_af) AS menge_af_,
    SUM(A.umsatz_brutto_af) AS umsatz_af_,
    SUM(A.menge_sa) AS menge_sa_,
    SUM(A.umsatz_brutto_sa) AS umsatz_sa_,
    SUM(0) AS umsatz_anteil_kum_uwg
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
    WHERE kl_owg_id <> -3
    GROUP BY
        mandant_id,
        art_nielsen_id,
        art_matching_id
    UNION DISTINCT
    SELECT
        mandant_id,
        art_nielsen_id,
        art_matching_id
    FROM dbp_etl_process.matching_art_nielsen_zu
    WHERE (
        mandant_id, kjwo_update) IN (
        SELECT (mandant_id, MAX(kjwo_update))
        FROM dbp_data.art_kl_preislage_zu_per
        WHERE mandant_id > 1
        GROUP BY mandant_id
    )
    GROUP BY
        mandant_id,
        art_nielsen_id,
        art_matching_id
) AS c ON A.mandant_id = c.mandant_id AND A.art_nielsen_id = c.art_nielsen_id
INNER JOIN dbp_data.nielsen_market AS D ON A.mandant_id = D.mandant_id AND A.nielsen_market_id = D.nielsen_market_id

INNER JOIN (
    SELECT *
    FROM dbp_etl_process.tupel_mat_etl AS ZZ
    WHERE a500_kjwo_update IN (
        SELECT MAX(kjwo_update) AS kjwo_update
        FROM dbp_data.art_kl_preislage_zu_per
        WHERE mandant_id > 1
    )
) AS t13
    ON A.mandant_id = t13.mandant_id AND c.art_matching_id = t13.matching_id
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
    c.art_matching_id,
    t13.a5_owg_id,
    t13.a7_wg_id,
    t13.wug_id;


CREATE OR REPLACE TEMPORARY TABLE _artikel_anteil_uwg_ranking AS
SELECT
    mandant_id,
    art_matching_id,
    a5_owg_id,
    a7_wg_id,
    wug_id,
    MAX(anz) AS anz,
    SUM(distr_gew_) AS distr_gew_,
    SUM(menge_) AS menge__,
    SUM(umsatz_) AS umsatz__,
    SUM(menge_af_) AS menge_af_,
    SUM(umsatz_af_) AS umsatz_af_,
    SUM(menge_sa_) AS menge_sa_,
    SUM(umsatz_sa_) AS umsatz_sa_,
    SUM(CAST(0 AS NUMERIC)) AS umsatz_anteil_kum_uwg,
    RANK() OVER (PARTITION BY mandant_id, a7_wg_id ORDER BY COALESCE(
        SUM(umsatz_), 0) IS NULL DESC, COALESCE(
        SUM(umsatz_),
        0
    ) DESC) AS rang_umsatz_uwg,
    RANK() OVER (
        PARTITION BY
            mandant_id, a7_wg_id ORDER BY
            COALESCE(SUM(menge_), 0) IS NULL DESC, COALESCE(SUM(menge_), 0
            ) DESC
    ) AS rang_absatz_uwg,
    0 AS rang_umsatz_wg
FROM `_artikel_anteil_uwg_ranking_1st_base` AS A
WHERE (
    mandant_id, art_matching_id) IN (
    SELECT (mandant_id, matching_id)
    FROM dbp_etl_process.tupel_mat_etl
    WHERE
        mandant_id > 1
        AND a500_kjwo_update IN (
            SELECT MAX(kjwo_update) AS a1290333724
            FROM dbp_data.art_kl_preislage_zu_per
            WHERE mandant_id > 1
        )
)
GROUP BY
    mandant_id,
    art_matching_id,
    a5_owg_id,
    a7_wg_id,
    wug_id;


CREATE OR REPLACE TEMPORARY TABLE _murks AS
SELECT
    mandant_id,
    matching_id,
    nielsen_gtin,
    a500_kjwo_update,
    a35_umsatz_nielsen,
    absatz_nielsen,
    a5_owg_id,
    a7_wg_id,
    wug_id,
    a58_rang_umsatz_owg,
    a2_rang_umsatz_wg,
    -- A36_gewichtete_distribution,
    a36_gewichtete_distribution_nielsen,
    CAST(0 AS NUMERIC) AS umsatz_gesamt,
    CAST(0 AS NUMERIC) AS umsatz_anteil_uwg,
    CAST(100 AS NUMERIC) AS umsatz_anteil_kum_uwg
FROM dbp_etl_process.tupel_mat_etl
WHERE a500_kjwo_update IN (
    SELECT MAX(kjwo_update) AS a1290333724
    FROM dbp_data.art_kl_preislage_zu_per
    WHERE mandant_id > 1
)
AND mandant_id > 1;


UPDATE `_murks` SET
    a35_umsatz_nielsen = b.umsatz_artikel,
    a36_gewichtete_distribution_nielsen = b.distr_gew,
    absatz_nielsen = b.absatz_artikel FROM (
    SELECT
        mandant_id,
        art_matching_id,
        SUM(distr_gew_) AS distr_gew,
        SUM(umsatz__) AS umsatz_artikel,
        SUM(menge__) AS absatz_artikel
    FROM `_artikel_anteil_uwg_ranking`
    GROUP BY
        mandant_id,
        art_matching_id
) AS b
WHERE `_murks`.mandant_id = b.mandant_id AND `_murks`.matching_id = b.art_matching_id;


CREATE OR REPLACE TEMPORARY TABLE _gesamt_uwg AS
SELECT
    mandant_id,
    a7_wg_id,
    wug_id,
    SUM(umsatz__) AS umsatz
FROM `_artikel_anteil_uwg_ranking`
GROUP BY
    mandant_id,
    a7_wg_id,
    wug_id;


UPDATE `_murks` SET
    umsatz_gesamt = b.umsatz,
    umsatz_anteil_uwg = ROUND(
        `_murks`.a35_umsatz_nielsen / IF(b.umsatz = 0, NULL, b.umsatz
        ) * 100.00, 16) FROM (
    SELECT *
    FROM `_gesamt_uwg`
    GROUP BY
        mandant_id,
        a7_wg_id,
        wug_id,
        umsatz
) AS b
WHERE `_murks`.wug_id = b.wug_id AND `_murks`.a7_wg_id = b.a7_wg_id AND `_murks`.mandant_id = b.mandant_id;


UPDATE `_artikel_anteil_uwg_ranking` SET
    umsatz_anteil_kum_uwg = ROUND(`_artikel_anteil_uwg_ranking`.umsatz__ / IF(
        b.umsatz =
        0, NULL, b.umsatz
    ) * 100.00, 5)
FROM (
    SELECT *
    FROM `_gesamt_uwg`
    GROUP BY
        mandant_id,
        a7_wg_id,
        wug_id,
        umsatz
) AS b
WHERE
    `_artikel_anteil_uwg_ranking`.wug_id = b.wug_id AND `_artikel_anteil_uwg_ranking`.a7_wg_id = b.a7_wg_id AND
    `_artikel_anteil_uwg_ranking`.mandant_id = b.mandant_id;


UPDATE `_murks` SET
    umsatz_anteil_kum_uwg = b.umsatz_anteil_kum FROM (SELECT
    mandant_id,
    art_matching_id,
    a7_wg_id,
    wug_id,
    SUM(umsatz_anteil_kum_uwg) OVER (PARTITION BY
        mandant_id, a7_wg_id, wug_id ORDER BY
        rang_umsatz_uwg IS NULL,
        rang_umsatz_uwg
    ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS umsatz_anteil_kum
FROM `_artikel_anteil_uwg_ranking`) AS b
WHERE
    `_murks`.matching_id = b.art_matching_id AND `_murks`.wug_id = b.wug_id AND `_murks`.a7_wg_id = b.a7_wg_id AND
    `_murks`.mandant_id = b.mandant_id;


UPDATE dbp_etl_process.tupel_mat_etl SET
    a35_umsatz_nielsen = b.umsatz_artikel,
    a32_umsatz_anteil_wgi_nielsen = b.umsatz_anteil_uwg,
    a33_umsatz_anteil_wgi_kumuliert_nielsen = b.umsatz_anteil_kum_uwg,
    a36_gewichtete_distribution_nielsen = b.gewichtete_distribution,
    absatz_nielsen = b.absatz_artikel FROM (
    SELECT
        mandant_id,
        matching_id,
        a500_kjwo_update,
        MAX(a36_gewichtete_distribution_nielsen) AS gewichtete_distribution,
        MAX(a35_umsatz_nielsen) AS umsatz_artikel,
        MAX(umsatz_anteil_uwg) AS umsatz_anteil_uwg,
        MAX(umsatz_anteil_kum_uwg) AS umsatz_anteil_kum_uwg,
        MAX(absatz_nielsen) AS absatz_artikel
    FROM `_murks`
    GROUP BY
        mandant_id,
        matching_id,
        a500_kjwo_update
) AS b
WHERE
    tupel_mat_etl.mandant_id = b.mandant_id AND tupel_mat_etl.a500_kjwo_update = b.a500_kjwo_update AND tupel_mat_etl.matching_id = b.matching_id;


---------------------------------------------------------------------
--WG level


CREATE OR REPLACE TEMPORARY TABLE _murks_wg AS
SELECT
    mandant_id,
    matching_id,
    nielsen_gtin,
    a500_kjwo_update,
    a35_umsatz_nielsen,
    a7_wg_id,
    CAST(0 AS NUMERIC) AS umsatz_anteil_wg,
    CAST(100 AS NUMERIC) AS umsatz_anteil_kum_wg
FROM dbp_etl_process.tupel_mat_etl
WHERE a500_kjwo_update IN (
    SELECT MAX(kjwo_update) AS a1290333724
    FROM dbp_data.art_kl_preislage_zu_per
    WHERE mandant_id > 1
)
AND mandant_id > 1;


CREATE OR REPLACE TEMPORARY TABLE _gesamt_wg AS
SELECT
    mandant_id,
    a7_wg_id,
    SUM(umsatz__) AS umsatz
FROM `_artikel_anteil_uwg_ranking`
GROUP BY
    mandant_id,
    a7_wg_id;


UPDATE `_murks_wg` SET
    umsatz_anteil_wg = ROUND(
        `_murks_wg`.a35_umsatz_nielsen / IF(b.umsatz = 0, NULL, b.umsatz
        ) * 100.00, 16) FROM (
    SELECT *
    FROM `_gesamt_wg`
    GROUP BY
        mandant_id,
        a7_wg_id,
        umsatz
) AS b
WHERE `_murks_wg`.a7_wg_id = b.a7_wg_id AND `_murks_wg`.mandant_id = b.mandant_id;


UPDATE `_artikel_anteil_uwg_ranking` SET
    umsatz_anteil_kum_uwg = ROUND(`_artikel_anteil_uwg_ranking`.umsatz__ / IF(
        b.umsatz =
        0, NULL, b.umsatz
    ) * 100.00, 5)
FROM (
    SELECT *
    FROM `_gesamt_wg`
    GROUP BY
        mandant_id,
        a7_wg_id,
        umsatz
) AS b
WHERE `_artikel_anteil_uwg_ranking`.a7_wg_id = b.a7_wg_id AND `_artikel_anteil_uwg_ranking`.mandant_id = b.mandant_id;


UPDATE `_murks_wg` SET
    umsatz_anteil_kum_wg = b.umsatz_anteil_kum FROM (SELECT
    mandant_id,
    art_matching_id,
    a7_wg_id,
    SUM(umsatz_anteil_kum_uwg) OVER (
        PARTITION BY mandant_id, a7_wg_id ORDER BY rang_umsatz_uwg IS NULL, rang_umsatz_uwg
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS umsatz_anteil_kum
FROM `_artikel_anteil_uwg_ranking`) AS b
WHERE `_murks_wg`.matching_id = b.art_matching_id AND `_murks_wg`.a7_wg_id = b.a7_wg_id AND `_murks_wg`.mandant_id = b.mandant_id;


UPDATE dbp_etl_process.tupel_mat_etl SET
    a519_umsatz_anteil_wg_nielsen = b.umsatz_anteil_wg,
    a520_umsatz_anteil_wg_kumuliert_nielsen = b.umsatz_anteil_kum_wg FROM (
    SELECT
        mandant_id,
        matching_id,
        a500_kjwo_update,
        MAX(umsatz_anteil_wg) AS umsatz_anteil_wg,
        MAX(umsatz_anteil_kum_wg) AS umsatz_anteil_kum_wg
    FROM `_murks_wg`
    GROUP BY
        mandant_id,
        matching_id,
        a500_kjwo_update
) AS b
WHERE
    tupel_mat_etl.mandant_id = b.mandant_id AND tupel_mat_etl.a500_kjwo_update = b.a500_kjwo_update AND tupel_mat_etl.matching_id = b.matching_id;


---------------------------------------------------------------------
--                                                                 --
--                         P H A S E   3                           --
--                                                                 --
-- Umsaetze und Co. fuer alle Artikel in die SL spielen.           --
--                                                                 --
---------------------------------------------------------------------


CREATE OR REPLACE TEMPORARY TABLE _upd_rank AS
SELECT
    mandant_id,
    matching_id,
    a7_wg_id,
    a35_umsatz_nielsen,
    absatz_nielsen,
    DENSE_RANK() OVER (
        PARTITION BY
            mandant_id, a7_wg_id ORDER BY
            mandant_id IS NULL, mandant_id, a7_wg_id IS NULL,
            a7_wg_id, COALESCE(a35_umsatz_nielsen, 0) IS NULL DESC, COALESCE(a35_umsatz_nielsen, 0) DESC
    ) AS rang_umsatz_uwg_,
    DENSE_RANK() OVER (
        PARTITION BY
            mandant_id, a7_wg_id ORDER BY
            mandant_id IS NULL, mandant_id, a7_wg_id IS NULL,
            a7_wg_id, COALESCE(absatz_nielsen, 0) IS NULL DESC, COALESCE(absatz_nielsen, 0) DESC
    ) AS rang_absatz_uwg_
FROM dbp_etl_process.tupel_mat_etl
WHERE a500_kjwo_update IN (
    SELECT MAX(kjwo_update) AS a1290333724
    FROM dbp_data.art_kl_preislage_zu_per
    WHERE mandant_id > 1
)
AND mandant_id > 1;


UPDATE dbp_etl_process.tupel_mat_etl SET
    a2_rang_umsatz_wg = b.rang_umsatz_uwg_,
    a59_rang_absatz_wg = b.rang_absatz_uwg_
FROM `_upd_rank` AS b
WHERE tupel_mat_etl.a500_kjwo_update IN (
    SELECT MAX(kjwo_update) AS a1290333724
    FROM dbp_data.art_kl_preislage_zu_per
    WHERE mandant_id > 1
) AND tupel_mat_etl.mandant_id = b.mandant_id AND tupel_mat_etl.matching_id = b.matching_id;


CREATE OR REPLACE TEMPORARY TABLE _upd_rank_wg AS
SELECT
    mandant_id,
    matching_id,
    a5_owg_id,
    a35_umsatz_nielsen,
    DENSE_RANK() OVER (
        PARTITION BY
            mandant_id, a5_owg_id ORDER BY
            mandant_id IS NULL, mandant_id, a5_owg_id IS NULL,
            a5_owg_id, COALESCE(a35_umsatz_nielsen, 0) IS NULL DESC, COALESCE(a35_umsatz_nielsen, 0) DESC
    ) AS rang_umsatz_wg_
FROM dbp_etl_process.tupel_mat_etl
WHERE a500_kjwo_update IN (
    SELECT MAX(kjwo_update) AS a1290333724
    FROM dbp_data.art_kl_preislage_zu_per
    WHERE mandant_id > 1
)
AND mandant_id > 1;


UPDATE dbp_etl_process.tupel_mat_etl SET
    a58_rang_umsatz_owg = b.rang_umsatz_wg_
FROM `_upd_rank_wg` AS b
WHERE tupel_mat_etl.a500_kjwo_update IN (
    SELECT MAX(kjwo_update) AS a1290333724
    FROM dbp_data.art_kl_preislage_zu_per
    WHERE mandant_id > 1
) AND tupel_mat_etl.mandant_id = b.mandant_id AND tupel_mat_etl.matching_id = b.matching_id;


UPDATE dbp_etl_process.tupel_mat_etl AS tupel_mat_etl0 SET
    a2_rang_umsatz_wg = b.next_rang_ums_uwg,
    a59_rang_absatz_wg = b.next_rang_abs_uwg FROM (
    SELECT
        mandant_id,
        a7_wg_id,
        MAX(a2_rang_umsatz_wg) + 1 AS next_rang_ums_uwg,
        MAX(a59_rang_absatz_wg) + 1 AS next_rang_abs_uwg
    FROM dbp_etl_process.tupel_mat_etl
    WHERE
        a2_rang_umsatz_wg IS NOT NULL
        AND mandant_id > 1
        AND a500_kjwo_update IN (
            SELECT MAX(kjwo_update) AS a1290333724
            FROM dbp_data.art_kl_preislage_zu_per
            WHERE mandant_id > 1
        )
    GROUP BY
        mandant_id,
        a7_wg_id
) AS b
WHERE
    tupel_mat_etl0.a7_wg_id = b.a7_wg_id AND tupel_mat_etl0.a2_rang_umsatz_wg IS NULL AND tupel_mat_etl0.a59_rang_absatz_wg
    IS NULL AND tupel_mat_etl0.mandant_id = b.mandant_id AND tupel_mat_etl0.a500_kjwo_update IN (SELECT
        MAX(kjwo_update)
            AS a1290333724
    FROM dbp_data.art_kl_preislage_zu_per
    WHERE mandant_id > 1);


UPDATE dbp_etl_process.tupel_mat_etl AS tupel_mat_etl0 SET
    a58_rang_umsatz_owg = b.next_rang_ums_wg FROM (
    SELECT
        mandant_id,
        a5_owg_id,
        MAX(a58_rang_umsatz_owg) + 1 AS next_rang_ums_wg
    FROM dbp_etl_process.tupel_mat_etl
    WHERE
        a58_rang_umsatz_owg IS NOT NULL
        AND mandant_id > 1
        AND a500_kjwo_update IN (
            SELECT MAX(kjwo_update) AS a1290333724
            FROM dbp_data.art_kl_preislage_zu_per
            WHERE mandant_id > 1
        )
    GROUP BY
        mandant_id,
        a5_owg_id
) AS b
WHERE
    tupel_mat_etl0.a5_owg_id = b.a5_owg_id AND tupel_mat_etl0.a58_rang_umsatz_owg IS NULL AND tupel_mat_etl0.mandant_id
    = b.mandant_id AND tupel_mat_etl0.a500_kjwo_update IN (
        SELECT MAX(kjwo_update) AS a1290333724
        FROM dbp_data.art_kl_preislage_zu_per
        WHERE mandant_id > 1
    );


UPDATE dbp_etl_process.tupel_mat_etl AS tupel_mat_etl1 SET
    a2_rang_umsatz_wg = b.next_rang_ums_uwg,
    a59_rang_absatz_wg = b.next_rang_abs_uwg FROM (
    SELECT
        mandant_id,
        a7_wg_id,
        COALESCE(MAX(a2_rang_umsatz_wg), 0) + 1 AS next_rang_ums_uwg,
        COALESCE(MAX(a59_rang_absatz_wg), 0) + 1 AS next_rang_abs_uwg
    FROM dbp_etl_process.tupel_mat_etl
    WHERE
        mandant_id > 1
        AND (
            mandant_id, a7_wg_id) IN (
            SELECT (mandant_id, a7_wg_id)
            FROM (SELECT
                mandant_id,
                a7_wg_id,
                MAX(CASE
                    WHEN a2_rang_umsatz_wg IS NULL
                        THEN 1
                    ELSE 2
                END) AS rang_xxx
            FROM dbp_etl_process.tupel_mat_etl
            WHERE
                mandant_id > 1
                AND a500_kjwo_update IN (
                    SELECT MAX(kjwo_update) AS a1290333724
                    FROM dbp_data.art_kl_preislage_zu_per
                    WHERE mandant_id > 1
                )
            GROUP BY
                mandant_id,
                a7_wg_id
            HAVING rang_xxx = 1) AS x
        )
        AND a500_kjwo_update IN (
            SELECT MAX(kjwo_update) AS a1290333724
            FROM dbp_data.art_kl_preislage_zu_per
            WHERE mandant_id > 1
        )
    GROUP BY
        mandant_id,
        a7_wg_id
) AS b
WHERE
    tupel_mat_etl1.a7_wg_id = b.a7_wg_id AND tupel_mat_etl1.a2_rang_umsatz_wg IS NULL AND tupel_mat_etl1.mandant_id =
    b.mandant_id AND tupel_mat_etl1.a500_kjwo_update IN (
        SELECT MAX(kjwo_update) AS a1290333724
        FROM dbp_data.art_kl_preislage_zu_per
        WHERE mandant_id > 1
    );


UPDATE dbp_etl_process.tupel_mat_etl AS tupel_mat_etl0 SET
    a58_rang_umsatz_owg = b.next_rang_ums_wg FROM (
    SELECT
        mandant_id,
        a5_owg_id,
        COALESCE(MAX(a58_rang_umsatz_owg), 0) + 1 AS next_rang_ums_wg
    FROM dbp_etl_process.tupel_mat_etl
    WHERE
        mandant_id > 1
        AND a500_kjwo_update IN (
            SELECT MAX(kjwo_update) AS a1290333724
            FROM dbp_data.art_kl_preislage_zu_per
            WHERE mandant_id > 1
        )
    GROUP BY
        mandant_id,
        a5_owg_id
) AS b
WHERE
    tupel_mat_etl0.a5_owg_id = b.a5_owg_id AND tupel_mat_etl0.a58_rang_umsatz_owg IS NULL AND tupel_mat_etl0.mandant_id
    = b.mandant_id AND tupel_mat_etl0.a500_kjwo_update IN (
        SELECT MAX(kjwo_update) AS a1290333724
        FROM dbp_data.art_kl_preislage_zu_per
        WHERE mandant_id > 1
    );


-------------------------------------------------------------------------------------------------------------------------------------------------------

--UPDATE dbp_etl_process.tupel_mat_etl SET A36_gewichtete_distribution_nielsen = 0,
--                                         A36_gewichtete_distribution = 0
--WHERE mandant_id > 1 AND
--      a500_kjwo_update IN (SELECT MAX(kjwo_update) FROM dbp_data.art_kl_preislage_zu_per WHERE mandant_id > 1) AND
--      a450_art_nielsen_nr IS NULL
--;


UPDATE dbp_etl_process.tupel_mat_etl SET
    a36_gewichtete_distribution_nielsen = tupel_mat_etl.a36_gewichtete_distribution_nielsen / 2
WHERE a36_gewichtete_distribution_nielsen > 100 AND mandant_id > 1 AND a500_kjwo_update IN (SELECT
    MAX(
        kjwo_update) AS
    a1290333724
FROM dbp_data.art_kl_preislage_zu_per
WHERE mandant_id > 1);


--UPDATE dbp_etl_process.tupel_mat_etl SET a36_gewichtete_distribution = a36_gewichtete_distribution_nielsen
--WHERE mandant_id > 1 AND
--      a500_kjwo_update IN (SELECT MAX(kjwo_update) FROM dbp_data.art_kl_preislage_zu_per WHERE mandant_id > 1) AND
--      a36_gewichtete_distribution <> a36_gewichtete_distribution_nielsen
--;


--Update the fields related to the product groups that have been changed


UPDATE dbp_etl_process.tupel_mat_etl SET
    a376_kl_marktanteil_wg_nielsen = b.kl_markt_anteil_owg FROM (SELECT DISTINCT
    mandant_id,
    kjwo_update,
    kl_wg_id,
    kl_owg_id,
    kl_markt_anteil_owg
FROM dbp_etl.sortiment_potenziale_kmo_all
WHERE kjwo_update = (
    SELECT MAX(kjwo_update) AS kjwo_update
    FROM dbp_data.sortiment_leistung
)) AS b
WHERE
    tupel_mat_etl.a5_owg_id = b.kl_wg_id AND tupel_mat_etl.a7_wg_id = b.kl_owg_id AND tupel_mat_etl.mandant_id = b.mandant_id
    AND tupel_mat_etl.a500_kjwo_update = b.kjwo_update AND tupel_mat_etl.a376_kl_marktanteil_wg_nielsen IS NOT NULL;


UPDATE dbp_etl_process.tupel_mat_etl AS tupel_mat_etl0 SET
    kassenumsatz_kl_absolut_netto_wg = t3.kassenumsatz_kl_absolut_netto_wg,
    totalabschriften_wert_netto_absolut_wg = t3.totalabschriften_wert_netto_absolut_wg,
    preisabschriften_preisanderungen_wert_netto_absolut_wg = t3.preisabschriften_preisanderungen_wert_netto_absolut_wg FROM
    (
        SELECT
            a500_kjwo_update,
            mandant_id,
            a7_wg_id,
            SUM(a21_kassenumsatz_kl_absolut_netto) AS kassenumsatz_kl_absolut_netto_wg,
            SUM(a27_totalabschriften_wert_netto_absolut) AS totalabschriften_wert_netto_absolut_wg,
            SUM(a313_preisabschriften_preisanderungen_wert_netto_absolut)
                AS
                preisabschriften_preisanderungen_wert_netto_absolut_wg
        FROM dbp_etl_process.tupel_mat_etl
        WHERE
            a500_kjwo_update = (
                SELECT MAX(kjwo_update) AS kjwo_update
                FROM dbp_data.sortiment_leistung
                WHERE mandant_id > 1
            )
            AND mandant_id > 1
        GROUP BY
            mandant_id,
            a500_kjwo_update,
            a7_wg_id
    ) AS t3
WHERE
    tupel_mat_etl0.a500_kjwo_update = t3.a500_kjwo_update AND tupel_mat_etl0.mandant_id = t3.mandant_id AND
    tupel_mat_etl0.a7_wg_id = t3.a7_wg_id;


UPDATE dbp_etl_process.tupel_mat_etl SET
    a445_anz_tupel_listung_wgi = b.anz_artikel FROM (
    SELECT
        mandant_id,
        kjwo_update,
        owg_id,
        wg_id,
        wug_id,
        SUM(CASE
            WHEN anz_maerkte_listung_gesamt > 0
                THEN 1
            ELSE 0
        END) AS anz_artikel
    FROM dbp_data.sortiment_leistung
    WHERE
        kjwo_update IN (
            SELECT MAX(kjwo_update) AS a1290333724
            FROM dbp_data.sortiment_leistung
            WHERE mandant_id > 1
        )
        AND mandant_id > 1
    GROUP BY
        mandant_id,
        kjwo_update,
        owg_id,
        wg_id,
        wug_id
) AS b
WHERE
    tupel_mat_etl.a5_owg_id = b.owg_id AND tupel_mat_etl.a7_wg_id = b.wg_id AND tupel_mat_etl.wug_id = b.wug_id AND
    tupel_mat_etl.a500_kjwo_update = b.kjwo_update AND tupel_mat_etl.mandant_id = b.mandant_id;


UPDATE dbp_etl_process.tupel_mat_etl SET
    nielsen_art_bez = b.art_nielsen_bez FROM (
    SELECT *
    FROM dbp_data.art_nielsen
    WHERE
        dat_bis = DATE '9999-12-31'
        AND mandant_id > 1
) AS b
WHERE
    tupel_mat_etl.mandant_id = b.mandant_id AND tupel_mat_etl.a450_art_nielsen_nr = b.art_nielsen_id AND tupel_mat_etl.a500_kjwo_update IN (
        SELECT MAX(kjwo_update) AS a1290333724
        FROM dbp_data.art_kl_preislage_zu_per
        WHERE mandant_id > 1
    );
