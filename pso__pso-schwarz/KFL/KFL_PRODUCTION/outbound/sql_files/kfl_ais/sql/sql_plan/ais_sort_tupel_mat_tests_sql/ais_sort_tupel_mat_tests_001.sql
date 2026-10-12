CREATE OR REPLACE TEMPORARY TABLE _week AS
SELECT
    mandant_id,
    MAX(kjwo_update) AS kjwo
FROM dbp_data.sortiment_leistung
GROUP BY
    mandant_id;

CREATE OR REPLACE TEMPORARY TABLE _week_prev AS
SELECT
    a.mandant_id,
    a.kjwo_update AS kjwo
FROM dbp_data.sortiment_leistung AS a
INNER JOIN dbp_data.woche AS b
    ON a.kjwo_update = b.kjwo
WHERE
    b.akt_wo = (
        SELECT akt_wo - 1 AS akt_wo
        FROM dbp_data.woche
        WHERE
            kjwo = (
                SELECT MAX(kjwo_update) AS kjwo
                FROM dbp_data.sortiment_leistung
            )
    )
GROUP BY
    a.mandant_id,
    kjwo;

CREATE OR REPLACE TEMPORARY TABLE _monat AS
SELECT
    mandant_id,
    kjmo
FROM dbp_data.art_nielsen_fakten_kjmo
WHERE
    mandant_id > 1
GROUP BY
    mandant_id,
    kjmo
QUALIFY
    (
        DENSE_RANK() OVER (PARTITION BY mandant_id ORDER BY kjmo IS NULL DESC, kjmo DESC)
    ) BETWEEN 1 AND 12;

CREATE OR REPLACE TEMPORARY TABLE _run_cnt AS
SELECT COALESCE(MAX(run_cnt), 0) + 1 AS run_cnt
FROM dbp_etl_process.mat_test
WHERE
    kjwo = (
        SELECT MAX(kjwo_update) AS kjwo
        FROM dbp_data.sortiment_leistung
    );

CREATE OR REPLACE TEMPORARY TABLE _art_nielsen AS
SELECT *
FROM dbp_data.art_nielsen
WHERE
    dat_bis = CAST('9999-12-31' AS DATE);

CREATE OR REPLACE TEMPORARY TABLE _art_matching_nielsen_per_kmo AS
SELECT *
FROM dbp_etl.art_matching_nielsen_per_kmo
WHERE
    kjwo_update = (
        SELECT MAX(kjwo_update)
        FROM dbp_etl.art_matching_nielsen_per_kmo
    );

CREATE OR REPLACE TEMPORARY TABLE _art_matching_nielsen_per AS
SELECT *
FROM dbp_etl.art_matching_nielsen_per
WHERE
    kjwo_update = (
        SELECT MAX(kjwo_update)
        FROM dbp_etl.art_matching_nielsen_per
    );

/* --- */
CREATE OR REPLACE TEMPORARY TABLE _tupel_mat_test_1 AS
SELECT
    qu.q_mandant_id,
    qu.q_a500_kjwo_update,
    qu.q_a425_kjmo,
    qu.q_anzahl_kl,
    pro.p_anzahl_kl,
    qu.q_anzahl_kl - pro.p_anzahl_kl AS differenz_kl
FROM (
    SELECT
        a.mandant_id AS q_mandant_id,
        a.a500_kjwo_update AS q_a500_kjwo_update,
        a.a425_kjmo AS q_a425_kjmo,
        SUM(CASE WHEN a.art_id IS NULL THEN 0 ELSE 1 END) AS q_anzahl_kl
    FROM dbp_etl_process.tupel_mat_etl AS a
    INNER JOIN `_week` AS b
        ON a.mandant_id = b.mandant_id AND a.a500_kjwo_update = b.kjwo
    GROUP BY
        q_mandant_id,
        q_a500_kjwo_update,
        q_a425_kjmo
) AS qu
INNER JOIN (
    SELECT
        a0.mandant_id AS p_mandant_id,
        a0.a500_kjwo_update AS p_a500_kjwo_update,
        a0.a425_kjmo AS p_a425_kjmo,
        SUM(CASE WHEN a0.art_id IS NULL THEN 0 ELSE 1 END) AS p_anzahl_kl
    FROM dbp_etl_process.tupel_mat_etl AS a0
    INNER JOIN `_week_prev` AS b0
        ON a0.mandant_id = b0.mandant_id AND a0.a500_kjwo_update = b0.kjwo
    GROUP BY
        p_mandant_id,
        p_a500_kjwo_update,
        p_a425_kjmo
) AS pro
    ON qu.q_mandant_id = pro.p_mandant_id
WHERE
    ABS(qu.q_anzahl_kl - pro.p_anzahl_kl) > 1000
ORDER BY
    qu.q_mandant_id NULLS LAST;

INSERT INTO dbp_etl_process.mat_test
(
    SELECT
        1 AS test_id,
        'TUPEL' AS test_type,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        CASE WHEN COUNT(*) >= 1 THEN 'ERROR' WHEN COUNT(*) < 1 THEN 'OK' ELSE NULL END AS test_status,
        COUNT(*) AS error_count,
        STRING_AGG(
            DISTINCT CAST(q_mandant_id AS STRING), ','
            ORDER BY
                CAST(q_mandant_id AS STRING)
        ) AS error_mandant_id,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_1`
);

INSERT INTO dbp_etl_process.mat_test_desc
(
    SELECT
        1 AS test_id,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        'DIFFERENZ_KL',
        CASE
            WHEN COUNT(*) >= 1
                THEN 'ABS(DIFFERENZ_KL)>1000'
            WHEN COUNT(*) < 1
                THEN 'OK'
            ELSE NULL
        END AS description,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_1`
);

INSERT INTO dbp_etl_process.mat_test_detail
(
    SELECT
        1 AS test_id,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        q_mandant_id,
        'MANDANT_ID' AS key_name,
        q_mandant_id AS key_value,
        'DIFFERENZ_KL',
        SUBSTR(CAST(differenz_kl AS STRING), 1, 300) AS differenz_kl,
        'ABS(DIFFERENZ_KL)<1000',
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_1`
);

/* ---------------------------------------------------------- */
CREATE OR REPLACE TEMPORARY TABLE _tupel_mat_test_2 AS
SELECT
    qu.q_mandant_id,
    qu.q_a500_kjwo_update,
    qu.q_a425_kjmo,
    qu.q_anzahl_nl,
    pro.p_anzahl_nl,
    qu.q_anzahl_nl - pro.p_anzahl_nl AS differenz_nl
FROM (
    SELECT
        a.mandant_id AS q_mandant_id,
        a.a500_kjwo_update AS q_a500_kjwo_update,
        a.a425_kjmo AS q_a425_kjmo,
        SUM(CASE WHEN a.art_id IS NULL THEN 1 ELSE 0 END) AS q_anzahl_nl
    FROM dbp_etl_process.tupel_mat_etl AS a
    INNER JOIN `_week` AS b
        ON a.mandant_id = b.mandant_id AND a.a500_kjwo_update = b.kjwo
    GROUP BY
        q_mandant_id,
        q_a500_kjwo_update,
        q_a425_kjmo
) AS qu
INNER JOIN (
    SELECT
        a0.mandant_id AS p_mandant_id,
        a0.a500_kjwo_update AS p_a500_kjwo_update,
        a0.a425_kjmo AS p_a425_kjmo,
        SUM(CASE WHEN a0.art_id IS NULL THEN 1 ELSE 0 END) AS p_anzahl_nl
    FROM dbp_etl_process.tupel_mat_etl AS a0
    INNER JOIN `_week_prev` AS b0
        ON a0.mandant_id = b0.mandant_id AND a0.a500_kjwo_update = b0.kjwo
    GROUP BY
        p_mandant_id,
        p_a500_kjwo_update,
        p_a425_kjmo
) AS pro
    ON qu.q_mandant_id = pro.p_mandant_id
WHERE
    ABS(qu.q_anzahl_nl - pro.p_anzahl_nl) > 1000
ORDER BY
    qu.q_mandant_id NULLS LAST;

INSERT INTO dbp_etl_process.mat_test
(
    SELECT
        2 AS test_id,
        'TUPEL' AS test_type,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        CASE WHEN COUNT(*) >= 1 THEN 'ERROR' WHEN COUNT(*) < 1 THEN 'OK' ELSE NULL END AS test_status,
        COUNT(*) AS error_count,
        STRING_AGG(
            DISTINCT CAST(q_mandant_id AS STRING), ','
            ORDER BY
                CAST(q_mandant_id AS STRING)
        ) AS error_mandant_id,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_2`
);

INSERT INTO dbp_etl_process.mat_test_desc
(
    SELECT
        2 AS test_id,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        'DIFFERENZ_NL',
        CASE
            WHEN COUNT(*) >= 1
                THEN 'ABS(DIFFERENZ_NL)>1000'
            WHEN COUNT(*) < 1
                THEN 'OK'
            ELSE NULL
        END AS description,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_2`
);

INSERT INTO dbp_etl_process.mat_test_detail
(
    SELECT
        2 AS test_id,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        q_mandant_id,
        'MANDANT_ID' AS key_name,
        q_mandant_id AS key_value,
        'DIFFERENZ_NL',
        SUBSTR(CAST(differenz_nl AS STRING), 1, 300) AS differenz_nl,
        'ABS(DIFFERENZ_NL)<1000',
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_2`
);

/* ---------------------------------------------------------- */
CREATE OR REPLACE TEMPORARY TABLE _tupel_mat_test_3 AS
SELECT
    a.mandant_id,
    a.matching_id,
    a.art_id,
    a.a500_kjwo_update,
    a.a14_art_status_de,
    b0.loesch_id,
    CASE WHEN a.a14_art_status_de = TRIM(b0.loesch_id) THEN 0 ELSE 1 END AS differenz
FROM (
    SELECT
        a.mandant_id,
        a.matching_id,
        a.art_id,
        a.a500_kjwo_update,
        a.a14_art_status_de
    FROM dbp_etl_process.tupel_mat_etl AS a
    INNER JOIN `_week` AS b
        ON a.mandant_id = b.mandant_id AND a.a500_kjwo_update = b.kjwo
) AS a
INNER JOIN dbp_data.art AS b0
    ON a.mandant_id = b0.mandant_id AND a.art_id = b0.art_id
WHERE
    CASE WHEN a.a14_art_status_de = TRIM(b0.loesch_id) THEN 0 ELSE 1 END = 1
ORDER BY
    1 NULLS LAST;

INSERT INTO dbp_etl_process.mat_test
(
    SELECT
        3 AS test_id,
        'MASTER DATA' AS test_type,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        CASE WHEN COUNT(*) >= 1 THEN 'ERROR' WHEN COUNT(*) < 1 THEN 'OK' ELSE NULL END AS test_status,
        COUNT(*) AS error_count,
        STRING_AGG(
            DISTINCT CAST(mandant_id AS STRING), ','
            ORDER BY
                CAST(mandant_id AS STRING)
        ) AS error_mandant_id,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_3`
);

INSERT INTO dbp_etl_process.mat_test_desc
(
    SELECT
        3 AS test_id,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        'A14_ART_STATUS_DE',
        CASE
            WHEN COUNT(*) >= 1
                THEN 'A14_ART_STATUS_DE <> TRIM(LOESCH_ID)'
            WHEN COUNT(*) < 1
                THEN 'OK'
            ELSE NULL
        END AS description,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_3`
);

INSERT INTO dbp_etl_process.mat_test_detail
(
    SELECT
        3 AS test_id,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        mandant_id,
        'MATCHING_ID' AS key_name,
        matching_id AS key_value,
        'A14_ART_STATUS_DE',
        a14_art_status_de,
        loesch_id,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_3`
);

/* ---------------------------------------------------------- */
CREATE OR REPLACE TEMPORARY TABLE _tupel_mat_test_4 AS
SELECT
    a.mandant_id,
    a.a500_kjwo_update,
    a.matching_id,
    a.art_id,
    a.art_bez_deutsch,
    b0.art_bez,
    CASE
        WHEN a.art_bez_deutsch = COALESCE(c.art_gruppe_bez, b0.art_bez)
            THEN 0
        ELSE 1
    END AS differenz_art_bez
FROM (
    SELECT
        a.mandant_id,
        a.a500_kjwo_update,
        a.matching_id,
        a.art_id,
        a.art_bez_deutsch
    FROM dbp_etl_process.tupel_mat_etl AS a
    INNER JOIN `_week` AS b
        ON a.mandant_id = b.mandant_id AND a.a500_kjwo_update = b.kjwo
) AS a
INNER JOIN dbp_data.art_spr_zu AS b0
    ON a.mandant_id = b0.mandant_id AND a.art_id = b0.art_id AND b0.spr_id = 22
LEFT JOIN (
    SELECT
        x.mandant_id,
        x.art_id,
        y.art_gruppe_bez
    FROM dbp_etl_process.art_art_nielsen_groups AS x
    INNER JOIN dbp_data.art_gruppe_art_zu AS z
        ON x.mandant_id = z.mandant_id AND x.art_id = z.art_id
    INNER JOIN dbp_data.art_gruppe AS y
        ON z.art_gruppe_id = y.art_gruppe_id
) AS c
    ON a.mandant_id = c.mandant_id AND a.art_id = c.art_id
WHERE
    CASE
        WHEN a.art_bez_deutsch = COALESCE(c.art_gruppe_bez, b0.art_bez)
            THEN 0
        ELSE 1
    END = 1
ORDER BY
    1 NULLS LAST;

INSERT INTO dbp_etl_process.mat_test
(
    SELECT
        4 AS test_id,
        'MASTER DATA' AS test_type,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        CASE WHEN COUNT(*) >= 1 THEN 'ERROR' WHEN COUNT(*) < 1 THEN 'OK' ELSE NULL END AS test_status,
        COUNT(*) AS error_count,
        STRING_AGG(
            DISTINCT CAST(mandant_id AS STRING), ','
            ORDER BY
                CAST(mandant_id AS STRING)
        ) AS error_mandant_id,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_4`
);

INSERT INTO dbp_etl_process.mat_test_desc
(
    SELECT
        4 AS test_id,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        'ART_BEZ_DEUTSCH',
        CASE
            WHEN COUNT(*) >= 1
                THEN 'ART_BEZ_DEUTSCH <> ART_BEZ'
            WHEN COUNT(*) < 1
                THEN 'OK'
            ELSE NULL
        END AS description,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_4`
);

INSERT INTO dbp_etl_process.mat_test_detail
(
    SELECT
        4 AS test_id,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        mandant_id,
        'MATCHING_ID' AS key_name,
        matching_id AS key_value,
        'ART_BEZ_DEUTSCH',
        art_bez_deutsch,
        art_bez,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_4`
);

/* ---------------------------------------------------------- */
CREATE OR REPLACE TEMPORARY TABLE _tupel_mat_test_5 AS
SELECT
    mandant_id,
    matching_id,
    a500_kjwo_update,
    a5_owg_id,
    a35_umsatz_nielsen,
    a58_rang_umsatz_owg,
    DENSE_RANK() OVER (
        PARTITION BY a500_kjwo_update, mandant_id, a5_owg_id
        ORDER BY a35_umsatz_nielsen IS NULL DESC, a35_umsatz_nielsen DESC
    ) AS a58_rang_umsatz_owg_m,
    (
        DENSE_RANK() OVER (
            PARTITION BY a500_kjwo_update, mandant_id, a5_owg_id
            ORDER BY a35_umsatz_nielsen IS NULL DESC, a35_umsatz_nielsen DESC
        )
    ) - a58_rang_umsatz_owg AS owg_rang_umsatz_diff
FROM (
    SELECT
        a.mandant_id,
        a.matching_id,
        a.a500_kjwo_update,
        a.a5_owg_id,
        a.a35_umsatz_nielsen,
        a.a58_rang_umsatz_owg
    FROM dbp_etl_process.tupel_mat_etl AS a
    INNER JOIN `_week` AS b
        ON a.mandant_id = b.mandant_id AND a.a500_kjwo_update = b.kjwo
) AS a
WHERE
    a35_umsatz_nielsen > 0
QUALIFY
    (
        DENSE_RANK() OVER (
            PARTITION BY a500_kjwo_update, mandant_id, a5_owg_id
            ORDER BY a35_umsatz_nielsen IS NULL DESC, a35_umsatz_nielsen DESC
        )
    ) - a58_rang_umsatz_owg > 0
ORDER BY
    mandant_id NULLS LAST,
    owg_rang_umsatz_diff DESC NULLS FIRST;

INSERT INTO dbp_etl_process.mat_test
(
    SELECT
        5 AS test_id,
        'TUPEL' AS test_type,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        CASE WHEN COUNT(*) >= 1 THEN 'ERROR' WHEN COUNT(*) < 1 THEN 'OK' ELSE NULL END AS test_status,
        COUNT(*) AS error_count,
        STRING_AGG(
            DISTINCT CAST(mandant_id AS STRING), ','
            ORDER BY
                CAST(mandant_id AS STRING)
        ) AS error_mandant_id,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_5`
);

INSERT INTO dbp_etl_process.mat_test_desc
(
    SELECT
        5 AS test_id,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        'A58_RANG_UMSATZ_OWG',
        CASE
            WHEN COUNT(*) >= 1
                THEN 'A58_RANG_UMSATZ_OWG <> A58_RANG_UMSATZ_OWG_M'
            WHEN COUNT(*) < 1
                THEN 'OK'
            ELSE NULL
        END AS description,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_5`
);

INSERT INTO dbp_etl_process.mat_test_detail
(
    SELECT
        5 AS test_id,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        mandant_id,
        'MATCHING_ID' AS key_name,
        matching_id AS key_value,
        'A58_RANG_UMSATZ_OWG',
        SUBSTR(CAST(a58_rang_umsatz_owg AS STRING), 1, 300) AS a58_rang_umsatz_owg,
        SUBSTR(CAST(a58_rang_umsatz_owg_m AS STRING), 1, 300) AS a58_rang_umsatz_owg_m,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_5`
);

/* ---------------------------------------------------------- */
CREATE OR REPLACE TEMPORARY TABLE _tupel_mat_test_6 AS
SELECT
    mandant_id,
    matching_id,
    a500_kjwo_update,
    a5_owg_id,
    a7_wg_id,
    a35_umsatz_nielsen,
    a2_rang_umsatz_wg,
    DENSE_RANK() OVER (
        PARTITION BY a500_kjwo_update, mandant_id, a7_wg_id
        ORDER BY a35_umsatz_nielsen IS NULL DESC, a35_umsatz_nielsen DESC
    ) AS a2_rang_umsatz_wg_m,
    (
        DENSE_RANK() OVER (
            PARTITION BY a500_kjwo_update, mandant_id, a7_wg_id
            ORDER BY a35_umsatz_nielsen IS NULL DESC, a35_umsatz_nielsen DESC
        )
    ) - a2_rang_umsatz_wg AS wg_rang_umsatz_diff
FROM (
    SELECT
        a.mandant_id,
        a.matching_id,
        a.a500_kjwo_update,
        a.a5_owg_id,
        a.a7_wg_id,
        a.a35_umsatz_nielsen,
        a.a2_rang_umsatz_wg
    FROM dbp_etl_process.tupel_mat_etl AS a
    INNER JOIN `_week` AS b
        ON a.mandant_id = b.mandant_id AND a.a500_kjwo_update = b.kjwo
) AS a
WHERE
    a35_umsatz_nielsen > 0
QUALIFY
    (
        DENSE_RANK() OVER (
            PARTITION BY a500_kjwo_update, mandant_id, a7_wg_id
            ORDER BY a35_umsatz_nielsen IS NULL DESC, a35_umsatz_nielsen DESC
        )
    ) - a2_rang_umsatz_wg > 0
ORDER BY
    mandant_id NULLS LAST,
    wg_rang_umsatz_diff DESC NULLS FIRST;

INSERT INTO dbp_etl_process.mat_test
(
    SELECT
        6 AS test_id,
        'TUPEL' AS test_type,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        CASE WHEN COUNT(*) >= 1 THEN 'ERROR' WHEN COUNT(*) < 1 THEN 'OK' ELSE NULL END AS test_status,
        COUNT(*) AS error_count,
        STRING_AGG(
            DISTINCT CAST(mandant_id AS STRING), ','
            ORDER BY
                CAST(mandant_id AS STRING)
        ) AS error_mandant_id,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_6`
);

INSERT INTO dbp_etl_process.mat_test_desc
(
    SELECT
        6 AS test_id,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        'A2_RANG_UMSATZ_WG',
        CASE
            WHEN COUNT(*) >= 1
                THEN 'A2_RANG_UMSATZ_WG <> A2_RANG_UMSATZ_WG_M'
            WHEN COUNT(*) < 1
                THEN 'OK'
            ELSE NULL
        END AS description,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_6`
);

INSERT INTO dbp_etl_process.mat_test_detail
(
    SELECT
        6 AS test_id,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        mandant_id,
        'MATCHING_ID' AS key_name,
        matching_id AS key_value,
        'A2_RANG_UMSATZ_WG',
        SUBSTR(CAST(a2_rang_umsatz_wg AS STRING), 1, 300) AS a2_rang_umsatz_wg,
        SUBSTR(CAST(a2_rang_umsatz_wg_m AS STRING), 1, 300) AS a2_rang_umsatz_wg_m,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_6`
);

/* ---------------------------------------------------------- */
CREATE OR REPLACE TEMPORARY TABLE _tupel_mat_test_7 AS
SELECT
    mandant_id,
    matching_id,
    a500_kjwo_update,
    a7_wg_id,
    a59_rang_absatz_wg,
    absatz_nielsen,
    DENSE_RANK() OVER (
        PARTITION BY a500_kjwo_update, mandant_id, a7_wg_id
        ORDER BY absatz_nielsen IS NULL DESC, absatz_nielsen DESC
    ) AS a59_rang_absatz_wg_m,
    (
        DENSE_RANK() OVER (
            PARTITION BY a500_kjwo_update, mandant_id, a7_wg_id
            ORDER BY absatz_nielsen IS NULL DESC, absatz_nielsen DESC
        )
    ) - a59_rang_absatz_wg AS wg_rang_absatz_diff
FROM (
    SELECT
        a.mandant_id,
        a.matching_id,
        a.a500_kjwo_update,
        a.a7_wg_id,
        a.a59_rang_absatz_wg,
        a.absatz_nielsen
    FROM dbp_etl_process.tupel_mat_etl AS a
    INNER JOIN `_week` AS b
        ON a.mandant_id = b.mandant_id AND a.a500_kjwo_update = b.kjwo
) AS a
WHERE
    absatz_nielsen > 0
QUALIFY
    (
        DENSE_RANK() OVER (
            PARTITION BY a500_kjwo_update, mandant_id, a7_wg_id
            ORDER BY absatz_nielsen IS NULL DESC, absatz_nielsen DESC
        )
    ) - a59_rang_absatz_wg > 0
ORDER BY
    mandant_id NULLS LAST,
    wg_rang_absatz_diff DESC NULLS FIRST;

INSERT INTO dbp_etl_process.mat_test
(
    SELECT
        7 AS test_id,
        'TUPEL' AS test_type,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        CASE WHEN COUNT(*) >= 1 THEN 'ERROR' WHEN COUNT(*) < 1 THEN 'OK' ELSE NULL END AS test_status,
        COUNT(*) AS error_count,
        STRING_AGG(
            DISTINCT CAST(mandant_id AS STRING), ','
            ORDER BY
                CAST(mandant_id AS STRING)
        ) AS error_mandant_id,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_7`
);

INSERT INTO dbp_etl_process.mat_test_desc
(
    SELECT
        7 AS test_id,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        'A59_RANG_ABSATZ_WG',
        CASE
            WHEN COUNT(*) >= 1
                THEN 'A59_RANG_ABSATZ_WG <> A59_RANG_ABSATZ_WG_M'
            WHEN COUNT(*) < 1
                THEN 'OK'
            ELSE NULL
        END AS description,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_7`
);

INSERT INTO dbp_etl_process.mat_test_detail
(
    SELECT
        7 AS test_id,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        mandant_id,
        'MATCHING_ID' AS key_name,
        matching_id AS key_value,
        'A59_RANG_ABSATZ_WG',
        SUBSTR(CAST(a59_rang_absatz_wg AS STRING), 1, 300) AS a59_rang_absatz_wg,
        SUBSTR(CAST(a59_rang_absatz_wg_m AS STRING), 1, 300) AS a59_rang_absatz_wg_m,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_7`
);

/* ---------------------------------------------------------- */
CREATE OR REPLACE TEMPORARY TABLE _tupel_mat_test_8 AS
SELECT
    mandant_id,
    a500_kjwo_update,
    matching_id,
    a33_umsatz_anteil_wgi_kumuliert_nielsen
FROM (
    SELECT
        a.mandant_id,
        a.a500_kjwo_update,
        a.matching_id,
        a.a33_umsatz_anteil_wgi_kumuliert_nielsen
    FROM dbp_etl_process.tupel_mat_etl AS a
    INNER JOIN `_week` AS b
        ON a.mandant_id = b.mandant_id AND a.a500_kjwo_update = b.kjwo
) AS a
WHERE
    a33_umsatz_anteil_wgi_kumuliert_nielsen > 101
ORDER BY
    mandant_id NULLS LAST;

INSERT INTO dbp_etl_process.mat_test
(
    SELECT
        8 AS test_id,
        'TUPEL' AS test_type,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        CASE WHEN COUNT(*) >= 1 THEN 'ERROR' WHEN COUNT(*) < 1 THEN 'OK' ELSE NULL END AS test_status,
        COUNT(*) AS error_count,
        STRING_AGG(
            DISTINCT CAST(mandant_id AS STRING), ','
            ORDER BY
                CAST(mandant_id AS STRING)
        ) AS error_mandant_id,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_8`
);

INSERT INTO dbp_etl_process.mat_test_desc
(
    SELECT
        8 AS test_id,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        'A33_UMSATZ_ANTEIL_WGI_KUMULIERT_NIELSEN',
        CASE
            WHEN COUNT(*) >= 1
                THEN 'A33_UMSATZ_ANTEIL_WGI_KUMULIERT_NIELSEN > 101'
            WHEN COUNT(*) < 1
                THEN 'OK'
            ELSE NULL
        END AS description,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_8`
);

INSERT INTO dbp_etl_process.mat_test_detail
(
    SELECT
        8 AS test_id,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        mandant_id,
        'MATCHING_ID' AS key_name,
        matching_id AS key_value,
        'A33_UMSATZ_ANTEIL_WGI_KUMULIERT_NIELSEN',
        SUBSTR(CAST(a33_umsatz_anteil_wgi_kumuliert_nielsen AS STRING), 1, 300) AS a33_umsatz_anteil_wgi_kumuliert_nielsen,
        'A33_UMSATZ_ANTEIL_WGI_KUMULIERT_NIELSEN < 101',
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_8`
);

/* ---------------------------------------------------------- */
CREATE OR REPLACE TEMPORARY TABLE _tupel_mat_test_9 AS
SELECT
    qu.q_mandant_id,
    qu.q_anz_artikel_tupel,
    qu.q_anzahl_artikel,
    pro.p_anz_artikel_tupel,
    pro.p_anzahl_artikel,
    ABS(qu.q_anzahl_artikel - pro.p_anzahl_artikel) AS anzahl_artikel_diff
FROM (
    SELECT
        a.mandant_id AS q_mandant_id,
        LENGTH(a.kl_art_id) - LENGTH(REPLACE(a.kl_art_id, ',', '')) + 1 AS q_anz_artikel_tupel,
        COUNT(*) AS q_anzahl_artikel
    FROM dbp_etl_process.tupel_mat_etl AS a
    INNER JOIN `_week` AS b
        ON a.mandant_id = b.mandant_id AND a.a500_kjwo_update = b.kjwo
    WHERE
        NOT a.art_id IS NULL
    GROUP BY
        q_mandant_id,
        q_anz_artikel_tupel
    HAVING
        q_anz_artikel_tupel <= 2
) AS qu
INNER JOIN (
    SELECT
        a0.mandant_id AS p_mandant_id,
        LENGTH(a0.kl_art_id) - LENGTH(REPLACE(a0.kl_art_id, ',', '')) + 1 AS p_anz_artikel_tupel,
        COUNT(*) AS p_anzahl_artikel
    FROM dbp_etl_process.tupel_mat_etl AS a0
    INNER JOIN `_week_prev` AS b0
        ON a0.mandant_id = b0.mandant_id AND a0.a500_kjwo_update = b0.kjwo
    WHERE
        NOT a0.art_id IS NULL
    GROUP BY
        p_mandant_id,
        p_anz_artikel_tupel
    HAVING
        p_anz_artikel_tupel <= 2
) AS pro
    ON
        qu.q_mandant_id = pro.p_mandant_id
        AND qu.q_anz_artikel_tupel = pro.p_anz_artikel_tupel
WHERE
    CASE
        WHEN qu.q_anzahl_artikel > 100
            THEN ABS(qu.q_anzahl_artikel - pro.p_anzahl_artikel) > qu.q_anzahl_artikel * 0.05
        ELSE ABS(qu.q_anzahl_artikel - pro.p_anzahl_artikel) > qu.q_anzahl_artikel * 0.3
    END
ORDER BY
    1 NULLS LAST,
    2 NULLS LAST;

INSERT INTO dbp_etl_process.mat_test
(
    SELECT
        9 AS test_id,
        'TUPEL' AS test_type,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        CASE WHEN COUNT(*) >= 1 THEN 'ERROR' WHEN COUNT(*) < 1 THEN 'OK' ELSE NULL END AS test_status,
        COUNT(*) AS error_count,
        STRING_AGG(
            DISTINCT CAST(q_mandant_id AS STRING), ','
            ORDER BY
                CAST(q_mandant_id AS STRING)
        ) AS error_mandant_id,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_9`
);

INSERT INTO dbp_etl_process.mat_test_desc
(
    SELECT
        9 AS test_id,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        'ANZAHL_ARTIKEL_DIFF',
        CASE
            WHEN COUNT(*) >= 1
                THEN 'WHEN Q_ANZAHL_ARTIKEL > 100 THEN ANZAHL_ARTIKEL_DIFF > (Q_ANZAHL_ARTIKEL*0.05) \nELSE ANZAHL_ARTIKEL_DIFF > (Q_ANZAHL_ARTIKEL*0.3)'
            WHEN COUNT(*) < 1
                THEN 'OK'
            ELSE NULL
        END AS description,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_9`
);

