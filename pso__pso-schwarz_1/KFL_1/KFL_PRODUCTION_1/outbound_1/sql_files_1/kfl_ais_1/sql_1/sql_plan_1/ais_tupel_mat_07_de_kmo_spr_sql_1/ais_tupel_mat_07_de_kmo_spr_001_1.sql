UPDATE dbp_etl_process.tupel_mat_etl_1 SET
    a61_muki_vk_kl_art_id_verkettung = NULL
WHERE a61_muki_vk_kl_art_id_verkettung = '-0.100000';


CREATE OR REPLACE TEMPORARY TABLE _art_nielsen AS
SELECT *
FROM dbp_data.art_nielsen_1
WHERE dat_bis = DATE '9999-12-31';


CREATE OR REPLACE TEMPORARY TABLE _tupel_bez1 AS
SELECT
    A.mandant_id,
    A.matching_id,
    A.a500_kjwo_update,
    B.spr_id,
    A.art_bez_deutsch AS tupel_bez
FROM dbp_etl_process.tupel_mat_etl_1 AS A
INNER JOIN dbp_data.mandant_spr_zu_1 AS B ON A.mandant_id = B.mandant_id
WHERE
    A.mandant_id > 1
    AND A.art_id IS NOT NULL
GROUP BY
    A.mandant_id,
    A.matching_id,
    A.a500_kjwo_update,
    B.spr_id,
    tupel_bez;


CREATE OR REPLACE TEMPORARY TABLE _tupel_bez2 AS
SELECT
    A.mandant_id,
    A.matching_id,
    A.a500_kjwo_update,
    B.spr_id,
    B.art_bez AS tupel_bez
FROM dbp_etl_process.tupel_mat_etl_1 AS A
INNER JOIN dbp_data.art_spr_zu_1 AS B
    ON
        A.mandant_id = B.mandant_id AND A.art_id = B.art_id AND B.spr_id
        = 22
WHERE
    A.mandant_id > 1
    AND A.art_id IS NOT NULL
GROUP BY
    A.mandant_id,
    A.matching_id,
    A.a500_kjwo_update,
    B.spr_id,
    tupel_bez;


TRUNCATE TABLE dbp_data.tupel_spr_zu_1;


INSERT INTO dbp_data.tupel_spr_zu_1
(SELECT
    mandant_id,
    matching_id,
    a500_kjwo_update,
    spr_id,
    tupel_bez,
    CURRENT_TIMESTAMP(),
    CURRENT_TIMESTAMP()
FROM ((
    SELECT *
    FROM `_tupel_bez1`
    WHERE tupel_bez IS NOT NULL
    UNION DISTINCT
    SELECT *
    FROM `_tupel_bez2`
    WHERE tupel_bez IS NOT NULL
)
UNION DISTINCT
SELECT
    A.mandant_id,
    A.matching_id,
    A.a500_kjwo_update,
    B.spr_id,
    A.art_bez_deutsch AS tupel_bez
FROM dbp_etl_process.tupel_mat_etl_1 AS A
INNER JOIN dbp_data.mandant_spr_zu_1 AS B ON A.mandant_id = B.mandant_id
    WHERE
        A.mandant_id = 1
        AND A.art_id IS NOT NULL
        AND A.art_bez_deutsch IS NOT NULL
    GROUP BY
        A.mandant_id,
        A.matching_id,
        A.a500_kjwo_update,
        B.spr_id,
        tupel_bez
) AS x);


CREATE OR REPLACE TEMPORARY TABLE _gp_bez1 AS
SELECT
    A.mandant_id,
    A.a500_kjwo_update,
    A.a16_akt_lieferant_id,
    B.spr_id,
    MAX(C.gp_name) AS akt_lieferant_bez
FROM dbp_etl_process.tupel_mat_etl_1 AS A
INNER JOIN dbp_data.gp_1 AS C
    ON
        A.mandant_id = C.mandant_id AND CAST(A.a16_akt_lieferant_id AS FLOAT64) =
        C.gp_id
INNER JOIN dbp_data.mandant_spr_zu_1 AS B ON A.mandant_id = B.mandant_id
WHERE
    A.mandant_id > 1
    AND A.art_id IS NOT NULL
GROUP BY
    A.mandant_id,
    A.a500_kjwo_update,
    A.a16_akt_lieferant_id,
    B.spr_id;


CREATE OR REPLACE TEMPORARY TABLE _gp_bez2 AS
SELECT
    mandant_id,
    a500_kjwo_update,
    a16_akt_lieferant_id,
    22 AS spr_id,
    MAX(dbp_etl_process.transcriptc(a446_lieferant_bez_latein)) AS akt_lieferant_bez --pe_review
FROM dbp_etl_process.tupel_mat_etl_1 AS A
WHERE
    mandant_id > 1
    AND art_id IS NOT NULL
GROUP BY
    mandant_id,
    a500_kjwo_update,
    a16_akt_lieferant_id,
    spr_id;


TRUNCATE TABLE dbp_data.sort_lieferant_spr_zu_1;


INSERT INTO dbp_data.sort_lieferant_spr_zu_1
(SELECT DISTINCT
    mandant_id,
    a500_kjwo_update,
    CAST(a16_akt_lieferant_id AS INTEGER) AS a16_akt_lieferant_id,
    spr_id,
    akt_lieferant_bez,
    CURRENT_TIMESTAMP(),
    CURRENT_TIMESTAMP()
FROM ((
    SELECT *
    FROM `_gp_bez1`
    WHERE
        akt_lieferant_bez IS NOT NULL
        AND CAST(a16_akt_lieferant_id AS INTEGER) NOT IN (-1, 9999)
        AND a16_akt_lieferant_id IS NOT NULL
    UNION DISTINCT
    SELECT *
    FROM `_gp_bez2`
    WHERE
        akt_lieferant_bez IS NOT NULL
        AND CAST(a16_akt_lieferant_id AS INTEGER) NOT IN (-1, 9999)
        AND a16_akt_lieferant_id IS NOT NULL
)
UNION DISTINCT
SELECT
    A.mandant_id,
    A.a500_kjwo_update,
    A.a16_akt_lieferant_id,
    B.spr_id,
    MAX(dbp_etl_process.transcriptc(A.a446_lieferant_bez_latein)) AS akt_lieferant_bez --pe_review
FROM dbp_etl_process.tupel_mat_etl_1 AS A
INNER JOIN dbp_data.mandant_spr_zu_1 AS B ON A.mandant_id = B.mandant_id
    WHERE
        A.mandant_id = 1
        AND CAST(A.a16_akt_lieferant_id AS INTEGER) NOT IN (-1, 9999)
        AND A.art_id IS NOT NULL
        AND A.a446_lieferant_bez_latein IS NOT NULL
        AND A.a16_akt_lieferant_id IS NOT NULL
    GROUP BY
        A.mandant_id,
        A.a500_kjwo_update,
        A.a16_akt_lieferant_id,
        B.spr_id
) AS x);


UPDATE dbp_etl_process.tupel_mat_etl_1 SET
    a446_lieferant_bez_latein = b.akt_lieferant_bez FROM (
    SELECT
        mandant_id,
        kjwo_update,
        akt_lieferant_id,
        MAX(akt_lieferant_bez) AS akt_lieferant_bez
    FROM dbp_data.sort_lieferant_spr_zu_1
    WHERE
        spr_id = 22
        AND mandant_id > 1
    GROUP BY
        mandant_id,
        kjwo_update,
        akt_lieferant_id
) AS b
WHERE tupel_mat_etl.mandant_id = b.mandant_id AND tupel_mat_etl.a500_kjwo_update = b.kjwo_update AND ROUND(
    CAST(tupel_mat_etl.a16_akt_lieferant_id AS BIGNUMERIC),
    0
) = b.akt_lieferant_id AND TRIM(tupel_mat_etl.a446_lieferant_bez_latein
) <> TRIM(b.akt_lieferant_bez
);


UPDATE dbp_etl_process.tupel_mat_etl_1 SET
    art_bez_deutsch = b.tupel_bez FROM (
    SELECT
        mandant_id,
        matching_id,
        kjwo_update,
        MAX(tupel_bez) AS tupel_bez
    FROM dbp_data.tupel_spr_zu_1
    WHERE
        spr_id = 22
        AND mandant_id > 1
    GROUP BY
        mandant_id,
        matching_id,
        kjwo_update
) AS b
WHERE
    tupel_mat_etl.mandant_id = b.mandant_id AND tupel_mat_etl.a500_kjwo_update = b.kjwo_update AND tupel_mat_etl.matching_id
    = b.matching_id AND TRIM(tupel_mat_etl.art_bez_deutsch) <> TRIM(b.tupel_bez);


UPDATE dbp_etl_process.tupel_mat_etl_1 SET
    a446_lieferant_bez_latein = b.gp_name FROM (
    SELECT
        A.mandant_id,
        A.a500_kjwo_update,
        A.matching_id,
        MAX(B.gp_name) AS gp_name
    FROM dbp_etl_process.tupel_mat_etl_1 AS A
    INNER JOIN dbp_data.gp_1 AS B
        ON
            A.mandant_id = B.mandant_id AND CAST(A.a16_akt_lieferant_id AS FLOAT64)
            = B.gp_id
    WHERE
        A.mandant_id > 1
        AND A.a500_kjwo_update IN (
            SELECT MAX(kjwo_update) AS a1290333724
            FROM dbp_data.sortiment_leistung_1
        )
        AND CAST(A.a16_akt_lieferant_id AS FLOAT64) > 0
    GROUP BY
        A.mandant_id,
        A.a500_kjwo_update,
        A.matching_id
) AS b
WHERE tupel_mat_etl.a500_kjwo_update = b.a500_kjwo_update AND tupel_mat_etl.mandant_id = b.mandant_id AND tupel_mat_etl.matching_id = b.matching_id;


