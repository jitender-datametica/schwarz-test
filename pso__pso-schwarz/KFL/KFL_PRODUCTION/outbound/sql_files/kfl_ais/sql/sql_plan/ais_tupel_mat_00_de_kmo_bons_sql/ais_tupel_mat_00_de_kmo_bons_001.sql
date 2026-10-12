CREATE OR REPLACE TABLE dbp_etl.sort_kpi_tag_basis (
    mandant_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    dat DATE,
    kasse_nr INTEGER NOT NULL,
    bon_nr INTEGER NOT NULL,
    bon_id STRING(25) COLLATE 'und:ci' NOT NULL,
    kl_art_id INTEGER NOT NULL,
    bon_umsatz_af NUMERIC(29, 2) NOT NULL,
    bon_umsatz_sa NUMERIC(29, 2) NOT NULL,
    bon_absatz_af NUMERIC(29, 3) NOT NULL,
    bon_absatz_sa NUMERIC(29, 3) NOT NULL,
    art_umsatz_af NUMERIC(29, 2) NOT NULL,
    art_umsatz_sa NUMERIC(29, 2) NOT NULL,
    art_absatz_af NUMERIC(29, 3) NOT NULL,
    art_absatz_sa NUMERIC(29, 3) NOT NULL,
    cpaf_fg INTEGER NOT NULL,
    cpsa_fg INTEGER NOT NULL
);


INSERT INTO dbp_etl.sort_kpi_tag_basis (
    mandant_id, wup_id, dat, kasse_nr, bon_nr, bon_id, kl_art_id,
    bon_umsatz_af,
    bon_umsatz_sa,
    bon_absatz_af,
    bon_absatz_sa,
    art_umsatz_af,
    art_umsatz_sa,
    art_absatz_af,
    art_absatz_sa,
    cpaf_fg, cpsa_fg
)
(
    SELECT
        OK.mandant_id AS mandant_id,
        OK.wup_id AS wup_id,
        OK.bon_dat AS dat,
        OK.kasse_nr AS kasse_nr,
        OK.bon_nr AS bon_nr,
        OK.bon_id,
        OV.kl_art_id AS kl_art_id,
        0 AS bon_umsatz_af,
        0 AS bon_umsatz_sa,
        0 AS bon_absatz_af,
        0 AS bon_absatz_sa,
        CAST(SUM(CASE
            WHEN TRIM(OV.aktion_id) = ''
                THEN OV.umsatz_brutto
            ELSE 0
        END) AS NUMERIC) AS art_umsatz_af,
        CAST(SUM(CASE
            WHEN TRIM(OV.aktion_id) <> ''
                THEN OV.umsatz_brutto
            ELSE 0
        END) AS NUMERIC) AS art_umsatz_sa,
        CAST(SUM(CASE
            WHEN TRIM(OV.aktion_id) = ''
                THEN OV.menge
            ELSE 0
        END) AS NUMERIC) AS art_absatz_af,
        CAST(SUM(CASE
            WHEN TRIM(OV.aktion_id) <> ''
                THEN OV.menge
            ELSE 0
        END) AS NUMERIC) AS art_absatz_sa,
        0 AS cpaf_fg,
        0 AS cpsa_fg
    FROM dbp_spezial.v_ods_bon_kopf_union AS OK
    INNER JOIN dbp_spezial.v_ods_bon_verkauf_union AS OV
        ON
            OK.mandant_id = OV.mandant_id AND OK.wup_id
            = OV.wup_id AND OK.bon_id = OV.bon_id AND OK.bon_dat = OV.bon_dat
    WHERE
        OK.bon_dat BETWEEN (
            SELECT MIN(dat)
            FROM dbp_data.tag
            WHERE akt_wo = -5) AND (
            SELECT MAX(dat)
            FROM dbp_data.tag
            WHERE akt_wo = -1
        )
        AND OK.turnover_fg = 1
        AND OV.wg_id <> 980
        AND (
            OK.bon_id, OK.bon_dat) NOT IN (
            SELECT (bon_id, bon_dat)
            FROM dbp_spezial.v_ods_bon_storno_union
        )
    GROUP BY
        OK.mandant_id,
        OK.wup_id,
        dat,
        OK.kasse_nr,
        OK.bon_nr,
        OK.bon_id,
        OV.kl_art_id
);