INSERT INTO dbp_etl_process.mat_test_detail
(
    SELECT
        9 AS test_id,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        q_mandant_id,
        'MANDANT_ID' AS key_name,
        q_mandant_id AS key_value,
        'ANZAHL_ARTIKEL_DIFF',
        SUBSTR(CAST(anzahl_artikel_diff AS STRING), 1, 300) AS anzahl_artikel_diff,
        'ANZAHL_ARTIKEL_DIFF < (Q_ANZAHL_ARTIKEL*0.05) OR ANZAHL_ARTIKEL_DIFF < (Q_ANZAHL_ARTIKEL*0.3)',
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_9`
);

/* ---------------------------------------------------------- */
CREATE OR REPLACE TEMPORARY TABLE _tupel_mat_test_10 AS
SELECT
    qu.q_mandant_id,
    qu.q_nl_em,
    qu.q_nl_komplett,
    qu.q_anteil_em,
    pro.p_nl_em,
    pro.p_nl_komplett,
    pro.p_anteil_em
FROM (
    SELECT
        a.mandant_id AS q_mandant_id,
        SUM(
            CASE
                WHEN CAST(a.nielsen_gtin AS FLOAT64) = -9999 AND a.art_id IS NULL
                    THEN 1
                ELSE 0
            END
        ) AS q_nl_em,
        SUM(CASE WHEN a.art_id IS NULL THEN 1 ELSE 0 END) AS q_nl_komplett,
        ROUND(
            CAST(CAST(SUM(
                CASE
                    WHEN CAST(a.nielsen_gtin AS FLOAT64) = -9999 AND a.art_id IS NULL
                        THEN 1
                    ELSE 0
                END
            ) AS FLOAT64) / IF(
                CAST(SUM(CASE WHEN a.art_id IS NULL THEN 1 ELSE 0 END) AS FLOAT64) = 0,
                NULL,
                CAST(SUM(CASE WHEN a.art_id IS NULL THEN 1 ELSE 0 END) AS FLOAT64)
            ) AS NUMERIC),
            2
        ) * 100 AS q_anteil_em
    FROM dbp_etl_process.tupel_mat_etl AS a
    INNER JOIN `_week` AS b
        ON a.mandant_id = b.mandant_id AND a.a500_kjwo_update = b.kjwo
    WHERE
        NOT ROUND(SAFE_CAST(a.nielsen_gtin AS BIGNUMERIC), 0) IS NULL
    GROUP BY
        q_mandant_id
) AS qu
INNER JOIN (
    SELECT
        a0.mandant_id AS p_mandant_id,
        SUM(
            CASE
                WHEN CAST(a0.nielsen_gtin AS FLOAT64) = -9999 AND a0.art_id IS NULL
                    THEN 1
                ELSE 0
            END
        ) AS p_nl_em,
        SUM(CASE WHEN a0.art_id IS NULL THEN 1 ELSE 0 END) AS p_nl_komplett,
        ROUND(
            CAST(CAST(SUM(
                CASE
                    WHEN CAST(a0.nielsen_gtin AS FLOAT64) = -9999 AND a0.art_id IS NULL
                        THEN 1
                    ELSE 0
                END
            ) AS FLOAT64) / IF(
                CAST(SUM(CASE WHEN a0.art_id IS NULL THEN 1 ELSE 0 END) AS FLOAT64) = 0,
                NULL,
                CAST(SUM(CASE WHEN a0.art_id IS NULL THEN 1 ELSE 0 END) AS FLOAT64)
            ) AS NUMERIC),
            2
        ) * 100 AS p_anteil_em
    FROM dbp_etl_process.tupel_mat_etl AS a0
    INNER JOIN `_week_prev` AS b0
        ON a0.mandant_id = b0.mandant_id AND a0.a500_kjwo_update = b0.kjwo
    WHERE
        NOT ROUND(SAFE_CAST(a0.nielsen_gtin AS BIGNUMERIC), 0) IS NULL
    GROUP BY
        p_mandant_id
) AS pro
    ON qu.q_mandant_id = pro.p_mandant_id
WHERE
    qu.q_anteil_em - pro.p_anteil_em > qu.q_anteil_em * 0.03
ORDER BY
    1 NULLS LAST;

INSERT INTO dbp_etl_process.mat_test
(
    SELECT
        10 AS test_id,
        'TUPEL' AS test_type,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        CASE WHEN COUNT(*) >= 1 THEN 'ERROR' WHEN COUNT(*) < 1 THEN 'OK' ELSE NULL END AS test_status,
        COUNT(*) AS error_count,
        STRING_AGG(
            DISTINCT CAST(q_mandant_id AS STRING), ','
            ORDER BY
                CAST(q_mandant_id AS STRING)
        ) AS error_mandant_id,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_10`
);

INSERT INTO dbp_etl_process.mat_test_desc
(
    SELECT
        10 AS test_id,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        'Q_ANTEIL_EM',
        CASE
            WHEN COUNT(*) >= 1
                THEN 'Q_ANTEIL_EM-P_ANTEIL_EM > (Q_ANTEIL_EM*0.03)'
            WHEN COUNT(*) < 1
                THEN 'OK'
            ELSE NULL
        END AS description,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_10`
);

INSERT INTO dbp_etl_process.mat_test_detail
(
    SELECT
        10 AS test_id,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        q_mandant_id,
        'MANDANT_ID' AS key_name,
        q_mandant_id AS key_value,
        'Q_ANTEIL_EM',
        SUBSTR(CAST(q_anteil_em AS STRING), 1, 300) AS q_anteil_em,
        'Q_ANTEIL_EM-P_ANTEIL_EM < (Q_ANTEIL_EM*0.03)',
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_10`
);

/* ---------------------------------------------------------- */
CREATE OR REPLACE TEMPORARY TABLE _tupel_mat_test_11 AS
SELECT
    a.mandant_id,
    a.a500_kjwo_update,
    a.matching_id,
    a.a446_lieferant_bez_latein,
    b0.gp_name AS a446_lieferant_bez_latein_source
FROM (
    SELECT
        a.mandant_id,
        a.a500_kjwo_update,
        a.matching_id,
        a.a16_akt_lieferant_id,
        a.a446_lieferant_bez_latein
    FROM dbp_etl_process.tupel_mat_etl AS a
    INNER JOIN `_week` AS b
        ON a.mandant_id = b.mandant_id AND a.a500_kjwo_update = b.kjwo
) AS a
INNER JOIN dbp_data.gp AS b0
    ON
        a.mandant_id = b0.mandant_id
        AND CAST(a.a16_akt_lieferant_id AS FLOAT64) = b0.gp_id
WHERE
    a.a446_lieferant_bez_latein <> b0.gp_name
    AND CAST(a.a16_akt_lieferant_id AS FLOAT64) > 1
    AND a.mandant_id <> 8
GROUP BY
    a.mandant_id,
    a.a500_kjwo_update,
    a.matching_id,
    a.a446_lieferant_bez_latein,
    a446_lieferant_bez_latein_source
UNION ALL
SELECT
    a.mandant_id,
    a.a500_kjwo_update,
    a.matching_id,
    a.a446_lieferant_bez_latein,
    b1.hersteller_bez AS a446_lieferant_bez_latein_source
FROM (
    SELECT
        a.mandant_id,
        a.a500_kjwo_update,
        a.matching_id,
        a.a450_art_nielsen_nr,
        a.art_id,
        a.a446_lieferant_bez_latein
    FROM dbp_etl_process.tupel_mat_etl AS a
    INNER JOIN `_week` AS b
        ON a.mandant_id = b.mandant_id AND a.a500_kjwo_update = b.kjwo
) AS a
INNER JOIN `_art_nielsen` AS b1
    ON a.mandant_id = b1.mandant_id AND a.a450_art_nielsen_nr = b1.art_nielsen_id
WHERE
    a.mandant_id > 1
    AND a.art_id IS NULL
    AND a.a446_lieferant_bez_latein <> b1.hersteller_bez
GROUP BY
    a.mandant_id,
    a.a500_kjwo_update,
    a.matching_id,
    a.a446_lieferant_bez_latein,
    a446_lieferant_bez_latein_source;

INSERT INTO dbp_etl_process.mat_test
(
    SELECT
        11 AS test_id,
        'MASTER DATA' AS test_type,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        CASE WHEN COUNT(*) >= 1 THEN 'ERROR' WHEN COUNT(*) < 1 THEN 'OK' ELSE NULL END AS test_status,
        COUNT(*) AS error_count,
        STRING_AGG(
            DISTINCT CAST(mandant_id AS STRING), ','
            ORDER BY
                CAST(mandant_id AS STRING)
        ) AS error_mandant_id,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_11`
);

INSERT INTO dbp_etl_process.mat_test_desc
(
    SELECT
        11 AS test_id,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        'A446_LIEFERANT_BEZ_LATEIN',
        CASE
            WHEN COUNT(*) >= 1
                THEN 'A446_LIEFERANT_BEZ_LATEIN <> A446_LIEFERANT_BEZ_LATEIN_SOURCE'
            WHEN COUNT(*) < 1
                THEN 'OK'
            ELSE NULL
        END AS description,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_11`
);

INSERT INTO dbp_etl_process.mat_test_detail
(
    SELECT
        11 AS test_id,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        mandant_id,
        'MATCHING_ID' AS key_name,
        matching_id AS key_value,
        'A446_LIEFERANT_BEZ_LATEIN',
        a446_lieferant_bez_latein,
        a446_lieferant_bez_latein_source,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_11`
);

/* ---------------------------------------------------------- */
CREATE OR REPLACE TEMPORARY TABLE _mandat AS
SELECT DISTINCT a.mandant_id
FROM dbp_data.sortiment_leistung AS a
INNER JOIN `_week` AS b
    ON a.mandant_id = b.mandant_id AND a.kjwo_update = b.kjwo;

CREATE OR REPLACE TEMPORARY TABLE _tupel_mat_test_12 AS
SELECT
    c.mandant_id,
    a.kjwo_update,
    COUNT(*) AS count
FROM dbp_data.tupel_spr_zu AS a
INNER JOIN `_week` AS b
    ON a.mandant_id = b.mandant_id AND a.kjwo_update = b.kjwo
RIGHT JOIN `_mandat` AS c
    ON a.mandant_id = c.mandant_id
WHERE
    a.mandant_id IS NULL
GROUP BY
    a.kjwo_update,
    c.mandant_id
ORDER BY
    2 NULLS LAST,
    1 NULLS LAST;

INSERT INTO dbp_etl_process.mat_test
(
    SELECT
        12 AS test_id,
        'TUPEL' AS test_type,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        CASE WHEN COUNT(*) >= 1 THEN 'ERROR' WHEN COUNT(*) < 1 THEN 'OK' ELSE NULL END AS test_status,
        COUNT(*) AS error_count,
        STRING_AGG(
            DISTINCT CAST(mandant_id AS STRING), ','
            ORDER BY
                CAST(mandant_id AS STRING)
        ) AS error_mandant_id,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_12`
);

INSERT INTO dbp_etl_process.mat_test_desc
(
    SELECT
        12 AS test_id,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        'MANDANT_ID',
        CASE
            WHEN COUNT(*) >= 1
                THEN 'NO RECORDS FOR MONDANT_ID'
            WHEN COUNT(*) < 1
                THEN 'OK'
            ELSE NULL
        END AS description,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_12`
);

INSERT INTO dbp_etl_process.mat_test_detail
(
    SELECT
        12 AS test_id,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        mandant_id,
        'MANDANT_ID' AS key_name,
        mandant_id AS key_value,
        'MANDANT_ID',
        SUBSTR(CAST(mandant_id AS STRING), 1, 300) AS mandant_id6,
        'COUNT(MANDANT_ID)>0',
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_12`
);

/* ---------------------------------------------------------- */
CREATE OR REPLACE TEMPORARY TABLE _tupel_mat_test_13 AS
SELECT
    a.mandant_id,
    a.a500_kjwo_update,
    SUM(a.a27_totalabschriften_wert_netto_absolut) AS netto_absolut
FROM dbp_etl_process.tupel_mat_etl AS a
INNER JOIN `_week` AS b
    ON a.mandant_id = b.mandant_id AND a.a500_kjwo_update = b.kjwo
GROUP BY
    a.mandant_id,
    a.a500_kjwo_update
HAVING
    netto_absolut <= 0
ORDER BY
    1 NULLS LAST,
    2 NULLS LAST;

INSERT INTO dbp_etl_process.mat_test
(
    SELECT
        13 AS test_id,
        'TUPEL' AS test_type,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        CASE WHEN COUNT(*) >= 1 THEN 'ERROR' WHEN COUNT(*) < 1 THEN 'OK' ELSE NULL END AS test_status,
        COUNT(*) AS error_count,
        STRING_AGG(
            DISTINCT CAST(mandant_id AS STRING), ','
            ORDER BY
                CAST(mandant_id AS STRING)
        ) AS error_mandant_id,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_13`
);

INSERT INTO dbp_etl_process.mat_test_desc
(
    SELECT
        13 AS test_id,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        'A27_TOTALABSCHRIFTEN_WERT_NETTO_ABSOLUT',
        CASE
            WHEN COUNT(*) >= 1
                THEN 'SUM(A27_TOTALABSCHRIFTEN_WERT_NETTO_ABSOLUT)<=0'
            WHEN COUNT(*) < 1
                THEN 'OK'
            ELSE NULL
        END AS description,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_13`
);

INSERT INTO dbp_etl_process.mat_test_detail
(
    SELECT
        13 AS test_id,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        mandant_id,
        'MANDANT_ID' AS key_name,
        mandant_id AS key_value,
        'A27_TOTALABSCHRIFTEN_WERT_NETTO_ABSOLUT',
        SUBSTR(CAST(netto_absolut AS STRING), 1, 300) AS netto_absolut,
        'SUM(A27_TOTALABSCHRIFTEN_WERT_NETTO_ABSOLUT) > 0',
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_13`
);

/* ---------------------------------------------------------- */
CREATE OR REPLACE TEMPORARY TABLE _tupel_mat_test_14 AS
SELECT
    a.mandant_id,
    a.a500_kjwo_update,
    SUM(a.totalabschriften_wert_netto_absolut_vj) AS netto_absolut_vj
FROM dbp_etl_process.tupel_mat_etl AS a
INNER JOIN `_week` AS b
    ON a.mandant_id = b.mandant_id AND a.a500_kjwo_update = b.kjwo
GROUP BY
    a.mandant_id,
    a.a500_kjwo_update
HAVING
    netto_absolut_vj <= 0
ORDER BY
    1 NULLS LAST,
    2 NULLS LAST;

INSERT INTO dbp_etl_process.mat_test
(
    SELECT
        14 AS test_id,
        'TUPEL' AS test_type,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        CASE WHEN COUNT(*) >= 1 THEN 'ERROR' WHEN COUNT(*) < 1 THEN 'OK' ELSE NULL END AS test_status,
        COUNT(*) AS error_count,
        STRING_AGG(
            DISTINCT CAST(mandant_id AS STRING), ','
            ORDER BY
                CAST(mandant_id AS STRING)
        ) AS error_mandant_id,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_14`
);

INSERT INTO dbp_etl_process.mat_test_desc
(
    SELECT
        14 AS test_id,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        'TOTALABSCHRIFTEN_WERT_NETTO_ABSOLUT_VJ',
        CASE
            WHEN COUNT(*) >= 1
                THEN 'SUM(TOTALABSCHRIFTEN_WERT_NETTO_ABSOLUT_VJ)<=0'
            WHEN COUNT(*) < 1
                THEN 'OK'
            ELSE NULL
        END AS description,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_14`
);

INSERT INTO dbp_etl_process.mat_test_detail
(
    SELECT
        14 AS test_id,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        mandant_id,
        'MANDANT_ID' AS key_name,
        mandant_id AS key_value,
        'TOTALABSCHRIFTEN_WERT_NETTO_ABSOLUT_VJ',
        SUBSTR(CAST(netto_absolut_vj AS STRING), 1, 300) AS netto_absolut_vj,
        'SUM(TOTALABSCHRIFTEN_WERT_NETTO_ABSOLUT_VJ) > 0',
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_14`
);

/* ---------------------------------------------------------- */
CREATE OR REPLACE TEMPORARY TABLE _tupel_mat_test_15 AS
SELECT
    a.mandant_id,
    a.a500_kjwo_update,
    SUM(a.totalabschriften_wert_netto_absolut_wg) AS netto_absolut_wg
FROM dbp_etl_process.tupel_mat_etl AS a
INNER JOIN `_week` AS b
    ON a.mandant_id = b.mandant_id AND a.a500_kjwo_update = b.kjwo
GROUP BY
    a.mandant_id,
    a.a500_kjwo_update
HAVING
    netto_absolut_wg <= 0
ORDER BY
    1 NULLS LAST,
    2 NULLS LAST;

INSERT INTO dbp_etl_process.mat_test
(
    SELECT
        15 AS test_id,
        'TUPEL' AS test_type,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        CASE WHEN COUNT(*) >= 1 THEN 'ERROR' WHEN COUNT(*) < 1 THEN 'OK' ELSE NULL END AS test_status,
        COUNT(*) AS error_count,
        STRING_AGG(
            DISTINCT CAST(mandant_id AS STRING), ','
            ORDER BY
                CAST(mandant_id AS STRING)
        ) AS error_mandant_id,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_15`
);

INSERT INTO dbp_etl_process.mat_test_desc
(
    SELECT
        15 AS test_id,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        'TOTALABSCHRIFTEN_WERT_NETTO_ABSOLUT_WG',
        CASE
            WHEN COUNT(*) >= 1
                THEN 'SUM(TOTALABSCHRIFTEN_WERT_NETTO_ABSOLUT_WG)<=0'
            WHEN COUNT(*) < 1
                THEN 'OK'
            ELSE NULL
        END AS description,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_15`
);

INSERT INTO dbp_etl_process.mat_test_detail
(
    SELECT
        15 AS test_id,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        mandant_id,
        'MANDANT_ID' AS key_name,
        mandant_id AS key_value,
        'TOTALABSCHRIFTEN_WERT_NETTO_ABSOLUT_WG',
        SUBSTR(CAST(netto_absolut_wg AS STRING), 1, 300) AS netto_absolut_wg,
        'SUM(TOTALABSCHRIFTEN_WERT_NETTO_ABSOLUT_WG) > 0',
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_15`
);

/* ---------------------------------------------------------- */
CREATE OR REPLACE TEMPORARY TABLE _tupel_mat_test_16 AS
SELECT
    mandant_id,
    a500_kjwo_update,
    art_id,
    kl_art_id,
    anzahl_markt_wochen_kombis_abverkauf_mit_listung,
    anzahl_markt_wochen_kombis_listung
FROM (
    SELECT
        a.mandant_id,
        a.a500_kjwo_update,
        a.art_id,
        a.kl_art_id,
        a.anzahl_markt_wochen_kombis_abverkauf_mit_listung,
        a.anzahl_markt_wochen_kombis_listung
    FROM dbp_etl_process.tupel_mat_etl AS a
    INNER JOIN `_week` AS b
        ON a.mandant_id = b.mandant_id AND a.a500_kjwo_update = b.kjwo
) AS a
WHERE
    anzahl_markt_wochen_kombis_abverkauf_mit_listung > anzahl_markt_wochen_kombis_listung;

INSERT INTO dbp_etl_process.mat_test
(
    SELECT
        16 AS test_id,
        'TUPEL' AS test_type,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        CASE WHEN COUNT(*) >= 1 THEN 'ERROR' WHEN COUNT(*) < 1 THEN 'OK' ELSE NULL END AS test_status,
        COUNT(*) AS error_count,
        STRING_AGG(
            DISTINCT CAST(mandant_id AS STRING), ','
            ORDER BY
                CAST(mandant_id AS STRING)
        ) AS error_mandant_id,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_16`
);

INSERT INTO dbp_etl_process.mat_test_desc
(
    SELECT
        16 AS test_id,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        'ANZAHL_MARKT_WOCHEN_KOMBIS_ABVERKAUF_MIT_LISTUNG',
        CASE
            WHEN COUNT(*) >= 1
                THEN ' ANZAHL_MARKT_WOCHEN_KOMBIS_ABVERKAUF_MIT_LISTUNG > ANZAHL_MARKT_WOCHEN_KOMBIS_LISTUNG'
            WHEN COUNT(*) < 1
                THEN 'OK'
            ELSE NULL
        END AS description,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_16`
);

INSERT INTO dbp_etl_process.mat_test_detail
(
    SELECT
        16 AS test_id,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        mandant_id,
        'ART_ID' AS key_name,
        art_id AS key_value,
        'ANZAHL_MARKT_WOCHEN_KOMBIS_ABVERKAUF_MIT_LISTUNG',
        SUBSTR(CAST(anzahl_markt_wochen_kombis_abverkauf_mit_listung AS STRING), 1, 300) AS anzahl_markt_wochen_kombis_abverkauf_mit_listung,
        'ANZAHL_MARKT_WOCHEN_KOMBIS_LISTUNG',
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_16`
);

/* ---------------------------------------------------------- */ /* TUPEL */
CREATE OR REPLACE TEMPORARY TABLE _abgleich_tm_artbew_q AS
SELECT
    a.mandant_id,
    a.a500_kjwo_update,
    a.a425_kjmo,
    a.matching_id,
    a.a21_kassenumsatz_kl_absolut_netto,
    a.a17_absatz_kl
FROM dbp_etl_process.tupel_mat_etl AS a
INNER JOIN `_week` AS b
    ON a.mandant_id = b.mandant_id AND a.a500_kjwo_update = b.kjwo;

/* KMO */
CREATE OR REPLACE TEMPORARY TABLE _abgleich_tm_artbew_p AS
SELECT
    a.mandant_id,
    c.art_matching_id,
    SUM(a.umsatz_netto) AS umsatz_netto,
    SUM(a.menge) AS absatz
FROM dbp_data.artbew_wo_sum AS a
INNER JOIN dbp_data.woche_kj_kl AS b
    ON a.kjwo_kl = b.kjwo_kl
INNER JOIN (
    SELECT
        mandant_id,
        art_matching_id,
        art_id
    FROM `_art_matching_nielsen_per_kmo`
    WHERE
        art_id <> -1
    GROUP BY
        mandant_id,
        art_matching_id,
        art_id
) AS c
    ON a.art_id = c.art_id AND a.mandant_id = c.mandant_id
WHERE
    (a.mandant_id, b.kjwo) IN (
        SELECT (mandant_id, kjwo)
        FROM (
            SELECT
                b.mandant_id,
                c.kjwo,
                (
                    RANK() OVER (
                        PARTITION BY b.mandant_id
                        ORDER BY b.mandant_id IS NULL, b.mandant_id, c.kjwo IS NULL DESC, c.kjwo DESC
                    )
                ) * -1 AS akt_wo
            FROM dbp_msi_data.ek_sort_sortiment_mat_zeitraum AS a0
            INNER JOIN (
                SELECT
                    mandant_id,
                    MAX(kjmo) AS kjmo
                FROM dbp_data.sortiment_leistung
                WHERE
                    mandant_id > 1
                GROUP BY
                    mandant_id
            ) AS b
                ON a0.kjmo_sort = b.kjmo
            INNER JOIN dbp_data.woche AS c
                ON a0.kjwo_bis >= c.kjwo
            QUALIFY
                (
                    (
                        RANK() OVER (
                            PARTITION BY b.mandant_id
                            ORDER BY b.mandant_id IS NULL, b.mandant_id, c.kjwo IS NULL DESC, c.kjwo DESC
                        )
                    ) * -1
                ) BETWEEN -52 AND (
                    -1
                )
        ) AS t6
        GROUP BY
            mandant_id,
        kjwo
    )
    AND a.mandant_id > 1
GROUP BY
    a.mandant_id,
    c.art_matching_id;

/* DE */
INSERT INTO `_abgleich_tm_artbew_p`
(
    SELECT
        a.mandant_id,
        c.art_matching_id,
        SUM(a.umsatz_netto) AS umsatz_netto,
        ROUND(CAST(SUM(a.menge * d.umrech_faktor) AS NUMERIC), 3) AS absatz
    FROM dbp_data.artbew_wo_sum AS a
    INNER JOIN dbp_data.woche_kj_kl AS b
        ON a.kjwo_kl = b.kjwo_kl
    INNER JOIN (
        SELECT
            mandant_id,
            art_matching_id,
            art_id
        FROM `_art_matching_nielsen_per`
        WHERE
            art_id <> -1
        GROUP BY
            mandant_id,
            art_matching_id,
            art_id
    ) AS c
        ON a.art_id = c.art_id AND a.mandant_id = c.mandant_id
    INNER JOIN (
        SELECT
            mandant_id,
            art_id,
            MAX(umrech_faktor) AS umrech_faktor
        FROM dbp_etl.art_matching_nielsen_per_de_xxx
        WHERE
            mandant_id = 1 AND art_id <> -1
        GROUP BY
            mandant_id,
            art_id
    ) AS d
        ON a.art_id = d.art_id AND a.mandant_id = d.mandant_id
    WHERE
        (a.mandant_id, b.kjwo) IN (
            SELECT (mandant_id, kjwo)
            FROM (
                SELECT
                    b.mandant_id,
                    c.kjwo,
                    (
                        RANK() OVER (
                            PARTITION BY b.mandant_id
                            ORDER BY b.mandant_id IS NULL, b.mandant_id, c.kjwo IS NULL DESC, c.kjwo DESC
                        )
                    ) * -1 AS akt_wo
                FROM dbp_msi_data.ek_sort_sortiment_mat_zeitraum AS a0
                INNER JOIN (
                    SELECT
                        mandant_id,
                        MAX(kjmo) AS kjmo
                    FROM dbp_data.sortiment_leistung
                    WHERE
                        mandant_id = 1
                    GROUP BY
                        mandant_id
                ) AS b
                    ON a0.kjmo_sort = b.kjmo
                INNER JOIN dbp_data.woche AS c
                    ON a0.kjwo_bis >= c.kjwo
                QUALIFY
                    (
                        (
                            RANK() OVER (
                                PARTITION BY b.mandant_id
                                ORDER BY b.mandant_id IS NULL, b.mandant_id, c.kjwo IS NULL DESC, c.kjwo DESC
                            )
                        ) * -1
                    ) BETWEEN -52 AND (
                        -1
                    )
            ) AS t9
            GROUP BY
                mandant_id,
            kjwo
        )
        AND a.mandant_id = 1
    GROUP BY
        a.mandant_id,
        c.art_matching_id
);

CREATE OR REPLACE TEMPORARY TABLE _tupel_mat_test_17 AS
SELECT
    a.mandant_id,
    a.a500_kjwo_update,
    a.a425_kjmo,
    a.matching_id,
    a.a21_kassenumsatz_kl_absolut_netto,
    b.umsatz_netto,
    ABS(a.a21_kassenumsatz_kl_absolut_netto - b.umsatz_netto) AS diff_umsatz
FROM `_abgleich_tm_artbew_q` AS a
INNER JOIN `_abgleich_tm_artbew_p` AS b
    ON a.mandant_id = b.mandant_id AND a.matching_id = b.art_matching_id
WHERE
    ABS(a.a21_kassenumsatz_kl_absolut_netto - b.umsatz_netto) > 5
ORDER BY
    diff_umsatz DESC NULLS FIRST;

INSERT INTO dbp_etl_process.mat_test
(
    SELECT
        17 AS test_id,
        'MASTER DATA' AS test_type,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        CASE WHEN COUNT(*) >= 1 THEN 'ERROR' WHEN COUNT(*) < 1 THEN 'OK' ELSE NULL END AS test_status,
        COUNT(*) AS error_count,
        STRING_AGG(
            DISTINCT CAST(mandant_id AS STRING), ','
            ORDER BY
                CAST(mandant_id AS STRING)
        ) AS error_mandant_id,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_17`
);

INSERT INTO dbp_etl_process.mat_test_desc
(
    SELECT
        17 AS test_id,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        'A21_KASSENUMSATZ_KL_ABSOLUT_NETTO',
        CASE
            WHEN COUNT(*) >= 1
                THEN 'ABS(A21_KASSENUMSATZ_KL_ABSOLUT_NETTO - B.UMSATZ_NETTO) > 5'
            WHEN COUNT(*) < 1
                THEN 'OK'
            ELSE NULL
        END AS description,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_17`
);

INSERT INTO dbp_etl_process.mat_test_detail
(
    SELECT
        17 AS test_id,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        mandant_id,
        'MATCHING_ID' AS key_name,
        matching_id AS key_value,
        'A21_KASSENUMSATZ_KL_ABSOLUT_NETTO',
        SUBSTR(CAST(a21_kassenumsatz_kl_absolut_netto AS STRING), 1, 300) AS a21_kassenumsatz_kl_absolut_netto,
        SUBSTR(CAST(umsatz_netto AS STRING), 1, 300) AS umsatz_netto,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_17`
);

/* ----------------------------------------------------------- */
CREATE OR REPLACE TEMPORARY TABLE _tupel_mat_test_18 AS
SELECT
    a.mandant_id,
    a.a500_kjwo_update,
    a.a425_kjmo,
    a.matching_id,
    a.a17_absatz_kl,
    b.absatz,
    ABS(a.a17_absatz_kl - b.absatz) AS diff_absatz
FROM `_abgleich_tm_artbew_q` AS a
INNER JOIN `_abgleich_tm_artbew_p` AS b
    ON a.mandant_id = b.mandant_id AND a.matching_id = b.art_matching_id
WHERE
    ABS(a.a17_absatz_kl - b.absatz) > 5
ORDER BY
    diff_absatz DESC NULLS FIRST;

INSERT INTO dbp_etl_process.mat_test
(
    SELECT
        18 AS test_id,
        'MASTER DATA' AS test_type,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        CASE WHEN COUNT(*) >= 1 THEN 'ERROR' WHEN COUNT(*) < 1 THEN 'OK' ELSE NULL END AS test_status,
        COUNT(*) AS error_count,
        STRING_AGG(
            DISTINCT CAST(mandant_id AS STRING), ','
            ORDER BY
                CAST(mandant_id AS STRING)
        ) AS error_mandant_id,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_18`
);

INSERT INTO dbp_etl_process.mat_test_desc
(
    SELECT
        18 AS test_id,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        'A17_ABSATZ_KL',
        CASE
            WHEN COUNT(*) >= 1
                THEN 'ABS(A.A17_ABSATZ_KL-B.ABSATZ) > 5'
            WHEN COUNT(*) < 1
                THEN 'OK'
            ELSE NULL
        END AS description,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_18`
);

INSERT INTO dbp_etl_process.mat_test_detail
(
    SELECT
        18 AS test_id,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        mandant_id,
        'MATCHING_ID' AS key_name,
        matching_id AS key_value,
        'A17_ABSATZ_KL',
        SUBSTR(CAST(a17_absatz_kl AS STRING), 1, 300) AS a17_absatz_kl,
        SUBSTR(CAST(absatz AS STRING), 1, 300) AS absatz,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_18`
);

/* ----------------------------------------------------------- */
CREATE OR REPLACE TEMPORARY TABLE _tupel_mat_test_19 AS
SELECT
    a.mandant_id,
    a.matching_id,
    a.art_id,
    a.a500_kjwo_update,
    a.a339_umsatzsteuer,
    c.mwst
FROM (
    SELECT
        a.mandant_id,
        a.matching_id,
        a.art_id,
        a.a500_kjwo_update,
        a.a339_umsatzsteuer
    FROM dbp_etl_process.tupel_mat_etl AS a
    INNER JOIN `_week` AS b
        ON a.mandant_id = b.mandant_id AND a.a500_kjwo_update = b.kjwo
) AS a
INNER JOIN dbp_data.art AS b0
    ON a.mandant_id = b0.mandant_id AND a.art_id = b0.art_id
INNER JOIN dbp_data.mwst_per AS c
    ON b0.mwst_id = c.mwst_id AND b0.mandant_id = c.mandant_id
WHERE
    c.dat_bis = CAST('9999-12-31' AS DATE) AND a.a339_umsatzsteuer <> c.mwst
ORDER BY
    1 NULLS LAST;

INSERT INTO dbp_etl_process.mat_test
(
    SELECT
        19 AS test_id,
        'MASTER DATA' AS test_type,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        CASE WHEN COUNT(*) >= 1 THEN 'ERROR' WHEN COUNT(*) < 1 THEN 'OK' ELSE NULL END AS test_status,
        COUNT(*) AS error_count,
        STRING_AGG(
            DISTINCT CAST(mandant_id AS STRING), ','
            ORDER BY
                CAST(mandant_id AS STRING)
        ) AS error_mandant_id,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_19`
);

INSERT INTO dbp_etl_process.mat_test_desc
(
    SELECT
        19 AS test_id,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        'A339_UMSATZSTEUER',
        CASE
            WHEN COUNT(*) >= 1
                THEN 'A339_UMSATZSTEUER<>MWST'
            WHEN COUNT(*) < 1
                THEN 'OK'
            ELSE NULL
        END AS description,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_19`
);