CREATE OR REPLACE TEMPORARY TABLE _fix_it AS
SELECT
    A.mandant_id,
    A.matching_id,
    A.a500_kjwo_update,
    B.spr_id,
    B.art_bez AS tupel_bez
FROM dbp_etl_process.tupel_mat_etl_1 AS A
INNER JOIN dbp_data.mandant_spr_zu_1 AS X ON A.mandant_id = X.mandant_id
INNER JOIN dbp_data.art_spr_zu_1 AS B
    ON
        A.mandant_id = B.mandant_id AND A.art_id = B.art_id AND X.spr_id
        = B.spr_id
WHERE
    A.mandant_id > 1
    AND A.art_id IS NOT NULL
GROUP BY
    A.mandant_id,
    A.matching_id,
    A.a500_kjwo_update,
    B.spr_id,
    tupel_bez;


UPDATE dbp_data.tupel_spr_zu_1 SET
    tupel_bez = b.tupel_bez FROM (
    SELECT
        mandant_id,
        matching_id,
        a500_kjwo_update,
        spr_id,
        MAX(tupel_bez) AS tupel_bez
    FROM `_fix_it`
    GROUP BY
        mandant_id,
        matching_id,
        a500_kjwo_update,
        spr_id
) AS b
WHERE
    tupel_spr_zu.mandant_id = b.mandant_id AND tupel_spr_zu.matching_id = b.matching_id AND tupel_spr_zu.kjwo_update =
    b.a500_kjwo_update AND tupel_spr_zu.spr_id = b.spr_id;


CREATE OR REPLACE TEMPORARY TABLE _step11 AS
SELECT
    B.kjwo,
    c.art_matching_id,
    A.mandant_id,
    MIN(A.sm_id) AS sm_id
FROM dbp_etl_process.art_sm_vw_zu_per_1 AS A
INNER JOIN dbp_data.woche_1 AS B ON CURRENT_DATE("Europe/Berlin") BETWEEN A.dat_von AND A.dat_bis
INNER JOIN (
    SELECT
        art_matching_id,
        art_id,
        mandant_id
    FROM dbp_etl.art_matching_nielsen_per_de_xxx_1
    WHERE art_id <> -1
    GROUP BY
        art_matching_id,
        art_id,
        mandant_id
) AS c ON A.art_id = c.art_id AND A.mandant_id = c.mandant_id
WHERE
    A.mandant_id = 1
    AND B.kjwo IN (
        SELECT MAX(kjwo_update) AS a1290333724
        FROM dbp_data.sortiment_leistung_1
        WHERE mandant_id = 1
    )
GROUP BY
    B.kjwo,
    c.art_matching_id,
    A.mandant_id;


UPDATE dbp_etl_process.tupel_mat_etl_1 SET
    a39_listung_sst_mvke = b.sm_id
FROM `_step11` AS b
WHERE
    tupel_mat_etl.mandant_id = b.mandant_id AND tupel_mat_etl.matching_id = b.art_matching_id AND tupel_mat_etl.a500_kjwo_update
    IN (
        SELECT MAX(kjwo_update) AS a1290333724
        FROM dbp_data.sortiment_leistung_1
        WHERE mandant_id = 1
    ) AND tupel_mat_etl.mandant_id IN (1
    );


-- texts for article groupings at the very end


CREATE OR REPLACE TEMPORARY TABLE _murks_1 AS
SELECT
    A.art_gruppe_id,
    B.art_id,
    A.art_gruppe_bez
FROM dbp_data.art_gruppe_1 AS A
INNER JOIN dbp_data.art_gruppe_art_zu_1 AS B ON A.art_gruppe_id = B.art_gruppe_id
WHERE
    A.art_gruppe_kategorie = 'Sortimentstool'
    AND B.mandant_id = 1
    AND A.art_gruppe_id IN (
        SELECT B0.art_gruppe_id
        FROM dbp_data.art_gruppe_1 AS A0
        INNER JOIN dbp_data.art_gruppe_art_zu_1 AS B0 ON A0.art_gruppe_id = B0.art_gruppe_id
        WHERE
            A0.art_gruppe_kategorie = 'Sortimentstool'
            AND B0.mandant_id = 1
        GROUP BY B0.art_gruppe_id
    )
GROUP BY
    A.art_gruppe_id,
    B.art_id,
    A.art_gruppe_bez;


CREATE OR REPLACE TEMPORARY TABLE _murks2 AS
SELECT
    A.mandant_id,
    A.matching_id,
    A.a500_kjwo_update,
    B.art_gruppe_bez
FROM dbp_etl_process.tupel_mat_etl_1 AS A
INNER JOIN `_murks_1` AS B ON A.mandant_id = 1 AND A.art_id = B.art_id
WHERE
    A.a500_kjwo_update IN (
        SELECT MAX(a500_kjwo_update) AS a1581216993
        FROM dbp_etl_process.tupel_mat_etl_1
        WHERE mandant_id = 1
    )
GROUP BY
    A.mandant_id,
    A.matching_id,
    A.a500_kjwo_update,
    B.art_gruppe_bez;


UPDATE dbp_etl_process.tupel_mat_etl_1 SET
    art_bez_deutsch = b.art_gruppe_bez
FROM `_murks2` AS b
WHERE tupel_mat_etl.a500_kjwo_update = b.a500_kjwo_update AND tupel_mat_etl.mandant_id = b.mandant_id AND tupel_mat_etl.matching_id = b.matching_id;


UPDATE dbp_data.tupel_spr_zu_1 SET
    tupel_bez = b.art_gruppe_bez
FROM `_murks2` AS b
WHERE
    tupel_spr_zu.kjwo_update = b.a500_kjwo_update AND tupel_spr_zu.mandant_id = b.mandant_id AND tupel_spr_zu.matching_id
    = b.matching_id;


UPDATE dbp_etl_process.tupel_mat_etl_1 SET
    a446_lieferant_bez_latein = b.hersteller_bez FROM (
    SELECT
        mandant_id,
        art_nielsen_id,
        hersteller_bez
    FROM `_art_nielsen`
    WHERE mandant_id > 1
    GROUP BY
        mandant_id,
        art_nielsen_id,
        hersteller_bez
) AS b
WHERE tupel_mat_etl.mandant_id = b.mandant_id AND tupel_mat_etl.a450_art_nielsen_nr = b.art_nielsen_id AND tupel_mat_etl.art_id IS NULL AND tupel_mat_etl.a500_kjwo_update = (
    SELECT MAX(kjwo_update)
    FROM dbp_data.sortiment_leistung_1
);


UPDATE dbp_etl_process.tupel_mat_etl_1 SET
    a446_lieferant_bez_latein = b.hersteller_bez FROM (
    SELECT
        mandant_id,
        art_nielsen_id,
        hersteller_bez
    FROM `_art_nielsen`
    WHERE mandant_id = 1
    GROUP BY
        mandant_id,
        art_nielsen_id,
        hersteller_bez
) AS b
WHERE tupel_mat_etl.mandant_id = b.mandant_id AND tupel_mat_etl.a450_art_nielsen_nr = b.art_nielsen_id AND tupel_mat_etl.art_id IS NULL AND tupel_mat_etl.a500_kjwo_update = (
    SELECT MAX(kjwo_update)
    FROM dbp_data.sortiment_leistung_1
);


UPDATE `dbp_etl_process.tupel_mat_etl_1` t
SET A61_muki_vk_kl_art_id_verkettung = b.mutter_wb_id
FROM (
    SELECT
        mandant_id,
        matching_id,
        a500_kjwo_update,

        REPLACE(
            TRIM(
                STRING_AGG(
                    LPAD(
                        CAST(
                            CAST(
                                LPAD(
                                    CAST(
                                        FLOOR(SAFE_CAST(A61_muki_vk_kl_art_id_verkettung AS FLOAT64))
                                        AS STRING
                                    ),
                                    8,
                                    '0'
                                ) AS INT64
                            ) AS STRING
                        ),
                        8,
                        '0'
                    ),
                    ',' ORDER BY SAFE_CAST(A61_muki_vk_kl_art_id_verkettung AS FLOAT64)
                )
            ),
            ' ',
            ''
        ) AS mutter_wb_id

    FROM `dbp_etl_process.tupel_mat_etl_1`

    WHERE
        mandant_id > 1
        AND a500_kjwo_update IN (
            SELECT MAX(a500_kjwo_update)
            FROM `dbp_etl_process.tupel_mat_etl_1`
        )
        AND STRPOS(A61_muki_vk_kl_art_id_verkettung, '.') > 0
        AND STRPOS(A61_muki_vk_kl_art_id_verkettung, ',') = 0
        AND SAFE_CAST(A61_muki_vk_kl_art_id_verkettung AS FLOAT64) IS NOT NULL

    GROUP BY mandant_id, matching_id, a500_kjwo_update
) b

WHERE
    t.mandant_id = b.mandant_id
    AND t.matching_id = b.matching_id
    AND t.a500_kjwo_update = b.a500_kjwo_update; --pe_review


UPDATE dbp_etl_process.tupel_mat_etl_1 SET
    tupel_typ = CASE
        WHEN tupel_mat_etl.art_id > 0
            THEN 'KAUFLAND'
        WHEN tupel_mat_etl.art_id IS NULL
            THEN 'NIELSEN'
        ELSE NULL
    END
WHERE a500_kjwo_update = (
    SELECT MAX(kjwo_update)
    FROM dbp_data.sortiment_leistung_1
);


--KL_OLD

--de


