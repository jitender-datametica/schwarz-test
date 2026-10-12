UPDATE ${TEMP_TABLE} SET
    wug_id = 0
WHERE mandant_id = 1 AND art_id = 980001200;


UPDATE dbp_data.art_wg_zu_per_2 SET
    dat_bis = t1.`_dat_bis` FROM (SELECT
    art_id AS `_art_id`,
    mandant_id AS `_mandant_id`,
    wug_id AS `_wug_id`,
    wg_id AS `_wg_id`,
    dat_von AS `_dat_von`,
    arthiertyp_id AS `_arthiertyp_id`,
    dat_bis AS `_dat_bis`
FROM ${TEMP_TABLE}) AS t1_2
WHERE
    art_wg_zu_per.art_id = t1.`_art_id` AND art_wg_zu_per.mandant_id = t1.`_mandant_id` AND art_wg_zu_per.arthiertyp_id
    = t1.`_arthiertyp_id` AND art_wg_zu_per.wg_id = t1.`_wg_id` AND art_wg_zu_per.wug_id = t1.`_wug_id` AND
    art_wg_zu_per.dat_von = t1.`_dat_von`;


UPDATE dbp_data.art_wg_zu_per_2 SET
    wug_id = dt1.`_wug_id`,
    wg_id = dt1.`_wg_id` FROM (
    SELECT
        art_id AS `_art_id`,
        mandant_id AS `_mandant_id`,
        MAX(wug_id) AS `_wug_id`,
        MAX(wg_id) AS `_wg_id`,
        dat_von AS `_dat_von`,
        arthiertyp_id AS `_arthiertyp_id`,
        dat_bis AS `_dat_bis`
    FROM ${TEMP_TABLE}
    GROUP BY
        `_art_id`,
        `_mandant_id`,
        `_dat_von`,
        `_arthiertyp_id`,
        `_dat_bis`
) AS dt1
WHERE
    art_wg_zu_per.art_id = dt1.`_art_id` AND art_wg_zu_per.dat_von = dt1.`_dat_von` AND art_wg_zu_per.arthiertyp_id =
    dt1.`_arthiertyp_id` AND art_wg_zu_per.mandant_id = dt1.`_mandant_id` AND art_wg_zu_per.dat_bis = PARSE_DATE(
        '%F',
        '9999-12-31'
    ) AND (art_wg_zu_per.wug_id <> dt1.`_wug_id` OR art_wg_zu_per.wg_id <> dt1.`_wg_id`
    );


INSERT INTO dbp_data.art_wg_zu_per_2 (mandant_id, dat_von, art_id, arthiertyp_id, wg_id, dat_bis, wug_id)
(
    SELECT
        A.mandant_id,
        A.dat_von,
        A.art_id,
        A.arthiertyp_id,
        A.wg_id,
        A.dat_bis,
        A.wug_id
    FROM ${TEMP_TABLE} AS A
    LEFT JOIN dbp_data.art_wg_zu_per_2 AS B
        ON
            A.mandant_id = B.mandant_id AND A.art_id = B.art_id AND A.arthiertyp_id
            = B.arthiertyp_id AND A.wg_id = B.wg_id AND A.wug_id = B.wug_id AND B.dat_bis = PARSE_DATE('%F', '9999-12-31')
            AND A.dat_von >= B.dat_von
    WHERE
        B.art_id IS NULL
        AND (A.art_id, A.mandant_id, A.wg_id, A.wug_id, A.arthiertyp_id, A.dat_bis) NOT IN (SELECT (
            art_id, mandant_id, wg_id,
            wug_id, arthiertyp_id, dat_bis
        )
        FROM dbp_data.art_wg_zu_per_2)
    GROUP BY
        A.mandant_id,
        A.dat_von,
        A.art_id,
        A.arthiertyp_id,
        A.wg_id,
        A.dat_bis,
        A.wug_id
);