INSERT INTO dbp_etl_process.mat_test_detail
(
    SELECT
        19 AS test_id,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        mandant_id,
        'MATCHING_ID' AS key_name,
        matching_id AS key_value,
        'A339_UMSATZSTEUER',
        SUBSTR(CAST(a339_umsatzsteuer AS STRING), 1, 300) AS a339_umsatzsteuer,
        SUBSTR(CAST(mwst AS STRING), 1, 300) AS mwst,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_19`
);

/* ----------------------------------------------------------- */
CREATE OR REPLACE TEMPORARY TABLE _err1 AS
SELECT
    a.mandant_id,
    a.matching_id,
    a.art_id,
    a.a500_kjwo_update,
    a.a389_zek_id
FROM dbp_etl_process.tupel_mat_etl AS a
INNER JOIN `_week` AS b
    ON a.mandant_id = b.mandant_id AND a.a500_kjwo_update = b.kjwo;

CREATE OR REPLACE TEMPORARY TABLE _tupel_mat_test_20 AS
SELECT
    a.mandant_id,
    a.matching_id,
    a.art_id,
    a.a500_kjwo_update,
    a.a389_zek_id,
    b.zek_id
FROM `_err1` AS a
INNER JOIN dbp_data.art AS b
    ON a.mandant_id = b.mandant_id AND a.art_id = b.art_id
WHERE
    a.a389_zek_id <> b.zek_id
ORDER BY
    1 NULLS LAST;

INSERT INTO dbp_etl_process.mat_test
(
    SELECT
        20 AS test_id,
        'MASTER DATA' AS test_type,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        CASE WHEN COUNT(*) >= 1 THEN 'ERROR' WHEN COUNT(*) < 1 THEN 'OK' ELSE NULL END AS test_status,
        COUNT(*) AS error_count,
        STRING_AGG(
            DISTINCT CAST(mandant_id AS STRING), ','
            ORDER BY
                CAST(mandant_id AS STRING)
        ) AS error_mandant_id,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_20`
);

INSERT INTO dbp_etl_process.mat_test_desc
(
    SELECT
        20 AS test_id,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        'A389_ZEK_ID',
        CASE
            WHEN COUNT(*) >= 1
                THEN 'A389_ZEK_ID <> ZEK_ID'
            WHEN COUNT(*) < 1
                THEN 'OK'
            ELSE NULL
        END AS description,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_20`
);

INSERT INTO dbp_etl_process.mat_test_detail
(
    SELECT
        20 AS test_id,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        mandant_id,
        'MATCHING_ID' AS key_name,
        matching_id AS key_value,
        'A389_ZEK_ID',
        a389_zek_id,
        zek_id,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_20`
);

/* ----------------------------------------------------------- */
CREATE OR REPLACE TEMPORARY TABLE _tupel_mat_test_21 AS
SELECT
    a.mandant_id,
    a.matching_id,
    a.art_id,
    a.a500_kjwo_update,
    a.a396_eigenmarke,
    b0.eigenmarke_id
FROM (
    SELECT
        a.mandant_id,
        a.matching_id,
        a.art_id,
        a.a500_kjwo_update,
        a.a396_eigenmarke
    FROM dbp_etl_process.tupel_mat_etl AS a
    INNER JOIN `_week` AS b
        ON a.mandant_id = b.mandant_id AND a.a500_kjwo_update = b.kjwo
) AS a
INNER JOIN dbp_data.art AS b0
    ON a.mandant_id = b0.mandant_id AND a.art_id = b0.art_id
WHERE
    a.a396_eigenmarke <> b0.eigenmarke_id
ORDER BY
    1 NULLS LAST;

INSERT INTO dbp_etl_process.mat_test
(
    SELECT
        21 AS test_id,
        'MASTER DATA' AS test_type,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        CASE WHEN COUNT(*) >= 1 THEN 'ERROR' WHEN COUNT(*) < 1 THEN 'OK' ELSE NULL END AS test_status,
        COUNT(*) AS error_count,
        STRING_AGG(
            DISTINCT CAST(mandant_id AS STRING), ','
            ORDER BY
                CAST(mandant_id AS STRING)
        ) AS error_mandant_id,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_21`
);

INSERT INTO dbp_etl_process.mat_test_desc
(
    SELECT
        21 AS test_id,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        'A396_EIGENMARKE',
        CASE
            WHEN COUNT(*) >= 1
                THEN 'A396_EIGENMARKE <> EIGENMARKE_ID'
            WHEN COUNT(*) < 1
                THEN 'OK'
            ELSE NULL
        END AS description,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_21`
);

INSERT INTO dbp_etl_process.mat_test_detail
(
    SELECT
        21 AS test_id,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        mandant_id,
        'MATCHING_ID' AS key_name,
        matching_id AS key_value,
        'A396_EIGENMARKE',
        a396_eigenmarke,
        eigenmarke_id,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_21`
);

/* ----------------------------------------------------------- */
CREATE OR REPLACE TEMPORARY TABLE _tupel_mat_test_22 AS
SELECT
    a.mandant_id,
    a.matching_id,
    a.art_id,
    a.a500_kjwo_update,
    a.a403_restlaufzeit_zl,
    b0.mhd_zeitraum
FROM (
    SELECT
        a.mandant_id,
        a.matching_id,
        a.art_id,
        a.a500_kjwo_update,
        a.a403_restlaufzeit_zl
    FROM dbp_etl_process.tupel_mat_etl AS a
    INNER JOIN `_week` AS b
        ON a.mandant_id = b.mandant_id AND a.a500_kjwo_update = b.kjwo
) AS a
INNER JOIN dbp_data.art AS b0
    ON a.mandant_id = b0.mandant_id AND a.art_id = b0.art_id
WHERE
    a.a403_restlaufzeit_zl <> b0.mhd_zeitraum
ORDER BY
    1 NULLS LAST;

INSERT INTO dbp_etl_process.mat_test
(
    SELECT
        22 AS test_id,
        'MASTER DATA' AS test_type,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        CASE WHEN COUNT(*) >= 1 THEN 'ERROR' WHEN COUNT(*) < 1 THEN 'OK' ELSE NULL END AS test_status,
        COUNT(*) AS error_count,
        STRING_AGG(
            DISTINCT CAST(mandant_id AS STRING), ','
            ORDER BY
                CAST(mandant_id AS STRING)
        ) AS error_mandant_id,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_22`
);

INSERT INTO dbp_etl_process.mat_test_desc
(
    SELECT
        22 AS test_id,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        'A403_RESTLAUFZEIT_ZL',
        CASE
            WHEN COUNT(*) >= 1
                THEN 'A403_RESTLAUFZEIT_ZL <> MHD_ZEITRAUM'
            WHEN COUNT(*) < 1
                THEN 'OK'
            ELSE NULL
        END AS description,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_22`
);

INSERT INTO dbp_etl_process.mat_test_detail
(
    SELECT
        22 AS test_id,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        mandant_id,
        'MATCHING_ID' AS key_name,
        matching_id AS key_value,
        'A403_RESTLAUFZEIT_ZL',
        SUBSTR(CAST(a403_restlaufzeit_zl AS STRING), 1, 300) AS a403_restlaufzeit_zl,
        SUBSTR(CAST(mhd_zeitraum AS STRING), 1, 300) AS mhd_zeitraum,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_22`
);

/* ----------------------------------------------------------- */
CREATE OR REPLACE TEMPORARY TABLE _tupel_mat_test_23 AS
SELECT
    a.mandant_id,
    a.matching_id,
    a.art_id,
    a.a500_kjwo_update,
    a.a416_artikelrolle_id,
    b0.artikelrolle_id
FROM (
    SELECT
        a.mandant_id,
        a.matching_id,
        a.art_id,
        a.a500_kjwo_update,
        a.a416_artikelrolle_id
    FROM dbp_etl_process.tupel_mat_etl AS a
    INNER JOIN `_week` AS b
        ON a.mandant_id = b.mandant_id AND a.a500_kjwo_update = b.kjwo
) AS a
INNER JOIN dbp_data.art AS b0
    ON a.mandant_id = b0.mandant_id AND a.art_id = b0.art_id
WHERE
    a.a416_artikelrolle_id <> b0.artikelrolle_id
ORDER BY
    1 NULLS LAST;

INSERT INTO dbp_etl_process.mat_test
(
    SELECT
        23 AS test_id,
        'MASTER DATA' AS test_type,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        CASE WHEN COUNT(*) >= 1 THEN 'ERROR' WHEN COUNT(*) < 1 THEN 'OK' ELSE NULL END AS test_status,
        COUNT(*) AS error_count,
        STRING_AGG(
            DISTINCT CAST(mandant_id AS STRING), ','
            ORDER BY
                CAST(mandant_id AS STRING)
        ) AS error_mandant_id,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_23`
);

INSERT INTO dbp_etl_process.mat_test_desc
(
    SELECT
        23 AS test_id,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        'A416_ARTIKELROLLE_ID',
        CASE
            WHEN COUNT(*) >= 1
                THEN 'A416_ARTIKELROLLE_ID <> ARTIKELROLLE_ID'
            WHEN COUNT(*) < 1
                THEN 'OK'
            ELSE NULL
        END AS description,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_23`
);

INSERT INTO dbp_etl_process.mat_test_detail
(
    SELECT
        23 AS test_id,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        mandant_id,
        'MATCHING_ID' AS key_name,
        matching_id AS key_value,
        'A416_ARTIKELROLLE_ID',
        a416_artikelrolle_id,
        artikelrolle_id,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_23`
);

/* ----------------------------------------------------------- */
CREATE OR REPLACE TEMPORARY TABLE _tupel_mat_test_24 AS
SELECT
    a.mandant_id,
    a.matching_id,
    a.art_id,
    a.a500_kjwo_update,
    a.a391_disc_pe,
    b0.aldi_id
FROM (
    SELECT
        a.mandant_id,
        a.matching_id,
        a.art_id,
        a.a500_kjwo_update,
        a.a391_disc_pe
    FROM dbp_etl_process.tupel_mat_etl AS a
    INNER JOIN `_week` AS b
        ON a.mandant_id = b.mandant_id AND a.a500_kjwo_update = b.kjwo
) AS a
INNER JOIN dbp_data.art AS b0
    ON a.mandant_id = b0.mandant_id AND a.art_id = b0.art_id
WHERE
    a.a391_disc_pe <> b0.aldi_id
ORDER BY
    1 NULLS LAST;

INSERT INTO dbp_etl_process.mat_test
(
    SELECT
        24 AS test_id,
        'MASTER DATA' AS test_type,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        CASE WHEN COUNT(*) >= 1 THEN 'ERROR' WHEN COUNT(*) < 1 THEN 'OK' ELSE NULL END AS test_status,
        COUNT(*) AS error_count,
        STRING_AGG(
            DISTINCT CAST(mandant_id AS STRING), ','
            ORDER BY
                CAST(mandant_id AS STRING)
        ) AS error_mandant_id,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_24`
);

INSERT INTO dbp_etl_process.mat_test_desc
(
    SELECT
        24 AS test_id,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        'A391_DISC_PE',
        CASE
            WHEN COUNT(*) >= 1
                THEN 'A391_DISC_PE <> ALDI_ID'
            WHEN COUNT(*) < 1
                THEN 'OK'
            ELSE NULL
        END AS description,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_24`
);

INSERT INTO dbp_etl_process.mat_test_detail
(
    SELECT
        24 AS test_id,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        mandant_id,
        'MATCHING_ID' AS key_name,
        matching_id AS key_value,
        'A391_DISC_PE',
        SUBSTR(CAST(a391_disc_pe AS STRING), 1, 300) AS a391_disc_pe,
        SUBSTR(CAST(aldi_id AS STRING), 1, 300) AS aldi_id,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_24`
);

/* ----------------------------------------------------------- */
CREATE OR REPLACE TEMPORARY TABLE _tupel_mat_test_25 AS
SELECT
    a.mandant_id,
    a.matching_id,
    a.art_id,
    a.a500_kjwo_update,
    a.a398_posten_food,
    b0.posten_kz_sap
FROM (
    SELECT
        a.mandant_id,
        a.matching_id,
        a.art_id,
        a.a500_kjwo_update,
        a.a398_posten_food
    FROM dbp_etl_process.tupel_mat_etl AS a
    INNER JOIN `_week` AS b
        ON a.mandant_id = b.mandant_id AND a.a500_kjwo_update = b.kjwo
) AS a
INNER JOIN dbp_data.art AS b0
    ON a.mandant_id = b0.mandant_id AND a.art_id = b0.art_id
WHERE
    a.a398_posten_food <> b0.posten_kz_sap
ORDER BY
    1 NULLS LAST;

INSERT INTO dbp_etl_process.mat_test
(
    SELECT
        25 AS test_id,
        'MASTER DATA' AS test_type,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        CASE WHEN COUNT(*) >= 1 THEN 'ERROR' WHEN COUNT(*) < 1 THEN 'OK' ELSE NULL END AS test_status,
        COUNT(*) AS error_count,
        STRING_AGG(
            DISTINCT CAST(mandant_id AS STRING), ','
            ORDER BY
                CAST(mandant_id AS STRING)
        ) AS error_mandant_id,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_25`
);

INSERT INTO dbp_etl_process.mat_test_desc
(
    SELECT
        25 AS test_id,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        'A398_POSTEN_FOOD',
        CASE
            WHEN COUNT(*) >= 1
                THEN 'A398_POSTEN_FOOD <> POSTEN_KZ_SAP'
            WHEN COUNT(*) < 1
                THEN 'OK'
            ELSE NULL
        END AS description,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_25`
);

INSERT INTO dbp_etl_process.mat_test_detail
(
    SELECT
        25 AS test_id,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        mandant_id,
        'MATCHING_ID' AS key_name,
        matching_id AS key_value,
        'A398_POSTEN_FOOD',
        a398_posten_food,
        posten_kz_sap,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_25`
);

/* ----------------------------------------------------------- */
CREATE OR REPLACE TEMPORARY TABLE _tupel_mat_test_26 AS
SELECT
    a.mandant_id,
    a.matching_id,
    a.art_id,
    a.a500_kjwo_update,
    a.a397_tierwohl,
    b0.tierwohl_kz
FROM (
    SELECT
        a.mandant_id,
        a.matching_id,
        a.art_id,
        a.a500_kjwo_update,
        a.a397_tierwohl
    FROM dbp_etl_process.tupel_mat_etl AS a
    INNER JOIN `_week` AS b
        ON a.mandant_id = b.mandant_id AND a.a500_kjwo_update = b.kjwo
) AS a
INNER JOIN dbp_data.art AS b0
    ON a.mandant_id = b0.mandant_id AND a.art_id = b0.art_id
WHERE
    a.a397_tierwohl <> b0.tierwohl_kz
ORDER BY
    1 NULLS LAST;

INSERT INTO dbp_etl_process.mat_test
(
    SELECT
        26 AS test_id,
        'MASTER DATA' AS test_type,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        CASE WHEN COUNT(*) >= 1 THEN 'ERROR' WHEN COUNT(*) < 1 THEN 'OK' ELSE NULL END AS test_status,
        COUNT(*) AS error_count,
        STRING_AGG(
            DISTINCT CAST(mandant_id AS STRING), ','
            ORDER BY
                CAST(mandant_id AS STRING)
        ) AS error_mandant_id,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_26`
);

INSERT INTO dbp_etl_process.mat_test_desc
(
    SELECT
        26 AS test_id,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        'A397_TIERWOHL',
        CASE
            WHEN COUNT(*) >= 1
                THEN 'A397_TIERWOHL <> TIERWOHL_KZ '
            WHEN COUNT(*) < 1
                THEN 'OK'
            ELSE NULL
        END AS description,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_26`
);

INSERT INTO dbp_etl_process.mat_test_detail
(
    SELECT
        26 AS test_id,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        mandant_id,
        'MATCHING_ID' AS key_name,
        matching_id AS key_value,
        'A397_TIERWOHL',
        a397_tierwohl,
        tierwohl_kz,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_26`
);

/* ----------------------------------------------------------- */
CREATE OR REPLACE TEMPORARY TABLE _tupel_mat_test_27 AS
SELECT
    a.mandant_id,
    a.matching_id,
    a.art_id,
    a.a500_kjwo_update,
    CASE WHEN a.a393_vegan = '' THEN 0 WHEN a.a393_vegan = 'X' THEN 1 ELSE NULL END AS q_vegan,
    b0.vegan_fg
FROM (
    SELECT
        a.mandant_id,
        a.matching_id,
        a.art_id,
        a.a500_kjwo_update,
        a.a393_vegan
    FROM dbp_etl_process.tupel_mat_etl AS a
    INNER JOIN `_week` AS b
        ON a.mandant_id = b.mandant_id AND a.a500_kjwo_update = b.kjwo
) AS a
INNER JOIN dbp_data.art AS b0
    ON a.mandant_id = b0.mandant_id AND a.art_id = b0.art_id
WHERE
    CASE WHEN a.a393_vegan = '' THEN 0 WHEN a.a393_vegan = 'X' THEN 1 ELSE NULL END <> b0.vegan_fg;

INSERT INTO dbp_etl_process.mat_test
(
    SELECT
        27 AS test_id,
        'MASTER DATA' AS test_type,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        CASE WHEN COUNT(*) >= 1 THEN 'ERROR' WHEN COUNT(*) < 1 THEN 'OK' ELSE NULL END AS test_status,
        COUNT(*) AS error_count,
        STRING_AGG(
            DISTINCT CAST(mandant_id AS STRING), ','
            ORDER BY
                CAST(mandant_id AS STRING)
        ) AS error_mandant_id,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_27`
);

INSERT INTO dbp_etl_process.mat_test_desc
(
    SELECT
        27 AS test_id,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        'A393_VEGAN',
        CASE
            WHEN COUNT(*) >= 1
                THEN 'A393_VEGAN <> VEGAN_FG '
            WHEN COUNT(*) < 1
                THEN 'OK'
            ELSE NULL
        END AS description,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_27`
);

INSERT INTO dbp_etl_process.mat_test_detail
(
    SELECT
        27 AS test_id,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        mandant_id,
        'MATCHING_ID' AS key_name,
        matching_id AS key_value,
        'A393_VEGAN',
        SUBSTR(CAST(q_vegan AS STRING), 1, 300) AS q_vegan,
        SUBSTR(CAST(vegan_fg AS STRING), 1, 300) AS vegan_fg,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_27`
);

/* ----------------------------------------------------------- */
CREATE OR REPLACE TEMPORARY TABLE _tupel_mat_test_28 AS
SELECT
    a.mandant_id,
    a.matching_id,
    a.art_id,
    a.a500_kjwo_update,
    CASE WHEN a.a394_gluten = '' THEN 0 WHEN a.a394_gluten = 'X' THEN 1 ELSE NULL END AS q_gluten,
    b0.gluten_fg
FROM (
    SELECT
        a.mandant_id,
        a.matching_id,
        a.art_id,
        a.a500_kjwo_update,
        a.a394_gluten
    FROM dbp_etl_process.tupel_mat_etl AS a
    INNER JOIN `_week` AS b
        ON a.mandant_id = b.mandant_id AND a.a500_kjwo_update = b.kjwo
    UNION DISTINCT
    SELECT
        a.mandant_id,
        a.matching_id,
        a.art_id,
        a.a500_kjwo_update,
        a.a394_gluten
    FROM dbp_etl_process.tupel_mat_etl AS a
    INNER JOIN `_week` AS b
        ON a.mandant_id = b.mandant_id AND a.a500_kjwo_update = b.kjwo
) AS a
INNER JOIN dbp_data.art AS b0
    ON a.mandant_id = b0.mandant_id AND a.art_id = b0.art_id
WHERE
    CASE WHEN a.a394_gluten = '' THEN 0 WHEN a.a394_gluten = 'X' THEN 1 ELSE NULL END <> b0.gluten_fg;

INSERT INTO dbp_etl_process.mat_test
(
    SELECT
        28 AS test_id,
        'MASTER DATA' AS test_type,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        CASE WHEN COUNT(*) >= 1 THEN 'ERROR' WHEN COUNT(*) < 1 THEN 'OK' ELSE NULL END AS test_status,
        COUNT(*) AS error_count,
        STRING_AGG(
            DISTINCT CAST(mandant_id AS STRING), ','
            ORDER BY
                CAST(mandant_id AS STRING)
        ) AS error_mandant_id,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_28`
);

INSERT INTO dbp_etl_process.mat_test_desc
(
    SELECT
        28 AS test_id,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        'A394_GLUTEN',
        CASE
            WHEN COUNT(*) >= 1
                THEN 'A394_GLUTEN <> GLUTEN_FG '
            WHEN COUNT(*) < 1
                THEN 'OK'
            ELSE NULL
        END AS description,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_28`
);

INSERT INTO dbp_etl_process.mat_test_detail
(
    SELECT
        28 AS test_id,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        mandant_id,
        'MATCHING_ID' AS key_name,
        matching_id AS key_value,
        'A394_GLUTEN',
        SUBSTR(CAST(q_gluten AS STRING), 1, 300) AS q_gluten,
        SUBSTR(CAST(gluten_fg AS STRING), 1, 300) AS gluten_fg,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_28`
);

/* ----------------------------------------------------------- */
CREATE OR REPLACE TEMPORARY TABLE _tupel_mat_test_29 AS
SELECT
    a.mandant_id,
    a.matching_id,
    a.art_id,
    a.a500_kjwo_update,
    CASE WHEN a.a395_bio = '' THEN 0 WHEN a.a395_bio = 'X' THEN 1 ELSE NULL END AS q_bio,
    b0.bio_fg
FROM (
    SELECT
        a.mandant_id,
        a.matching_id,
        a.art_id,
        a.a500_kjwo_update,
        a.a395_bio
    FROM dbp_etl_process.tupel_mat_etl AS a
    INNER JOIN `_week` AS b
        ON a.mandant_id = b.mandant_id AND a.a500_kjwo_update = b.kjwo
) AS a
INNER JOIN dbp_data.art AS b0
    ON a.mandant_id = b0.mandant_id AND a.art_id = b0.art_id
WHERE
    CASE WHEN a.a395_bio = '' THEN 0 WHEN a.a395_bio = 'X' THEN 1 ELSE NULL END <> b0.bio_fg;

INSERT INTO dbp_etl_process.mat_test
(
    SELECT
        29 AS test_id,
        'MASTER DATA' AS test_type,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        CASE WHEN COUNT(*) >= 1 THEN 'ERROR' WHEN COUNT(*) < 1 THEN 'OK' ELSE NULL END AS test_status,
        COUNT(*) AS error_count,
        STRING_AGG(
            DISTINCT CAST(mandant_id AS STRING), ','
            ORDER BY
                CAST(mandant_id AS STRING)
        ) AS error_mandant_id,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_29`
);

INSERT INTO dbp_etl_process.mat_test_desc
(
    SELECT
        29 AS test_id,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        'A395_BIO',
        CASE
            WHEN COUNT(*) >= 1
                THEN 'A395_BIO <> BIO_FG '
            WHEN COUNT(*) < 1
                THEN 'OK'
            ELSE NULL
        END AS description,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_29`
);

INSERT INTO dbp_etl_process.mat_test_detail
(
    SELECT
        29 AS test_id,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        mandant_id,
        'MATCHING_ID' AS key_name,
        matching_id AS key_value,
        'A395_BIO',
        SUBSTR(CAST(q_bio AS STRING), 1, 300) AS q_bio,
        SUBSTR(CAST(bio_fg AS STRING), 1, 300) AS bio_fg,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_29`
);

/* ----------------------------------------------------------- */
CREATE OR REPLACE TEMPORARY TABLE _tupel_mat_test_30 AS
SELECT
    tm.mandant_id,
    tm.art_id,
    tm.a16_akt_lieferant_id,
    gp.akt_gp_id
FROM (
    SELECT
        a.mandant_id,
        a.art_id,
        a.a16_akt_lieferant_id
    FROM dbp_etl_process.tupel_mat_etl AS a
    INNER JOIN `_week` AS b
        ON a.mandant_id = b.mandant_id AND a.a500_kjwo_update = b.kjwo
) AS tm
INNER JOIN dbp_msi_view2.mv_art_gp_nm_zu_aktuell AS gp
    ON tm.mandant_id = gp.mandant_id AND tm.art_id = gp.art_id
WHERE
    CAST(tm.a16_akt_lieferant_id AS FLOAT64) <> gp.akt_gp_id;

INSERT INTO dbp_etl_process.mat_test
(
    SELECT
        30 AS test_id,
        'MASTER DATA' AS test_type,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        CASE WHEN COUNT(*) >= 1 THEN 'ERROR' WHEN COUNT(*) < 1 THEN 'OK' ELSE NULL END AS test_status,
        COUNT(*) AS error_count,
        STRING_AGG(
            DISTINCT CAST(mandant_id AS STRING), ','
            ORDER BY
                CAST(mandant_id AS STRING)
        ) AS error_mandant_id,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_30`
);

INSERT INTO dbp_etl_process.mat_test_desc
(
    SELECT
        30 AS test_id,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        'A16_AKT_LIEFERANT_ID',
        CASE
            WHEN COUNT(*) >= 1
                THEN 'A16_AKT_LIEFERANT_ID <> AKT_GP_ID '
            WHEN COUNT(*) < 1
                THEN 'OK'
            ELSE NULL
        END AS description,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_30`
);

INSERT INTO dbp_etl_process.mat_test_detail
(
    SELECT
        30 AS test_id,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        mandant_id,
        'ART_ID' AS key_name,
        art_id AS key_value,
        'A16_AKT_LIEFERANT_ID',
        a16_akt_lieferant_id,
        SUBSTR(CAST(akt_gp_id AS STRING), 1, 300) AS akt_gp_id,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_30`
);

/* ----------------------------------------------------------- */
CREATE OR REPLACE TEMPORARY TABLE _art_nielsen_mgtin AS
SELECT DISTINCT
    mandant_id,
    art_nielsen_id,
    gtin_id
FROM dbp_data.art_nielsen
WHERE
    dat_bis = CAST('9999-12-31' AS DATE)
UNION DISTINCT
SELECT DISTINCT
    mandant_id,
    art_nielsen_id,
    gtin_ref_id AS gtin_id
FROM dbp_etl_process.art_nielsen_gtin_zu;

/* ERSTELLUNG TABELLE RELEVANTE NIELSEN-ARTIKEL */
CREATE OR REPLACE TEMPORARY TABLE _menge_nielsen_artikel_fakten AS
SELECT
    nf.mandant_id,
    nf.art_nielsen_id,
    SUM(nf.umsatz_brutto) AS umsatz_brutto
FROM dbp_data.art_nielsen_fakten_kjmo AS nf
INNER JOIN dbp_data.nielsen_market AS nm
    ON nf.mandant_id = nm.mandant_id AND nf.nielsen_market_id = nm.nielsen_market_id
WHERE
    (nf.mandant_id, nf.kjmo) IN (
        SELECT (mandant_id, kjmo)
        FROM `_monat`
    )
    AND nm.nielsen_market_cluster_id = 1
    AND nf.umsatz_brutto > 0
GROUP BY
    nf.mandant_id,
    nf.art_nielsen_id;

/* ABFRAGE FEHLENDER NIELSEN-ARTIKEL IN MATCHING-TABELLE */
CREATE OR REPLACE TEMPORARY TABLE _tupel_mat_test_31 AS
SELECT
    a.mandant_id,
    a.art_nielsen_id,
    b.art_matching_id
FROM `_menge_nielsen_artikel_fakten` AS a
LEFT JOIN `_art_matching_nielsen_per_kmo` AS b
    ON a.mandant_id = b.mandant_id AND a.art_nielsen_id = b.art_nielsen_id
INNER JOIN `_art_nielsen_mgtin` AS c
    ON a.mandant_id = c.mandant_id AND a.art_nielsen_id = c.art_nielsen_id
INNER JOIN dbp_etl_process.art_gtin AS d
    ON c.gtin_id = d.gtin_id AND a.mandant_id = d.mandant_id
INNER JOIN dbp_data.art_wg_zu_per AS e
    ON
        a.mandant_id = e.mandant_id
        AND d.art_id = e.art_id
        AND e.arthiertyp_id = 2
        AND e.dat_bis = PARSE_DATE('%F', '9999-12-31')
INNER JOIN dbp_data.wg_filter_zu AS wfz
    ON
        e.wg_id = wfz.wg_id
        AND a.mandant_id = wfz.mandant_id
        AND wfz.wg_filter_id = 47
        AND wfz.arthiertyp_id = 2
WHERE
    b.art_matching_id IS NULL
GROUP BY
    a.mandant_id,
    a.art_nielsen_id,
    b.art_matching_id
ORDER BY
    a.mandant_id NULLS LAST;

INSERT INTO dbp_etl_process.mat_test
(
    SELECT
        31 AS test_id,
        'TUPEL' AS test_type,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        CASE WHEN COUNT(*) >= 1 THEN 'ERROR' WHEN COUNT(*) < 1 THEN 'OK' ELSE NULL END AS test_status,
        COUNT(*) AS error_count,
        STRING_AGG(
            DISTINCT CAST(mandant_id AS STRING), ','
            ORDER BY
                CAST(mandant_id AS STRING)
        ) AS error_mandant_id,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_31`
);

INSERT INTO dbp_etl_process.mat_test_desc
(
    SELECT
        31 AS test_id,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        'ART_MATCHING_ID',
        CASE
            WHEN COUNT(*) >= 1
                THEN 'MISSING ARTIKEL FROM ART_NIELSEN_FAKTEN_KJMO IN ART_MATCHING_NIELSEN_PER_KMO'
            WHEN COUNT(*) < 1
                THEN 'OK'
            ELSE NULL
        END AS description,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_31`
);