CREATE OR REPLACE TEMPORARY TABLE _sales_data_10m_de AS
SELECT
    A.mandant_id,
    c.art_matching_id,
    SUM(A.umsatz_netto) AS umsatz_netto_10m
FROM dbp_data.artbew_wo_sum_1 AS A
INNER JOIN dbp_data.woche_kj_kl_1 AS B ON A.kjwo_kl = B.kjwo_kl
INNER JOIN (
    SELECT
        mandant_id,
        art_matching_id,
        art_id
    FROM dbp_etl.art_matching_nielsen_per_1
    WHERE
        kjwo_update = (
            SELECT MAX(kjwo_update)
            FROM dbp_etl.art_matching_nielsen_per_1
        )
        AND art_id <> -1
    GROUP BY
        mandant_id,
        art_matching_id,
        art_id
) AS c ON A.art_id = c.art_id AND A.mandant_id = c.mandant_id
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
        FROM dbp_msi_data.ek_sort_sortiment_mat_zeitraum_1 AS A0
        INNER JOIN (SELECT
            mandant_id,
            MAX(kjmo) AS kjmo
        FROM dbp_data.sortiment_leistung_1
        WHERE mandant_id = 1
        GROUP BY mandant_id) AS b ON A0.kjmo_sort = b.kjmo
        INNER JOIN dbp_data.woche_1 AS C ON A0.kjwo_bis >= C.kjwo
        QUALIFY ((RANK() OVER (
            PARTITION BY
                b.mandant_id ORDER BY
                b.mandant_id IS NULL, b.mandant_id, C.kjwo IS NULL DESC,
                C.kjwo DESC
        )) * -1) BETWEEN -43 AND (-1)
    ) AS t5
    GROUP BY mandant_id,
    kjwo
)
AND A.mandant_id = 1
GROUP BY
    A.mandant_id,
    c.art_matching_id
HAVING umsatz_netto_10m > 0;


CREATE OR REPLACE TEMPORARY TABLE _tupel_sales_data_10m_de AS
SELECT
    mandant_id,
    a500_kjwo_update,
    matching_id,
    art_id,
    a450_art_nielsen_nr,
    a14_art_status_de
FROM dbp_etl_process.tupel_mat_etl_1 AS A
WHERE
    mandant_id = 1
    AND a14_art_status_de = 'L'
    AND a500_kjwo_update = (
        SELECT MAX(kjwo_update)
        FROM dbp_etl.art_matching_nielsen_per_1
    )
    AND (
        mandant_id, matching_id) NOT IN (
        SELECT (mandant_id, matching_id)
        FROM (
            SELECT
                mandant_id,
                art_matching_id AS matching_id
            FROM `_sales_data_10m_de`
            GROUP BY
                mandant_id,
                matching_id
        ) AS t1_1
    )
    AND a450_art_nielsen_nr IS NOT NULL;


--de


UPDATE dbp_etl_process.tupel_mat_etl_1 SET
    tupel_typ = 'KL_OLD'
FROM `_tupel_sales_data_10m_de` AS b
WHERE tupel_mat_etl.mandant_id = b.mandant_id AND tupel_mat_etl.a500_kjwo_update = b.a500_kjwo_update AND tupel_mat_etl.matching_id = b.matching_id;


CREATE OR REPLACE TEMPORARY TABLE _sales_data_10m_kmo AS
SELECT
    A.mandant_id,
    c.art_matching_id,
    SUM(A.umsatz_netto) AS umsatz_netto_10m
FROM dbp_data.artbew_wo_sum_1 AS A
INNER JOIN dbp_data.woche_kj_kl_1 AS B ON A.kjwo_kl = B.kjwo_kl
INNER JOIN (
    SELECT
        mandant_id,
        art_matching_id,
        art_id
    FROM dbp_etl.art_matching_nielsen_per_kmo_1
    WHERE
        kjwo_update = (
            SELECT MAX(kjwo_update)
            FROM dbp_etl.art_matching_nielsen_per_kmo_1
        )
        AND art_id <> -1
    GROUP BY
        mandant_id,
        art_matching_id,
        art_id
) AS c ON A.art_id = c.art_id AND A.mandant_id = c.mandant_id
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
        FROM dbp_msi_data.ek_sort_sortiment_mat_zeitraum_1 AS A0
        INNER JOIN (SELECT
            mandant_id,
            MAX(kjmo) AS kjmo
        FROM dbp_data.sortiment_leistung_1
        WHERE mandant_id > 1
        GROUP BY mandant_id) AS b ON A0.kjmo_sort = b.kjmo
        INNER JOIN dbp_data.woche_1 AS C ON A0.kjwo_bis >= C.kjwo
        QUALIFY ((RANK() OVER (
            PARTITION BY
                b.mandant_id ORDER BY
                b.mandant_id IS NULL, b.mandant_id, C.kjwo IS NULL DESC,
                C.kjwo DESC
        )) * -1) BETWEEN -43 AND (-1)
    ) AS t5
    GROUP BY mandant_id,
    kjwo
)
AND A.mandant_id > 1
GROUP BY
    A.mandant_id,
    c.art_matching_id
HAVING umsatz_netto_10m > 0;


CREATE OR REPLACE TEMPORARY TABLE _tupel_sales_data_10m_kmo AS
SELECT
    mandant_id,
    a500_kjwo_update,
    matching_id,
    art_id,
    a450_art_nielsen_nr,
    a14_art_status_de
FROM dbp_etl_process.tupel_mat_etl_1 AS A
WHERE
    mandant_id > 1
    AND a14_art_status_de = 'L'
    AND a500_kjwo_update = (
        SELECT MAX(kjwo_update)
        FROM dbp_etl.art_matching_nielsen_per_kmo_1
    )
    AND (
        mandant_id, matching_id) NOT IN (
        SELECT (mandant_id, matching_id)
        FROM (
            SELECT
                mandant_id,
                art_matching_id AS matching_id
            FROM `_sales_data_10m_kmo`
            GROUP BY
                mandant_id,
                matching_id
        ) AS t1_1
    )
    AND a450_art_nielsen_nr IS NOT NULL;


--kmo


UPDATE dbp_etl_process.tupel_mat_etl_1 SET
    tupel_typ = 'KL_OLD'
FROM `_tupel_sales_data_10m_kmo` AS b
WHERE tupel_mat_etl.mandant_id = b.mandant_id AND tupel_mat_etl.a500_kjwo_update = b.a500_kjwo_update AND tupel_mat_etl.matching_id = b.matching_id;


--DE


CREATE OR REPLACE TEMPORARY TABLE _nielsen_based_data_de AS
SELECT
    A.mandant_id,
    c.art_nielsen_id,
    COUNT(DISTINCT x.kjwo) AS anz_weeks
FROM dbp_data.art_nielsen_fakten_kjwo_1 AS A
INNER JOIN (SELECT
    kjwo,
    MIN(kjmo) AS kjmo
FROM dbp_data.tag_1
GROUP BY kjwo) AS x ON A.kjwo = x.kjwo
INNER JOIN (
    SELECT
        mandant_id,
        art_nielsen_id,
        art_matching_id
    FROM dbp_etl.art_matching_nielsen_per_1
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
    FROM dbp_etl_process.matching_art_nielsen_zu_1
    WHERE (
        mandant_id, kjwo_update) IN (
        SELECT (mandant_id, MAX(kjwo_update))
        FROM dbp_data.art_kl_preislage_zu_per_1
        WHERE mandant_id = 1
        GROUP BY mandant_id
    )
    GROUP BY
        mandant_id,
        art_nielsen_id,
        art_matching_id
) AS c ON A.mandant_id = c.mandant_id AND A.art_nielsen_id = c.art_nielsen_id
INNER JOIN dbp_data.nielsen_market_1 AS D ON A.mandant_id = D.mandant_id AND A.nielsen_market_id = D.nielsen_market_id

INNER JOIN (
    SELECT *
    FROM dbp_etl_process.tupel_mat_etl_1 AS ZZ
    WHERE a500_kjwo_update IN (
        SELECT MAX(kjwo_update) AS kjwo_update
        FROM dbp_data.art_kl_preislage_zu_per_1
        WHERE mandant_id = 1
    )
) AS t13
    ON A.mandant_id = t13.mandant_id AND c.art_matching_id = t13.matching_id
WHERE
    A.kjwo IN (
        SELECT kjwo
        FROM dbp_data.art_nielsen_fakten_kjwo_1
        WHERE mandant_id = 1
        GROUP BY kjwo
        QUALIFY ((RANK() OVER (ORDER BY kjwo IS NULL DESC, kjwo DESC)) * -1) BETWEEN -52 AND (-1)
    )
    AND D.nielsen_market_cluster_id = 2
    AND A.mandant_id = 1
GROUP BY
    A.mandant_id,
    c.art_nielsen_id;


UPDATE dbp_etl_process.tupel_mat_etl_1 SET
    anz_wochen_de_anz_monate_kmo_nielsen = b.anz_weeks
FROM `_nielsen_based_data_de` AS b
WHERE tupel_mat_etl.mandant_id = b.mandant_id AND tupel_mat_etl.a450_art_nielsen_nr = b.art_nielsen_id AND tupel_mat_etl.a500_kjwo_update = (
    SELECT MAX(kjwo_update)
    FROM dbp_data.art_kl_preislage_zu_per_1
    WHERE mandant_id = 1
);


--KMO


CREATE OR REPLACE TEMPORARY TABLE _nielsen_based_data AS
SELECT
    A.mandant_id,
    c.art_nielsen_id,
    COUNT(DISTINCT x.kjmo) AS anz_months