UPDATE dbp_etl.sort_kpi_tag_basis SET
    bon_umsatz_af
    = CAST(sort_kpi_tag_basis.bon_umsatz_af + shop.`_bon_umsatz_af` AS NUMERIC),
    bon_umsatz_sa
    = CAST(sort_kpi_tag_basis.bon_umsatz_sa + shop.`_bon_umsatz_sa` AS NUMERIC),
    bon_absatz_af
    = CAST(sort_kpi_tag_basis.bon_absatz_af + shop.`_bon_absatz_af` AS NUMERIC),
    bon_absatz_sa
    = CAST(sort_kpi_tag_basis.bon_absatz_sa + shop.`_bon_absatz_sa` AS NUMERIC)
FROM (
    SELECT
        OK.mandant_id
            AS
            `_mandant_id`,
        OK.wup_id AS `_wup_id`,
        OK.bon_dat AS `_dat`,
        OK.kasse_nr AS `_kasse_nr`,
        OK.bon_nr AS `_bon_nr`,
        OK.bon_id AS `_bon_id`,
        SUM(CASE
            WHEN TRIM(OV.aktion_id) = ''
                THEN OV.umsatz_brutto
            ELSE 0
        END) AS `_bon_umsatz_af`,
        SUM(CASE
            WHEN TRIM(OV.aktion_id) <> ''
                THEN OV.umsatz_brutto
            ELSE 0
        END) AS `_bon_umsatz_sa`,
        SUM(CASE
            WHEN TRIM(OV.aktion_id) = ''
                THEN OV.menge
            ELSE 0
        END) AS `_bon_absatz_af`,
        SUM(CASE
            WHEN TRIM(OV.aktion_id) <> ''
                THEN OV.menge
            ELSE 0
        END) AS `_bon_absatz_sa`
    FROM dbp_spezial.v_ods_bon_kopf_union AS OK
    INNER JOIN dbp_spezial.v_ods_bon_verkauf_union AS OV
        ON
            OK.mandant_id = OV.mandant_id AND OK.wup_id
            = OV.wup_id AND OK.bon_id = OV.bon_id AND OK.bon_dat = OV.bon_dat
    WHERE
        OK.bon_dat BETWEEN (
            SELECT MIN(dat)
            FROM dbp_data.tag
            WHERE akt_wo = -5) AND (
            SELECT MAX(dat)
            FROM dbp_data.tag
            WHERE akt_wo = -1
        )
        AND OK.turnover_fg = 1
        AND OV.wg_id <> 980
        AND (
            OK.bon_id, OK.bon_dat) NOT IN (
            SELECT (bon_id, bon_dat)
            FROM dbp_spezial.v_ods_bon_storno_union
        )
    GROUP BY
        `_mandant_id`,
        `_wup_id`,
        `_dat`,
        `_kasse_nr`,
        `_bon_nr`,
        `_bon_id`
) AS shop
WHERE
    sort_kpi_tag_basis.mandant_id = shop.`_mandant_id`
    AND sort_kpi_tag_basis.wup_id = shop.`_wup_id`
    AND sort_kpi_tag_basis.dat = shop.`_dat` AND sort_kpi_tag_basis.kasse_nr = shop.`_kasse_nr` AND sort_kpi_tag_basis.bon_nr
    = shop.`_bon_nr` AND sort_kpi_tag_basis.bon_id = shop.`_bon_id`;


UPDATE dbp_etl.sort_kpi_tag_basis SET
    cpaf_fg = 1
WHERE
    (art_umsatz_af + art_umsatz_sa)
    / IF(art_absatz_af + art_absatz_sa = 0, NULL, art_absatz_af + art_absatz_sa)
    >= 8
    AND art_umsatz_af / IF(
        bon_umsatz_af + bon_umsatz_sa = 0, NULL, bon_umsatz_af + bon_umsatz_sa
    ) > 0.85
    OR (
        art_umsatz_af
        + art_umsatz_sa
    )
    / IF(art_absatz_af + art_absatz_sa = 0, NULL, art_absatz_af + art_absatz_sa
    ) < 8
    AND art_umsatz_af / IF(bon_umsatz_af + bon_umsatz_sa = 0, NULL, bon_umsatz_af + bon_umsatz_sa) > 0.6;


UPDATE dbp_etl.sort_kpi_tag_basis SET
    cpsa_fg = 1