INSERT INTO dbp_etl_process.mat_test_detail
(
    SELECT
        31 AS test_id,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        mandant_id,
        'ART_NIELSEN_ID' AS key_name,
        art_nielsen_id AS key_value,
        'ART_MATCHING_ID',
        SUBSTR(CAST(art_matching_id AS STRING), 1, 300) AS art_matching_id,
        'FIELD CANNOT BE NULL ',
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_31`
);

/* ERSTELLUNG TABELLE RELEVANTE MATCHINGS */
CREATE OR REPLACE TEMPORARY TABLE _menge_nielsen_artikel_matching AS
SELECT
    a.mandant_id,
    a.art_nielsen_id,
    b.art_matching_id
FROM `_menge_nielsen_artikel_fakten` AS a
LEFT JOIN `_art_matching_nielsen_per_kmo` AS b
    ON a.mandant_id = b.mandant_id AND a.art_nielsen_id = b.art_nielsen_id
GROUP BY
    a.mandant_id,
    a.art_nielsen_id,
    b.art_matching_id;

/* ABFRAGE FEHLENDER MATCHINGS IN TUPEL_MAT */
CREATE OR REPLACE TEMPORARY TABLE _tupel_mat_test_32 AS
SELECT DISTINCT
    a.mandant_id,
    a.art_matching_id,
    b.matching_id,
    c.art_id,
    wfz.wg_filter_id,
    wfz.arthiertyp_id
FROM `_menge_nielsen_artikel_matching` AS a
LEFT JOIN (
    SELECT
        a0.mandant_id,
        a0.matching_id
    FROM dbp_etl_process.tupel_mat_etl AS a0
    INNER JOIN `_week` AS b
        ON a0.mandant_id = b.mandant_id AND a0.a500_kjwo_update = b.kjwo
) AS b
    ON a.mandant_id = b.mandant_id AND a.art_matching_id = b.matching_id
INNER JOIN `_art_matching_nielsen_per_kmo` AS c
    ON a.mandant_id = c.mandant_id AND a.art_matching_id = c.art_matching_id
INNER JOIN dbp_data.art_wg_zu_per AS d
    ON
        a.mandant_id = d.mandant_id
        AND c.art_id = d.art_id
        AND d.arthiertyp_id = 2
        AND d.dat_bis = PARSE_DATE('%F', '9999-12-31')
INNER JOIN dbp_data.wg_filter_zu AS wfz
    ON
        d.wg_id = wfz.wg_id
        AND a.mandant_id = wfz.mandant_id
        AND wfz.wg_filter_id = 47
        AND wfz.arthiertyp_id = 2
WHERE
    b.matching_id IS NULL
ORDER BY
    a.mandant_id NULLS LAST;

INSERT INTO dbp_etl_process.mat_test
(
    SELECT
        32 AS test_id,
        'TUPEL' AS test_type,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        CASE WHEN COUNT(*) >= 1 THEN 'ERROR' WHEN COUNT(*) < 1 THEN 'OK' ELSE NULL END AS test_status,
        COUNT(*) AS error_count,
        STRING_AGG(
            DISTINCT CAST(mandant_id AS STRING), ','
            ORDER BY
                CAST(mandant_id AS STRING)
        ) AS error_mandant_id,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_32`
);

INSERT INTO dbp_etl_process.mat_test_desc
(
    SELECT
        32 AS test_id,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        'MATCHING_ID',
        CASE
            WHEN COUNT(*) >= 1
                THEN 'MISSING ARTIKEL FROM ART_NIELSEN_FAKTEN_KJMO IN TUPEL_MAT'
            WHEN COUNT(*) < 1
                THEN 'OK'
            ELSE NULL
        END AS description,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_32`
);

INSERT INTO dbp_etl_process.mat_test_detail
(
    SELECT
        32 AS test_id,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        mandant_id,
        'ART_MATCHING_ID' AS key_name,
        art_matching_id AS key_value,
        'MATCHING_ID',
        SUBSTR(CAST(matching_id AS STRING), 1, 300) AS matching_id,
        'FIELD CANNOT BE NULL ',
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_32`
);

CREATE OR REPLACE TEMPORARY TABLE _tupel_mat_test_33 AS
SELECT
    a.mandant_id,
    b.art_gruppe_id,
    COUNT(DISTINCT a.art_matching_id) AS anz
FROM `_art_matching_nielsen_per` AS a
INNER JOIN dbp_data.art_gruppe_art_zu AS b
    ON a.mandant_id = b.mandant_id AND a.art_id = b.art_id
INNER JOIN dbp_data.art_gruppe AS c
    ON b.art_gruppe_id = c.art_gruppe_id
WHERE
    UPPER(c.art_gruppe_kategorie) = 'SORTIMENTSTOOL' AND a.mandant_id = 1
GROUP BY
    a.mandant_id,
    b.art_gruppe_id
HAVING
    anz > 1;

INSERT INTO dbp_etl_process.mat_test
(
    SELECT
        33 AS test_id,
        'TUPEL' AS test_type,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        CASE WHEN COUNT(*) >= 1 THEN 'ERROR' WHEN COUNT(*) < 1 THEN 'OK' ELSE NULL END AS test_status,
        COUNT(*) AS error_count,
        STRING_AGG(
            DISTINCT CAST(mandant_id AS STRING), ','
            ORDER BY
                CAST(mandant_id AS STRING)
        ) AS error_mandant_id,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_33`
);

INSERT INTO dbp_etl_process.mat_test_desc
(
    SELECT
        33 AS test_id,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        'ART_GRUPPE_ID',
        CASE
            WHEN COUNT(*) >= 1
                THEN 'MORE THEN 1 ART_MATCHING_ID IN 1 ART_GRUPPE_ID'
            WHEN COUNT(*) < 1
                THEN 'OK'
            ELSE NULL
        END AS description,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_33`
);

INSERT INTO dbp_etl_process.mat_test_detail
(
    SELECT
        33 AS test_id,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        mandant_id,
        'MANDANT_ID' AS key_name,
        mandant_id AS key_value,
        'ART_GRUPPE_ID',
        SUBSTR(CAST(art_gruppe_id AS STRING), 1, 300) AS art_gruppe_id,
        '1 ART_MATCHING_ID IN 1 ART_GRUPPE_ID',
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_33`
);

/*
 * Due to a change in the grouping logic, the test 34 is disabled.
 *
CREATE OR REPLACE TEMPORARY TABLE dbp_data._TUPEL_MAT_TEST_34 AS
(
SELECT
A.MANDANT_ID,
A.ART_MATCHING_ID
,COUNT(DISTINCT B.ART_GRUPPE_ID) AS ANZ
FROM dbp_data._ART_MATCHING_NIELSEN_PER A
JOIN dbp_data.ART_GRUPPE_ART_ZU B
ON A.MANDANT_ID=B.MANDANT_ID
AND A.ART_ID=B.ART_ID
JOIN dbp_data.ART_GRUPPE C
ON B.ART_GRUPPE_ID=C.ART_GRUPPE_ID
WHERE UPPER(C.ART_GRUPPE_KATEGORIE) = 'SORTIMENTSTOOL' AND A.MANDANT_ID = 1
GROUP BY 1,2
HAVING ANZ > 1
);
*/
CREATE OR REPLACE TEMPORARY TABLE _tupel_mat_test_34 AS
(
    SELECT *
    FROM `_art_matching_nielsen_per`
    LIMIT 0
);

INSERT INTO dbp_etl_process.mat_test
(
    SELECT
        34 AS test_id,
        'TUPEL' AS test_type,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        CASE WHEN COUNT(*) >= 1 THEN 'ERROR' WHEN COUNT(*) < 1 THEN 'OK' ELSE NULL END AS test_status,
        COUNT(*) AS error_count,
        STRING_AGG(
            DISTINCT CAST(mandant_id AS STRING), ','
            ORDER BY
                CAST(mandant_id AS STRING)
        ) AS error_mandant_id,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_34`
);

INSERT INTO dbp_etl_process.mat_test_desc
(
    SELECT
        34 AS test_id,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        'ART_MATCHING_ID',
        CASE
            WHEN COUNT(*) >= 1
                THEN 'MORE THEN 1 ART_GRUPPE_ID PER 1 ART_MATCHING_ID'
            WHEN COUNT(*) < 1
                THEN 'OK'
            ELSE NULL
        END AS description,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_34`
);

INSERT INTO dbp_etl_process.mat_test_detail
(
    SELECT
        34 AS test_id,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        mandant_id,
        'MANDANT_ID' AS key_name,
        mandant_id AS key_value,
        'ART_MATCHING_ID',
        SUBSTR(CAST(art_matching_id AS STRING), 1, 300) AS art_matching_id,
        '1 ART_GRUPPE_ID PER 1 ART_MATCHING_ID',
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_34`
);

CREATE OR REPLACE TEMPORARY TABLE _tupel_mat_test_35 AS
SELECT
    a.mandant_id,
    a.matching_id,
    a.art_bez_deutsch,
    b0.tupel_bez
FROM (
    SELECT
        a.mandant_id,
        a.matching_id,
        a.a500_kjwo_update,
        a.art_id,
        a.art_bez_deutsch
    FROM dbp_etl_process.tupel_mat_etl AS a
    INNER JOIN `_week` AS b
        ON a.mandant_id = b.mandant_id AND a.a500_kjwo_update = b.kjwo
) AS a
INNER JOIN dbp_data.tupel_spr_zu AS b0
    ON
        a.mandant_id = b0.mandant_id
        AND a.matching_id = b0.matching_id
        AND a.a500_kjwo_update = b0.kjwo_update
WHERE
    a.art_bez_deutsch <> b0.tupel_bez AND a.mandant_id = 1;

INSERT INTO dbp_etl_process.mat_test
(
    SELECT
        35 AS test_id,
        'TUPEL' AS test_type,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        CASE WHEN COUNT(*) >= 1 THEN 'ERROR' WHEN COUNT(*) < 1 THEN 'OK' ELSE NULL END AS test_status,
        COUNT(*) AS error_count,
        STRING_AGG(
            DISTINCT CAST(mandant_id AS STRING), ','
            ORDER BY
                CAST(mandant_id AS STRING)
        ) AS error_mandant_id,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_35`
);

INSERT INTO dbp_etl_process.mat_test_desc
(
    SELECT
        35 AS test_id,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        'ART_BEZ_DEUTSCH',
        CASE
            WHEN COUNT(*) >= 1
                THEN 'ART_BEZ_DEUTSCH <> TUPEL_BEZ'
            WHEN COUNT(*) < 1
                THEN 'OK'
            ELSE NULL
        END AS description,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_35`
);

INSERT INTO dbp_etl_process.mat_test_detail
(
    SELECT
        35 AS test_id,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        mandant_id,
        'MATCHING_ID' AS key_name,
        matching_id AS key_value,
        'ART_BEZ_DEUTSCH',
        art_bez_deutsch,
        tupel_bez,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_35`
);

CREATE OR REPLACE TEMPORARY TABLE _tupel_mat_test_36 AS
SELECT
    a.mandant_id,
    a.matching_id,
    a.art_bez_deutsch,
    d.art_gruppe_bez
FROM (
    SELECT
        a.mandant_id,
        a.matching_id,
        a.a500_kjwo_update,
        a.art_id,
        a.art_bez_deutsch
    FROM dbp_etl_process.tupel_mat_etl AS a
    INNER JOIN `_week` AS b
        ON a.mandant_id = b.mandant_id AND a.a500_kjwo_update = b.kjwo
) AS a
INNER JOIN dbp_data.tupel_spr_zu AS b0
    ON
        a.mandant_id = b0.mandant_id
        AND a.matching_id = b0.matching_id
        AND a.a500_kjwo_update = b0.kjwo_update
INNER JOIN dbp_data.art_gruppe_art_zu AS c
    ON a.mandant_id = c.mandant_id AND a.art_id = c.art_id
INNER JOIN dbp_data.art_gruppe AS d
    ON
        c.art_gruppe_id = d.art_gruppe_id
        AND UPPER(d.art_gruppe_kategorie) = 'SORTIMENTSTOOL'
WHERE
    a.art_bez_deutsch <> d.art_gruppe_bez AND a.mandant_id = 1;

INSERT INTO dbp_etl_process.mat_test
(
    SELECT
        36 AS test_id,
        'TUPEL' AS test_type,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        CASE WHEN COUNT(*) >= 1 THEN 'ERROR' WHEN COUNT(*) < 1 THEN 'OK' ELSE NULL END AS test_status,
        COUNT(*) AS error_count,
        STRING_AGG(
            DISTINCT CAST(mandant_id AS STRING), ','
            ORDER BY
                CAST(mandant_id AS STRING)
        ) AS error_mandant_id,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_36`
);

INSERT INTO dbp_etl_process.mat_test_desc
(
    SELECT
        36 AS test_id,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        'ART_BEZ_DEUTSCH',
        CASE
            WHEN COUNT(*) >= 1
                THEN 'ART_BEZ_DEUTSCH <> ART_GRUPPE_BEZ'
            WHEN COUNT(*) < 1
                THEN 'OK'
            ELSE NULL
        END AS description,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_36`
);

INSERT INTO dbp_etl_process.mat_test_detail
(
    SELECT
        36 AS test_id,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        mandant_id,
        'MATCHING_ID' AS key_name,
        matching_id AS key_value,
        'ART_BEZ_DEUTSCH',
        art_bez_deutsch,
        art_gruppe_bez,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_36`
);

CREATE OR REPLACE TEMPORARY TABLE _tupel_mat_test_37 AS
SELECT DISTINCT
    nf.mandant_id,
    nf.art_nielsen_id,
    an.gtin_id,
    b.art_matching_id
FROM dbp_data.art_nielsen_fakten_kjwo AS nf
INNER JOIN dbp_data.nielsen_market AS nm
    ON nf.mandant_id = nm.mandant_id AND nf.nielsen_market_id = nm.nielsen_market_id
INNER JOIN `_art_nielsen` AS an
    ON nf.mandant_id = an.mandant_id AND nf.art_nielsen_id = an.art_nielsen_id
LEFT JOIN `_art_matching_nielsen_per` AS b
    ON nf.mandant_id = b.mandant_id AND nf.art_nielsen_id = b.art_nielsen_id
WHERE
    nf.mandant_id = 1
    AND nf.kjwo IN (
        SELECT kjwo
        FROM dbp_data.art_nielsen_fakten_kjwo
        WHERE
            mandant_id = 1
        GROUP BY
            kjwo
        QUALIFY
            (
                (
                    RANK() OVER (ORDER BY kjwo IS NULL DESC, kjwo DESC)
                ) * -1
            ) BETWEEN -52 AND (
                -1
            )
    )
    AND nm.nielsen_market_cluster_id = 2
    AND b.art_matching_id IS NULL;

INSERT INTO dbp_etl_process.mat_test
(
    SELECT
        37 AS test_id,
        'TUPEL' AS test_type,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        CASE WHEN COUNT(*) >= 1 THEN 'ERROR' WHEN COUNT(*) < 1 THEN 'OK' ELSE NULL END AS test_status,
        COUNT(*) AS error_count,
        STRING_AGG(
            DISTINCT CAST(mandant_id AS STRING), ','
            ORDER BY
                CAST(mandant_id AS STRING)
        ) AS error_mandant_id,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_37`
);

INSERT INTO dbp_etl_process.mat_test_desc
(
    SELECT
        37 AS test_id,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        'ART_MATCHING_ID',
        CASE
            WHEN COUNT(*) >= 1
                THEN 'MISSING ARTIKEL FROM ART_NIELSEN_FAKTEN_KJWO IN ART_MATCHING_NIELSEN_PER'
            WHEN COUNT(*) < 1
                THEN 'OK'
            ELSE NULL
        END AS description,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_37`
);

INSERT INTO dbp_etl_process.mat_test_detail
(
    SELECT
        37 AS test_id,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        mandant_id,
        'ART_NIELSEN_ID' AS key_name,
        art_nielsen_id AS key_value,
        'GTIN_ID',
        SUBSTR(CAST(gtin_id AS STRING), 1, 300) AS gtin_id,
        'FIELD CANNOT BE NULL ',
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_37`
);

CREATE OR REPLACE TEMPORARY TABLE _tupel_mat_test_38 AS
SELECT DISTINCT
    mandant_id,
    a500_kjwo_update
FROM dbp_msi_data.tupel_mat
WHERE
    NOT (mandant_id, a500_kjwo_update) IN (
        SELECT (mandant_id, kjwo_update)
        FROM dbp_data.l_kjmo_sort
        GROUP BY
            mandant_id,
        kjwo_update
    )
UNION DISTINCT
SELECT DISTINCT
    mandant_id,
    a500_kjwo_update
FROM dbp_msi_data.tupel_mat
WHERE
    (mandant_id, a500_kjwo_update) IN (
        SELECT (mandant_id, a500_kjwo_update)
        FROM dbp_msi_data.tupel_mat_quarantaene
        GROUP BY
            mandant_id,
        a500_kjwo_update
    );

INSERT INTO dbp_etl_process.mat_test
(
    SELECT
        38 AS test_id,
        'TUPEL' AS test_type,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        CASE WHEN COUNT(*) >= 1 THEN 'ERROR' WHEN COUNT(*) < 1 THEN 'OK' ELSE NULL END AS test_status,
        COUNT(*) AS error_count,
        STRING_AGG(
            DISTINCT CAST(mandant_id AS STRING), ','
            ORDER BY
                CAST(mandant_id AS STRING)
        ) AS error_mandant_id,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_38`
);

INSERT INTO dbp_etl_process.mat_test_desc
(
    SELECT
        38 AS test_id,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        'A500_KJWO_UPDATE',
        CASE
            WHEN COUNT(*) >= 1
                THEN 'A500_KJWO_UPDATE FROM TUPEL_MAT MISSING IN L_KJMO_SORT OR EXIST IN TUPEL_MAT_QUARANTAENE'
            WHEN COUNT(*) < 1
                THEN 'OK'
            ELSE NULL
        END AS description,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_38`
);

INSERT INTO dbp_etl_process.mat_test_detail
(
    SELECT
        38 AS test_id,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        mandant_id,
        'MANDANT_ID' AS key_name,
        mandant_id AS key_value,
        'A500_KJWO_UPDATE',
        '',
        SUBSTR(CAST(a500_kjwo_update AS STRING), 1, 300) AS a500_kjwo_update,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_38`
);

CREATE OR REPLACE TEMPORARY TABLE _prepare AS
SELECT
    t6.mandant_id,
    t6.art_matching_id,
    t6.art_nielsen_id,
    t6.kjmo,
    t6.umsatz_brutto AS nf_umsatz_brutto
FROM (
    SELECT
        m.mandant_id,
        m.art_matching_id,
        m.art_nielsen_id,
        nf.mandant_id AS mandant_id0,
        nf.art_nielsen_id AS art_nielsen_id0,
        nf.nielsen_market_id,
        nf.kjmo,
        nf.umsatz_brutto,
        tm.mandant_id AS mandant_id1,
        tm.a500_kjwo_update,
        tm.matching_id,
        tm.a425_kjmo,
        tm.wrg_id,
        tm.a5_owg_id,
        tm.a7_wg_id,
        tm.wug_id,
        tm.art_id,
        tm.kl_art_id,
        tm.a450_art_nielsen_nr,
        tm.art_bez_deutsch,
        tm.a14_art_status_de,
        tm.nielsen_art_bez,
        tm.nielsen_gtin,
        tm.a58_rang_umsatz_owg,
        tm.a2_rang_umsatz_wg,
        tm.a59_rang_absatz_wg,
        tm.a16_akt_lieferant_id,
        tm.a419_hersteller_id,
        tm.a446_lieferant_bez_latein,
        tm.a447_hersteller_bez_latein,
        tm.lieferant_nielsen,
        tm.a389_zek_id,
        tm.a391_disc_pe,
        tm.a392_disc_ohne_etikett,
        tm.a400_lcf,
        tm.a393_vegan,
        tm.a394_gluten,
        tm.a395_bio,
        tm.a396_eigenmarke,
        tm.a397_tierwohl,
        tm.a398_posten_food,
        tm.a399_posten_nonfood,
        tm.a339_umsatzsteuer,
        tm.a36_gewichtete_distribution,
        tm.a60_muki_vk_kz,
        tm.a61_muki_vk_kl_art_id_verkettung,
        tm.anzahl_markt_wochen_kombis_abverkauf_af,
        tm.anzahl_markt_wochen_kombis_abverkauf_sa,
        tm.anzahl_markt_wochen_kombis_abverkauf_af_vj,
        tm.anzahl_markt_wochen_kombis_abverkauf_sa_vj,
        tm.a273_kassenumsatz_kl_absolut_brutto,
        tm.kassenumsatz_af_kl_absolut_brutto,
        tm.kassenumsatz_sa_kl_absolut_brutto,
        tm.kassenumsatz_kl_absolut_brutto_vj,
        tm.kassenumsatz_af_kl_absolut_brutto_vj,
        tm.kassenumsatz_sa_kl_absolut_brutto_vj,
        tm.a21_kassenumsatz_kl_absolut_netto,
        tm.kassenumsatz_af_kl_absolut_netto,
        tm.kassenumsatz_sa_kl_absolut_netto,
        tm.kassenumsatz_kl_absolut_netto_vj,
        tm.kassenumsatz_af_kl_absolut_netto_vj,
        tm.kassenumsatz_sa_kl_absolut_netto_vj,
        tm.a17_absatz_kl,
        tm.absatz_af_kl,
        tm.absatz_sa_kl,
        tm.absatz_kl_vj,
        tm.absatz_af_kl_vj,
        tm.absatz_sa_kl_vj,
        tm.a76_absatz_sst1,
        tm.a78_absatz_sst2,
        tm.a80_absatz_sst3,
        tm.a82_absatz_sst4,
        tm.a84_absatz_sst5,
        tm.a86_absatz_sst6,
        tm.a88_absatz_sst7,
        tm.a62_absatz_ksst1,
        tm.a64_absatz_ksst2,
        tm.a66_absatz_ksst3,
        tm.a68_absatz_ksst4,
        tm.a70_absatz_ksst5,
        tm.a72_absatz_ksst6,
        tm.a74_absatz_ksst7,
        tm.a90_absatz_ost_basis,
        tm.a92_absatz_ost_gross,
        tm.a94_absatz_sued_ost,
        tm.a96_absatz_sued_west,
        tm.a98_absatz_west,
        tm.a100_absatz_nord,
        tm.markt_wochen_sst1,
        tm.markt_wochen_sst2,
        tm.markt_wochen_sst3,
        tm.markt_wochen_sst4,
        tm.markt_wochen_sst5,
        tm.markt_wochen_sst6,
        tm.markt_wochen_sst7,
        tm.markt_wochen_ksst1,
        tm.markt_wochen_ksst2,
        tm.markt_wochen_ksst3,
        tm.markt_wochen_ksst4,
        tm.markt_wochen_ksst5,
        tm.markt_wochen_ksst6,
        tm.markt_wochen_ksst7,
        tm.markt_wochen_ost_basis,
        tm.markt_wochen_ost_gross,
        tm.markt_wochen_sued_ost,
        tm.markt_wochen_sued_west,
        tm.markt_wochen_west,
        tm.markt_wochen_nord,
        tm.anzahl_markt_wochen_kombis_abverkauf_mit_listung,
        tm.anzahl_markt_wochen_kombis_listung,
        tm.a31_vk_brutto_kl_pk_1,
        tm.a333_vk_brutto_kl_pk_2,
        tm.a54_vk_brutto_kl_pk_3,
        tm.a334_vk_brutto_kl_pk_4,
        tm.a432_vk_brutto_kl_pk_5,
        tm.a433_vk_brutto_kl_pk_6,
        tm.a434_vk_brutto_kl_pk_7,
        tm.a435_vk_brutto_kl_pk_8,
        tm.a436_vk_brutto_kl_pk_9,
        tm.a437_vk_brutto_kl_pk_10,
        tm.a30_kb_olk_ek4ndz_stamm,
        tm.a23_rohertrag_ekmep_olk_4n,
        tm.a51_listung_sst_pflege,
        tm.a52_listung_k_sst_pflege,
        tm.a426_ost_basis_pflege,
        tm.a427_ost_gross_pflege,
        tm.a428_sued_ost_pflege,
        tm.a429_sued_west_pflege,
        tm.a430_west_pflege,
        tm.a431_nord_pflege,
        tm.a50_listungsaktion,
        tm.a411_stk_rohertrag_pflege,
        tm.a415_kannibalisierungsfaktor,
        tm.a412_umsatz_brutto_hochrechnung,
        tm.a413_absatz_hochrechnung,
        tm.a414_rohertrag_hochrechnung,
        tm.a36_gewichtete_distribution_nielsen,
        tm.a32_umsatz_anteil_wgi_nielsen,
        tm.a33_umsatz_anteil_wgi_kumuliert_nielsen,
        tm.a34_vk_brutto_durchschnitt_nielsen,
        tm.a35_umsatz_nielsen,
        tm.anz_wochen_de_anz_monate_kmo_nielsen,
        tm.absatz_nielsen,
        tm.a376_kl_marktanteil_wg_nielsen,
        tm.a380_marktanteilbewertung_nielsen,
        tm.a377_durchschnitt_anz_maerkte_nielsen,
        tm.a382_sales_units_absatz_verkaufsartikel_in_1000_nielsen,
        tm.a383_sales_units_verkaufseinheiten_gl_in_1000_normiert_nielsen,
        tm.a384_durchschn_preis_einheit_gl_normiert_nielsen,
        tm.a385_numerische_distribution_nielsen,
        tm.a386_inhaltsmengen_nielsen,
        tm.a387_duft_geschmack_nielsen,
        tm.a388_einheit_nielsen,
        tm.eigenmarke_fg_nielsen,
        tm.a39_listung_sst_mvke,
        tm.a38_listung_k_sst_mvke,
        tm.a40_ost_basis,
        tm.a41_ost_gross,
        tm.a42_sued_ost,
        tm.a43_sued_west,
        tm.a44_west,
        tm.a45_nord,
        tm.a37_listung_erster_markt,
        tm.a59_anz_maerkte_sst,
        tm.a449_anz_maerkte_k_sst,
        tm.a46_max_anz_maerkte_sst,
        tm.a47_max_anz_maerkte_k_sst,
        tm.a53_anz_maerkte_listung_gesamt,
        tm.a57_anz_maerkte_listung_einzel,
        tm.anz_maerkte_baustein_sonstige,
        tm.anz_bons_af,
        tm.anz_bons_sa,
        tm.anz_bons_gesamt,
        tm.rohertrag_ekmep_olk_4n_vj,
        tm.rohertrag_ekmep_olk_4n_af,
        tm.rohertrag_ekmep_olk_4n_sa,
        tm.rohertrag_ekmep_olk_4n_af_vj,
        tm.rohertrag_ekmep_olk_4n_sa_vj,
        tm.a381_preislagenverteilung,
        tm.a27_totalabschriften_wert_netto_absolut,
        tm.a313_preisabschriften_preisanderungen_wert_netto_absolut,
        tm.totalabschriften_wert_netto_absolut_vj,
        tm.preisabschriften_preisanderungen_wert_netto_absolut_vj,
        tm.a402_kolli_la,
        tm.a401_kolli_bst,
        tm.a403_restlaufzeit_zl,
        tm.a404_restlaufzeit_dz,
        tm.a405_basismengeneinheit,
        tm.a406_letzte_listungsanderung_sst_ksst,
        tm.a407_verhandler,
        tm.a408_display_komponente_kz,
        tm.a409_kl_art_id_display,
        tm.a416_artikelrolle_id,
        tm.kassenumsatz_kl_absolut_netto_wg,
        tm.anz_bons_tupel,
        tm.restbon_summe,
        tm.totalabschriften_wert_netto_absolut_wg,
        tm.preisabschriften_preisanderungen_wert_netto_absolut_wg,
        tm.anz_bons_af_markt_tag,
        tm.anz_bons_sa_markt_tag,
        tm.cpq_tupel,
        tm.cp_bons_af,
        tm.cp_bons_sa,
        tm.umrech_faktor,
        tm.lagerprozent,
        tm.absatz_af_kl_listungswochen,
        tm.absatz_af_kl_vj_listungswochen,
        tm.absatz_sa_kl_listungswochen,
        tm.absatz_sa_kl_vj_listungswochen,
        tm.kassenumsatz_af_kl_absolut_netto_listungswochen,
        tm.kassenumsatz_af_kl_absolut_netto_vj_listungswochen,
        tm.kassenumsatz_sa_kl_absolut_netto_listungswochen,
        tm.kassenumsatz_sa_kl_absolut_netto_vj_listungswochen,
        tm.rohertrag_ekmep_olk_4n_af_listungswochen,
        tm.rohertrag_ekmep_olk_4n_af_vj_listungswochen,
        tm.rohertrag_ekmep_olk_4n_sa_listungswochen,
        tm.rohertrag_ekmep_olk_4n_sa_vj_listungswochen,
        tm.a445_anz_tupel_listung_wgi,
        tm.td_insert,
        tm.td_update,
        tm.sustain_concat,
        tm.check_fg,
        tm.tupel_typ,
        tm.a471_marke_nielsen_bez,
        tm.a515_bio_organic_nielsen_kz,
        tm.a516_veggy_split_nielsen_kz,
        tm.a517_laktosefrei_nielsen_kz,
        tm.a518_glutenfrei_nielsen_kz,
        tm.a510_muki_ek_kz,
        tm.a511_muki_ek_kl_art_id_verkettung,
        tm.a512_muki_wb_kz,
        tm.a513_muki_wb_kl_art_id_verkettung,
        tm.a519_umsatz_anteil_wg_nielsen,
        tm.a520_umsatz_anteil_wg_kumuliert_nielsen,
        tm.a521_inhalt_menge
    FROM (
        SELECT
            mandant_id,
            art_matching_id,
            art_nielsen_id
        FROM `_art_matching_nielsen_per_kmo`
        GROUP BY
            mandant_id,
            art_matching_id,
            art_nielsen_id
    ) AS m
    LEFT JOIN (
        SELECT
            mandant_id,
            art_nielsen_id,
            nielsen_market_id,
            kjmo,
            umsatz_brutto
        FROM dbp_data.art_nielsen_fakten_kjmo
        WHERE
            (mandant_id, kjmo) IN (
                SELECT (mandant_id, kjmo)
                FROM `_monat`
            )
    ) AS nf
        ON m.mandant_id = nf.mandant_id AND m.art_nielsen_id = nf.art_nielsen_id
    LEFT JOIN (
        dbp_etl_process.tupel_mat_etl AS tm
        INNER JOIN (
            SELECT *
            FROM `_week`
            GROUP BY
                mandant_id,
                kjwo
        ) AS t5
            ON tm.mandant_id = t5.mandant_id AND tm.a500_kjwo_update = t5.kjwo
    )
        ON m.mandant_id = tm.mandant_id AND m.art_matching_id = tm.matching_id
) AS t6
LEFT JOIN dbp_data.nielsen_market AS nm
    ON t6.mandant_id0 = nm.mandant_id AND t6.nielsen_market_id = nm.nielsen_market_id
WHERE
    t6.mandant_id > 1
    AND nm.nielsen_market_cluster_id = 1
    AND NOT t6.mandant_id IN (2, 3, 5, 6)
GROUP BY
    t6.mandant_id,
    t6.art_matching_id,
    t6.art_nielsen_id,
    t6.kjmo,
    nf_umsatz_brutto;