FROM dbp_data.art_nielsen_fakten_kjmo_1 AS A
INNER JOIN (
    SELECT kjmo
    FROM dbp_data.tag_1
    GROUP BY kjmo
) AS x
    ON A.kjmo = x.kjmo
INNER JOIN (
    SELECT
        mandant_id,
        art_nielsen_id,
        art_matching_id
    FROM dbp_etl.art_matching_nielsen_per_kmo_1
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
    FROM dbp_etl_process.matching_art_nielsen_zu_1
    WHERE (
        mandant_id, kjwo_update) IN (
        SELECT (mandant_id, MAX(kjwo_update))
        FROM dbp_data.art_kl_preislage_zu_per_1
        WHERE mandant_id > 1
        GROUP BY mandant_id
    )
    GROUP BY
        mandant_id,
        art_nielsen_id,
        art_matching_id
) AS c ON A.mandant_id = c.mandant_id AND A.art_nielsen_id = c.art_nielsen_id
INNER JOIN dbp_data.nielsen_market_1 AS D ON A.mandant_id = D.mandant_id AND A.nielsen_market_id = D.nielsen_market_id

INNER JOIN (
    SELECT *
    FROM dbp_etl_process.tupel_mat_etl_1 AS ZZ
    WHERE a500_kjwo_update IN (
        SELECT MAX(kjwo_update) AS kjwo_update
        FROM dbp_data.art_kl_preislage_zu_per_1
        WHERE mandant_id > 1
    )
) AS t13
    ON A.mandant_id = t13.mandant_id AND c.art_matching_id = t13.matching_id