WHERE
    (art_umsatz_af + art_umsatz_sa)
    / IF(art_absatz_af + art_absatz_sa = 0, NULL, art_absatz_af + art_absatz_sa)
    >= 8
    AND art_umsatz_sa / IF(
        bon_umsatz_af + bon_umsatz_sa = 0, NULL, bon_umsatz_af + bon_umsatz_sa
    ) > 0.85
    OR (
        art_umsatz_af
        + art_umsatz_sa
    )
    / IF(art_absatz_af + art_absatz_sa = 0, NULL, art_absatz_af + art_absatz_sa
    ) < 8
    AND art_umsatz_sa / IF(bon_umsatz_af + bon_umsatz_sa = 0, NULL, bon_umsatz_af + bon_umsatz_sa) > 0.6;


UPDATE dbp_etl.sort_kpi_tag_basis SET
    cpsa_fg = 1
WHERE
    art_absatz_sa / IF(bon_absatz_af + bon_absatz_sa = 0, NULL, bon_absatz_af + bon_absatz_sa) >= 0.6;


UPDATE dbp_etl.sort_kpi_tag_basis SET
    cpaf_fg = 1
WHERE
    art_absatz_af / IF(bon_absatz_af + bon_absatz_sa = 0, NULL, bon_absatz_af + bon_absatz_sa) >= 0.6;


DELETE FROM dbp_etl.sort_kpi_woche_basis
WHERE kjwo IN (
    SELECT B.kjwo
    FROM dbp_etl.sort_kpi_tag_basis AS A
    INNER JOIN dbp_data.tag AS B ON A.dat = B.dat
    GROUP BY B.kjwo
);


INSERT INTO dbp_etl.sort_kpi_woche_basis (
    mandant_id, wup_id, kjwo, kl_art_id, anz_bons, bon_ums_af,
    bon_ums_sa,
    bon_abs_af,
    bon_abs_sa,
    art_ums_af,
    art_ums_sa,
    art_abs_af,
    art_abs_sa,
    restbon_af,
    restbon_sa,
    art_bons_af,
    art_bons_sa, cp_bons_af, cp_bons_sa
)
(
    SELECT
        A.mandant_id,
        A.wup_id,
        B.kjwo,
        A.kl_art_id,
        0 AS anz_bons,
        SUM(A.bon_umsatz_af) AS bon_ums_af,
        SUM(A.bon_umsatz_sa) AS bon_ums_sa,
        SUM(A.bon_absatz_af) AS bon_abs_af,
        SUM(A.bon_absatz_sa) AS bon_abs_sa,
        SUM(A.art_umsatz_af) AS art_ums_af,
        SUM(A.art_umsatz_sa) AS art_ums_sa,
        SUM(A.art_absatz_af) AS art_abs_af,
        SUM(A.art_absatz_sa) AS art_abs_sa,
        CAST(SUM(CASE
            WHEN A.art_umsatz_af > 0
                THEN A.bon_umsatz_af + A.bon_umsatz_sa - A.art_umsatz_af
            ELSE 0
        END) AS NUMERIC) AS restbon_af,
        CAST(SUM(CASE
            WHEN A.art_umsatz_sa > 0
                THEN A.bon_umsatz_af + A.bon_umsatz_sa - A.art_umsatz_sa
            ELSE 0
        END) AS NUMERIC) AS restbon_sa,
        SUM(CASE
            WHEN A.art_umsatz_af > 0
                THEN 1
            ELSE 0
        END) AS art_bons_af,
        SUM(CASE
            WHEN A.art_umsatz_sa > 0
                THEN 1
            ELSE 0
        END) AS art_bons_sa,
        SUM(A.cpaf_fg) AS cp_bons_af,
        SUM(A.cpsa_fg) AS cp_bons_sa
    FROM dbp_etl.sort_kpi_tag_basis AS A
    INNER JOIN dbp_data.tag AS B ON A.dat = B.dat
    GROUP BY
        A.mandant_id,
        A.wup_id,
        B.kjwo,
        A.kl_art_id,
        anz_bons
);


UPDATE dbp_etl.sort_kpi_woche_basis SET
    anz_bons = b.anz_bons FROM (
    SELECT
        A.mandant_id,
        A.wup_id,
        B.kjwo,
        COUNT(DISTINCT A.bon_id) AS anz_bons
    FROM dbp_etl.sort_kpi_tag_basis AS A
    INNER JOIN dbp_data.tag AS B ON A.dat = B.dat
    GROUP BY
        A.mandant_id,
        A.wup_id,
        B.kjwo
) AS b
WHERE
    sort_kpi_woche_basis.mandant_id = b.mandant_id
    AND sort_kpi_woche_basis.wup_id = b.wup_id
    AND sort_kpi_woche_basis
    .kjwo = b.kjwo;
