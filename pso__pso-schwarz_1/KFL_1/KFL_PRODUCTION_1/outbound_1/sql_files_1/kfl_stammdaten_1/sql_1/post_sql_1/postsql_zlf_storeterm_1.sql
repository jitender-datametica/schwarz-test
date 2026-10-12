CREATE OR REPLACE TABLE dbp_etl.zlf_storeterm_xxx_1 (
    mandant_id INTEGER,
    wup_id INTEGER,
    nb_id INTEGER,
    kunde_id INTEGER,
    wg_id INTEGER,
    arthiertyp_id INTEGER,
    sortimentslistenart_id STRING(1) COLLATE 'und:ci',
    terminierungsgruppe_1_id STRING(3) COLLATE 'und:ci',
    terminierungsgruppe_2_id STRING(2) COLLATE 'und:ci',
    terminierungsgruppe_3_id STRING(2) COLLATE 'und:ci',
    kwoab DATE,
    kwobi DATE,
    auslieferungsgruppe_id STRING(4) COLLATE 'und:ci',
    disposition_rhythmus_ltf_id STRING(3) COLLATE 'und:ci',
    we_bearbeitungszeit INTEGER,
    planlieferzeit INTEGER,
    td_insert TIMESTAMP
);


INSERT INTO dbp_etl.zlf_storeterm_xxx_1 (
    mandant_id, wup_id, nb_id, kunde_id, wg_id, arthiertyp_id,
    sortimentslistenart_id, terminierungsgruppe_1_id, terminierungsgruppe_2_id, terminierungsgruppe_3_id, kwoab, kwobi,
    auslieferungsgruppe_id, disposition_rhythmus_ltf_id, we_bearbeitungszeit, planlieferzeit
)
(
    SELECT
        A.mandant_id,
        A.wup_id,
        A.nb_id,
        A.kunde_id,
        b.wg_id,
        A.arthiertyp_id,
        b.sortimentslistenart_id,
        A.terminierungsgruppe_1_id,
        A.terminierungsgruppe_2_id,
        A.terminierungsgruppe_3_id,
        COALESCE(C.wo_dat_von, PARSE_DATE('%F', '1900-01-01')) AS c_wo_dat_von,
        COALESCE(D.wo_dat_bis, PARSE_DATE('%F', '9999-12-31')) AS d_wo_dat_bis,
        A.auslieferungsgruppe_id,
        A.disposition_rhythmus_ltf_id,
        A.we_bearbeitungszeit,
        A.planlieferzeit
    FROM ${TEMP_TABLE} AS A
    INNER JOIN (
        SELECT
            auslieferungsgruppe_id,
            wg_id,
            sortimentslistenart_id
        FROM dbp_etl.zlf_auslfel_zwischenspeicher_1
        GROUP BY
            auslieferungsgruppe_id,
            wg_id,
            sortimentslistenart_id
    ) AS b ON A.auslieferungsgruppe_id = b.auslieferungsgruppe_id
    LEFT JOIN dbp_data.woche_1 AS C ON A.kwoab = C.kjwo
    LEFT JOIN dbp_data.woche_1 AS D ON A.kwobi = D.kjwo
    WHERE A.nb_id = -111
);


DELETE FROM dbp_data.wup_kunde_wg_disporhythmus_lft_zu_per_1
WHERE (
    mandant_id, wup_id, kunde_id, wg_id, terminierungsgruppe_1_id, terminierungsgruppe_2_id, terminierungsgruppe_3_id,
    auslieferungsgruppe_id) IN (
    SELECT (
        mandant_id, wup_id, kunde_id,
        wg_id, terminierungsgruppe_1_id, terminierungsgruppe_2_id, terminierungsgruppe_3_id,
        auslieferungsgruppe_id
    )
    FROM dbp_etl.zlf_storeterm_xxx_1
);


INSERT INTO dbp_data.wup_kunde_wg_disporhythmus_lft_zu_per_1 (
    mandant_id, wup_id, nb_id, kunde_id, wg_id,
    arthiertyp_id, sortimentslistenart_id, terminierungsgruppe_1_id, terminierungsgruppe_2_id, terminierungsgruppe_3_id,
    dat_von, dat_bis, auslieferungsgruppe_id, disposition_rhythmus_ltf_id, we_bearbeitungszeit, planlieferzeit
)
(
    SELECT
        mandant_id,
        wup_id,
        nb_id,
        kunde_id,
        wg_id,
        arthiertyp_id,
        MIN(sortimentslistenart_id) AS sortimentslistenart_id,
        terminierungsgruppe_1_id,
        terminierungsgruppe_2_id,
        terminierungsgruppe_3_id,
        kwoab,
        kwobi,
        auslieferungsgruppe_id,
        MAX(disposition_rhythmus_ltf_id) AS disposition_rhythmus_ltf_id,
        MAX(we_bearbeitungszeit) AS we_bearbeitungszeit,
        MAX(planlieferzeit) AS planlieferzeit
    FROM dbp_etl.zlf_storeterm_xxx_1
    GROUP BY
        mandant_id,
        wup_id,
        nb_id,
        kunde_id,
        wg_id,
        arthiertyp_id,
        terminierungsgruppe_1_id,
        terminierungsgruppe_2_id,
        terminierungsgruppe_3_id,
        kwoab,
        kwobi,
        auslieferungsgruppe_id
);