WHERE (
    A.mandant_id, A.kjmo) IN (
    SELECT (mandant_id, kjmo)
    FROM dbp_data.art_nielsen_fakten_kjmo_1
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


UPDATE dbp_etl_process.tupel_mat_etl_1 SET
    anz_wochen_de_anz_monate_kmo_nielsen = b.anz_months
FROM `_nielsen_based_data` AS b
WHERE tupel_mat_etl.mandant_id = b.mandant_id AND tupel_mat_etl.a450_art_nielsen_nr = b.art_nielsen_id AND tupel_mat_etl.a500_kjwo_update = (
    SELECT MAX(kjwo_update)
    FROM dbp_data.art_kl_preislage_zu_per_1
    WHERE mandant_id > 1
);


--new nielsen data --de


CREATE OR REPLACE TEMPORARY TABLE _update_de AS
SELECT
    A.mandant_id,
    B.art_matching_id,
    A.art_nielsen_id,
    NULLIF(A.marke_bez, '') AS marke_bez,
    NULLIF(A.bio_organic_kz, '') AS bio_organic_kz,
    NULLIF(A.veggy_split_kz, '') AS veggy_split_kz,
    NULLIF(A.laktosefrei_kz, '') AS laktosefrei_kz,
    NULLIF(A.glutenfrei_kz, '') AS glutenfrei_kz,
    NULLIF(A.duft_geschmack_bez, '') AS duft_geschmack_bez,
    NULLIF(A.inhalt_menge, '') AS inhalt_menge
FROM dbp_data.art_nielsen_1 AS A
INNER JOIN dbp_etl.art_matching_nielsen_per_1 AS B ON A.mandant_id = B.mandant_id AND A.art_nielsen_id = B.art_nielsen_id
WHERE
    A.mandant_id = 1
    AND A.dat_bis = DATE '9999-12-31'
    AND B.kjwo_update IN (
        SELECT MAX(kjwo_update) AS a1290333724
        FROM dbp_data.sortiment_leistung_1
        WHERE mandant_id = 1
    );


CREATE OR REPLACE TEMPORARY TABLE _update_de_agg AS
SELECT
    mandant_id,
    art_matching_id,
    STRING_AGG(DISTINCT bio_organic_kz, ', ' ORDER BY bio_organic_kz) AS kombi_bio_organic_kz, --pe_review
    STRING_AGG(DISTINCT veggy_split_kz, ', ' ORDER BY veggy_split_kz) AS kombi_veggy_split_kz, --pe_review
    STRING_AGG(DISTINCT laktosefrei_kz, ', ' ORDER BY laktosefrei_kz) AS kombi_laktosefrei_kz, --pe_review
    STRING_AGG(DISTINCT glutenfrei_kz, ', ' ORDER BY glutenfrei_kz) AS kombi_glutenfrei_kz, --pe_review
    STRING_AGG(DISTINCT inhalt_menge, ', ' ORDER BY inhalt_menge) AS kombi_inhalt_menge  --pe_review
FROM `_update_de`
GROUP BY mandant_id, art_matching_id;


UPDATE dbp_etl_process.tupel_mat_etl_1 SET
    a515_bio_organic_nielsen_kz = b.kombi_bio_organic_kz,
    a516_veggy_split_nielsen_kz = b.kombi_veggy_split_kz,
    a517_laktosefrei_nielsen_kz = b.kombi_laktosefrei_kz,
    a518_glutenfrei_nielsen_kz = b.kombi_glutenfrei_kz,
    a386_inhaltsmengen_nielsen = b.kombi_inhalt_menge
FROM `_update_de_agg` AS b
WHERE
    tupel_mat_etl.mandant_id = b.mandant_id AND tupel_mat_etl.matching_id = b.art_matching_id AND tupel_mat_etl.a500_kjwo_update
    = (
        SELECT MAX(kjwo_update)
        FROM dbp_data.sortiment_leistung_1
        WHERE mandant_id = 1
    );


--new nielsen data --kmo


CREATE OR REPLACE TEMPORARY TABLE _update_kmo AS
SELECT
    A.mandant_id,
    B.art_matching_id,
    A.art_nielsen_id,
    NULLIF(A.marke_bez, '') AS marke_bez,
    NULLIF(A.bio_organic_kz, '') AS bio_organic_kz,
    NULLIF(A.veggy_split_kz, '') AS veggy_split_kz,
    NULLIF(A.laktosefrei_kz, '') AS laktosefrei_kz,
    NULLIF(A.glutenfrei_kz, '') AS glutenfrei_kz,
    NULLIF(A.duft_geschmack_bez, '') AS duft_geschmack_bez,
    NULLIF(A.inhalt_menge, '') AS inhalt_menge,
    NULLIF(A.inhalt_einheit, '') AS inhalt_einheit
FROM dbp_data.art_nielsen_1 AS A
INNER JOIN dbp_etl.art_matching_nielsen_per_kmo_1 AS B
    ON
        A.mandant_id = B.mandant_id AND A.art_nielsen_id
        = B.art_nielsen_id
WHERE
    A.mandant_id > 1
    AND A.dat_bis = DATE '9999-12-31'
    AND B.kjwo_update IN (
        SELECT MAX(kjwo_update) AS a1290333724
        FROM dbp_data.sortiment_leistung_1
        WHERE mandant_id > 1
    );


CREATE OR REPLACE TEMPORARY TABLE _update_kmo_agg AS
SELECT
    mandant_id,
    art_matching_id,

    STRING_AGG(DISTINCT marke_bez, ', ' ORDER BY marke_bez) AS kombi_marke_bez, --pe_review
    STRING_AGG(DISTINCT bio_organic_kz, ', ' ORDER BY bio_organic_kz) AS kombi_bio_organic_kz, --pe_review
    STRING_AGG(DISTINCT duft_geschmack_bez, ', ' ORDER BY duft_geschmack_bez) AS kombi_duft_geschmack_bez, --pe_review
    STRING_AGG(DISTINCT inhalt_menge, ', ' ORDER BY inhalt_menge) AS kombi_inhalt_menge, --pe_review
    STRING_AGG(DISTINCT inhalt_einheit, ', ' ORDER BY inhalt_einheit) AS kombi_inhalt_einheit --pe_review

FROM `_update_kmo`
GROUP BY mandant_id, art_matching_id;


UPDATE dbp_etl_process.tupel_mat_etl_1 SET
    a471_marke_nielsen_bez = b.kombi_marke_bez,
    a515_bio_organic_nielsen_kz = b.kombi_bio_organic_kz,
    a387_duft_geschmack_nielsen = b.kombi_duft_geschmack_bez,
    a386_inhaltsmengen_nielsen = b.kombi_inhalt_menge,
    a388_einheit_nielsen = b.kombi_inhalt_einheit
FROM `_update_kmo_agg` AS b
WHERE
    tupel_mat_etl.mandant_id = b.mandant_id AND tupel_mat_etl.matching_id = b.art_matching_id AND tupel_mat_etl.a500_kjwo_update
    = (
        SELECT MAX(kjwo_update)
        FROM dbp_data.sortiment_leistung_1
        WHERE mandant_id > 1
    );


--new nielsen data , art_matching_id based --de with new market_tag


CREATE OR REPLACE TEMPORARY TABLE _art_matching_id_based_de AS
SELECT
    A.mandant_id,
    c.art_matching_id,
    t12.a5_owg_id,
    t12.a7_wg_id,
    t12.wug_id,
    COUNT(DISTINCT CAST(c.art_nielsen_id AS STRING) || CAST(x.kjwo AS STRING)) AS anz,
    SUM(A.distr_gew_4_wo) / COUNT(DISTINCT CAST(c.art_nielsen_id AS STRING) || CAST(x.kjwo AS STRING)) AS distr_gew_4_wo,
    SUM(A.distr_num_4_wo) / COUNT(DISTINCT CAST(c.art_nielsen_id AS STRING) || CAST(x.kjwo AS STRING)) AS distr_num_4_wo
FROM dbp_data.art_nielsen_fakten_kjwo_1 AS A
INNER JOIN (SELECT
    kjwo,
    MIN(kjmo) AS kjmo
FROM dbp_data.tag_1
GROUP BY kjwo) AS x ON A.kjwo = x.kjwo
INNER JOIN (
    SELECT
        mandant_id,
        gtin_id,
        art_nielsen_id,
        art_matching_id
    FROM dbp_etl.art_matching_nielsen_per_1
    GROUP BY
        mandant_id,
        gtin_id,
        art_nielsen_id,
        art_matching_id
    UNION DISTINCT
    SELECT
        mandant_id,
        gtin_id,
        art_nielsen_id,
        art_matching_id
    FROM dbp_etl_process.matching_art_nielsen_zu_1
    WHERE (
        mandant_id, kjwo_update) IN (
        SELECT (mandant_id, MAX(kjwo_update))
        FROM dbp_data.art_kl_preislage_zu_per_1
        WHERE mandant_id = 1
        GROUP BY mandant_id
    )
    GROUP BY
        mandant_id,
        gtin_id,
        art_nielsen_id,
        art_matching_id
) AS c ON A.mandant_id = c.mandant_id AND A.art_nielsen_id = c.art_nielsen_id
INNER JOIN dbp_data.nielsen_market_1 AS D ON A.mandant_id = D.mandant_id AND A.nielsen_market_id = D.nielsen_market_id

INNER JOIN (
    SELECT *
    FROM dbp_etl_process.tupel_mat_etl_1 AS ZZ
    WHERE a500_kjwo_update IN (
        SELECT MAX(kjwo_update) AS kjwo_update
        FROM dbp_data.art_kl_preislage_zu_per_1
        WHERE mandant_id = 1
    )
) AS t12
    ON A.mandant_id = t12.mandant_id AND c.art_matching_id = t12.matching_id
WHERE
    A.kjwo IN (
        SELECT kjwo
        FROM dbp_data.art_nielsen_fakten_kjwo_1
        WHERE mandant_id = 1
        GROUP BY kjwo
        QUALIFY ((RANK() OVER (ORDER BY kjwo IS NULL DESC, kjwo DESC)) * -1) BETWEEN -52 AND (-1)
    )
    AND D.nielsen_market_cluster_id = 2
    AND A.mandant_id = 1
GROUP BY
    A.mandant_id,
    c.art_matching_id,
    t12.a5_owg_id,
    t12.a7_wg_id,
    t12.wug_id;


CREATE OR REPLACE TEMPORARY TABLE _art_matching_id_based_de_agg AS
SELECT
    mandant_id,
    art_matching_id,
    a5_owg_id,
    a7_wg_id,
    wug_id,
    MAX(anz) AS anz,
    SUM(distr_gew_4_wo) AS distr_gew_4_wo,
    SUM(distr_num_4_wo) AS distr_num_4_wo
FROM `_art_matching_id_based_de` AS A
WHERE (
    mandant_id, art_matching_id) IN (
    SELECT (mandant_id, matching_id)
    FROM dbp_etl_process.tupel_mat_etl_1
    WHERE
        mandant_id = 1
        AND a500_kjwo_update IN (
            SELECT MAX(kjwo_update) AS a1290333724
            FROM dbp_data.art_kl_preislage_zu_per_1
            WHERE mandant_id = 1
        )
)
GROUP BY
    mandant_id,
    art_matching_id,
    a5_owg_id,
    a7_wg_id,
    wug_id;


CREATE OR REPLACE TEMPORARY TABLE _base_de AS
SELECT
    mandant_id,
    matching_id,
    a500_kjwo_update,
    a36_gewichtete_distribution_nielsen,
    a385_numerische_distribution_nielsen
FROM dbp_etl_process.tupel_mat_etl_1
WHERE a500_kjwo_update IN (
    SELECT MAX(kjwo_update) AS a1290333724
    FROM dbp_data.art_kl_preislage_zu_per_1
    WHERE mandant_id = 1
)
AND mandant_id = 1;


UPDATE `_base_de` SET
    a36_gewichtete_distribution_nielsen = b.distr_gew_4_wo,
    a385_numerische_distribution_nielsen = b.distr_num_4_wo FROM (
    SELECT
        mandant_id,
        art_matching_id,
        SUM(distr_gew_4_wo) AS distr_gew_4_wo,
        SUM(distr_num_4_wo) AS distr_num_4_wo
    FROM `_art_matching_id_based_de_agg`
    GROUP BY
        mandant_id,
        art_matching_id
) AS b
WHERE `_base_de`.mandant_id = b.mandant_id AND `_base_de`.matching_id = b.art_matching_id;


UPDATE dbp_etl_process.tupel_mat_etl_1 SET
    a36_gewichtete_distribution_nielsen = b.gewichtete_distribution,
    a385_numerische_distribution_nielsen = b.numerische_distribution FROM (
    SELECT
        mandant_id,
        matching_id,
        a500_kjwo_update,
        MAX(a36_gewichtete_distribution_nielsen) AS gewichtete_distribution,
        MAX(a385_numerische_distribution_nielsen) AS numerische_distribution
    FROM `_base_de`
    GROUP BY
        mandant_id,
        matching_id,
        a500_kjwo_update
) AS b
WHERE tupel_mat_etl.mandant_id = b.mandant_id AND tupel_mat_etl.a500_kjwo_update = b.a500_kjwo_update AND tupel_mat_etl.matching_id = b.matching_id;


--new nielsen data , art_matching_id based --kmo


CREATE OR REPLACE TEMPORARY TABLE _art_matching_id_based_kmo AS
SELECT
    A.mandant_id,
    c.art_matching_id,
    SUM(A.menge) AS menge,
    SUM(A.umsatz_brutto) AS umsatz_brutto,
    SUM(COALESCE(A.menge_verkaufseinheiten_normiert, 0)) AS menge_verkaufseinheiten_normiert,
    CASE
        WHEN A.mandant_id NOT IN (2, 3, 5, 6)
            THEN COUNT(DISTINCT CAST(A.mandant_id AS STRING) || CAST(c.art_nielsen_id AS STRING) || CAST(x.kjmo AS STRING))
        ELSE COUNT(CAST(A.mandant_id AS STRING) || CAST(c.art_nielsen_id AS STRING) || CAST(x.kjmo AS STRING))
    END AS anz,
    SUM(A.distr_num) / CASE
        WHEN A.mandant_id NOT IN (2, 3, 5, 6)
            THEN COUNT(DISTINCT CAST(A.mandant_id AS STRING) || CAST(c.art_nielsen_id AS STRING) || CAST(x.kjmo AS STRING))
        ELSE COUNT(CAST(A.mandant_id AS STRING) || CAST(c.art_nielsen_id AS STRING) || CAST(x.kjmo AS STRING))
    END AS distr_num
FROM dbp_data.art_nielsen_fakten_kjmo_1 AS A
INNER JOIN (
    SELECT kjmo
    FROM dbp_data.tag_1
    GROUP BY kjmo
) AS x
    ON A.kjmo = x.kjmo
INNER JOIN (
    SELECT
        mandant_id,
        art_nielsen_id,
        art_matching_id
    FROM dbp_etl.art_matching_nielsen_per_kmo_1
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
    FROM dbp_etl_process.matching_art_nielsen_zu_1
    WHERE (
        mandant_id, kjwo_update) IN (
        SELECT (mandant_id, MAX(kjwo_update))
        FROM dbp_data.art_kl_preislage_zu_per_1
        WHERE mandant_id > 1
        GROUP BY mandant_id
    )
    GROUP BY
        mandant_id,
        art_nielsen_id,
        art_matching_id
) AS c ON A.mandant_id = c.mandant_id AND A.art_nielsen_id = c.art_nielsen_id
INNER JOIN dbp_data.nielsen_market_1 AS D ON A.mandant_id = D.mandant_id AND A.nielsen_market_id = D.nielsen_market_id

INNER JOIN (
    SELECT *
    FROM dbp_etl_process.tupel_mat_etl_1 AS ZZ
    WHERE a500_kjwo_update IN (
        SELECT MAX(kjwo_update) AS kjwo_update
        FROM dbp_data.art_kl_preislage_zu_per_1
        WHERE mandant_id > 1
    )
) AS t13
    ON A.mandant_id = t13.mandant_id AND c.art_matching_id = t13.matching_id
WHERE (
    A.mandant_id, A.kjmo) IN (
    SELECT (mandant_id, kjmo)
    FROM dbp_data.art_nielsen_fakten_kjmo_1
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
    c.art_matching_id;


CREATE OR REPLACE TEMPORARY TABLE _art_matching_id_based_kmo_agg AS
SELECT
    mandant_id,
    art_matching_id,
    SUM(distr_num) AS distr_num
FROM `_art_matching_id_based_kmo` AS A
WHERE (
    mandant_id, art_matching_id) IN (
    SELECT (mandant_id, matching_id)
    FROM dbp_etl_process.tupel_mat_etl_1
    WHERE
        mandant_id > 1
        AND a500_kjwo_update IN (
            SELECT MAX(kjwo_update) AS a1290333724
            FROM dbp_data.art_kl_preislage_zu_per_1
            WHERE mandant_id > 1
        )
)
GROUP BY
    mandant_id,
    art_matching_id;


CREATE OR REPLACE TEMPORARY TABLE _base_kmo AS
SELECT
    mandant_id,
    matching_id,
    a500_kjwo_update,
    a385_numerische_distribution_nielsen
FROM dbp_etl_process.tupel_mat_etl_1
WHERE a500_kjwo_update IN (
    SELECT MAX(kjwo_update) AS a1290333724
    FROM dbp_data.art_kl_preislage_zu_per_1
    WHERE mandant_id > 1
)
AND mandant_id > 1;


UPDATE `_base_kmo` SET
    a385_numerische_distribution_nielsen = b.distr_num FROM (
    SELECT
        mandant_id,
        art_matching_id,
        SUM(distr_num) AS distr_num
    FROM `_art_matching_id_based_kmo_agg`
    GROUP BY
        mandant_id,
        art_matching_id
) AS b
WHERE `_base_kmo`.mandant_id = b.mandant_id AND `_base_kmo`.matching_id = b.art_matching_id;


CREATE OR REPLACE TEMPORARY TABLE _nielsen_preis AS
SELECT
    mandant_id,
    art_matching_id,
    umsatz_brutto / IF(menge = 0, NULL, menge) AS durchschnitt_preis
FROM `_art_matching_id_based_kmo`
WHERE
    umsatz_brutto > 0
    AND menge > 0;


CREATE OR REPLACE TEMPORARY TABLE _durchschn_preis AS
SELECT
    mandant_id,
    art_matching_id,
    umsatz_brutto / menge_verkaufseinheiten_normiert AS durchschn_preis_einheit
FROM `_art_matching_id_based_kmo`
WHERE
    umsatz_brutto > 0
    AND menge_verkaufseinheiten_normiert > 0;


UPDATE dbp_etl_process.tupel_mat_etl_1 SET
    a34_vk_brutto_durchschnitt_nielsen = b.durchschnitt_preis
FROM `_nielsen_preis` AS b
WHERE
    tupel_mat_etl.mandant_id = b.mandant_id AND tupel_mat_etl.matching_id = b.art_matching_id AND tupel_mat_etl.a500_kjwo_update
    = (
        SELECT MAX(kjwo_update)
        FROM dbp_data.art_kl_preislage_zu_per_1
        WHERE mandant_id > 1
    );


UPDATE dbp_etl_process.tupel_mat_etl_1 SET
    a383_sales_units_verkaufseinheiten_gl_in_1000_normiert_nielsen = b.menge_verkaufseinheiten_normiert FROM
    `_art_matching_id_based_kmo` AS b
WHERE
    tupel_mat_etl.mandant_id = b.mandant_id AND tupel_mat_etl.matching_id = b.art_matching_id AND tupel_mat_etl.a500_kjwo_update
    = (
        SELECT MAX(kjwo_update)
        FROM dbp_data.art_kl_preislage_zu_per_1
        WHERE mandant_id > 1
    );


UPDATE dbp_etl_process.tupel_mat_etl_1 SET
    a384_durchschn_preis_einheit_gl_normiert_nielsen = b.durchschn_preis_einheit
FROM `_durchschn_preis` AS b
WHERE
    tupel_mat_etl.mandant_id = b.mandant_id AND tupel_mat_etl.matching_id = b.art_matching_id AND tupel_mat_etl.a500_kjwo_update
    = (
        SELECT MAX(kjwo_update)
        FROM dbp_data.art_kl_preislage_zu_per_1
        WHERE mandant_id > 1
    );


UPDATE dbp_etl_process.tupel_mat_etl_1 SET
    a385_numerische_distribution_nielsen = b.distr_num FROM (
    SELECT
        mandant_id,
        matching_id,
        a500_kjwo_update,
        MAX(a385_numerische_distribution_nielsen) AS distr_num
    FROM `_base_kmo`
    GROUP BY
        mandant_id,
        matching_id,
        a500_kjwo_update
) AS b
WHERE tupel_mat_etl.mandant_id = b.mandant_id AND tupel_mat_etl.a500_kjwo_update = b.a500_kjwo_update AND tupel_mat_etl.matching_id = b.matching_id;


--new nielsen data , art_matching_id based --de


CREATE OR REPLACE TEMPORARY TABLE _art_matching_id_based_de AS
SELECT
    A.mandant_id,
    c.art_matching_id,
    SUM(A.menge) AS menge,
    SUM(A.menge_af) AS menge_af,
    SUM(A.menge_sa) AS menge_sa,
    SUM(A.umsatz_brutto) AS umsatz_brutto,
    SUM(A.umsatz_brutto_af) AS umsatz_brutto_af,
    SUM(A.umsatz_brutto_sa) AS umsatz_brutto_sa
FROM dbp_data.art_nielsen_fakten_kjwo_1 AS A
INNER JOIN (SELECT
    kjwo,
    MIN(kjmo) AS kjmo
FROM dbp_data.tag_1
GROUP BY kjwo) AS x ON A.kjwo = x.kjwo
INNER JOIN (
    SELECT
        mandant_id,
        gtin_id,
        art_nielsen_id,
        art_matching_id
    FROM dbp_etl.art_matching_nielsen_per_1
    GROUP BY
        mandant_id,
        gtin_id,
        art_nielsen_id,
        art_matching_id
    UNION DISTINCT
    SELECT
        mandant_id,
        gtin_id,
        art_nielsen_id,
        art_matching_id
    FROM dbp_etl_process.matching_art_nielsen_zu_1
    WHERE (
        mandant_id, kjwo_update) IN (
        SELECT (mandant_id, MAX(kjwo_update))
        FROM dbp_data.art_kl_preislage_zu_per_1
        WHERE mandant_id = 1
        GROUP BY mandant_id
    )
    GROUP BY
        mandant_id,
        gtin_id,
        art_nielsen_id,
        art_matching_id
) AS c ON A.mandant_id = c.mandant_id AND A.art_nielsen_id = c.art_nielsen_id
INNER JOIN dbp_data.nielsen_market_1 AS D ON A.mandant_id = D.mandant_id AND A.nielsen_market_id = D.nielsen_market_id

INNER JOIN (
    SELECT *
    FROM dbp_etl_process.tupel_mat_etl_1 AS ZZ
    WHERE a500_kjwo_update IN (
        SELECT MAX(kjwo_update) AS kjwo_update
        FROM dbp_data.art_kl_preislage_zu_per_1
        WHERE mandant_id = 1
    )
) AS t12
    ON A.mandant_id = t12.mandant_id AND c.art_matching_id = t12.matching_id
WHERE
    A.kjwo IN (
        SELECT kjwo
        FROM dbp_data.art_nielsen_fakten_kjwo_1
        WHERE mandant_id = 1
        GROUP BY kjwo
        QUALIFY ((RANK() OVER (ORDER BY kjwo IS NULL DESC, kjwo DESC)) * -1) BETWEEN -52 AND (-1)
    )
    AND D.nielsen_market_cluster_id = 2
    AND A.mandant_id = 1
GROUP BY
    A.mandant_id,
    c.art_matching_id;


CREATE OR REPLACE TEMPORARY TABLE _nielsen_preis_de AS
SELECT
    mandant_id,
    art_matching_id,
    CASE
        WHEN umsatz_brutto_af > 0
            THEN umsatz_brutto_af / IF(menge_af = 0, NULL, menge_af)
        WHEN umsatz_brutto_af = 0 AND umsatz_brutto_sa > 0
            THEN umsatz_brutto_sa / IF(menge_sa = 0, NULL, menge_sa)
        ELSE 0
    END AS durchschnitt_preis
FROM `_art_matching_id_based_de`
WHERE
    umsatz_brutto > 0
    AND menge > 0;


UPDATE dbp_etl_process.tupel_mat_etl_1 SET
    a34_vk_brutto_durchschnitt_nielsen = CAST(b.durchschnitt_preis AS NUMERIC)
FROM `_nielsen_preis_de` AS b
WHERE
    tupel_mat_etl.mandant_id = b.mandant_id AND tupel_mat_etl.matching_id = b.art_matching_id AND tupel_mat_etl.a500_kjwo_update
    = (
        SELECT MAX(kjwo_update)
        FROM dbp_data.art_kl_preislage_zu_per_1
        WHERE mandant_id = 1
    );


--restbon + cherrypicker de


CREATE OR REPLACE TEMPORARY TABLE _bons_art_de AS
SELECT
    A.mandant_id,
    B.art_id,
    SUM(A.art_ums_af) AS art_umsatz_af,
    SUM(A.art_ums_sa) AS art_umsatz_sa,
    SUM(A.bon_ums_af) AS bon_umsatz_af,
    SUM(A.bon_ums_sa) AS bon_umsatz_sa,
    SUM(A.restbon_af) AS restbon_af,
    SUM(A.restbon_sa) AS restbon_sa,
    SUM(A.restbon_af) + SUM(A.restbon_sa) AS restbon_summe,
    SUM(A.art_bons_af) AS anz_bons_af,
    SUM(A.art_bons_sa) AS anz_bons_sa,
    SUM(A.art_bons_af) + SUM(A.art_bons_sa) AS anz_bons,
    SUM(A.cp_bons_sa) AS cpsa_fg
FROM dbp_etl.bf_bons_sort_sum_1 AS A
INNER JOIN dbp_data.art_1 AS B
    ON
        A.mandant_id = B.mandant_id AND A.kl_art_id = B.kl_art_id AND B.dat_bis
        = DATE '9999-12-31'
INNER JOIN dbp_data.tag_1 AS C ON A.dat = C.dat
WHERE
    A.mandant_id = 1
    AND (
        A.mandant_id, C.kjwo) IN (
        SELECT (mandant_id, kjwo)
        FROM (
            SELECT
                b.mandant_id,
                C0.kjwo,
                (RANK() OVER (
                    PARTITION BY
                        b.mandant_id ORDER BY
                        b.mandant_id IS NULL, b.mandant_id, C0.kjwo IS NULL DESC, C0.kjwo
                        DESC
                )) * -1 AS akt_wo
            FROM dbp_msi_data.ek_sort_sortiment_mat_zeitraum_1 AS A0
            INNER JOIN (SELECT
                mandant_id,
                MAX(kjmo) AS kjmo
            FROM dbp_data.sortiment_leistung_1
            WHERE mandant_id = 1
            GROUP BY mandant_id) AS b ON A0.kjmo_sort = b.kjmo
            INNER JOIN dbp_data.woche_1 AS C0 ON A0.kjwo_bis >= C0.kjwo
            QUALIFY ((RANK() OVER (
                PARTITION BY
                    b.mandant_id ORDER BY
                    b.mandant_id IS NULL, b.mandant_id, C0.kjwo IS NULL DESC,
                    C0.kjwo DESC
            )) * -1) BETWEEN -52 AND (-1)
        ) AS t2
        GROUP BY mandant_id,
        kjwo
    )
GROUP BY
    A.mandant_id,
    B.art_id;


CREATE OR REPLACE TEMPORARY TABLE _bons_matching_de AS
SELECT
    A.mandant_id,
    b.art_matching_id,
    SUM(A.art_umsatz_af) AS art_umsatz_af,
    SUM(A.art_umsatz_sa) AS art_umsatz_sa,
    SUM(A.bon_umsatz_af) AS bon_umsatz_af,
    SUM(A.bon_umsatz_sa) AS bon_umsatz_sa,
    SUM(A.restbon_af) AS restbon_af,
    SUM(A.restbon_sa) AS restbon_sa,
    SUM(A.restbon_summe) AS restbon_summe,
    SUM(A.anz_bons_af) AS anz_bons_af,
    SUM(A.anz_bons_sa) AS anz_bons_sa,
    SUM(A.anz_bons) AS anz_bons,
    SUM(A.cpsa_fg) AS cpsa_fg
FROM `_bons_art_de` AS A
INNER JOIN (SELECT DISTINCT
    mandant_id,
    art_matching_id,
    art_id
FROM dbp_etl.art_matching_nielsen_per_1
WHERE kjwo_update = (
    SELECT MAX(kjwo_update)
    FROM dbp_etl.art_matching_nielsen_per_1
)
AND art_id <> -1) AS b ON A.mandant_id = b.mandant_id AND A.art_id = b.art_id
GROUP BY
    A.mandant_id,
    b.art_matching_id;


UPDATE dbp_etl_process.tupel_mat_etl_1 SET
    restbon_summe = b.restbon_summe,
    anz_bons_gesamt = b.anz_bons,
    anz_bons_af = b.anz_bons_af,
    anz_bons_sa = b.anz_bons_sa,
    cp_bons_sa = b.cpsa_fg
FROM `_bons_matching_de` AS b
WHERE
    tupel_mat_etl.mandant_id = b.mandant_id AND tupel_mat_etl.matching_id = b.art_matching_id AND tupel_mat_etl.a500_kjwo_update
    = (
        SELECT MAX(kjwo_update)
        FROM dbp_data.art_kl_preislage_zu_per_1
        WHERE mandant_id = 1
    );


--restbon + cherrypicker kmo


CREATE OR REPLACE TEMPORARY TABLE _bons_art_kmo AS
SELECT
    A.mandant_id,
    B.art_id,
    SUM(A.art_ums_af) AS art_umsatz_af,
    SUM(A.art_ums_sa) AS art_umsatz_sa,
    SUM(A.bon_ums_af) AS bon_umsatz_af,
    SUM(A.bon_ums_sa) AS bon_umsatz_sa,
    SUM(A.restbon_af) AS restbon_af,
    SUM(A.restbon_sa) AS restbon_sa,
    SUM(A.restbon_af) + SUM(A.restbon_sa) AS restbon_summe,
    SUM(A.art_bons_af) AS anz_bons_af,
    SUM(A.art_bons_sa) AS anz_bons_sa,
    SUM(A.art_bons_af) + SUM(A.art_bons_sa) AS anz_bons,
    SUM(A.cp_bons_sa) AS cp_bons_sa
FROM dbp_etl.bf_bons_sort_sum_1 AS A
INNER JOIN dbp_data.art_1 AS B
    ON
        A.mandant_id = B.mandant_id AND A.kl_art_id = B.kl_art_id AND B.dat_bis
        = DATE '9999-12-31'
INNER JOIN dbp_data.tag_1 AS C ON A.dat = C.dat
WHERE
    A.mandant_id > 1
    AND (
        A.mandant_id, C.kjwo) IN (
        SELECT (mandant_id, kjwo)
        FROM (
            SELECT
                b.mandant_id,
                C0.kjwo,
                (RANK() OVER (
                    PARTITION BY
                        b.mandant_id ORDER BY
                        b.mandant_id IS NULL, b.mandant_id, C0.kjwo IS NULL DESC, C0.kjwo
                        DESC
                )) * -1 AS akt_wo
            FROM dbp_msi_data.ek_sort_sortiment_mat_zeitraum_1 AS A0
            INNER JOIN (SELECT
                mandant_id,
                MAX(kjmo) AS kjmo
            FROM dbp_data.sortiment_leistung_1
            WHERE mandant_id <> 1
            GROUP BY mandant_id) AS b ON A0.kjmo_sort = b.kjmo
            INNER JOIN dbp_data.woche_1 AS C0 ON A0.kjwo_bis >= C0.kjwo
            QUALIFY ((RANK() OVER (
                PARTITION BY
                    b.mandant_id ORDER BY
                    b.mandant_id IS NULL, b.mandant_id, C0.kjwo IS NULL DESC,
                    C0.kjwo DESC
            )) * -1) BETWEEN -52 AND (-1)
        ) AS t2
        GROUP BY mandant_id,
        kjwo
    )
GROUP BY
    A.mandant_id,
    B.art_id;


CREATE OR REPLACE TEMPORARY TABLE _bons_matching_kmo AS
SELECT
    A.mandant_id,
    b.art_matching_id,
    SUM(A.art_umsatz_af) AS art_umsatz_af,
    SUM(A.art_umsatz_sa) AS art_umsatz_sa,
    SUM(A.bon_umsatz_af) AS bon_umsatz_af,
    SUM(A.bon_umsatz_sa) AS bon_umsatz_sa,
    SUM(A.restbon_af) AS restbon_af,
    SUM(A.restbon_sa) AS restbon_sa,
    SUM(A.restbon_summe) AS restbon_summe,
    SUM(A.anz_bons_af) AS anz_bons_af,
    SUM(A.anz_bons_sa) AS anz_bons_sa,
    SUM(A.anz_bons) AS anz_bons,
    SUM(A.cp_bons_sa) AS cp_bons_sa
FROM `_bons_art_kmo` AS A
INNER JOIN (SELECT DISTINCT
    mandant_id,
    art_matching_id,
    art_id
FROM dbp_etl.art_matching_nielsen_per_kmo_1
WHERE kjwo_update = (
    SELECT MAX(kjwo_update)
    FROM dbp_etl.art_matching_nielsen_per_kmo_1
)
AND art_id <> -1) AS b ON A.mandant_id = b.mandant_id AND A.art_id = b.art_id
GROUP BY
    A.mandant_id,
    b.art_matching_id;


UPDATE dbp_etl_process.tupel_mat_etl_1 SET
    restbon_summe = b.restbon_summe,
    anz_bons_gesamt = b.anz_bons,
    anz_bons_af = b.anz_bons_af,
    anz_bons_sa = b.anz_bons_sa,
    cp_bons_sa = b.cp_bons_sa
FROM `_bons_matching_kmo` AS b
WHERE
    tupel_mat_etl.mandant_id = b.mandant_id AND tupel_mat_etl.matching_id = b.art_matching_id AND tupel_mat_etl.a500_kjwo_update
    = (
        SELECT MAX(kjwo_update)
        FROM dbp_data.art_kl_preislage_zu_per_1
        WHERE mandant_id > 1
    );


---------------------------
--de Bonreichweite


CREATE OR REPLACE TABLE dbp_etl_process.sort_bon_receipt_agg_sa_de_1 AS
SELECT
    A.mandant_id,
    A.art_id,
    SUM(A.total_receipt) AS sum_total_receipt
FROM dbp_etl_process.sort_bon_receipt_de_1 AS A
INNER JOIN (
    SELECT
        dat,
        kjwo
    FROM dbp_data.tag_1
    GROUP BY
        dat,
        kjwo
) AS x ON A.bon_dat = x.dat
WHERE (
    A.mandant_id, x.kjwo) IN (
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
        FROM dbp_msi_data.ek_sort_sortiment_mat_zeitraum_1 AS A0
        INNER JOIN (SELECT
            mandant_id,
            MAX(kjmo) AS kjmo
        FROM dbp_data.sortiment_leistung_1
        WHERE mandant_id = 1
        GROUP BY mandant_id) AS b ON A0.kjmo_sort = b.kjmo
        INNER JOIN dbp_data.woche_1 AS C ON A0.kjwo_bis >= C.kjwo
        QUALIFY ((RANK() OVER (
            PARTITION BY
                b.mandant_id ORDER BY
                b.mandant_id IS NULL, b.mandant_id, C.kjwo IS NULL DESC,
                C.kjwo DESC
        )) * -1) BETWEEN -52 AND (-1)
    ) AS t4
    GROUP BY mandant_id,
    kjwo
)
AND A.anz_bons_sa_fg > 0
GROUP BY
    A.mandant_id,
    A.art_id;


CREATE OR REPLACE TABLE dbp_etl_process.sort_bon_receipt_agg_af_de_1 AS
SELECT
    A.mandant_id,
    A.art_id,
    SUM(A.total_receipt) AS sum_total_receipt
FROM dbp_etl_process.sort_bon_receipt_de_1 AS A
INNER JOIN (
    SELECT
        dat,
        kjwo
    FROM dbp_data.tag_1
    GROUP BY
        dat,
        kjwo
) AS x ON A.bon_dat = x.dat
WHERE (
    A.mandant_id, x.kjwo) IN (
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
        FROM dbp_msi_data.ek_sort_sortiment_mat_zeitraum_1 AS A0
        INNER JOIN (SELECT
            mandant_id,
            MAX(kjmo) AS kjmo
        FROM dbp_data.sortiment_leistung_1
        WHERE mandant_id = 1
        GROUP BY mandant_id) AS b ON A0.kjmo_sort = b.kjmo
        INNER JOIN dbp_data.woche_1 AS C ON A0.kjwo_bis >= C.kjwo
        QUALIFY ((RANK() OVER (
            PARTITION BY
                b.mandant_id ORDER BY
                b.mandant_id IS NULL, b.mandant_id, C.kjwo IS NULL DESC,
                C.kjwo DESC
        )) * -1) BETWEEN -52 AND (-1)
    ) AS t4
    GROUP BY mandant_id,
    kjwo
)
AND A.anz_bons_af_fg > 0
GROUP BY
    A.mandant_id,
    A.art_id;