UPDATE dbp_data.art_wg_zu_per_2 AS art_wg_zu_per0 SET
    dat_bis = dt1.dat_bis FROM (SELECT
    mandant_id,
    art_id,
    dat_von,
    arthiertyp_id,
    CASE
        WHEN (SUM(ROUND(CAST(
            FORMAT_DATE('%Y%m%d', dat_von) AS BIGNUMERIC), 0)) OVER (PARTITION BY
            mandant_id, art_id,
            arthiertyp_id
        ORDER BY dat_von IS NULL, dat_von
        ROWS BETWEEN 1 PRECEDING AND CURRENT ROW)) - ROUND(CAST(FORMAT_DATE('%Y%m%d', dat_von) AS BIGNUMERIC),
        0) = 0
            THEN PARSE_DATE('%F', '9999-12-31')
        ELSE DATE_ADD(DATE(CAST((SUM(ROUND(CAST(FORMAT_DATE('%Y%m%d', dat_von) AS BIGNUMERIC), 0)) OVER (
            PARTITION BY
                mandant_id, art_id, arthiertyp_id
            ORDER BY dat_von IS NULL, dat_von ROWS BETWEEN 1 PRECEDING AND CURRENT ROW
        )) - ROUND(CAST(FORMAT_DATE('%Y%m%d', dat_von) AS BIGNUMERIC), 0) AS STRING)), INTERVAL -1 DAY)
    END AS dat_bis
FROM dbp_data.art_wg_zu_per_2) AS dt1
WHERE
    art_wg_zu_per0.mandant_id = dt1.mandant_id AND art_wg_zu_per0.art_id = dt1.art_id AND art_wg_zu_per0.arthiertyp_id
    = dt1.arthiertyp_id AND art_wg_zu_per0.dat_von = dt1.dat_von AND art_wg_zu_per0.dat_bis <> dt1.dat_bis;


UPDATE dbp_data.art_wg_zu_per_2 AS art_wg_zu_per0 SET
    dat_von = b.dat_von_mara FROM (
    SELECT
        a.mandant_id,
        a.art_id,
        a.dat_von_wg,
        b.dat_von_mara
    FROM (
        SELECT
            mandant_id,
            art_id,
            MIN(dat_von) AS dat_von_wg
        FROM dbp_data.art_wg_zu_per_2
        GROUP BY
            mandant_id,
            art_id
    ) AS a
    INNER JOIN (
        SELECT
            mandant_id,
            art_id,
            MIN(dat_von) AS dat_von_mara
        FROM dbp_data.art_2
        GROUP BY
            mandant_id,
            art_id
    ) AS b ON a.mandant_id = b.mandant_id AND a.art_id = b.art_id
    WHERE a.dat_von_wg > b.dat_von_mara
) AS b
WHERE art_wg_zu_per0.mandant_id = b.mandant_id AND art_wg_zu_per0.art_id = b.art_id AND art_wg_zu_per0.dat_von = b.dat_von_wg;


INSERT INTO dbp_etl_process.dwh_wg_erfass_artikel_2 (art_id, mandant_id, wg_id, arthiertyp_id)
(
    SELECT
        A.art_id,
        1 AS mandant_id,
        AW.wg_id AS wgr,
        2 AS `_arthiertyp_id`
    FROM dbp_data.art_2 AS A
    INNER JOIN dbp_data.art_wg_zu_per_2 AS AW
        ON
            A.art_id = AW.art_id AND A.wg_art_fg = 1 AND A.mandant_id =
            1 AND AW.arthiertyp_id = 2 AND AW.mandant_id = 1 AND A.dat_bis = PARSE_DATE('%F', '9999-12-31') AND AW.dat_bis =
            PARSE_DATE('%F', '9999-12-31')
    LEFT JOIN dbp_data.wg_per_2 AS WG
        ON
            AW.wg_id = WG.wg_id AND WG.mandant_id = 1 AND A.mwst_id = WG.lead_mwst_id
            AND WG.arthiertyp_id = 2 AND WG.dat_bis = PARSE_DATE('%F', '9999-12-31')
    WHERE (
        AW.wg_id, 2) NOT IN (
        SELECT (wg_id, arthiertyp_id)
        FROM dbp_etl_process.dwh_wg_erfass_artikel_2
    )
    QUALIFY (ROW_NUMBER() OVER (PARTITION BY AW.wg_id ORDER BY COALESCE(WG.lead_mwst_id - A.mwst_id, 999) IS NULL, COALESCE(WG.lead_mwst_id - A.mwst_id, 999), A.art_id IS NULL DESC, A.art_id DESC)) = 1
);