INSERT INTO `_prepare`
(
    SELECT
        t5.mandant_id,
        t5.art_matching_id,
        t5.art_nielsen_id,
        t5.kjmo,
        t5.umsatz_brutto AS nf_umsatz_brutto
    FROM (
        SELECT
            m.mandant_id,
            m.art_matching_id,
            m.art_nielsen_id,
            nf.mandant_id AS mandant_id0,
            nf.art_nielsen_id AS art_nielsen_id0,
            nf.nielsen_market_id,
            nf.kjmo,
            nf.umsatz_brutto,
            tm.mandant_id AS mandant_id1,
            tm.a500_kjwo_update,
            tm.matching_id,
            tm.a425_kjmo,
            tm.wrg_id,
            tm.a5_owg_id,
            tm.a7_wg_id,
            tm.wug_id,
            tm.art_id,
            tm.kl_art_id,
            tm.a450_art_nielsen_nr,
            tm.art_bez_deutsch,
            tm.a14_art_status_de,
            tm.nielsen_art_bez,
            tm.nielsen_gtin,
            tm.a58_rang_umsatz_owg,
            tm.a2_rang_umsatz_wg,
            tm.a59_rang_absatz_wg,
            tm.a16_akt_lieferant_id,
            tm.a419_hersteller_id,
            tm.a446_lieferant_bez_latein,
            tm.a447_hersteller_bez_latein,
            tm.lieferant_nielsen,
            tm.a389_zek_id,
            tm.a391_disc_pe,
            tm.a392_disc_ohne_etikett,
            tm.a400_lcf,
            tm.a393_vegan,
            tm.a394_gluten,
            tm.a395_bio,
            tm.a396_eigenmarke,
            tm.a397_tierwohl,
            tm.a398_posten_food,
            tm.a399_posten_nonfood,
            tm.a339_umsatzsteuer,
            tm.a36_gewichtete_distribution,
            tm.a60_muki_vk_kz,
            tm.a61_muki_vk_kl_art_id_verkettung,
            tm.anzahl_markt_wochen_kombis_abverkauf_af,
            tm.anzahl_markt_wochen_kombis_abverkauf_sa,
            tm.anzahl_markt_wochen_kombis_abverkauf_af_vj,
            tm.anzahl_markt_wochen_kombis_abverkauf_sa_vj,
            tm.a273_kassenumsatz_kl_absolut_brutto,
            tm.kassenumsatz_af_kl_absolut_brutto,
            tm.kassenumsatz_sa_kl_absolut_brutto,
            tm.kassenumsatz_kl_absolut_brutto_vj,
            tm.kassenumsatz_af_kl_absolut_brutto_vj,
            tm.kassenumsatz_sa_kl_absolut_brutto_vj,
            tm.a21_kassenumsatz_kl_absolut_netto,
            tm.kassenumsatz_af_kl_absolut_netto,
            tm.kassenumsatz_sa_kl_absolut_netto,
            tm.kassenumsatz_kl_absolut_netto_vj,
            tm.kassenumsatz_af_kl_absolut_netto_vj,
            tm.kassenumsatz_sa_kl_absolut_netto_vj,
            tm.a17_absatz_kl,
            tm.absatz_af_kl,
            tm.absatz_sa_kl,
            tm.absatz_kl_vj,
            tm.absatz_af_kl_vj,
            tm.absatz_sa_kl_vj,
            tm.a76_absatz_sst1,
            tm.a78_absatz_sst2,
            tm.a80_absatz_sst3,
            tm.a82_absatz_sst4,
            tm.a84_absatz_sst5,
            tm.a86_absatz_sst6,
            tm.a88_absatz_sst7,
            tm.a62_absatz_ksst1,
            tm.a64_absatz_ksst2,
            tm.a66_absatz_ksst3,
            tm.a68_absatz_ksst4,
            tm.a70_absatz_ksst5,
            tm.a72_absatz_ksst6,
            tm.a74_absatz_ksst7,
            tm.a90_absatz_ost_basis,
            tm.a92_absatz_ost_gross,
            tm.a94_absatz_sued_ost,
            tm.a96_absatz_sued_west,
            tm.a98_absatz_west,
            tm.a100_absatz_nord,
            tm.markt_wochen_sst1,
            tm.markt_wochen_sst2,
            tm.markt_wochen_sst3,
            tm.markt_wochen_sst4,
            tm.markt_wochen_sst5,
            tm.markt_wochen_sst6,
            tm.markt_wochen_sst7,
            tm.markt_wochen_ksst1,
            tm.markt_wochen_ksst2,
            tm.markt_wochen_ksst3,
            tm.markt_wochen_ksst4,
            tm.markt_wochen_ksst5,
            tm.markt_wochen_ksst6,
            tm.markt_wochen_ksst7,
            tm.markt_wochen_ost_basis,
            tm.markt_wochen_ost_gross,
            tm.markt_wochen_sued_ost,
            tm.markt_wochen_sued_west,
            tm.markt_wochen_west,
            tm.markt_wochen_nord,
            tm.anzahl_markt_wochen_kombis_abverkauf_mit_listung,
            tm.anzahl_markt_wochen_kombis_listung,
            tm.a31_vk_brutto_kl_pk_1,
            tm.a333_vk_brutto_kl_pk_2,
            tm.a54_vk_brutto_kl_pk_3,
            tm.a334_vk_brutto_kl_pk_4,
            tm.a432_vk_brutto_kl_pk_5,
            tm.a433_vk_brutto_kl_pk_6,
            tm.a434_vk_brutto_kl_pk_7,
            tm.a435_vk_brutto_kl_pk_8,
            tm.a436_vk_brutto_kl_pk_9,
            tm.a437_vk_brutto_kl_pk_10,
            tm.a30_kb_olk_ek4ndz_stamm,
            tm.a23_rohertrag_ekmep_olk_4n,
            tm.a51_listung_sst_pflege,
            tm.a52_listung_k_sst_pflege,
            tm.a426_ost_basis_pflege,
            tm.a427_ost_gross_pflege,
            tm.a428_sued_ost_pflege,
            tm.a429_sued_west_pflege,
            tm.a430_west_pflege,
            tm.a431_nord_pflege,
            tm.a50_listungsaktion,
            tm.a411_stk_rohertrag_pflege,
            tm.a415_kannibalisierungsfaktor,
            tm.a412_umsatz_brutto_hochrechnung,
            tm.a413_absatz_hochrechnung,
            tm.a414_rohertrag_hochrechnung,
            tm.a36_gewichtete_distribution_nielsen,
            tm.a32_umsatz_anteil_wgi_nielsen,
            tm.a33_umsatz_anteil_wgi_kumuliert_nielsen,
            tm.a34_vk_brutto_durchschnitt_nielsen,
            tm.a35_umsatz_nielsen,
            tm.anz_wochen_de_anz_monate_kmo_nielsen,
            tm.absatz_nielsen,
            tm.a376_kl_marktanteil_wg_nielsen,
            tm.a380_marktanteilbewertung_nielsen,
            tm.a377_durchschnitt_anz_maerkte_nielsen,
            tm.a382_sales_units_absatz_verkaufsartikel_in_1000_nielsen,
            tm.a383_sales_units_verkaufseinheiten_gl_in_1000_normiert_nielsen,
            tm.a384_durchschn_preis_einheit_gl_normiert_nielsen,
            tm.a385_numerische_distribution_nielsen,
            tm.a386_inhaltsmengen_nielsen,
            tm.a387_duft_geschmack_nielsen,
            tm.a388_einheit_nielsen,
            tm.eigenmarke_fg_nielsen,
            tm.a39_listung_sst_mvke,
            tm.a38_listung_k_sst_mvke,
            tm.a40_ost_basis,
            tm.a41_ost_gross,
            tm.a42_sued_ost,
            tm.a43_sued_west,
            tm.a44_west,
            tm.a45_nord,
            tm.a37_listung_erster_markt,
            tm.a59_anz_maerkte_sst,
            tm.a449_anz_maerkte_k_sst,
            tm.a46_max_anz_maerkte_sst,
            tm.a47_max_anz_maerkte_k_sst,
            tm.a53_anz_maerkte_listung_gesamt,
            tm.a57_anz_maerkte_listung_einzel,
            tm.anz_maerkte_baustein_sonstige,
            tm.anz_bons_af,
            tm.anz_bons_sa,
            tm.anz_bons_gesamt,
            tm.rohertrag_ekmep_olk_4n_vj,
            tm.rohertrag_ekmep_olk_4n_af,
            tm.rohertrag_ekmep_olk_4n_sa,
            tm.rohertrag_ekmep_olk_4n_af_vj,
            tm.rohertrag_ekmep_olk_4n_sa_vj,
            tm.a381_preislagenverteilung,
            tm.a27_totalabschriften_wert_netto_absolut,
            tm.a313_preisabschriften_preisanderungen_wert_netto_absolut,
            tm.totalabschriften_wert_netto_absolut_vj,
            tm.preisabschriften_preisanderungen_wert_netto_absolut_vj,
            tm.a402_kolli_la,
            tm.a401_kolli_bst,
            tm.a403_restlaufzeit_zl,
            tm.a404_restlaufzeit_dz,
            tm.a405_basismengeneinheit,
            tm.a406_letzte_listungsanderung_sst_ksst,
            tm.a407_verhandler,
            tm.a408_display_komponente_kz,
            tm.a409_kl_art_id_display,
            tm.a416_artikelrolle_id,
            tm.kassenumsatz_kl_absolut_netto_wg,
            tm.anz_bons_tupel,
            tm.restbon_summe,
            tm.totalabschriften_wert_netto_absolut_wg,
            tm.preisabschriften_preisanderungen_wert_netto_absolut_wg,
            tm.anz_bons_af_markt_tag,
            tm.anz_bons_sa_markt_tag,
            tm.cpq_tupel,
            tm.cp_bons_af,
            tm.cp_bons_sa,
            tm.umrech_faktor,
            tm.lagerprozent,
            tm.absatz_af_kl_listungswochen,
            tm.absatz_af_kl_vj_listungswochen,
            tm.absatz_sa_kl_listungswochen,
            tm.absatz_sa_kl_vj_listungswochen,
            tm.kassenumsatz_af_kl_absolut_netto_listungswochen,
            tm.kassenumsatz_af_kl_absolut_netto_vj_listungswochen,
            tm.kassenumsatz_sa_kl_absolut_netto_listungswochen,
            tm.kassenumsatz_sa_kl_absolut_netto_vj_listungswochen,
            tm.rohertrag_ekmep_olk_4n_af_listungswochen,
            tm.rohertrag_ekmep_olk_4n_af_vj_listungswochen,
            tm.rohertrag_ekmep_olk_4n_sa_listungswochen,
            tm.rohertrag_ekmep_olk_4n_sa_vj_listungswochen,
            tm.a445_anz_tupel_listung_wgi,
            tm.td_insert,
            tm.td_update,
            tm.sustain_concat,
            tm.check_fg,
            tm.tupel_typ,
            tm.a471_marke_nielsen_bez,
            tm.a515_bio_organic_nielsen_kz,
            tm.a516_veggy_split_nielsen_kz,
            tm.a517_laktosefrei_nielsen_kz,
            tm.a518_glutenfrei_nielsen_kz,
            tm.a510_muki_ek_kz,
            tm.a511_muki_ek_kl_art_id_verkettung,
            tm.a512_muki_wb_kz,
            tm.a513_muki_wb_kl_art_id_verkettung,
            tm.a519_umsatz_anteil_wg_nielsen,
            tm.a520_umsatz_anteil_wg_kumuliert_nielsen,
            tm.a521_inhalt_menge
        FROM (
            SELECT
                mandant_id,
                art_matching_id,
                art_nielsen_id
            FROM `_art_matching_nielsen_per_kmo`
            GROUP BY
                mandant_id,
                art_matching_id,
                art_nielsen_id
        ) AS m
        LEFT JOIN (
            SELECT
                mandant_id,
                art_nielsen_id,
                nielsen_market_id,
                kjmo,
                umsatz_brutto
            FROM dbp_data.art_nielsen_fakten_kjmo
            WHERE
                (mandant_id, kjmo) IN (
                    SELECT (mandant_id, kjmo)
                    FROM `_monat`
                )
        ) AS nf
            ON m.mandant_id = nf.mandant_id AND m.art_nielsen_id = nf.art_nielsen_id
        LEFT JOIN (
            dbp_etl_process.tupel_mat_etl AS tm
            INNER JOIN (
                SELECT *
                FROM `_week`
                GROUP BY
                    mandant_id,
                    kjwo
            ) AS t4
                ON tm.mandant_id = t4.mandant_id AND tm.a500_kjwo_update = t4.kjwo
        )
            ON m.mandant_id = tm.mandant_id AND m.art_matching_id = tm.matching_id
    ) AS t5
    LEFT JOIN dbp_data.nielsen_market AS nm
        ON t5.mandant_id0 = nm.mandant_id AND t5.nielsen_market_id = nm.nielsen_market_id
    WHERE
        t5.mandant_id IN (2, 3, 5, 6) AND nm.nielsen_market_cluster_id = 1
);

CREATE OR REPLACE TEMPORARY TABLE _agg AS
SELECT
    mandant_id,
    art_matching_id,
    SUM(nf_umsatz_brutto) AS nf_umsatz_brutto
FROM `_prepare`
GROUP BY
    mandant_id,
    art_matching_id;

CREATE OR REPLACE TEMPORARY TABLE _tupel_mat_test_39 AS
SELECT
    a.mandant_id,
    a.matching_id,
    a.a35_umsatz_nielsen,
    c.nf_umsatz_brutto
FROM dbp_etl_process.tupel_mat_etl AS a
INNER JOIN `_week` AS b
    ON a.mandant_id = b.mandant_id AND a.a500_kjwo_update = b.kjwo
INNER JOIN `_agg` AS c
    ON a.mandant_id = c.mandant_id AND a.matching_id = c.art_matching_id
WHERE
    a.a35_umsatz_nielsen <> c.nf_umsatz_brutto;

INSERT INTO dbp_etl_process.mat_test
(
    SELECT
        39 AS test_id,
        'TUPEL' AS test_type,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        CASE WHEN COUNT(*) >= 1 THEN 'ERROR' WHEN COUNT(*) < 1 THEN 'OK' ELSE NULL END AS test_status,
        COUNT(*) AS error_count,
        STRING_AGG(
            DISTINCT CAST(mandant_id AS STRING), ','
            ORDER BY
                CAST(mandant_id AS STRING)
        ) AS error_mandant_id,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_39`
);

INSERT INTO dbp_etl_process.mat_test_desc
(
    SELECT
        39 AS test_id,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        'A35_UMSATZ_NIELSEN',
        CASE
            WHEN COUNT(*) >= 1
                THEN 'A35_UMSATZ_NIELSEN <> UMSATZ_BRUTTO FROM ART_NIELSEN_FAKTEN_KJMO '
            WHEN COUNT(*) < 1
                THEN 'OK'
            ELSE NULL
        END AS description,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_39`
);

INSERT INTO dbp_etl_process.mat_test_detail
(
    SELECT
        39 AS test_id,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        mandant_id,
        'MATCHING_ID' AS key_name,
        matching_id AS key_value,
        'A35_UMSATZ_NIELSEN',
        SUBSTR(CAST(a35_umsatz_nielsen AS STRING), 1, 300) AS a35_umsatz_nielsen,
        SUBSTR(CAST(nf_umsatz_brutto AS STRING), 1, 300) AS nf_umsatz_brutto,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_39`
);

CREATE OR REPLACE TEMPORARY TABLE _prepare2 AS
SELECT
    t5.mandant_id,
    t5.art_matching_id,
    t5.art_nielsen_id,
    t5.kjmo,
    t5.distr_gew AS nf_gewichtete_distribution_nielsen
FROM (
    SELECT
        m.mandant_id,
        m.art_matching_id,
        m.art_nielsen_id,
        nf.mandant_id AS mandant_id0,
        nf.art_nielsen_id AS art_nielsen_id0,
        nf.nielsen_market_id,
        nf.kjmo,
        nf.distr_gew,
        tm.mandant_id AS mandant_id1,
        tm.a500_kjwo_update,
        tm.matching_id,
        tm.a425_kjmo,
        tm.wrg_id,
        tm.a5_owg_id,
        tm.a7_wg_id,
        tm.wug_id,
        tm.art_id,
        tm.kl_art_id,
        tm.a450_art_nielsen_nr,
        tm.art_bez_deutsch,
        tm.a14_art_status_de,
        tm.nielsen_art_bez,
        tm.nielsen_gtin,
        tm.a58_rang_umsatz_owg,
        tm.a2_rang_umsatz_wg,
        tm.a59_rang_absatz_wg,
        tm.a16_akt_lieferant_id,
        tm.a419_hersteller_id,
        tm.a446_lieferant_bez_latein,
        tm.a447_hersteller_bez_latein,
        tm.lieferant_nielsen,
        tm.a389_zek_id,
        tm.a391_disc_pe,
        tm.a392_disc_ohne_etikett,
        tm.a400_lcf,
        tm.a393_vegan,
        tm.a394_gluten,
        tm.a395_bio,
        tm.a396_eigenmarke,
        tm.a397_tierwohl,
        tm.a398_posten_food,
        tm.a399_posten_nonfood,
        tm.a339_umsatzsteuer,
        tm.a36_gewichtete_distribution,
        tm.a60_muki_vk_kz,
        tm.a61_muki_vk_kl_art_id_verkettung,
        tm.anzahl_markt_wochen_kombis_abverkauf_af,
        tm.anzahl_markt_wochen_kombis_abverkauf_sa,
        tm.anzahl_markt_wochen_kombis_abverkauf_af_vj,
        tm.anzahl_markt_wochen_kombis_abverkauf_sa_vj,
        tm.a273_kassenumsatz_kl_absolut_brutto,
        tm.kassenumsatz_af_kl_absolut_brutto,
        tm.kassenumsatz_sa_kl_absolut_brutto,
        tm.kassenumsatz_kl_absolut_brutto_vj,
        tm.kassenumsatz_af_kl_absolut_brutto_vj,
        tm.kassenumsatz_sa_kl_absolut_brutto_vj,
        tm.a21_kassenumsatz_kl_absolut_netto,
        tm.kassenumsatz_af_kl_absolut_netto,
        tm.kassenumsatz_sa_kl_absolut_netto,
        tm.kassenumsatz_kl_absolut_netto_vj,
        tm.kassenumsatz_af_kl_absolut_netto_vj,
        tm.kassenumsatz_sa_kl_absolut_netto_vj,
        tm.a17_absatz_kl,
        tm.absatz_af_kl,
        tm.absatz_sa_kl,
        tm.absatz_kl_vj,
        tm.absatz_af_kl_vj,
        tm.absatz_sa_kl_vj,
        tm.a76_absatz_sst1,
        tm.a78_absatz_sst2,
        tm.a80_absatz_sst3,
        tm.a82_absatz_sst4,
        tm.a84_absatz_sst5,
        tm.a86_absatz_sst6,
        tm.a88_absatz_sst7,
        tm.a62_absatz_ksst1,
        tm.a64_absatz_ksst2,
        tm.a66_absatz_ksst3,
        tm.a68_absatz_ksst4,
        tm.a70_absatz_ksst5,
        tm.a72_absatz_ksst6,
        tm.a74_absatz_ksst7,
        tm.a90_absatz_ost_basis,
        tm.a92_absatz_ost_gross,
        tm.a94_absatz_sued_ost,
        tm.a96_absatz_sued_west,
        tm.a98_absatz_west,
        tm.a100_absatz_nord,
        tm.markt_wochen_sst1,
        tm.markt_wochen_sst2,
        tm.markt_wochen_sst3,
        tm.markt_wochen_sst4,
        tm.markt_wochen_sst5,
        tm.markt_wochen_sst6,
        tm.markt_wochen_sst7,
        tm.markt_wochen_ksst1,
        tm.markt_wochen_ksst2,
        tm.markt_wochen_ksst3,
        tm.markt_wochen_ksst4,
        tm.markt_wochen_ksst5,
        tm.markt_wochen_ksst6,
        tm.markt_wochen_ksst7,
        tm.markt_wochen_ost_basis,
        tm.markt_wochen_ost_gross,
        tm.markt_wochen_sued_ost,
        tm.markt_wochen_sued_west,
        tm.markt_wochen_west,
        tm.markt_wochen_nord,
        tm.anzahl_markt_wochen_kombis_abverkauf_mit_listung,
        tm.anzahl_markt_wochen_kombis_listung,
        tm.a31_vk_brutto_kl_pk_1,
        tm.a333_vk_brutto_kl_pk_2,
        tm.a54_vk_brutto_kl_pk_3,
        tm.a334_vk_brutto_kl_pk_4,
        tm.a432_vk_brutto_kl_pk_5,
        tm.a433_vk_brutto_kl_pk_6,
        tm.a434_vk_brutto_kl_pk_7,
        tm.a435_vk_brutto_kl_pk_8,
        tm.a436_vk_brutto_kl_pk_9,
        tm.a437_vk_brutto_kl_pk_10,
        tm.a30_kb_olk_ek4ndz_stamm,
        tm.a23_rohertrag_ekmep_olk_4n,
        tm.a51_listung_sst_pflege,
        tm.a52_listung_k_sst_pflege,
        tm.a426_ost_basis_pflege,
        tm.a427_ost_gross_pflege,
        tm.a428_sued_ost_pflege,
        tm.a429_sued_west_pflege,
        tm.a430_west_pflege,
        tm.a431_nord_pflege,
        tm.a50_listungsaktion,
        tm.a411_stk_rohertrag_pflege,
        tm.a415_kannibalisierungsfaktor,
        tm.a412_umsatz_brutto_hochrechnung,
        tm.a413_absatz_hochrechnung,
        tm.a414_rohertrag_hochrechnung,
        tm.a36_gewichtete_distribution_nielsen,
        tm.a32_umsatz_anteil_wgi_nielsen,
        tm.a33_umsatz_anteil_wgi_kumuliert_nielsen,
        tm.a34_vk_brutto_durchschnitt_nielsen,
        tm.a35_umsatz_nielsen,
        tm.anz_wochen_de_anz_monate_kmo_nielsen,
        tm.absatz_nielsen,
        tm.a376_kl_marktanteil_wg_nielsen,
        tm.a380_marktanteilbewertung_nielsen,
        tm.a377_durchschnitt_anz_maerkte_nielsen,
        tm.a382_sales_units_absatz_verkaufsartikel_in_1000_nielsen,
        tm.a383_sales_units_verkaufseinheiten_gl_in_1000_normiert_nielsen,
        tm.a384_durchschn_preis_einheit_gl_normiert_nielsen,
        tm.a385_numerische_distribution_nielsen,
        tm.a386_inhaltsmengen_nielsen,
        tm.a387_duft_geschmack_nielsen,
        tm.a388_einheit_nielsen,
        tm.eigenmarke_fg_nielsen,
        tm.a39_listung_sst_mvke,
        tm.a38_listung_k_sst_mvke,
        tm.a40_ost_basis,
        tm.a41_ost_gross,
        tm.a42_sued_ost,
        tm.a43_sued_west,
        tm.a44_west,
        tm.a45_nord,
        tm.a37_listung_erster_markt,
        tm.a59_anz_maerkte_sst,
        tm.a449_anz_maerkte_k_sst,
        tm.a46_max_anz_maerkte_sst,
        tm.a47_max_anz_maerkte_k_sst,
        tm.a53_anz_maerkte_listung_gesamt,
        tm.a57_anz_maerkte_listung_einzel,
        tm.anz_maerkte_baustein_sonstige,
        tm.anz_bons_af,
        tm.anz_bons_sa,
        tm.anz_bons_gesamt,
        tm.rohertrag_ekmep_olk_4n_vj,
        tm.rohertrag_ekmep_olk_4n_af,
        tm.rohertrag_ekmep_olk_4n_sa,
        tm.rohertrag_ekmep_olk_4n_af_vj,
        tm.rohertrag_ekmep_olk_4n_sa_vj,
        tm.a381_preislagenverteilung,
        tm.a27_totalabschriften_wert_netto_absolut,
        tm.a313_preisabschriften_preisanderungen_wert_netto_absolut,
        tm.totalabschriften_wert_netto_absolut_vj,
        tm.preisabschriften_preisanderungen_wert_netto_absolut_vj,
        tm.a402_kolli_la,
        tm.a401_kolli_bst,
        tm.a403_restlaufzeit_zl,
        tm.a404_restlaufzeit_dz,
        tm.a405_basismengeneinheit,
        tm.a406_letzte_listungsanderung_sst_ksst,
        tm.a407_verhandler,
        tm.a408_display_komponente_kz,
        tm.a409_kl_art_id_display,
        tm.a416_artikelrolle_id,
        tm.kassenumsatz_kl_absolut_netto_wg,
        tm.anz_bons_tupel,
        tm.restbon_summe,
        tm.totalabschriften_wert_netto_absolut_wg,
        tm.preisabschriften_preisanderungen_wert_netto_absolut_wg,
        tm.anz_bons_af_markt_tag,
        tm.anz_bons_sa_markt_tag,
        tm.cpq_tupel,
        tm.cp_bons_af,
        tm.cp_bons_sa,
        tm.umrech_faktor,
        tm.lagerprozent,
        tm.absatz_af_kl_listungswochen,
        tm.absatz_af_kl_vj_listungswochen,
        tm.absatz_sa_kl_listungswochen,
        tm.absatz_sa_kl_vj_listungswochen,
        tm.kassenumsatz_af_kl_absolut_netto_listungswochen,
        tm.kassenumsatz_af_kl_absolut_netto_vj_listungswochen,
        tm.kassenumsatz_sa_kl_absolut_netto_listungswochen,
        tm.kassenumsatz_sa_kl_absolut_netto_vj_listungswochen,
        tm.rohertrag_ekmep_olk_4n_af_listungswochen,
        tm.rohertrag_ekmep_olk_4n_af_vj_listungswochen,
        tm.rohertrag_ekmep_olk_4n_sa_listungswochen,
        tm.rohertrag_ekmep_olk_4n_sa_vj_listungswochen,
        tm.a445_anz_tupel_listung_wgi,
        tm.td_insert,
        tm.td_update,
        tm.sustain_concat,
        tm.check_fg,
        tm.tupel_typ,
        tm.a471_marke_nielsen_bez,
        tm.a515_bio_organic_nielsen_kz,
        tm.a516_veggy_split_nielsen_kz,
        tm.a517_laktosefrei_nielsen_kz,
        tm.a518_glutenfrei_nielsen_kz,
        tm.a510_muki_ek_kz,
        tm.a511_muki_ek_kl_art_id_verkettung,
        tm.a512_muki_wb_kz,
        tm.a513_muki_wb_kl_art_id_verkettung,
        tm.a519_umsatz_anteil_wg_nielsen,
        tm.a520_umsatz_anteil_wg_kumuliert_nielsen,
        tm.a521_inhalt_menge
    FROM (
        SELECT
            mandant_id,
            art_matching_id,
            art_nielsen_id
        FROM `_art_matching_nielsen_per_kmo`
        GROUP BY
            mandant_id,
            art_matching_id,
            art_nielsen_id
    ) AS m
    LEFT JOIN (
        SELECT
            mandant_id,
            art_nielsen_id,
            nielsen_market_id,
            kjmo,
            distr_gew
        FROM dbp_data.art_nielsen_fakten_kjmo
        WHERE
            (mandant_id, kjmo) IN (
                SELECT (mandant_id, kjmo)
                FROM `_monat`
            )
    ) AS nf
        ON m.mandant_id = nf.mandant_id AND m.art_nielsen_id = nf.art_nielsen_id
    LEFT JOIN (
        dbp_etl_process.tupel_mat_etl AS tm
        INNER JOIN (
            SELECT *
            FROM `_week`
            GROUP BY
                mandant_id,
                kjwo
        ) AS t4
            ON tm.mandant_id = t4.mandant_id AND tm.a500_kjwo_update = t4.kjwo
    )
        ON m.mandant_id = tm.mandant_id AND m.art_matching_id = tm.matching_id
) AS t5
LEFT JOIN dbp_data.nielsen_market AS nm
    ON t5.mandant_id0 = nm.mandant_id AND t5.nielsen_market_id = nm.nielsen_market_id
WHERE
    t5.mandant_id IN (2, 3, 5, 6) AND nm.nielsen_market_cluster_id = 1;

INSERT INTO `_prepare2`
(
    SELECT
        t5.mandant_id,
        t5.art_matching_id,
        t5.art_nielsen_id,
        t5.kjmo,
        t5.distr_gew AS nf_gewichtete_distribution_nielsen
    FROM (
        SELECT
            m.mandant_id,
            m.art_matching_id,
            m.art_nielsen_id,
            nf.mandant_id AS mandant_id0,
            nf.art_nielsen_id AS art_nielsen_id0,
            nf.nielsen_market_id,
            nf.kjmo,
            nf.distr_gew,
            tm.mandant_id AS mandant_id1,
            tm.a500_kjwo_update,
            tm.matching_id,
            tm.a425_kjmo,
            tm.wrg_id,
            tm.a5_owg_id,
            tm.a7_wg_id,
            tm.wug_id,
            tm.art_id,
            tm.kl_art_id,
            tm.a450_art_nielsen_nr,
            tm.art_bez_deutsch,
            tm.a14_art_status_de,
            tm.nielsen_art_bez,
            tm.nielsen_gtin,
            tm.a58_rang_umsatz_owg,
            tm.a2_rang_umsatz_wg,
            tm.a59_rang_absatz_wg,
            tm.a16_akt_lieferant_id,
            tm.a419_hersteller_id,
            tm.a446_lieferant_bez_latein,
            tm.a447_hersteller_bez_latein,
            tm.lieferant_nielsen,
            tm.a389_zek_id,
            tm.a391_disc_pe,
            tm.a392_disc_ohne_etikett,
            tm.a400_lcf,
            tm.a393_vegan,
            tm.a394_gluten,
            tm.a395_bio,
            tm.a396_eigenmarke,
            tm.a397_tierwohl,
            tm.a398_posten_food,
            tm.a399_posten_nonfood,
            tm.a339_umsatzsteuer,
            tm.a36_gewichtete_distribution,
            tm.a60_muki_vk_kz,
            tm.a61_muki_vk_kl_art_id_verkettung,
            tm.anzahl_markt_wochen_kombis_abverkauf_af,
            tm.anzahl_markt_wochen_kombis_abverkauf_sa,
            tm.anzahl_markt_wochen_kombis_abverkauf_af_vj,
            tm.anzahl_markt_wochen_kombis_abverkauf_sa_vj,
            tm.a273_kassenumsatz_kl_absolut_brutto,
            tm.kassenumsatz_af_kl_absolut_brutto,
            tm.kassenumsatz_sa_kl_absolut_brutto,
            tm.kassenumsatz_kl_absolut_brutto_vj,
            tm.kassenumsatz_af_kl_absolut_brutto_vj,
            tm.kassenumsatz_sa_kl_absolut_brutto_vj,
            tm.a21_kassenumsatz_kl_absolut_netto,
            tm.kassenumsatz_af_kl_absolut_netto,
            tm.kassenumsatz_sa_kl_absolut_netto,
            tm.kassenumsatz_kl_absolut_netto_vj,
            tm.kassenumsatz_af_kl_absolut_netto_vj,
            tm.kassenumsatz_sa_kl_absolut_netto_vj,
            tm.a17_absatz_kl,
            tm.absatz_af_kl,
            tm.absatz_sa_kl,
            tm.absatz_kl_vj,
            tm.absatz_af_kl_vj,
            tm.absatz_sa_kl_vj,
            tm.a76_absatz_sst1,
            tm.a78_absatz_sst2,
            tm.a80_absatz_sst3,
            tm.a82_absatz_sst4,
            tm.a84_absatz_sst5,
            tm.a86_absatz_sst6,
            tm.a88_absatz_sst7,
            tm.a62_absatz_ksst1,
            tm.a64_absatz_ksst2,
            tm.a66_absatz_ksst3,
            tm.a68_absatz_ksst4,
            tm.a70_absatz_ksst5,
            tm.a72_absatz_ksst6,
            tm.a74_absatz_ksst7,
            tm.a90_absatz_ost_basis,
            tm.a92_absatz_ost_gross,
            tm.a94_absatz_sued_ost,
            tm.a96_absatz_sued_west,
            tm.a98_absatz_west,
            tm.a100_absatz_nord,
            tm.markt_wochen_sst1,
            tm.markt_wochen_sst2,
            tm.markt_wochen_sst3,
            tm.markt_wochen_sst4,
            tm.markt_wochen_sst5,
            tm.markt_wochen_sst6,
            tm.markt_wochen_sst7,
            tm.markt_wochen_ksst1,
            tm.markt_wochen_ksst2,
            tm.markt_wochen_ksst3,
            tm.markt_wochen_ksst4,
            tm.markt_wochen_ksst5,
            tm.markt_wochen_ksst6,
            tm.markt_wochen_ksst7,
            tm.markt_wochen_ost_basis,
            tm.markt_wochen_ost_gross,
            tm.markt_wochen_sued_ost,
            tm.markt_wochen_sued_west,
            tm.markt_wochen_west,
            tm.markt_wochen_nord,
            tm.anzahl_markt_wochen_kombis_abverkauf_mit_listung,
            tm.anzahl_markt_wochen_kombis_listung,
            tm.a31_vk_brutto_kl_pk_1,
            tm.a333_vk_brutto_kl_pk_2,
            tm.a54_vk_brutto_kl_pk_3,
            tm.a334_vk_brutto_kl_pk_4,
            tm.a432_vk_brutto_kl_pk_5,
            tm.a433_vk_brutto_kl_pk_6,
            tm.a434_vk_brutto_kl_pk_7,
            tm.a435_vk_brutto_kl_pk_8,
            tm.a436_vk_brutto_kl_pk_9,
            tm.a437_vk_brutto_kl_pk_10,
            tm.a30_kb_olk_ek4ndz_stamm,
            tm.a23_rohertrag_ekmep_olk_4n,
            tm.a51_listung_sst_pflege,
            tm.a52_listung_k_sst_pflege,
            tm.a426_ost_basis_pflege,
            tm.a427_ost_gross_pflege,
            tm.a428_sued_ost_pflege,
            tm.a429_sued_west_pflege,
            tm.a430_west_pflege,
            tm.a431_nord_pflege,
            tm.a50_listungsaktion,
            tm.a411_stk_rohertrag_pflege,
            tm.a415_kannibalisierungsfaktor,
            tm.a412_umsatz_brutto_hochrechnung,
            tm.a413_absatz_hochrechnung,
            tm.a414_rohertrag_hochrechnung,
            tm.a36_gewichtete_distribution_nielsen,
            tm.a32_umsatz_anteil_wgi_nielsen,
            tm.a33_umsatz_anteil_wgi_kumuliert_nielsen,
            tm.a34_vk_brutto_durchschnitt_nielsen,
            tm.a35_umsatz_nielsen,
            tm.anz_wochen_de_anz_monate_kmo_nielsen,
            tm.absatz_nielsen,
            tm.a376_kl_marktanteil_wg_nielsen,
            tm.a380_marktanteilbewertung_nielsen,
            tm.a377_durchschnitt_anz_maerkte_nielsen,
            tm.a382_sales_units_absatz_verkaufsartikel_in_1000_nielsen,
            tm.a383_sales_units_verkaufseinheiten_gl_in_1000_normiert_nielsen,
            tm.a384_durchschn_preis_einheit_gl_normiert_nielsen,
            tm.a385_numerische_distribution_nielsen,
            tm.a386_inhaltsmengen_nielsen,
            tm.a387_duft_geschmack_nielsen,
            tm.a388_einheit_nielsen,
            tm.eigenmarke_fg_nielsen,
            tm.a39_listung_sst_mvke,
            tm.a38_listung_k_sst_mvke,
            tm.a40_ost_basis,
            tm.a41_ost_gross,
            tm.a42_sued_ost,
            tm.a43_sued_west,
            tm.a44_west,
            tm.a45_nord,
            tm.a37_listung_erster_markt,
            tm.a59_anz_maerkte_sst,
            tm.a449_anz_maerkte_k_sst,
            tm.a46_max_anz_maerkte_sst,
            tm.a47_max_anz_maerkte_k_sst,
            tm.a53_anz_maerkte_listung_gesamt,
            tm.a57_anz_maerkte_listung_einzel,
            tm.anz_maerkte_baustein_sonstige,
            tm.anz_bons_af,
            tm.anz_bons_sa,
            tm.anz_bons_gesamt,
            tm.rohertrag_ekmep_olk_4n_vj,
            tm.rohertrag_ekmep_olk_4n_af,
            tm.rohertrag_ekmep_olk_4n_sa,
            tm.rohertrag_ekmep_olk_4n_af_vj,
            tm.rohertrag_ekmep_olk_4n_sa_vj,
            tm.a381_preislagenverteilung,
            tm.a27_totalabschriften_wert_netto_absolut,
            tm.a313_preisabschriften_preisanderungen_wert_netto_absolut,
            tm.totalabschriften_wert_netto_absolut_vj,
            tm.preisabschriften_preisanderungen_wert_netto_absolut_vj,
            tm.a402_kolli_la,
            tm.a401_kolli_bst,
            tm.a403_restlaufzeit_zl,
            tm.a404_restlaufzeit_dz,
            tm.a405_basismengeneinheit,
            tm.a406_letzte_listungsanderung_sst_ksst,
            tm.a407_verhandler,
            tm.a408_display_komponente_kz,
            tm.a409_kl_art_id_display,
            tm.a416_artikelrolle_id,
            tm.kassenumsatz_kl_absolut_netto_wg,
            tm.anz_bons_tupel,
            tm.restbon_summe,
            tm.totalabschriften_wert_netto_absolut_wg,
            tm.preisabschriften_preisanderungen_wert_netto_absolut_wg,
            tm.anz_bons_af_markt_tag,
            tm.anz_bons_sa_markt_tag,
            tm.cpq_tupel,
            tm.cp_bons_af,
            tm.cp_bons_sa,
            tm.umrech_faktor,
            tm.lagerprozent,
            tm.absatz_af_kl_listungswochen,
            tm.absatz_af_kl_vj_listungswochen,
            tm.absatz_sa_kl_listungswochen,
            tm.absatz_sa_kl_vj_listungswochen,
            tm.kassenumsatz_af_kl_absolut_netto_listungswochen,
            tm.kassenumsatz_af_kl_absolut_netto_vj_listungswochen,
            tm.kassenumsatz_sa_kl_absolut_netto_listungswochen,
            tm.kassenumsatz_sa_kl_absolut_netto_vj_listungswochen,
            tm.rohertrag_ekmep_olk_4n_af_listungswochen,
            tm.rohertrag_ekmep_olk_4n_af_vj_listungswochen,
            tm.rohertrag_ekmep_olk_4n_sa_listungswochen,
            tm.rohertrag_ekmep_olk_4n_sa_vj_listungswochen,
            tm.a445_anz_tupel_listung_wgi,
            tm.td_insert,
            tm.td_update,
            tm.sustain_concat,
            tm.check_fg,
            tm.tupel_typ,
            tm.a471_marke_nielsen_bez,
            tm.a515_bio_organic_nielsen_kz,
            tm.a516_veggy_split_nielsen_kz,
            tm.a517_laktosefrei_nielsen_kz,
            tm.a518_glutenfrei_nielsen_kz,
            tm.a510_muki_ek_kz,
            tm.a511_muki_ek_kl_art_id_verkettung,
            tm.a512_muki_wb_kz,
            tm.a513_muki_wb_kl_art_id_verkettung,
            tm.a519_umsatz_anteil_wg_nielsen,
            tm.a520_umsatz_anteil_wg_kumuliert_nielsen,
            tm.a521_inhalt_menge
        FROM (
            SELECT
                mandant_id,
                art_matching_id,
                art_nielsen_id
            FROM `_art_matching_nielsen_per_kmo`
            GROUP BY
                mandant_id,
                art_matching_id,
                art_nielsen_id
        ) AS m
        LEFT JOIN (
            SELECT
                mandant_id,
                art_nielsen_id,
                nielsen_market_id,
                kjmo,
                distr_gew
            FROM dbp_data.art_nielsen_fakten_kjmo
            WHERE
                (mandant_id, kjmo) IN (
                    SELECT (mandant_id, kjmo)
                    FROM `_monat`
                )
        ) AS nf
            ON m.mandant_id = nf.mandant_id AND m.art_nielsen_id = nf.art_nielsen_id
        LEFT JOIN (
            dbp_etl_process.tupel_mat_etl AS tm
            INNER JOIN (
                SELECT *
                FROM `_week`
                GROUP BY
                    mandant_id,
                    kjwo
            ) AS t4
                ON tm.mandant_id = t4.mandant_id AND tm.a500_kjwo_update = t4.kjwo
        )
            ON m.mandant_id = tm.mandant_id AND m.art_matching_id = tm.matching_id
    ) AS t5
    LEFT JOIN dbp_data.nielsen_market AS nm
        ON t5.mandant_id0 = nm.mandant_id AND t5.nielsen_market_id = nm.nielsen_market_id
    WHERE
        t5.mandant_id > 1
        AND nm.nielsen_market_cluster_id = 1
        AND NOT t5.mandant_id IN (2, 3, 5, 6)
    GROUP BY
        t5.mandant_id,
        t5.art_matching_id,
        t5.art_nielsen_id,
        t5.kjmo,
        nf_gewichtete_distribution_nielsen
);

CREATE OR REPLACE TEMPORARY TABLE _agg2 AS
SELECT
    mandant_id,
    art_matching_id,
    ROUND(AVG(nf_gewichtete_distribution_nielsen), 4) AS nf_gewichtete_distribution_nielsen
FROM `_prepare2`
GROUP BY
    mandant_id,
    art_matching_id;

CREATE OR REPLACE TEMPORARY TABLE _tupel_mat_test_40 AS
SELECT
    a.mandant_id,
    a.matching_id,
    a.a36_gewichtete_distribution_nielsen,
    c.nf_gewichtete_distribution_nielsen
FROM dbp_etl_process.tupel_mat_etl AS a
INNER JOIN `_week` AS b
    ON a.mandant_id = b.mandant_id AND a.a500_kjwo_update = b.kjwo
INNER JOIN `_agg2` AS c
    ON a.mandant_id = c.mandant_id AND a.matching_id = c.art_matching_id
WHERE
    a.a5_owg_id <> 1059
    AND a.a36_gewichtete_distribution_nielsen <> c.nf_gewichtete_distribution_nielsen;

INSERT INTO dbp_etl_process.mat_test
(
    SELECT
        40 AS test_id,
        'TUPEL' AS test_type,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        CASE WHEN COUNT(*) >= 1 THEN 'ERROR' WHEN COUNT(*) < 1 THEN 'OK' ELSE NULL END AS test_status,
        COUNT(*) AS error_count,
        STRING_AGG(
            DISTINCT CAST(mandant_id AS STRING), ','
            ORDER BY
                CAST(mandant_id AS STRING)
        ) AS error_mandant_id,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_40`
);