UPDATE dbp_data.wup_kunde_wg_disporhythmus_lft_zu_per_1 SET
    dat_bis = dt1.dat_bis FROM (SELECT
    mandant_id,
    wg_id,
    wup_id,
    kunde_id,
    terminierungsgruppe_1_id,
    terminierungsgruppe_2_id,
    terminierungsgruppe_3_id,
    auslieferungsgruppe_id,
    dat_von,
    CASE
        WHEN (SUM(ROUND(CAST(
            FORMAT_DATE('%Y%m%d', dat_von) AS BIGNUMERIC), 0)) OVER (PARTITION BY
            mandant_id, wup_id, wg_id,
            kunde_id, terminierungsgruppe_1_id, terminierungsgruppe_2_id, terminierungsgruppe_3_id,
            auslieferungsgruppe_id
        ORDER BY dat_von IS NULL, dat_von
        ROWS BETWEEN 1 PRECEDING AND CURRENT ROW)) - ROUND(CAST(FORMAT_DATE('%Y%m%d', dat_von) AS BIGNUMERIC),
        0) = 0
            THEN PARSE_DATE('%F', '9999-12-31')
        ELSE DATE_ADD(DATE(CAST((SUM(ROUND(CAST(FORMAT_DATE('%Y%m%d', dat_von) AS BIGNUMERIC), 0)) OVER (PARTITION BY
            mandant_id, wup_id, wg_id, kunde_id, terminierungsgruppe_1_id, terminierungsgruppe_2_id,
            terminierungsgruppe_3_id, auslieferungsgruppe_id
        ORDER BY dat_von IS NULL, dat_von ROWS BETWEEN 1 PRECEDING
        AND CURRENT ROW)) - ROUND(CAST(FORMAT_DATE('%Y%m%d', dat_von) AS BIGNUMERIC), 0) AS STRING)), INTERVAL -1
        DAY)
    END AS dat_bis
FROM (
    SELECT
        mandant_id,
        wg_id,
        wup_id,
        kunde_id,
        terminierungsgruppe_1_id,
        terminierungsgruppe_2_id,
        terminierungsgruppe_3_id,
        auslieferungsgruppe_id,
        dat_von
    FROM dbp_data.wup_kunde_wg_disporhythmus_lft_zu_per_1 AS L
    GROUP BY
        mandant_id,
        wup_id,
        kunde_id,
        wg_id,
        terminierungsgruppe_1_id,
        terminierungsgruppe_2_id,
        terminierungsgruppe_3_id,
        dat_von,
        auslieferungsgruppe_id
) AS t0) AS dt1
WHERE
    wup_kunde_wg_disporhythmus_lft_zu_per.mandant_id = dt1.mandant_id AND wup_kunde_wg_disporhythmus_lft_zu_per.wup_id
    = dt1.wup_id AND wup_kunde_wg_disporhythmus_lft_zu_per.kunde_id = dt1.kunde_id AND
    wup_kunde_wg_disporhythmus_lft_zu_per.wg_id = dt1.wg_id AND wup_kunde_wg_disporhythmus_lft_zu_per.terminierungsgruppe_1_id
    = dt1.terminierungsgruppe_1_id AND wup_kunde_wg_disporhythmus_lft_zu_per.terminierungsgruppe_2_id = dt1.terminierungsgruppe_2_id
    AND wup_kunde_wg_disporhythmus_lft_zu_per.terminierungsgruppe_3_id = dt1.terminierungsgruppe_3_id AND
    wup_kunde_wg_disporhythmus_lft_zu_per.auslieferungsgruppe_id = dt1.auslieferungsgruppe_id AND
    wup_kunde_wg_disporhythmus_lft_zu_per.dat_von = dt1.dat_von AND wup_kunde_wg_disporhythmus_lft_zu_per.dat_bis <> dt1.dat_bis;