CREATE OR REPLACE TEMPORARY TABLE _sort_bon_receipt_agg_de_lvl2_af AS
SELECT
    A.mandant_id,
    b.art_matching_id,
    SUM(A.sum_total_receipt) AS sum_total_receipt
FROM dbp_etl_process.sort_bon_receipt_agg_af_de_1 AS A
INNER JOIN (SELECT DISTINCT
    mandant_id,
    art_matching_id,
    art_id
FROM dbp_etl.art_matching_nielsen_per_1
WHERE kjwo_update = (
    SELECT MAX(kjwo_update)
    FROM dbp_etl.art_matching_nielsen_per_1
)
AND art_id <> -1) AS b ON A.mandant_id = b.mandant_id AND A.art_id = b.art_id
GROUP BY
    A.mandant_id,
    b.art_matching_id;


CREATE OR REPLACE TEMPORARY TABLE _sort_bon_receipt_agg_de_lvl2_sa AS
SELECT
    A.mandant_id,
    b.art_matching_id,
    SUM(A.sum_total_receipt) AS sum_total_receipt
FROM dbp_etl_process.sort_bon_receipt_agg_sa_de_1 AS A
INNER JOIN (SELECT DISTINCT
    mandant_id,
    art_matching_id,
    art_id
FROM dbp_etl.art_matching_nielsen_per_1
WHERE kjwo_update = (
    SELECT MAX(kjwo_update)
    FROM dbp_etl.art_matching_nielsen_per_1
)
AND art_id <> -1) AS b ON A.mandant_id = b.mandant_id AND A.art_id = b.art_id
GROUP BY
    A.mandant_id,
    b.art_matching_id;