INSERT INTO dbp_etl_process.mat_test_desc
(
    SELECT
        40 AS test_id,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        'A36_GEWICHTETE_DISTRIBUTION_NIELSEN',
        CASE
            WHEN COUNT(*) >= 1
                THEN 'A36_GEWICHTETE_DISTRIBUTION_NIELSEN <> DISTR_GEW FROM ART_NIELSEN_FAKTEN_KJMO '
            WHEN COUNT(*) < 1
                THEN 'OK'
            ELSE NULL
        END AS description,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_40`
);

INSERT INTO dbp_etl_process.mat_test_detail
(
    SELECT
        40 AS test_id,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        mandant_id,
        'MATCHING_ID' AS key_name,
        matching_id AS key_value,
        'A36_GEWICHTETE_DISTRIBUTION_NIELSEN',
        SUBSTR(CAST(a36_gewichtete_distribution_nielsen AS STRING), 1, 300) AS a36_gewichtete_distribution_nielsen,
        SUBSTR(CAST(nf_gewichtete_distribution_nielsen AS STRING), 1, 300) AS nf_gewichtete_distribution_nielsen,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_40`
);

CREATE OR REPLACE TEMPORARY TABLE _tupel_mat_test_41 AS
SELECT
    a.mandant_id,
    b.matching_id,
    COALESCE(b.anzahl_markt_wochen_kombis_abverkauf_mit_listung, 0) AS tm_anz_abverkauf,
    SUM(a.anz_wup_absatz) AS sal_anz_abverkauf
FROM dbp_data.sal_int AS a
INNER JOIN (
    SELECT
        mandant_id,
        art_matching_id,
        art_id
    FROM `_art_matching_nielsen_per`
    GROUP BY
        mandant_id,
        art_matching_id,
        art_id
) AS c
    ON a.mandant_id = c.mandant_id AND a.art_id = c.art_id
INNER JOIN dbp_etl_process.tupel_mat_etl AS b
    ON c.mandant_id = b.mandant_id AND c.art_matching_id = b.matching_id
WHERE
    a.kjwo IN (
        SELECT kjwo
        FROM dbp_data.art_nielsen_fakten_kjwo
        WHERE
            mandant_id = 1
        GROUP BY
            kjwo
        QUALIFY
            (
                (
                    RANK() OVER (ORDER BY kjwo IS NULL DESC, kjwo DESC)
                ) * -1
            ) BETWEEN -52 AND (
                -1
            )
    )
    AND a.mandant_id = 1
    AND b.a500_kjwo_update IN (
        SELECT MAX(a500_kjwo_update) AS a1581216993
        FROM dbp_etl_process.tupel_mat_etl
        WHERE
            mandant_id = 1
    )
GROUP BY
    a.mandant_id,
    b.matching_id,
    tm_anz_abverkauf
HAVING
    tm_anz_abverkauf <> sal_anz_abverkauf;

INSERT INTO dbp_etl_process.mat_test
(
    SELECT
        41 AS test_id,
        'TUPEL' AS test_type,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        CASE WHEN COUNT(*) >= 1 THEN 'ERROR' WHEN COUNT(*) < 1 THEN 'OK' ELSE NULL END AS test_status,
        COUNT(*) AS error_count,
        STRING_AGG(
            DISTINCT CAST(mandant_id AS STRING), ','
            ORDER BY
                CAST(mandant_id AS STRING)
        ) AS error_mandant_id,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_41`
);

INSERT INTO dbp_etl_process.mat_test_desc
(
    SELECT
        41 AS test_id,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        'ANZAHL_MARKT_WOCHEN_KOMBIS_ABVERKAUF_MIT_LISTUNG',
        CASE
            WHEN COUNT(*) >= 1
                THEN 'ANZAHL_MARKT_WOCHEN_KOMBIS_ABVERKAUF_MIT_LISTUNG <> ANZ_WUP_ABSATZ FROM SAL_INT '
            WHEN COUNT(*) < 1
                THEN 'OK'
            ELSE NULL
        END AS description,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_41`
);

INSERT INTO dbp_etl_process.mat_test_detail
(
    SELECT
        41 AS test_id,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        mandant_id,
        'MATCHING_ID' AS key_name,
        matching_id AS key_value,
        'ANZAHL_MARKT_WOCHEN_KOMBIS_ABVERKAUF_MIT_LISTUNG',
        SUBSTR(CAST(tm_anz_abverkauf AS STRING), 1, 300) AS tm_anz_abverkauf,
        SUBSTR(CAST(sal_anz_abverkauf AS STRING), 1, 300) AS sal_anz_abverkauf,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_41`
);

CREATE OR REPLACE TEMPORARY TABLE _tupel_mat_test_42 AS
SELECT
    a.mandant_id,
    b.matching_id,
    COALESCE(b.anzahl_markt_wochen_kombis_listung, 0) AS tm_anz_listung,
    SUM(a.anz_wup_listung) AS sal_anz_listung
FROM dbp_data.sal_int AS a
INNER JOIN (
    SELECT
        mandant_id,
        art_matching_id,
        art_id
    FROM `_art_matching_nielsen_per`
    GROUP BY
        mandant_id,
        art_matching_id,
        art_id
) AS c
    ON a.mandant_id = c.mandant_id AND a.art_id = c.art_id
INNER JOIN dbp_etl_process.tupel_mat_etl AS b
    ON c.mandant_id = b.mandant_id AND c.art_matching_id = b.matching_id
WHERE
    a.kjwo IN (
        SELECT kjwo
        FROM dbp_data.art_nielsen_fakten_kjwo
        WHERE
            mandant_id = 1
        GROUP BY
            kjwo
        QUALIFY
            (
                (
                    RANK() OVER (ORDER BY kjwo IS NULL DESC, kjwo DESC)
                ) * -1
            ) BETWEEN -52 AND (
                -1
            )
    )
    AND a.mandant_id = 1
    AND b.a500_kjwo_update IN (
        SELECT MAX(a500_kjwo_update) AS a1581216993
        FROM dbp_etl_process.tupel_mat_etl
        WHERE
            mandant_id = 1
    )
GROUP BY
    a.mandant_id,
    b.matching_id,
    tm_anz_listung
HAVING
    tm_anz_listung <> sal_anz_listung;

INSERT INTO dbp_etl_process.mat_test
(
    SELECT
        42 AS test_id,
        'TUPEL' AS test_type,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        CASE WHEN COUNT(*) >= 1 THEN 'ERROR' WHEN COUNT(*) < 1 THEN 'OK' ELSE NULL END AS test_status,
        COUNT(*) AS error_count,
        STRING_AGG(
            DISTINCT CAST(mandant_id AS STRING), ','
            ORDER BY
                CAST(mandant_id AS STRING)
        ) AS error_mandant_id,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_42`
);

INSERT INTO dbp_etl_process.mat_test_desc
(
    SELECT
        42 AS test_id,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        'ANZAHL_MARKT_WOCHEN_KOMBIS_LISTUNG',
        CASE
            WHEN COUNT(*) >= 1
                THEN 'ANZAHL_MARKT_WOCHEN_KOMBIS_LISTUNG <> ANZ_WUP_LISTUNG FROM SAL_INT '
            WHEN COUNT(*) < 1
                THEN 'OK'
            ELSE NULL
        END AS description,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_42`
);

INSERT INTO dbp_etl_process.mat_test_detail
(
    SELECT
        42 AS test_id,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        mandant_id,
        'MATCHING_ID' AS key_name,
        matching_id AS key_value,
        'ANZAHL_MARKT_WOCHEN_KOMBIS_LISTUNG',
        SUBSTR(CAST(tm_anz_listung AS STRING), 1, 300) AS tm_anz_listung,
        SUBSTR(CAST(sal_anz_listung AS STRING), 1, 300) AS sal_anz_listung,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_42`
);

CREATE OR REPLACE TEMPORARY TABLE _tupel_mat_test_43 AS
(
    SELECT
        a.mandant_id,
        a.matching_id,
        a.kjwo_update,
        a.spr_id,
        b.spr_id AS spr_id_m
    FROM dbp_data.tupel_spr_zu AS a
    INNER JOIN dbp_data.mandant_spr_zu AS b
        ON a.mandant_id = b.mandant_id
    WHERE
        (a.mandant_id, a.kjwo_update) IN (
            SELECT (mandant_id, kjwo)
            FROM `_week`
        )
        AND a.spr_id <> 22
        AND a.spr_id <> b.spr_id
        AND a.mandant_id > 1
    UNION DISTINCT
    SELECT
        a.mandant_id,
        a.matching_id,
        a.kjwo_update,
        a.spr_id,
        b.spr_id AS spr_id_m
    FROM dbp_data.tupel_spr_zu AS a
    INNER JOIN dbp_data.mandant_spr_zu AS b
        ON a.mandant_id = b.mandant_id
    WHERE
        (a.mandant_id, a.kjwo_update) IN (
            SELECT (mandant_id, kjwo)
            FROM `_week`
        )
        AND a.spr_id = 22
        AND a.spr_id <> b.spr_id
        AND a.mandant_id = 1
)
UNION DISTINCT
SELECT
    a.mandant_id,
    a.matching_id,
    a.kjwo_update,
    a.spr_id,
    c.spr_id AS spr_id_m
FROM dbp_data.tupel_spr_zu AS a
INNER JOIN `_art_matching_nielsen_per_kmo` AS b
    ON a.mandant_id = b.mandant_id AND a.matching_id = b.art_matching_id
INNER JOIN (
    SELECT *
    FROM dbp_data.art_spr_zu
    WHERE
        spr_id = 22
) AS c
    ON a.mandant_id = c.mandant_id AND b.art_id = c.art_id
WHERE
    (a.mandant_id, a.kjwo_update) IN (
        SELECT (mandant_id, kjwo)
        FROM `_week`
    )
    AND a.spr_id = 22
    AND a.spr_id <> c.spr_id
    AND a.mandant_id > 1;

INSERT INTO dbp_etl_process.mat_test
(
    SELECT
        43 AS test_id,
        'MASTER DATA' AS test_type,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        CASE WHEN COUNT(*) >= 1 THEN 'ERROR' WHEN COUNT(*) < 1 THEN 'OK' ELSE NULL END AS test_status,
        COUNT(*) AS error_count,
        STRING_AGG(
            DISTINCT CAST(mandant_id AS STRING), ','
            ORDER BY
                CAST(mandant_id AS STRING)
        ) AS error_mandant_id,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_43`
);

INSERT INTO dbp_etl_process.mat_test_desc
(
    SELECT
        43 AS test_id,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        'SPR_ID',
        CASE
            WHEN COUNT(*) >= 1
                THEN 'SPR_ID <> SPR_ID (TUPEL_SPR_ZU /  ART_SPR_ZU OR MANDANT_SPR_ZU )'
            WHEN COUNT(*) < 1
                THEN 'OK'
            ELSE NULL
        END AS description,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_43`
);

INSERT INTO dbp_etl_process.mat_test_detail
(
    SELECT
        43 AS test_id,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        mandant_id,
        'MATCHING_ID' AS key_name,
        matching_id AS key_value,
        'SPR_ID',
        SUBSTR(CAST(spr_id AS STRING), 1, 300) AS spr_id,
        SUBSTR(CAST(spr_id_m AS STRING), 1, 300) AS spr_id_m,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_43`
);

CREATE OR REPLACE TEMPORARY TABLE _tupel_mat_test_44 AS
SELECT
    a.mandant_id,
    a.kjwo_update,
    a.akt_lieferant_id,
    a.akt_lieferant_bez,
    c.gp_name
FROM dbp_data.sort_lieferant_spr_zu AS a
INNER JOIN dbp_data.gp AS c
    ON a.mandant_id = c.mandant_id AND a.akt_lieferant_id = c.gp_id
WHERE
    (
        a.mandant_id > 1 AND a.mandant_id < 8 OR a.mandant_id > 8
    )
    AND (a.mandant_id, a.kjwo_update) IN (
        SELECT (mandant_id, kjwo)
        FROM `_week`
    )
    AND a.akt_lieferant_bez <> c.gp_name
GROUP BY
    a.mandant_id,
    a.kjwo_update,
    a.akt_lieferant_id,
    a.akt_lieferant_bez,
    c.gp_name;

INSERT INTO dbp_etl_process.mat_test
(
    SELECT
        44 AS test_id,
        'MASTER DATA' AS test_type,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        CASE WHEN COUNT(*) >= 1 THEN 'ERROR' WHEN COUNT(*) < 1 THEN 'OK' ELSE NULL END AS test_status,
        COUNT(*) AS error_count,
        STRING_AGG(
            DISTINCT CAST(mandant_id AS STRING), ','
            ORDER BY
                CAST(mandant_id AS STRING)
        ) AS error_mandant_id,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_44`
);

INSERT INTO dbp_etl_process.mat_test_desc
(
    SELECT
        44 AS test_id,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        'AKT_LIEFERANT_BEZ',
        CASE
            WHEN COUNT(*) >= 1
                THEN 'AKT_LIEFERANT_BEZ <> GP_NAME (SORT_LIEFERANT_SPR_ZU / GP) '
            WHEN COUNT(*) < 1
                THEN 'OK'
            ELSE NULL
        END AS description,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_44`
);

INSERT INTO dbp_etl_process.mat_test_detail
(
    SELECT
        44 AS test_id,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        mandant_id,
        'AKT_LIEFERANT_ID' AS key_name,
        akt_lieferant_id AS key_value,
        'AKT_LIEFERANT_BEZ',
        akt_lieferant_bez,
        gp_name,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_44`
);

/* -TUPEL_KW */
CREATE OR REPLACE TEMPORARY TABLE _kw_woche AS
SELECT kjwo
FROM dbp_data.woche
WHERE
    akt_wo = -1;

/* DE */
CREATE OR REPLACE TEMPORARY TABLE _artbew_kw AS
SELECT
    a.mandant_id,
    c.art_matching_id,
    IFNULL(SUM(ROUND(CAST(a.menge * d.umrech_faktor AS NUMERIC), 3)), 0) AS absatz,
    IFNULL(SUM(a.umsatz_netto), 0) AS umsatz,
    IFNULL(SUM(CASE WHEN a.bewart_id = 1002 THEN a.umsatz_netto ELSE NULL END), 0) AS umsatz_sa,
    IFNULL(SUM(CASE WHEN a.bewart_id = 1001 THEN a.umsatz_netto ELSE NULL END), 0) AS umsatz_af
FROM dbp_data.artbew_wo_sum AS a
INNER JOIN dbp_data.woche_kj_kl AS b
    ON a.kjwo_kl = b.kjwo_kl
INNER JOIN (
    SELECT
        mandant_id,
        art_matching_id,
        art_id
    FROM `_art_matching_nielsen_per`
    WHERE
        art_id <> -1
    GROUP BY
        mandant_id,
        art_matching_id,
        art_id
) AS c
    ON a.art_id = c.art_id AND a.mandant_id = c.mandant_id
INNER JOIN (
    SELECT
        mandant_id,
        art_id,
        MAX(umrech_faktor) AS umrech_faktor
    FROM dbp_etl.art_matching_nielsen_per_de_xxx
    WHERE
        mandant_id = 1 AND art_id <> -1
    GROUP BY
        mandant_id,
        art_id
) AS d
    ON a.art_id = d.art_id AND a.mandant_id = d.mandant_id
WHERE
    b.kjwo = (
        SELECT kjwo
        FROM `_kw_woche`
    ) AND a.mandant_id = 1
GROUP BY
    a.mandant_id,
    c.art_matching_id;

/* KMO */
INSERT INTO `_artbew_kw`
(
    SELECT
        a.mandant_id,
        c.art_matching_id,
        IFNULL(SUM(a.menge), 0) AS absatz,
        IFNULL(SUM(a.umsatz_netto), 0) AS umsatz,
        IFNULL(SUM(CASE WHEN a.bewart_id = 1002 THEN a.umsatz_netto ELSE NULL END), 0) AS umsatz_sa,
        IFNULL(SUM(CASE WHEN a.bewart_id = 1001 THEN a.umsatz_netto ELSE NULL END), 0) AS umsatz_af
    FROM dbp_data.artbew_wo_sum AS a
    INNER JOIN dbp_data.woche_kj_kl AS b
        ON a.kjwo_kl = b.kjwo_kl
    INNER JOIN (
        SELECT
            mandant_id,
            art_matching_id,
            art_id
        FROM `_art_matching_nielsen_per_kmo`
        WHERE
            art_id <> -1
        GROUP BY
            mandant_id,
            art_matching_id,
            art_id
    ) AS c
        ON a.art_id = c.art_id AND a.mandant_id = c.mandant_id
    WHERE
        b.kjwo = (
            SELECT kjwo
            FROM `_kw_woche`
        ) AND a.mandant_id > 1
    GROUP BY
        a.mandant_id,
        c.art_matching_id
);

CREATE OR REPLACE TEMPORARY TABLE _tupel_kw AS
SELECT DISTINCT
    mandant_id,
    kjwo,
    matching_id,
    absatz_kl,
    kassenumsatz_kl_absolut_netto,
    kassenumsatz_af_kl_absolut_netto,
    kassenumsatz_sa_kl_absolut_netto
FROM dbp_data.tupel_kw
WHERE
    kjwo IN (
        SELECT kjwo
        FROM `_kw_woche`
    );

CREATE OR REPLACE TEMPORARY TABLE _tupel_mat_test_45 AS
SELECT
    a.mandant_id,
    a.kjwo,
    a.matching_id,
    a.kassenumsatz_kl_absolut_netto,
    b.umsatz,
    ABS(a.kassenumsatz_kl_absolut_netto - b.umsatz) AS diff_umsatz
FROM `_tupel_kw` AS a
INNER JOIN `_artbew_kw` AS b
    ON a.mandant_id = b.mandant_id AND a.matching_id = b.art_matching_id
WHERE
    ABS(a.kassenumsatz_kl_absolut_netto - b.umsatz) <> 0
ORDER BY
    diff_umsatz DESC NULLS FIRST;

INSERT INTO dbp_etl_process.mat_test
(
    SELECT
        45 AS test_id,
        'MASTER DATA' AS test_type,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        CASE WHEN COUNT(*) >= 1 THEN 'ERROR' WHEN COUNT(*) < 1 THEN 'OK' ELSE NULL END AS test_status,
        COUNT(*) AS error_count,
        STRING_AGG(
            DISTINCT CAST(mandant_id AS STRING), ','
            ORDER BY
                CAST(mandant_id AS STRING)
        ) AS error_mandant_id,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_45`
);

INSERT INTO dbp_etl_process.mat_test_desc
(
    SELECT
        45 AS test_id,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        'KASSENUMSATZ_KL_ABSOLUT_NETTO',
        CASE
            WHEN COUNT(*) >= 1
                THEN 'KASSENUMSATZ_KL_ABSOLUT_NETTO <> UMSATZ IN TUPEL_KW'
            WHEN COUNT(*) < 1
                THEN 'OK'
            ELSE NULL
        END AS description,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_45`
);

INSERT INTO dbp_etl_process.mat_test_detail
(
    SELECT
        45 AS test_id,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        mandant_id,
        'MATCHING_ID' AS key_name,
        matching_id AS key_value,
        'KASSENUMSATZ_KL_ABSOLUT_NETTO',
        SUBSTR(CAST(kassenumsatz_kl_absolut_netto AS STRING), 1, 300) AS kassenumsatz_kl_absolut_netto,
        SUBSTR(CAST(umsatz AS STRING), 1, 300) AS umsatz,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_45`
);

CREATE OR REPLACE TEMPORARY TABLE _tupel_mat_test_46 AS
SELECT
    a.mandant_id,
    a.kjwo,
    a.matching_id,
    a.kassenumsatz_af_kl_absolut_netto,
    b.umsatz_af,
    ABS(a.kassenumsatz_af_kl_absolut_netto - b.umsatz_af) AS diff_umsatz
FROM `_tupel_kw` AS a
INNER JOIN `_artbew_kw` AS b
    ON a.mandant_id = b.mandant_id AND a.matching_id = b.art_matching_id
WHERE
    ABS(a.kassenumsatz_af_kl_absolut_netto - b.umsatz_af) <> 0
ORDER BY
    diff_umsatz DESC NULLS FIRST;

INSERT INTO dbp_etl_process.mat_test
(
    SELECT
        46 AS test_id,
        'MASTER DATA' AS test_type,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        CASE WHEN COUNT(*) >= 1 THEN 'ERROR' WHEN COUNT(*) < 1 THEN 'OK' ELSE NULL END AS test_status,
        COUNT(*) AS error_count,
        STRING_AGG(
            DISTINCT CAST(mandant_id AS STRING), ','
            ORDER BY
                CAST(mandant_id AS STRING)
        ) AS error_mandant_id,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_46`
);

INSERT INTO dbp_etl_process.mat_test_desc
(
    SELECT
        46 AS test_id,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        'KASSENUMSATZ_AF_KL_ABSOLUT_NETTO',
        CASE
            WHEN COUNT(*) >= 1
                THEN 'KASSENUMSATZ_AF_KL_ABSOLUT_NETTO <> UMSATZ_AF IN TUPEL_KW'
            WHEN COUNT(*) < 1
                THEN 'OK'
            ELSE NULL
        END AS description,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_46`
);

INSERT INTO dbp_etl_process.mat_test_detail
(
    SELECT
        46 AS test_id,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        mandant_id,
        'MATCHING_ID' AS key_name,
        matching_id AS key_value,
        'KASSENUMSATZ_AF_KL_ABSOLUT_NETTO',
        SUBSTR(CAST(kassenumsatz_af_kl_absolut_netto AS STRING), 1, 300) AS kassenumsatz_af_kl_absolut_netto,
        SUBSTR(CAST(umsatz_af AS STRING), 1, 300) AS umsatz_af,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_46`
);