UPDATE dbp_etl_process.tupel_mat_etl_1 SET
    anz_bons_af_markt_tag = b.sum_total_receipt
FROM `_sort_bon_receipt_agg_de_lvl2_af` AS b
WHERE
    tupel_mat_etl.mandant_id = b.mandant_id AND tupel_mat_etl.matching_id = b.art_matching_id AND tupel_mat_etl.a500_kjwo_update
    = (
        SELECT MAX(kjwo_update)
        FROM dbp_data.art_kl_preislage_zu_per_1
        WHERE mandant_id = 1
    );


UPDATE dbp_etl_process.tupel_mat_etl_1 SET
    anz_bons_sa_markt_tag = b.sum_total_receipt
FROM `_sort_bon_receipt_agg_de_lvl2_sa` AS b
WHERE
    tupel_mat_etl.mandant_id = b.mandant_id AND tupel_mat_etl.matching_id = b.art_matching_id AND tupel_mat_etl.a500_kjwo_update
    = (
        SELECT MAX(kjwo_update)
        FROM dbp_data.art_kl_preislage_zu_per_1
        WHERE mandant_id = 1
    );


--kmo Bonreichweite


CREATE OR REPLACE TABLE dbp_etl_process.sort_bon_receipt_agg_kmo_af_1 AS
SELECT
    A.mandant_id,
    A.art_id,
    SUM(A.total_receipt) AS sum_total_receipt
FROM dbp_etl_process.sort_bon_receipt_kmo_1 AS A
INNER JOIN (
    SELECT
        dat,
        kjwo
    FROM dbp_data.tag_1
    GROUP BY
        dat,
        kjwo
) AS x ON A.bon_dat = x.dat
WHERE (
    A.mandant_id, x.kjwo) IN (
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
        FROM dbp_msi_data.ek_sort_sortiment_mat_zeitraum_1 AS A0
        INNER JOIN (SELECT
            mandant_id,
            MAX(kjmo) AS kjmo
        FROM dbp_data.sortiment_leistung_1
        WHERE mandant_id > 1
        GROUP BY mandant_id) AS b ON A0.kjmo_sort = b.kjmo
        INNER JOIN dbp_data.woche_1 AS C ON A0.kjwo_bis >= C.kjwo
        QUALIFY ((RANK() OVER (
            PARTITION BY
                b.mandant_id ORDER BY
                b.mandant_id IS NULL, b.mandant_id, C.kjwo IS NULL DESC,
                C.kjwo DESC
        )) * -1) BETWEEN -52 AND (-1)
    ) AS t4
    GROUP BY mandant_id,
    kjwo
)
AND A.anz_bons_af_fg > 0
GROUP BY
    A.mandant_id,
    A.art_id;


CREATE OR REPLACE TABLE dbp_etl_process.sort_bon_receipt_agg_kmo_sa_1 AS
SELECT
    A.mandant_id,
    A.art_id,
    SUM(A.total_receipt) AS sum_total_receipt
FROM dbp_etl_process.sort_bon_receipt_kmo_1 AS A
INNER JOIN (
    SELECT
        dat,
        kjwo
    FROM dbp_data.tag_1
    GROUP BY
        dat,
        kjwo
) AS x ON A.bon_dat = x.dat
WHERE (
    A.mandant_id, x.kjwo) IN (
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
        FROM dbp_msi_data.ek_sort_sortiment_mat_zeitraum_1 AS A0
        INNER JOIN (SELECT
            mandant_id,
            MAX(kjmo) AS kjmo
        FROM dbp_data.sortiment_leistung_1
        WHERE mandant_id > 1
        GROUP BY mandant_id) AS b ON A0.kjmo_sort = b.kjmo
        INNER JOIN dbp_data.woche_1 AS C ON A0.kjwo_bis >= C.kjwo
        QUALIFY ((RANK() OVER (
            PARTITION BY
                b.mandant_id ORDER BY
                b.mandant_id IS NULL, b.mandant_id, C.kjwo IS NULL DESC,
                C.kjwo DESC
        )) * -1) BETWEEN -52 AND (-1)
    ) AS t4
    GROUP BY mandant_id,
    kjwo
)
AND A.anz_bons_sa_fg > 0
GROUP BY
    A.mandant_id,
    A.art_id;


CREATE OR REPLACE TEMPORARY TABLE _sort_bon_receipt_agg_kmo_lvl2_af AS
SELECT
    A.mandant_id,
    b.art_matching_id,
    SUM(A.sum_total_receipt) AS sum_total_receipt
FROM dbp_etl_process.sort_bon_receipt_agg_kmo_af_1 AS A
INNER JOIN (SELECT DISTINCT
    mandant_id,
    art_matching_id,
    art_id
FROM dbp_etl.art_matching_nielsen_per_kmo_1
WHERE kjwo_update = (
    SELECT MAX(kjwo_update)
    FROM dbp_etl.art_matching_nielsen_per_kmo_1
)
AND art_id <> -1) AS b ON A.mandant_id = b.mandant_id AND A.art_id = b.art_id
GROUP BY
    A.mandant_id,
    b.art_matching_id;


CREATE OR REPLACE TEMPORARY TABLE _sort_bon_receipt_agg_kmo_lvl2_sa AS
SELECT
    A.mandant_id,
    b.art_matching_id,
    SUM(A.sum_total_receipt) AS sum_total_receipt
FROM dbp_etl_process.sort_bon_receipt_agg_kmo_sa_1 AS A
INNER JOIN (SELECT DISTINCT
    mandant_id,
    art_matching_id,
    art_id
FROM dbp_etl.art_matching_nielsen_per_kmo_1
WHERE kjwo_update = (
    SELECT MAX(kjwo_update)
    FROM dbp_etl.art_matching_nielsen_per_kmo_1
)
AND art_id <> -1) AS b ON A.mandant_id = b.mandant_id AND A.art_id = b.art_id
GROUP BY
    A.mandant_id,
    b.art_matching_id;


UPDATE dbp_etl_process.tupel_mat_etl_1 SET
    anz_bons_af_markt_tag = b.sum_total_receipt
FROM `_sort_bon_receipt_agg_kmo_lvl2_af` AS b
WHERE
    tupel_mat_etl.mandant_id = b.mandant_id AND tupel_mat_etl.matching_id = b.art_matching_id AND tupel_mat_etl.a500_kjwo_update
    = (
        SELECT MAX(kjwo_update)
        FROM dbp_data.art_kl_preislage_zu_per_1
        WHERE mandant_id > 1
    );


UPDATE dbp_etl_process.tupel_mat_etl_1 SET
    anz_bons_sa_markt_tag = b.sum_total_receipt
FROM `_sort_bon_receipt_agg_kmo_lvl2_sa` AS b
WHERE
    tupel_mat_etl.mandant_id = b.mandant_id AND tupel_mat_etl.matching_id = b.art_matching_id AND tupel_mat_etl.a500_kjwo_update
    = (
        SELECT MAX(kjwo_update)
        FROM dbp_data.art_kl_preislage_zu_per_1
        WHERE mandant_id > 1
    );