CREATE OR REPLACE TEMPORARY TABLE _tupel_mat_test_47 AS
SELECT
    a.mandant_id,
    a.kjwo,
    a.matching_id,
    a.kassenumsatz_sa_kl_absolut_netto,
    b.umsatz_sa,
    ABS(a.kassenumsatz_sa_kl_absolut_netto - b.umsatz_sa) AS diff_umsatz
FROM `_tupel_kw` AS a
INNER JOIN `_artbew_kw` AS b
    ON a.mandant_id = b.mandant_id AND a.matching_id = b.art_matching_id
WHERE
    ABS(a.kassenumsatz_sa_kl_absolut_netto - b.umsatz_sa) <> 0
ORDER BY
    diff_umsatz DESC NULLS FIRST;

INSERT INTO dbp_etl_process.mat_test
(
    SELECT
        47 AS test_id,
        'MASTER DATA' AS test_type,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        CASE WHEN COUNT(*) >= 1 THEN 'ERROR' WHEN COUNT(*) < 1 THEN 'OK' ELSE NULL END AS test_status,
        COUNT(*) AS error_count,
        STRING_AGG(
            DISTINCT CAST(mandant_id AS STRING), ','
            ORDER BY
                CAST(mandant_id AS STRING)
        ) AS error_mandant_id,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_47`
);

INSERT INTO dbp_etl_process.mat_test_desc
(
    SELECT
        47 AS test_id,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        'KASSENUMSATZ_SA_KL_ABSOLUT_NETTO',
        CASE
            WHEN COUNT(*) >= 1
                THEN 'KASSENUMSATZ_SA_KL_ABSOLUT_NETTO <> UMSATZ_SA IN TUPEL_KW'
            WHEN COUNT(*) < 1
                THEN 'OK'
            ELSE NULL
        END AS description,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_47`
);

INSERT INTO dbp_etl_process.mat_test_detail
(
    SELECT
        47 AS test_id,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        mandant_id,
        'MATCHING_ID' AS key_name,
        matching_id AS key_value,
        'KASSENUMSATZ_SA_KL_ABSOLUT_NETTO',
        SUBSTR(CAST(kassenumsatz_sa_kl_absolut_netto AS STRING), 1, 300) AS kassenumsatz_sa_kl_absolut_netto,
        SUBSTR(CAST(umsatz_sa AS STRING), 1, 300) AS umsatz_sa,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_47`
);

CREATE OR REPLACE TEMPORARY TABLE _tupel_mat_test_48 AS
SELECT
    a.mandant_id,
    a.kjwo,
    a.matching_id,
    a.absatz_kl,
    b.absatz,
    ABS(a.absatz_kl - b.absatz) AS diff_absatz
FROM `_tupel_kw` AS a
INNER JOIN `_artbew_kw` AS b
    ON a.mandant_id = b.mandant_id AND a.matching_id = b.art_matching_id
WHERE
    ABS(a.absatz_kl - b.absatz) <> 0
ORDER BY
    diff_absatz DESC NULLS FIRST;

INSERT INTO dbp_etl_process.mat_test
(
    SELECT
        48 AS test_id,
        'MASTER DATA' AS test_type,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        CASE WHEN COUNT(*) >= 1 THEN 'ERROR' WHEN COUNT(*) < 1 THEN 'OK' ELSE NULL END AS test_status,
        COUNT(*) AS error_count,
        STRING_AGG(
            DISTINCT CAST(mandant_id AS STRING), ','
            ORDER BY
                CAST(mandant_id AS STRING)
        ) AS error_mandant_id,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_48`
);

INSERT INTO dbp_etl_process.mat_test_desc
(
    SELECT
        48 AS test_id,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        'ABSATZ_KL',
        CASE
            WHEN COUNT(*) >= 1
                THEN 'ABSATZ_KL <> ABSATZ IN TUPEL_KW'
            WHEN COUNT(*) < 1
                THEN 'OK'
            ELSE NULL
        END AS description,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_48`
);

INSERT INTO dbp_etl_process.mat_test_detail
(
    SELECT
        48 AS test_id,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        mandant_id,
        'MATCHING_ID' AS key_name,
        matching_id AS key_value,
        'ABSATZ_KL',
        SUBSTR(CAST(absatz_kl AS STRING), 1, 300) AS absatz_kl,
        SUBSTR(CAST(absatz AS STRING), 1, 300) AS absatz,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_48`
);

/* -TUPEL_KW_VJ */
CREATE OR REPLACE TEMPORARY TABLE _kw_woche_vj AS
SELECT kjwo
FROM dbp_data.woche
WHERE
    akt_wo = -53;

/* DE */
CREATE OR REPLACE TEMPORARY TABLE _artbew_kw_vj AS
SELECT
    a.mandant_id,
    c.art_matching_id,
    IFNULL(SUM(a.umsatz_netto), 0) AS umsatz,
    IFNULL(SUM(CASE WHEN a.bewart_id = 1002 THEN a.umsatz_netto ELSE NULL END), 0) AS umsatz_sa,
    IFNULL(SUM(CASE WHEN a.bewart_id = 1001 THEN a.umsatz_netto ELSE NULL END), 0) AS umsatz_af
FROM dbp_data.artbew_wo_sum AS a
INNER JOIN dbp_data.woche_kj_kl AS b
    ON a.kjwo_kl = b.kjwo_kl
INNER JOIN (
    SELECT
        mandant_id,
        art_matching_id,
        art_id
    FROM `_art_matching_nielsen_per`
    WHERE
        art_id <> -1
    GROUP BY
        mandant_id,
        art_matching_id,
        art_id
) AS c
    ON a.art_id = c.art_id AND a.mandant_id = c.mandant_id
WHERE
    b.kjwo = (
        SELECT kjwo
        FROM `_kw_woche_vj`
    ) AND a.mandant_id = 1
GROUP BY
    a.mandant_id,
    c.art_matching_id;

/* KMO */
INSERT INTO `_artbew_kw_vj`
(
    SELECT
        a.mandant_id,
        c.art_matching_id,
        IFNULL(SUM(a.umsatz_netto), 0) AS umsatz,
        IFNULL(SUM(CASE WHEN a.bewart_id = 1002 THEN a.umsatz_netto ELSE NULL END), 0) AS umsatz_sa,
        IFNULL(SUM(CASE WHEN a.bewart_id = 1001 THEN a.umsatz_netto ELSE NULL END), 0) AS umsatz_af
    FROM dbp_data.artbew_wo_sum AS a
    INNER JOIN dbp_data.woche_kj_kl AS b
        ON a.kjwo_kl = b.kjwo_kl
    INNER JOIN (
        SELECT
            mandant_id,
            art_matching_id,
            art_id
        FROM `_art_matching_nielsen_per_kmo`
        WHERE
            art_id <> -1
        GROUP BY
            mandant_id,
            art_matching_id,
            art_id
    ) AS c
        ON a.art_id = c.art_id AND a.mandant_id = c.mandant_id
    WHERE
        b.kjwo = (
            SELECT kjwo
            FROM `_kw_woche_vj`
        ) AND a.mandant_id > 1
    GROUP BY
        a.mandant_id,
        c.art_matching_id
);

CREATE OR REPLACE TEMPORARY TABLE _tupel_kw_vj AS
SELECT DISTINCT
    mandant_id,
    kjwo,
    matching_id,
    kassenumsatz_kl_absolut_netto_vj,
    kassenumsatz_af_kl_absolut_netto_vj,
    kassenumsatz_sa_kl_absolut_netto_vj
FROM dbp_data.tupel_kw
WHERE
    kjwo IN (
        SELECT kjwo
        FROM `_kw_woche`
    );

CREATE OR REPLACE TEMPORARY TABLE _tupel_mat_test_49 AS
SELECT
    a.mandant_id,
    a.kjwo,
    a.matching_id,
    a.kassenumsatz_kl_absolut_netto_vj,
    b.umsatz,
    ABS(a.kassenumsatz_kl_absolut_netto_vj - b.umsatz) AS diff_umsatz
FROM `_tupel_kw_vj` AS a
INNER JOIN `_artbew_kw_vj` AS b
    ON a.mandant_id = b.mandant_id AND a.matching_id = b.art_matching_id
WHERE
    ABS(a.kassenumsatz_kl_absolut_netto_vj - b.umsatz) <> 0
ORDER BY
    diff_umsatz DESC NULLS FIRST;

INSERT INTO dbp_etl_process.mat_test
(
    SELECT
        49 AS test_id,
        'MASTER DATA' AS test_type,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        CASE WHEN COUNT(*) >= 1 THEN 'ERROR' WHEN COUNT(*) < 1 THEN 'OK' ELSE NULL END AS test_status,
        COUNT(*) AS error_count,
        STRING_AGG(
            DISTINCT CAST(mandant_id AS STRING), ','
            ORDER BY
                CAST(mandant_id AS STRING)
        ) AS error_mandant_id,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_49`
);

INSERT INTO dbp_etl_process.mat_test_desc
(
    SELECT
        49 AS test_id,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        'KASSENUMSATZ_KL_ABSOLUT_NETTO_VJ',
        CASE
            WHEN COUNT(*) >= 1
                THEN 'KASSENUMSATZ_KL_ABSOLUT_NETTO_VJ <> UMSATZ IN TUPEL_KW'
            WHEN COUNT(*) < 1
                THEN 'OK'
            ELSE NULL
        END AS description,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_49`
);

INSERT INTO dbp_etl_process.mat_test_detail
(
    SELECT
        49 AS test_id,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        mandant_id,
        'MATCHING_ID' AS key_name,
        matching_id AS key_value,
        'KASSENUMSATZ_KL_ABSOLUT_NETTO_VJ',
        SUBSTR(CAST(kassenumsatz_kl_absolut_netto_vj AS STRING), 1, 300) AS kassenumsatz_kl_absolut_netto_vj,
        SUBSTR(CAST(umsatz AS STRING), 1, 300) AS umsatz,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_49`
);

CREATE OR REPLACE TEMPORARY TABLE _tupel_mat_test_50 AS
SELECT
    a.mandant_id,
    a.kjwo,
    a.matching_id,
    a.kassenumsatz_af_kl_absolut_netto_vj,
    b.umsatz_af,
    ABS(a.kassenumsatz_af_kl_absolut_netto_vj - b.umsatz_af) AS diff_umsatz
FROM `_tupel_kw_vj` AS a
INNER JOIN `_artbew_kw_vj` AS b
    ON a.mandant_id = b.mandant_id AND a.matching_id = b.art_matching_id
WHERE
    ABS(a.kassenumsatz_af_kl_absolut_netto_vj - b.umsatz_af) <> 0
ORDER BY
    diff_umsatz DESC NULLS FIRST;

INSERT INTO dbp_etl_process.mat_test
(
    SELECT
        50 AS test_id,
        'MASTER DATA' AS test_type,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        CASE WHEN COUNT(*) >= 1 THEN 'ERROR' WHEN COUNT(*) < 1 THEN 'OK' ELSE NULL END AS test_status,
        COUNT(*) AS error_count,
        STRING_AGG(
            DISTINCT CAST(mandant_id AS STRING), ','
            ORDER BY
                CAST(mandant_id AS STRING)
        ) AS error_mandant_id,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_50`
);

INSERT INTO dbp_etl_process.mat_test_desc
(
    SELECT
        50 AS test_id,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        'KASSENUMSATZ_AF_KL_ABSOLUT_NETTO_VJ',
        CASE
            WHEN COUNT(*) >= 1
                THEN 'KASSENUMSATZ_AF_KL_ABSOLUT_NETTO_VJ <> UMSATZ_AF IN TUPEL_KW'
            WHEN COUNT(*) < 1
                THEN 'OK'
            ELSE NULL
        END AS description,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_50`
);

INSERT INTO dbp_etl_process.mat_test_detail
(
    SELECT
        50 AS test_id,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        mandant_id,
        'MATCHING_ID' AS key_name,
        matching_id AS key_value,
        'KASSENUMSATZ_AF_KL_ABSOLUT_NETTO_VJ',
        SUBSTR(CAST(kassenumsatz_af_kl_absolut_netto_vj AS STRING), 1, 300) AS kassenumsatz_af_kl_absolut_netto_vj,
        SUBSTR(CAST(umsatz_af AS STRING), 1, 300) AS umsatz_af,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_50`
);

CREATE OR REPLACE TEMPORARY TABLE _tupel_mat_test_51 AS
SELECT
    a.mandant_id,
    a.kjwo,
    a.matching_id,
    a.kassenumsatz_sa_kl_absolut_netto_vj,
    b.umsatz_sa,
    ABS(a.kassenumsatz_sa_kl_absolut_netto_vj - b.umsatz_sa) AS diff_umsatz
FROM `_tupel_kw_vj` AS a
INNER JOIN `_artbew_kw_vj` AS b
    ON a.mandant_id = b.mandant_id AND a.matching_id = b.art_matching_id
WHERE
    ABS(a.kassenumsatz_sa_kl_absolut_netto_vj - b.umsatz_sa) <> 0
ORDER BY
    diff_umsatz DESC NULLS FIRST;

INSERT INTO dbp_etl_process.mat_test
(
    SELECT
        51 AS test_id,
        'MASTER DATA' AS test_type,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        CASE WHEN COUNT(*) >= 1 THEN 'ERROR' WHEN COUNT(*) < 1 THEN 'OK' ELSE NULL END AS test_status,
        COUNT(*) AS error_count,
        STRING_AGG(
            DISTINCT CAST(mandant_id AS STRING), ','
            ORDER BY
                CAST(mandant_id AS STRING)
        ) AS error_mandant_id,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_51`
);

INSERT INTO dbp_etl_process.mat_test_desc
(
    SELECT
        51 AS test_id,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        'KASSENUMSATZ_SA_KL_ABSOLUT_NETTO_VJ',
        CASE
            WHEN COUNT(*) >= 1
                THEN 'KASSENUMSATZ_SA_KL_ABSOLUT_NETTO_VJ <> UMSATZ_SA IN TUPEL_KW'
            WHEN COUNT(*) < 1
                THEN 'OK'
            ELSE NULL
        END AS description,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_51`
);

INSERT INTO dbp_etl_process.mat_test_detail
(
    SELECT
        51 AS test_id,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        mandant_id,
        'MATCHING_ID' AS key_name,
        matching_id AS key_value,
        'KASSENUMSATZ_SA_KL_ABSOLUT_NETTO_VJ',
        SUBSTR(CAST(kassenumsatz_sa_kl_absolut_netto_vj AS STRING), 1, 300) AS kassenumsatz_sa_kl_absolut_netto_vj,
        SUBSTR(CAST(umsatz_sa AS STRING), 1, 300) AS umsatz_sa,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_51`
);

/* KMO */
CREATE OR REPLACE TEMPORARY TABLE _artbew AS
SELECT
    a.mandant_id,
    a.dat,
    a.wup_id,
    a.menge,
    a.art_id,
    a.bewart_id,
    c.art_matching_id
FROM dbp_data.artbew AS a
INNER JOIN dbp_data.tag AS b
    ON a.dat = b.dat
INNER JOIN (
    SELECT
        mandant_id,
        art_matching_id,
        art_id
    FROM `_art_matching_nielsen_per_kmo`
    WHERE
        art_id <> -1
    GROUP BY
        mandant_id,
        art_matching_id,
        art_id
) AS c
    ON a.art_id = c.art_id AND a.mandant_id = c.mandant_id
WHERE
    b.kjwo IN (
        SELECT kjwo
        FROM `_kw_woche`
    ) AND a.mandant_id > 1;

/* DE */
INSERT INTO `_artbew`
(
    SELECT
        a.mandant_id,
        a.dat,
        a.wup_id,
        CAST(a.menge * d.umrech_faktor AS NUMERIC) AS menge,
        a.art_id,
        a.bewart_id,
        c.art_matching_id
    FROM dbp_data.artbew AS a
    INNER JOIN dbp_data.tag AS b
        ON a.dat = b.dat
    INNER JOIN (
        SELECT
            mandant_id,
            art_matching_id,
            art_id
        FROM `_art_matching_nielsen_per`
        WHERE
            art_id <> -1
        GROUP BY
            mandant_id,
            art_matching_id,
            art_id
    ) AS c
        ON a.art_id = c.art_id AND a.mandant_id = c.mandant_id
    INNER JOIN (
        SELECT
            mandant_id,
            art_id,
            MAX(umrech_faktor) AS umrech_faktor
        FROM dbp_etl.art_matching_nielsen_per_de_xxx
        WHERE
            mandant_id = 1 AND art_id <> -1
        GROUP BY
            mandant_id,
            art_id
    ) AS d
        ON a.art_id = d.art_id AND a.mandant_id = d.mandant_id
    WHERE
        b.kjwo = (
            SELECT kjwo
            FROM `_kw_woche`
        ) AND a.mandant_id = 1
);

CREATE OR REPLACE TEMPORARY TABLE _artbew_sum AS
SELECT
    mandant_id,
    dat,
    wup_id,
    art_matching_id,
    CASE WHEN IFNULL(SUM(menge), 0) > 0 THEN 1 ELSE 0 END AS anz_wo_mit_absatz,
    CASE
        WHEN IFNULL(SUM(CASE WHEN bewart_id = 1001 THEN menge ELSE NULL END), 0) > 0
            THEN 1
        ELSE 0
    END AS anz_wo_mit_absatz_af,
    CASE
        WHEN IFNULL(SUM(CASE WHEN bewart_id = 1002 THEN menge ELSE NULL END), 0) > 0
            THEN 1
        ELSE 0
    END AS anz_wo_mit_absatz_sa
FROM `_artbew`
GROUP BY
    mandant_id,
    dat,
    wup_id,
    art_matching_id;

CREATE OR REPLACE TEMPORARY TABLE _artbew_agg AS
SELECT
    mandant_id,
    art_matching_id,
    CAST(SUM(anz_wo_mit_absatz) / 7 AS INTEGER) AS anz_wo_mit_absatz,
    CAST(SUM(anz_wo_mit_absatz_af) / 7 AS INTEGER) AS anz_wo_mit_absatz_af,
    CAST(SUM(anz_wo_mit_absatz_sa) / 7 AS INTEGER) AS anz_wo_mit_absatz_sa
FROM `_artbew_sum`
GROUP BY
    mandant_id,
    art_matching_id;

CREATE OR REPLACE TEMPORARY TABLE _tupel_kw_2 AS
SELECT DISTINCT
    mandant_id,
    kjwo,
    matching_id,
    anzahl_markt_wochen_kombis_abverkauf_af,
    anzahl_markt_wochen_kombis_abverkauf_sa
FROM dbp_data.tupel_kw
WHERE
    kjwo IN (
        SELECT kjwo
        FROM `_kw_woche`
    );

CREATE OR REPLACE TEMPORARY TABLE _tupel_mat_test_52 AS
SELECT
    a.mandant_id,
    a.kjwo,
    a.matching_id,
    a.anzahl_markt_wochen_kombis_abverkauf_af,
    b.anz_wo_mit_absatz_af,
    ABS(a.anzahl_markt_wochen_kombis_abverkauf_af - b.anz_wo_mit_absatz_af) AS diff
FROM `_tupel_kw_2` AS a
INNER JOIN `_artbew_agg` AS b
    ON a.mandant_id = b.mandant_id AND a.matching_id = b.art_matching_id
WHERE
    ABS(a.anzahl_markt_wochen_kombis_abverkauf_af - b.anz_wo_mit_absatz_af) <> 0
ORDER BY
    diff DESC NULLS FIRST;

INSERT INTO dbp_etl_process.mat_test
(
    SELECT
        52 AS test_id,
        'MASTER DATA' AS test_type,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        CASE WHEN COUNT(*) >= 1 THEN 'ERROR' WHEN COUNT(*) < 1 THEN 'OK' ELSE NULL END AS test_status,
        COUNT(*) AS error_count,
        STRING_AGG(
            DISTINCT CAST(mandant_id AS STRING), ','
            ORDER BY
                CAST(mandant_id AS STRING)
        ) AS error_mandant_id,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_52`
);

INSERT INTO dbp_etl_process.mat_test_desc
(
    SELECT
        52 AS test_id,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        'ANZAHL_MARKT_WOCHEN_KOMBIS_ABVERKAUF_AF',
        CASE
            WHEN COUNT(*) >= 1
                THEN 'ANZAHL_MARKT_WOCHEN_KOMBIS_ABVERKAUF_AF <> ANZ_WO_MIT_ABSATZ_AF IN TUPEL_KW'
            WHEN COUNT(*) < 1
                THEN 'OK'
            ELSE NULL
        END AS description,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_52`
);

INSERT INTO dbp_etl_process.mat_test_detail
(
    SELECT
        52 AS test_id,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        mandant_id,
        'MATCHING_ID' AS key_name,
        matching_id AS key_value,
        'ANZAHL_MARKT_WOCHEN_KOMBIS_ABVERKAUF_AF',
        SUBSTR(CAST(anzahl_markt_wochen_kombis_abverkauf_af AS STRING), 1, 300) AS anzahl_markt_wochen_kombis_abverkauf_af,
        SUBSTR(CAST(anz_wo_mit_absatz_af AS STRING), 1, 300) AS anz_wo_mit_absatz_af,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_52`
);

CREATE OR REPLACE TEMPORARY TABLE _tupel_mat_test_53 AS
SELECT
    a.mandant_id,
    a.kjwo,
    a.matching_id,
    a.anzahl_markt_wochen_kombis_abverkauf_sa,
    b.anz_wo_mit_absatz_sa,
    ABS(a.anzahl_markt_wochen_kombis_abverkauf_sa - b.anz_wo_mit_absatz_sa) AS diff
FROM `_tupel_kw_2` AS a
INNER JOIN `_artbew_agg` AS b
    ON a.mandant_id = b.mandant_id AND a.matching_id = b.art_matching_id
WHERE
    ABS(a.anzahl_markt_wochen_kombis_abverkauf_sa - b.anz_wo_mit_absatz_sa) <> 0
ORDER BY
    diff DESC NULLS FIRST;

INSERT INTO dbp_etl_process.mat_test
(
    SELECT
        53 AS test_id,
        'MASTER DATA' AS test_type,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        CASE WHEN COUNT(*) >= 1 THEN 'ERROR' WHEN COUNT(*) < 1 THEN 'OK' ELSE NULL END AS test_status,
        COUNT(*) AS error_count,
        STRING_AGG(
            DISTINCT CAST(mandant_id AS STRING), ','
            ORDER BY
                CAST(mandant_id AS STRING)
        ) AS error_mandant_id,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_53`
);

INSERT INTO dbp_etl_process.mat_test_desc
(
    SELECT
        53 AS test_id,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        'ANZAHL_MARKT_WOCHEN_KOMBIS_ABVERKAUF_SA',
        CASE
            WHEN COUNT(*) >= 1
                THEN 'ANZAHL_MARKT_WOCHEN_KOMBIS_ABVERKAUF_SA <> ANZ_WO_MIT_ABSATZ_SA IN TUPEL_KW'
            WHEN COUNT(*) < 1
                THEN 'OK'
            ELSE NULL
        END AS description,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_53`
);

INSERT INTO dbp_etl_process.mat_test_detail
(
    SELECT
        53 AS test_id,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        mandant_id,
        'MATCHING_ID' AS key_name,
        matching_id AS key_value,
        'ANZAHL_MARKT_WOCHEN_KOMBIS_ABVERKAUF_SA',
        SUBSTR(CAST(anzahl_markt_wochen_kombis_abverkauf_sa AS STRING), 1, 300) AS anzahl_markt_wochen_kombis_abverkauf_sa,
        SUBSTR(CAST(anz_wo_mit_absatz_sa AS STRING), 1, 300) AS anz_wo_mit_absatz_sa,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_53`
);

/* KMO */
CREATE OR REPLACE TEMPORARY TABLE _artbew_vj AS
SELECT
    a.mandant_id,
    a.dat,
    a.wup_id,
    a.menge,
    a.art_id,
    a.bewart_id,
    c.art_matching_id
FROM dbp_data.artbew AS a
INNER JOIN dbp_data.tag AS b
    ON a.dat = b.dat
INNER JOIN (
    SELECT
        mandant_id,
        art_matching_id,
        art_id
    FROM `_art_matching_nielsen_per_kmo`
    WHERE
        art_id <> -1
    GROUP BY
        mandant_id,
        art_matching_id,
        art_id
) AS c
    ON a.art_id = c.art_id AND a.mandant_id = c.mandant_id
WHERE
    b.kjwo IN (
        SELECT kjwo
        FROM `_kw_woche_vj`
    ) AND a.mandant_id > 1;

/* DE */
INSERT INTO `_artbew_vj`
(
    SELECT
        a.mandant_id,
        a.dat,
        a.wup_id,
        CAST(a.menge * d.umrech_faktor AS NUMERIC) AS menge,
        a.art_id,
        a.bewart_id,
        c.art_matching_id
    FROM dbp_data.artbew AS a
    INNER JOIN dbp_data.tag AS b
        ON a.dat = b.dat
    INNER JOIN (
        SELECT
            mandant_id,
            art_matching_id,
            art_id
        FROM `_art_matching_nielsen_per`
        WHERE
            art_id <> -1
        GROUP BY
            mandant_id,
            art_matching_id,
            art_id
    ) AS c
        ON a.art_id = c.art_id AND a.mandant_id = c.mandant_id
    INNER JOIN (
        SELECT
            mandant_id,
            art_id,
            MAX(umrech_faktor) AS umrech_faktor
        FROM dbp_etl.art_matching_nielsen_per_de_xxx
        WHERE
            mandant_id = 1 AND art_id <> -1
        GROUP BY
            mandant_id,
            art_id
    ) AS d
        ON a.art_id = d.art_id AND a.mandant_id = d.mandant_id
    WHERE
        b.kjwo = (
            SELECT kjwo
            FROM `_kw_woche_vj`
        ) AND a.mandant_id = 1
);

CREATE OR REPLACE TEMPORARY TABLE _artbew_sum_vj AS
SELECT
    mandant_id,
    dat,
    wup_id,
    art_matching_id,
    CASE WHEN IFNULL(SUM(menge), 0) > 0 THEN 1 ELSE 0 END AS anz_wo_mit_absatz,
    CASE
        WHEN IFNULL(SUM(CASE WHEN bewart_id = 1001 THEN menge ELSE NULL END), 0) > 0
            THEN 1
        ELSE 0
    END AS anz_wo_mit_absatz_af,
    CASE
        WHEN IFNULL(SUM(CASE WHEN bewart_id = 1002 THEN menge ELSE NULL END), 0) > 0
            THEN 1
        ELSE 0
    END AS anz_wo_mit_absatz_sa
FROM `_artbew_vj`
GROUP BY
    mandant_id,
    dat,
    wup_id,
    art_matching_id;

CREATE OR REPLACE TEMPORARY TABLE _artbew_agg_vj AS
SELECT
    mandant_id,
    art_matching_id,
    CAST(SUM(anz_wo_mit_absatz) / 7 AS INTEGER) AS anz_wo_mit_absatz,
    CAST(SUM(anz_wo_mit_absatz_af) / 7 AS INTEGER) AS anz_wo_mit_absatz_af,
    CAST(SUM(anz_wo_mit_absatz_sa) / 7 AS INTEGER) AS anz_wo_mit_absatz_sa
FROM `_artbew_sum_vj`
GROUP BY
    mandant_id,
    art_matching_id;

CREATE OR REPLACE TEMPORARY TABLE _tupel_kw_2_vj AS
SELECT DISTINCT
    mandant_id,
    kjwo,
    matching_id,
    anzahl_markt_wochen_kombis_abverkauf_af_vj,
    anzahl_markt_wochen_kombis_abverkauf_sa_vj
FROM dbp_data.tupel_kw
WHERE
    kjwo IN (
        SELECT kjwo
        FROM `_kw_woche`
    );

CREATE OR REPLACE TEMPORARY TABLE _tupel_mat_test_54 AS
SELECT
    a.mandant_id,
    a.kjwo,
    a.matching_id,
    a.anzahl_markt_wochen_kombis_abverkauf_af_vj,
    b.anz_wo_mit_absatz_af,
    ABS(a.anzahl_markt_wochen_kombis_abverkauf_af_vj - b.anz_wo_mit_absatz_af) AS diff
FROM `_tupel_kw_2_vj` AS a
INNER JOIN `_artbew_agg_vj` AS b
    ON a.mandant_id = b.mandant_id AND a.matching_id = b.art_matching_id
WHERE
    ABS(a.anzahl_markt_wochen_kombis_abverkauf_af_vj - b.anz_wo_mit_absatz_af) <> 0
ORDER BY
    diff DESC NULLS FIRST;

INSERT INTO dbp_etl_process.mat_test
(
    SELECT
        54 AS test_id,
        'MASTER DATA' AS test_type,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        CASE WHEN COUNT(*) >= 1 THEN 'ERROR' WHEN COUNT(*) < 1 THEN 'OK' ELSE NULL END AS test_status,
        COUNT(*) AS error_count,
        STRING_AGG(
            DISTINCT CAST(mandant_id AS STRING), ','
            ORDER BY
                CAST(mandant_id AS STRING)
        ) AS error_mandant_id,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_54`
);

INSERT INTO dbp_etl_process.mat_test_desc
(
    SELECT
        54 AS test_id,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        'ANZAHL_MARKT_WOCHEN_KOMBIS_ABVERKAUF_AF_VJ',
        CASE
            WHEN COUNT(*) >= 1
                THEN 'ANZAHL_MARKT_WOCHEN_KOMBIS_ABVERKAUF_AF_VJ <> ANZ_WO_MIT_ABSATZ_AF IN TUPEL_KW'
            WHEN COUNT(*) < 1
                THEN 'OK'
            ELSE NULL
        END AS description,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_54`
);

INSERT INTO dbp_etl_process.mat_test_detail
(
    SELECT
        54 AS test_id,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        mandant_id,
        'MATCHING_ID' AS key_name,
        matching_id AS key_value,
        'ANZAHL_MARKT_WOCHEN_KOMBIS_ABVERKAUF_AF_VJ',
        SUBSTR(CAST(anzahl_markt_wochen_kombis_abverkauf_af_vj AS STRING), 1, 300) AS anzahl_markt_wochen_kombis_abverkauf_af_vj,
        SUBSTR(CAST(anz_wo_mit_absatz_af AS STRING), 1, 300) AS anz_wo_mit_absatz_af,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_54`
);

CREATE OR REPLACE TEMPORARY TABLE _tupel_mat_test_55 AS
SELECT
    a.mandant_id,
    a.kjwo,
    a.matching_id,
    a.anzahl_markt_wochen_kombis_abverkauf_sa_vj,
    b.anz_wo_mit_absatz_sa,
    ABS(a.anzahl_markt_wochen_kombis_abverkauf_sa_vj - b.anz_wo_mit_absatz_sa) AS diff
FROM `_tupel_kw_2_vj` AS a
INNER JOIN `_artbew_agg_vj` AS b
    ON a.mandant_id = b.mandant_id AND a.matching_id = b.art_matching_id
WHERE
    ABS(a.anzahl_markt_wochen_kombis_abverkauf_sa_vj - b.anz_wo_mit_absatz_sa) <> 0
ORDER BY
    diff DESC NULLS FIRST;

INSERT INTO dbp_etl_process.mat_test
(
    SELECT
        55 AS test_id,
        'MASTER DATA' AS test_type,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        CASE WHEN COUNT(*) >= 1 THEN 'ERROR' WHEN COUNT(*) < 1 THEN 'OK' ELSE NULL END AS test_status,
        COUNT(*) AS error_count,
        STRING_AGG(
            DISTINCT CAST(mandant_id AS STRING), ','
            ORDER BY
                CAST(mandant_id AS STRING)
        ) AS error_mandant_id,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_55`
);

INSERT INTO dbp_etl_process.mat_test_desc
(
    SELECT
        55 AS test_id,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        'ANZAHL_MARKT_WOCHEN_KOMBIS_ABVERKAUF_SA_VJ',
        CASE
            WHEN COUNT(*) >= 1
                THEN 'ANZAHL_MARKT_WOCHEN_KOMBIS_ABVERKAUF_SA_VJ <> ANZ_WO_MIT_ABSATZ_SA IN TUPEL_KW'
            WHEN COUNT(*) < 1
                THEN 'OK'
            ELSE NULL
        END AS description,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_55`
);

INSERT INTO dbp_etl_process.mat_test_detail
(
    SELECT
        55 AS test_id,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        mandant_id,
        'MATCHING_ID' AS key_name,
        matching_id AS key_value,
        'ANZAHL_MARKT_WOCHEN_KOMBIS_ABVERKAUF_SA_VJ',
        SUBSTR(CAST(anzahl_markt_wochen_kombis_abverkauf_sa_vj AS STRING), 1, 300) AS anzahl_markt_wochen_kombis_abverkauf_sa_vj,
        SUBSTR(CAST(anz_wo_mit_absatz_sa AS STRING), 1, 300) AS anz_wo_mit_absatz_sa,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_55`
);

/* KMO */
CREATE OR REPLACE TEMPORARY TABLE _listung AS
SELECT
    a.kjwo,
    b.art_matching_id AS matching_id,
    a.mandant_id,
    a.wup_id,
    COUNT(DISTINCT a.kjwo) AS anz_wo_listung
FROM (
    SELECT
        v01.mandant_id,
        v01.art_id,
        v01.wup_id,
        v02.kjwo
    FROM (
        SELECT
            mandant_id,
            art_id,
            wup_id,
            nb_id,
            dat_von,
            dat_bis,
            listung_id
        FROM dbp_data.art_wup_zu_per
        WHERE
            listung_id = 1
            AND dat_bis >= (
                SELECT MIN(dat)
                FROM dbp_data.tag
                WHERE
                    kjwo = (
                        SELECT kjwo
                        FROM `_kw_woche`
                    )
            )
    ) AS v01
    INNER JOIN dbp_data.tag AS v02
        ON v02.dat BETWEEN v01.dat_von AND v01.dat_bis
    WHERE
        v02.kjwo IN (
            SELECT kjwo
            FROM `_kw_woche`
        ) AND v01.mandant_id > 1
    GROUP BY
        v01.mandant_id,
        v01.art_id,
        v01.wup_id,
        v02.kjwo
) AS a
INNER JOIN (
    SELECT
        mandant_id,
        art_matching_id,
        art_id
    FROM `_art_matching_nielsen_per_kmo`
    WHERE
        art_id <> -1
    GROUP BY
        mandant_id,
        art_matching_id,
        art_id
) AS b
    ON a.art_id = b.art_id AND a.mandant_id = b.mandant_id
GROUP BY
    a.kjwo,
    matching_id,
    a.mandant_id,
    a.wup_id;

/* DE */
INSERT INTO `_listung`
(
    SELECT
        a.kjwo,
        b.art_matching_id AS matching_id,
        a.mandant_id,
        a.wup_id,
        COUNT(DISTINCT a.kjwo) AS anz_wo_listung
    FROM (
        SELECT
            v01.mandant_id,
            v01.art_id,
            v01.wup_id,
            v02.kjwo
        FROM (
            SELECT
                mandant_id,
                art_id,
                wup_id,
                nb_id,
                dat_von,
                dat_bis,
                listung_id
            FROM dbp_data.art_wup_zu_per
            WHERE
                listung_id = 1
                AND dat_bis >= (
                    SELECT MIN(dat)
                    FROM dbp_data.tag
                    WHERE
                        kjwo = (
                            SELECT kjwo
                            FROM `_kw_woche`
                        )
                )
        ) AS v01
        INNER JOIN dbp_data.tag AS v02
            ON v02.dat BETWEEN v01.dat_von AND v01.dat_bis
        WHERE
            v02.kjwo IN (
                SELECT kjwo
                FROM `_kw_woche`
            ) AND v01.mandant_id = 1
        GROUP BY
            v01.mandant_id,
            v01.art_id,
            v01.wup_id,
            v02.kjwo
    ) AS a
    INNER JOIN (
        SELECT
            mandant_id,
            art_matching_id,
            art_id
        FROM dbp_etl.art_matching_nielsen_per_de_xxx
        WHERE
            art_id <> -1
        GROUP BY
            mandant_id,
            art_matching_id,
            art_id
    ) AS b
        ON a.art_id = b.art_id AND a.mandant_id = b.mandant_id
    GROUP BY
        a.kjwo,
        matching_id,
        a.mandant_id,
        a.wup_id
);

CREATE OR REPLACE TEMPORARY TABLE _listung_agg AS
SELECT
    mandant_id,
    matching_id,
    SUM(anz_wo_listung) AS anz_wo_listung
FROM `_listung`
GROUP BY
    mandant_id,
    matching_id;

CREATE OR REPLACE TEMPORARY TABLE _tupel_kw_3 AS
SELECT DISTINCT
    mandant_id,
    kjwo,
    matching_id,
    anzahl_markt_wochen_kombis_listung
FROM dbp_data.tupel_kw
WHERE
    kjwo IN (
        SELECT kjwo
        FROM `_kw_woche`
    );

CREATE OR REPLACE TEMPORARY TABLE _tupel_mat_test_56 AS
SELECT
    a.mandant_id,
    a.kjwo,
    a.matching_id,
    a.anzahl_markt_wochen_kombis_listung,
    b.anz_wo_listung,
    ABS(a.anzahl_markt_wochen_kombis_listung - b.anz_wo_listung) AS diff
FROM `_tupel_kw_3` AS a
INNER JOIN `_listung_agg` AS b
    ON a.mandant_id = b.mandant_id AND a.matching_id = b.matching_id
WHERE
    ABS(a.anzahl_markt_wochen_kombis_listung - b.anz_wo_listung) <> 0
ORDER BY
    diff DESC NULLS FIRST;

INSERT INTO dbp_etl_process.mat_test
(
    SELECT
        56 AS test_id,
        'MASTER DATA' AS test_type,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        CASE WHEN COUNT(*) >= 1 THEN 'ERROR' WHEN COUNT(*) < 1 THEN 'OK' ELSE NULL END AS test_status,
        COUNT(*) AS error_count,
        STRING_AGG(
            DISTINCT CAST(mandant_id AS STRING), ','
            ORDER BY
                CAST(mandant_id AS STRING)
        ) AS error_mandant_id,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_56`
);

INSERT INTO dbp_etl_process.mat_test_desc
(
    SELECT
        56 AS test_id,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        'ANZAHL_MARKT_WOCHEN_KOMBIS_LISTUNG',
        CASE
            WHEN COUNT(*) >= 1
                THEN 'ANZAHL_MARKT_WOCHEN_KOMBIS_LISTUNG <> ANZ_WO_LISTUNG IN TUPEL_KW'
            WHEN COUNT(*) < 1
                THEN 'OK'
            ELSE NULL
        END AS description,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_56`
);

INSERT INTO dbp_etl_process.mat_test_detail
(
    SELECT
        56 AS test_id,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        mandant_id,
        'MATCHING_ID' AS key_name,
        matching_id AS key_value,
        'ANZAHL_MARKT_WOCHEN_KOMBIS_LISTUNG',
        SUBSTR(CAST(anzahl_markt_wochen_kombis_listung AS STRING), 1, 300) AS anzahl_markt_wochen_kombis_listung,
        SUBSTR(CAST(anz_wo_listung AS STRING), 1, 300) AS anz_wo_listung,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_56`
);

/* KMO */
CREATE OR REPLACE TEMPORARY TABLE _rohertrag AS
SELECT
    a.mandant_id,
    c.art_matching_id,
    IFNULL(SUM(a.umsatz_netto), 0) - IFNULL(SUM(a.einstandspreis), 0) AS rohertrag_ekmep_olk_4n,
    IFNULL(SUM(CASE WHEN a.bewart_id = 1001 THEN a.umsatz_netto ELSE NULL END), 0) - IFNULL(SUM(CASE WHEN a.bewart_id = 1001 THEN a.einstandspreis ELSE NULL END), 0) AS rohertrag_ekmep_olk_4n_af,
    IFNULL(SUM(CASE WHEN a.bewart_id = 1002 THEN a.umsatz_netto ELSE NULL END), 0) - IFNULL(SUM(CASE WHEN a.bewart_id = 1002 THEN a.einstandspreis ELSE NULL END), 0) AS rohertrag_ekmep_olk_4n_sa
FROM dbp_data.artbew AS a
INNER JOIN dbp_data.tag AS b
    ON a.dat = b.dat
INNER JOIN (
    SELECT
        mandant_id,
        art_matching_id,
        art_id
    FROM `_art_matching_nielsen_per_kmo`
    WHERE
        art_id <> -1
    GROUP BY
        mandant_id,
        art_matching_id,
        art_id
) AS c
    ON a.art_id = c.art_id AND a.mandant_id = c.mandant_id
WHERE
    b.kjwo = (
        SELECT kjwo
        FROM `_kw_woche`
    ) AND a.mandant_id > 1
GROUP BY
    a.mandant_id,
    c.art_matching_id;

/* DE */
INSERT INTO `_rohertrag`
(
    SELECT
        a.mandant_id,
        c.art_matching_id,
        IFNULL(SUM(a.umsatz_netto), 0) - IFNULL(SUM(a.ek_mep - a.logkostenzuschlag), 0) AS rohertrag_ekmep_olk_4n,
        IFNULL(SUM(CASE WHEN a.bewart_id = 1001 THEN a.umsatz_netto ELSE NULL END), 0) - IFNULL(
            SUM(CASE WHEN a.bewart_id = 1001 THEN a.ek_mep - a.logkostenzuschlag ELSE NULL END),
            0
        ) AS rohertrag_ekmep_olk_4n_af,
        IFNULL(SUM(CASE WHEN a.bewart_id = 1002 THEN a.umsatz_netto ELSE NULL END), 0) - IFNULL(
            SUM(CASE WHEN a.bewart_id = 1002 THEN a.ek_mep - a.logkostenzuschlag ELSE NULL END),
            0
        ) AS rohertrag_ekmep_olk_4n_sa
    FROM dbp_data.artbew AS a
    INNER JOIN dbp_data.tag AS b
        ON a.dat = b.dat
    INNER JOIN (
        SELECT
            mandant_id,
            art_matching_id,
            art_id
        FROM `_art_matching_nielsen_per`
        WHERE
            art_id <> -1
        GROUP BY
            mandant_id,
            art_matching_id,
            art_id
    ) AS c
        ON a.art_id = c.art_id AND a.mandant_id = c.mandant_id
    WHERE
        b.kjwo = (
            SELECT kjwo
            FROM `_kw_woche`
        ) AND a.mandant_id = 1
    GROUP BY
        a.mandant_id,
        c.art_matching_id
);

CREATE OR REPLACE TEMPORARY TABLE _tupel_kw_3 AS
SELECT DISTINCT
    mandant_id,
    kjwo,
    matching_id,
    rohertrag_ekmep_olk_4n,
    rohertrag_ekmep_olk_4n_af,
    rohertrag_ekmep_olk_4n_sa
FROM dbp_data.tupel_kw
WHERE
    kjwo IN (
        SELECT kjwo
        FROM `_kw_woche`
    );

CREATE OR REPLACE TEMPORARY TABLE _tupel_mat_test_57 AS
SELECT
    a.mandant_id,
    a.kjwo,
    a.matching_id,
    a.rohertrag_ekmep_olk_4n,
    b.rohertrag_ekmep_olk_4n AS rohertrag_ekmep_olk_4n_art,
    ABS(a.rohertrag_ekmep_olk_4n - b.rohertrag_ekmep_olk_4n) AS diff
FROM `_tupel_kw_3` AS a
INNER JOIN `_rohertrag` AS b
    ON a.mandant_id = b.mandant_id AND a.matching_id = b.art_matching_id
WHERE
    ABS(a.rohertrag_ekmep_olk_4n - b.rohertrag_ekmep_olk_4n) <> 0
ORDER BY
    diff DESC NULLS FIRST;

INSERT INTO dbp_etl_process.mat_test
(
    SELECT
        57 AS test_id,
        'MASTER DATA' AS test_type,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        CASE WHEN COUNT(*) >= 1 THEN 'ERROR' WHEN COUNT(*) < 1 THEN 'OK' ELSE NULL END AS test_status,
        COUNT(*) AS error_count,
        STRING_AGG(
            DISTINCT CAST(mandant_id AS STRING), ','
            ORDER BY
                CAST(mandant_id AS STRING)
        ) AS error_mandant_id,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_57`
);

INSERT INTO dbp_etl_process.mat_test_desc
(
    SELECT
        57 AS test_id,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        'ROHERTRAG_EKMEP_OLK_4N',
        CASE
            WHEN COUNT(*) >= 1
                THEN 'ROHERTRAG_EKMEP_OLK_4N <> ROHERTRAG_EKMEP_OLK_4N_ART IN TUPEL_KW'
            WHEN COUNT(*) < 1
                THEN 'OK'
            ELSE NULL
        END AS description,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_57`
);

INSERT INTO dbp_etl_process.mat_test_detail
(
    SELECT
        57 AS test_id,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        mandant_id,
        'MATCHING_ID' AS key_name,
        matching_id AS key_value,
        'ROHERTRAG_EKMEP_OLK_4N',
        SUBSTR(CAST(rohertrag_ekmep_olk_4n AS STRING), 1, 300) AS rohertrag_ekmep_olk_4n,
        SUBSTR(CAST(rohertrag_ekmep_olk_4n_art AS STRING), 1, 300) AS rohertrag_ekmep_olk_4n_art,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_57`
);

CREATE OR REPLACE TEMPORARY TABLE _tupel_mat_test_58 AS
SELECT
    a.mandant_id,
    a.kjwo,
    a.matching_id,
    a.rohertrag_ekmep_olk_4n_af,
    b.rohertrag_ekmep_olk_4n_af AS rohertrag_ekmep_olk_4n_af_art,
    ABS(a.rohertrag_ekmep_olk_4n_af - b.rohertrag_ekmep_olk_4n_af) AS diff
FROM `_tupel_kw_3` AS a
INNER JOIN `_rohertrag` AS b
    ON a.mandant_id = b.mandant_id AND a.matching_id = b.art_matching_id
WHERE
    ABS(a.rohertrag_ekmep_olk_4n_af - b.rohertrag_ekmep_olk_4n_af) <> 0
ORDER BY
    diff DESC NULLS FIRST;

INSERT INTO dbp_etl_process.mat_test
(
    SELECT
        58 AS test_id,
        'MASTER DATA' AS test_type,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        CASE WHEN COUNT(*) >= 1 THEN 'ERROR' WHEN COUNT(*) < 1 THEN 'OK' ELSE NULL END AS test_status,
        COUNT(*) AS error_count,
        STRING_AGG(
            DISTINCT CAST(mandant_id AS STRING), ','
            ORDER BY
                CAST(mandant_id AS STRING)
        ) AS error_mandant_id,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_58`
);

INSERT INTO dbp_etl_process.mat_test_desc
(
    SELECT
        58 AS test_id,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        'ROHERTRAG_EKMEP_OLK_4N_AF',
        CASE
            WHEN COUNT(*) >= 1
                THEN 'ROHERTRAG_EKMEP_OLK_4N_AF <> ROHERTRAG_EKMEP_OLK_4N_AF_ART IN TUPEL_KW'
            WHEN COUNT(*) < 1
                THEN 'OK'
            ELSE NULL
        END AS description,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_58`
);

INSERT INTO dbp_etl_process.mat_test_detail
(
    SELECT
        58 AS test_id,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        mandant_id,
        'MATCHING_ID' AS key_name,
        matching_id AS key_value,
        'ROHERTRAG_EKMEP_OLK_4N_AF',
        SUBSTR(CAST(rohertrag_ekmep_olk_4n_af AS STRING), 1, 300) AS rohertrag_ekmep_olk_4n_af,
        SUBSTR(CAST(rohertrag_ekmep_olk_4n_af_art AS STRING), 1, 300) AS rohertrag_ekmep_olk_4n_af_art,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_58`
);

CREATE OR REPLACE TEMPORARY TABLE _tupel_mat_test_59 AS
SELECT
    a.mandant_id,
    a.kjwo,
    a.matching_id,
    a.rohertrag_ekmep_olk_4n_sa,
    b.rohertrag_ekmep_olk_4n_sa AS rohertrag_ekmep_olk_4n_sa_art,
    ABS(a.rohertrag_ekmep_olk_4n_sa - b.rohertrag_ekmep_olk_4n_sa) AS diff
FROM `_tupel_kw_3` AS a
INNER JOIN `_rohertrag` AS b
    ON a.mandant_id = b.mandant_id AND a.matching_id = b.art_matching_id
WHERE
    ABS(a.rohertrag_ekmep_olk_4n_sa - b.rohertrag_ekmep_olk_4n_sa) <> 0
ORDER BY
    diff DESC NULLS FIRST;

INSERT INTO dbp_etl_process.mat_test
(
    SELECT
        59 AS test_id,
        'MASTER DATA' AS test_type,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        CASE WHEN COUNT(*) >= 1 THEN 'ERROR' WHEN COUNT(*) < 1 THEN 'OK' ELSE NULL END AS test_status,
        COUNT(*) AS error_count,
        STRING_AGG(
            DISTINCT CAST(mandant_id AS STRING), ','
            ORDER BY
                CAST(mandant_id AS STRING)
        ) AS error_mandant_id,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_59`
);

INSERT INTO dbp_etl_process.mat_test_desc
(
    SELECT
        59 AS test_id,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        'ROHERTRAG_EKMEP_OLK_4N_SA',
        CASE
            WHEN COUNT(*) >= 1
                THEN 'ROHERTRAG_EKMEP_OLK_4N_SA <> ROHERTRAG_EKMEP_OLK_4N_SA_ART IN TUPEL_KW'
            WHEN COUNT(*) < 1
                THEN 'OK'
            ELSE NULL
        END AS description,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_59`
);

INSERT INTO dbp_etl_process.mat_test_detail
(
    SELECT
        59 AS test_id,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        mandant_id,
        'MATCHING_ID' AS key_name,
        matching_id AS key_value,
        'ROHERTRAG_EKMEP_OLK_4N_SA',
        SUBSTR(CAST(rohertrag_ekmep_olk_4n_sa AS STRING), 1, 300) AS rohertrag_ekmep_olk_4n_sa,
        SUBSTR(CAST(rohertrag_ekmep_olk_4n_sa_art AS STRING), 1, 300) AS rohertrag_ekmep_olk_4n_sa_art,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_59`
);

CREATE OR REPLACE TEMPORARY TABLE _tupel_mat_test_60 AS
SELECT
    mandant_id,
    a7_wg_id,
    a376_kl_marktanteil_wg_nielsen,
    DENSE_RANK() OVER (
        PARTITION BY mandant_id, a7_wg_id
        ORDER BY a376_kl_marktanteil_wg_nielsen IS NULL DESC, a376_kl_marktanteil_wg_nielsen DESC
    ) AS rank
FROM dbp_etl_process.tupel_mat_etl
WHERE
    NOT a35_umsatz_nielsen IS NULL
    AND (mandant_id, a500_kjwo_update) IN (
        SELECT (mandant_id, kjwo)
        FROM `_week`
    )
GROUP BY
    mandant_id,
    a7_wg_id,
    a376_kl_marktanteil_wg_nielsen
QUALIFY
    (
        DENSE_RANK() OVER (
            PARTITION BY mandant_id, a7_wg_id
            ORDER BY a376_kl_marktanteil_wg_nielsen IS NULL DESC, a376_kl_marktanteil_wg_nielsen DESC
        )
    ) > 2;

INSERT INTO dbp_etl_process.mat_test
(
    SELECT
        60 AS test_id,
        'TUPEL' AS test_type,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        CASE WHEN COUNT(*) >= 1 THEN 'ERROR' WHEN COUNT(*) < 1 THEN 'OK' ELSE NULL END AS test_status,
        COUNT(*) AS error_count,
        STRING_AGG(
            DISTINCT CAST(mandant_id AS STRING), ','
            ORDER BY
                CAST(mandant_id AS STRING)
        ) AS error_mandant_id,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_60`
);

INSERT INTO dbp_etl_process.mat_test_desc
(
    SELECT
        60 AS test_id,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        'A376_KL_MARKTANTEIL_WG_NIELSEN',
        CASE
            WHEN COUNT(*) >= 1
                THEN 'A376_KL_MARKTANTEIL_WG_NIELSEN HAS MORE THEN 1 VALUE PER A7_WG_ID'
            WHEN COUNT(*) < 1
                THEN 'OK'
            ELSE NULL
        END AS description,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_60`
);

INSERT INTO dbp_etl_process.mat_test_detail
(
    SELECT
        60 AS test_id,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        mandant_id,
        'A7_WG_ID' AS key_name,
        a7_wg_id AS key_value,
        'A376_KL_MARKTANTEIL_WG_NIELSEN',
        SUBSTR(CAST(a376_kl_marktanteil_wg_nielsen AS STRING), 1, 300) AS a376_kl_marktanteil_wg_nielsen,
        'A376_KL_MARKTANTEIL_WG_NIELSEN SHOULD HAVE ONLY 1 VALUE PER A7_WG_ID',
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_60`
);

CREATE OR REPLACE TEMPORARY TABLE _tupel_mat_test_61 AS
SELECT
    mandant_id,
    matching_id,
    a450_art_nielsen_nr
FROM dbp_etl_process.tupel_mat_etl
WHERE
    art_id IS NULL
    AND a450_art_nielsen_nr IS NULL
    AND (mandant_id, a500_kjwo_update) IN (
        SELECT (mandant_id, kjwo)
        FROM `_week`
    )
GROUP BY
    mandant_id,
    matching_id,
    a450_art_nielsen_nr;

INSERT INTO dbp_etl_process.mat_test
(
    SELECT
        61 AS test_id,
        'TUPEL' AS test_type,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        CASE WHEN COUNT(*) >= 1 THEN 'ERROR' WHEN COUNT(*) < 1 THEN 'OK' ELSE NULL END AS test_status,
        COUNT(*) AS error_count,
        STRING_AGG(
            DISTINCT CAST(mandant_id AS STRING), ','
            ORDER BY
                CAST(mandant_id AS STRING)
        ) AS error_mandant_id,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_61`
);

INSERT INTO dbp_etl_process.mat_test_desc
(
    SELECT
        61 AS test_id,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        'A450_ART_NIELSEN_NR AND ART_ID',
        CASE
            WHEN COUNT(*) >= 1
                THEN 'A450_ART_NIELSEN_NR AND ART_ID ARE EQUAL NULL'
            WHEN COUNT(*) < 1
                THEN 'OK'
            ELSE NULL
        END AS description,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_61`
);

INSERT INTO dbp_etl_process.mat_test_detail
(
    SELECT
        61 AS test_id,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        mandant_id,
        'MATCHING_ID' AS key_name,
        matching_id AS key_value,
        'A450_ART_NIELSEN_NR',
        SUBSTR(CAST(a450_art_nielsen_nr AS STRING), 1, 300) AS a450_art_nielsen_nr,
        'A450_ART_NIELSEN_NR OR ART_ID SHOULD HAVE A VALUE',
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_61`
);

CREATE OR REPLACE TEMPORARY TABLE _tupel_mat_test_62 AS
SELECT
    mandant_id,
    matching_id,
    a446_lieferant_bez_latein
FROM dbp_etl_process.tupel_mat_etl
WHERE
    a446_lieferant_bez_latein IS NULL
    AND (mandant_id, a500_kjwo_update) IN (
        SELECT (mandant_id, kjwo)
        FROM `_week`
    )
GROUP BY
    mandant_id,
    matching_id,
    a446_lieferant_bez_latein;

INSERT INTO dbp_etl_process.mat_test
(
    SELECT
        62 AS test_id,
        'TUPEL' AS test_type,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        CASE WHEN COUNT(*) >= 1 THEN 'ERROR' WHEN COUNT(*) < 1 THEN 'OK' ELSE NULL END AS test_status,
        COUNT(*) AS error_count,
        STRING_AGG(
            DISTINCT CAST(mandant_id AS STRING), ','
            ORDER BY
                CAST(mandant_id AS STRING)
        ) AS error_mandant_id,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_62`
);

INSERT INTO dbp_etl_process.mat_test_desc
(
    SELECT
        62 AS test_id,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        'A446_LIEFERANT_BEZ_LATEIN',
        CASE
            WHEN COUNT(*) >= 1
                THEN 'A446_LIEFERANT_BEZ_LATEIN IS NULL'
            WHEN COUNT(*) < 1
                THEN 'OK'
            ELSE NULL
        END AS description,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_62`
);

INSERT INTO dbp_etl_process.mat_test_detail
(
    SELECT
        62 AS test_id,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        mandant_id,
        'MATCHING_ID' AS key_name,
        matching_id AS key_value,
        'A446_LIEFERANT_BEZ_LATEIN',
        a446_lieferant_bez_latein,
        'A446_LIEFERANT_BEZ_LATEIN SHOULD HAVE A VALUE',
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_62`
);

CREATE OR REPLACE TEMPORARY TABLE _tupel_mat_test_63 AS
SELECT
    mandant_id,
    matching_id,
    a16_akt_lieferant_id
FROM dbp_etl_process.tupel_mat_etl
WHERE
    NOT art_id IS NULL
    AND a16_akt_lieferant_id IS NULL
    AND (mandant_id, a500_kjwo_update) IN (
        SELECT (mandant_id, kjwo)
        FROM `_week`
    )
GROUP BY
    mandant_id,
    matching_id,
    a16_akt_lieferant_id;

INSERT INTO dbp_etl_process.mat_test
(
    SELECT
        63 AS test_id,
        'TUPEL' AS test_type,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        CASE WHEN COUNT(*) >= 1 THEN 'ERROR' WHEN COUNT(*) < 1 THEN 'OK' ELSE NULL END AS test_status,
        COUNT(*) AS error_count,
        STRING_AGG(
            DISTINCT CAST(mandant_id AS STRING), ','
            ORDER BY
                CAST(mandant_id AS STRING)
        ) AS error_mandant_id,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_63`
);

INSERT INTO dbp_etl_process.mat_test_desc
(
    SELECT
        63 AS test_id,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        'A16_AKT_LIEFERANT_ID',
        CASE
            WHEN COUNT(*) >= 1
                THEN 'A16_AKT_LIEFERANT_ID IS NULL'
            WHEN COUNT(*) < 1
                THEN 'OK'
            ELSE NULL
        END AS description,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_63`
);

INSERT INTO dbp_etl_process.mat_test_detail
(
    SELECT
        63 AS test_id,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        mandant_id,
        'MATCHING_ID' AS key_name,
        matching_id AS key_value,
        'A16_AKT_LIEFERANT_ID',
        a16_akt_lieferant_id,
        'A16_AKT_LIEFERANT_ID SHOULD HAVE A VALUE',
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_63`
);

CREATE OR REPLACE TEMPORARY TABLE _tupel_mat_test_64 AS
SELECT
    mandant_id,
    art_matching_id AS matching_id,
    art_id
FROM `_art_matching_nielsen_per`
WHERE
    (mandant_id, art_id) IN (
        SELECT (mandant_id, art_id)
        FROM dbp_data.art_gp_zu_per
        WHERE
            mandant_id = 1 AND gp_id = 5059720 AND dat_bis = CAST('9999-12-31' AS DATE)
        GROUP BY
            mandant_id,
        art_id
    );

INSERT INTO dbp_etl_process.mat_test
(
    SELECT
        64 AS test_id,
        'TUPEL' AS test_type,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        CASE WHEN COUNT(*) >= 1 THEN 'ERROR' WHEN COUNT(*) < 1 THEN 'OK' ELSE NULL END AS test_status,
        COUNT(*) AS error_count,
        STRING_AGG(
            DISTINCT CAST(mandant_id AS STRING), ','
            ORDER BY
                CAST(mandant_id AS STRING)
        ) AS error_mandant_id,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_64`
);

INSERT INTO dbp_etl_process.mat_test_desc
(
    SELECT
        64 AS test_id,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        'ART_ID',
        CASE
            WHEN COUNT(*) >= 1
                THEN 'ART_ID WITH GP_ID = 5059720'
            WHEN COUNT(*) < 1
                THEN 'OK'
            ELSE NULL
        END AS description,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_64`
);

INSERT INTO dbp_etl_process.mat_test_detail
(
    SELECT
        64 AS test_id,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        mandant_id,
        'MATCHING_ID' AS key_name,
        matching_id AS key_value,
        'ART_ID',
        SUBSTR(CAST(art_id AS STRING), 1, 300) AS art_id,
        'ART_ID WITH GP_ID = 5059720 SHOULD NOT BE LOADED',
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_64`
);

CREATE OR REPLACE TEMPORARY TABLE _tupel_mat_test_65 AS
SELECT
    mandant_id,
    matching_id
FROM dbp_etl_process.tupel_mat_etl
WHERE
    mandant_id = 1
    AND a500_kjwo_update = (
        SELECT MAX(kjwo)
        FROM `_week`
    )
    AND NOT matching_id IN (
        SELECT DISTINCT art_matching_id AS matching_id
        FROM `_art_matching_nielsen_per`
        WHERE
            kjwo_update IN (
                SELECT MAX(kjwo) AS a1886115246
                FROM `_week`
            )
    )
GROUP BY
    mandant_id,
    matching_id;

INSERT INTO dbp_etl_process.mat_test
(
    SELECT
        65 AS test_id,
        'TUPEL' AS test_type,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        CASE WHEN COUNT(*) >= 1 THEN 'ERROR' WHEN COUNT(*) < 1 THEN 'OK' ELSE NULL END AS test_status,
        COUNT(*) AS error_count,
        STRING_AGG(
            DISTINCT CAST(mandant_id AS STRING), ','
            ORDER BY
                CAST(mandant_id AS STRING)
        ) AS error_mandant_id,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_65`
);

INSERT INTO dbp_etl_process.mat_test_desc
(
    SELECT
        65 AS test_id,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        'MATCHING_ID',
        CASE
            WHEN COUNT(*) >= 1
                THEN 'matching_id does not exist in art_matching_nielsen_per'
            WHEN COUNT(*) < 1
                THEN 'OK'
            ELSE NULL
        END AS description,
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_65`
);

INSERT INTO dbp_etl_process.mat_test_detail
(
    SELECT
        65 AS test_id,
        (
            SELECT MAX(kjwo)
            FROM `_week`
        ) AS kjwo,
        mandant_id,
        'MATCHING_ID' AS key_name,
        matching_id AS key_value,
        'MATCHING_ID',
        SUBSTR(CAST(matching_id AS STRING), 1, 300) AS matching_id,
        'matching_id should exist in art_matching_nielsen_per',
        (
            SELECT run_cnt
            FROM `_run_cnt`
        ),
        CURRENT_DATE("Europe/Berlin"),
        CURRENT_TIME()
    FROM `_tupel_mat_test_65`
);
