CREATE OR REPLACE TEMPORARY TABLE _xxx_woche_sort AS
SELECT C.kjmo AS kjmo_sort
FROM dbp_data.monat AS A
INNER JOIN (
    SELECT kjmo_sort
    FROM dbp_msi_data.ek_sort_sortiment_mat_zeitraum
    WHERE kjwo_bis IN (
        SELECT MAX(kjwo) AS a1886115246
        FROM dbp_data.art_nielsen_fakten_kjwo
        WHERE mandant_id = 1
    )
) AS b
    ON A.kjmo = b.kjmo_sort
INNER JOIN dbp_data.monat AS C ON A.akt_mo = C.akt_mo;


DELETE FROM dbp_etl.bf_bons_sort_basis
WHERE dat BETWEEN (
    SELECT MIN(dat)
    FROM dbp_data.tag
    WHERE akt_mo = -4) AND (
    SELECT dat_bis
    FROM dbp_msi_data.ek_sort_sortiment_mat_zeitraum
    WHERE
        kjmo_sort IN (
            SELECT kjmo_sort
            FROM `_xxx_woche_sort`
        )
);


CREATE OR REPLACE TABLE dbp_etl.bf_bons_sort_basis_tmp_de LIKE dbp_etl.bf_bons_sort_basis;


INSERT INTO dbp_etl.bf_bons_sort_basis_tmp_de
(
    SELECT
        OK.mandant_id,
        OK.wup_id,
        OK.bon_dat,
        OK.kasse_nr,
        OK.bon_nr,
        OK.bon_id,
        OV.kl_art_id,
        0,
        0,
        0,
        0,
        CAST(SUM(CASE
            WHEN OV.aktion_id = ''
                THEN OV.umsatz_brutto
            ELSE 0
        END) AS NUMERIC) AS `_art_umsatz_af`,
        CAST(SUM(CASE
            WHEN OV.aktion_id <> ''
                THEN OV.umsatz_brutto
            ELSE 0
        END) AS NUMERIC) AS `_art_umsatz_sa`,
        CAST(SUM(CASE
            WHEN OV.aktion_id = ''
                THEN OV.menge
            ELSE 0
        END) AS NUMERIC) AS `_art_absatz_af`,
        CAST(SUM(CASE
            WHEN OV.aktion_id <> ''
                THEN OV.menge
            ELSE 0
        END) AS NUMERIC) AS `_art_absatz_sa`,
        0,
        0
    FROM dbp_spezial.v_ods_bon_kopf_union AS OK
    INNER JOIN dbp_spezial.v_ods_bon_verkauf_union AS OV
        ON
            OK.mandant_id = OV.mandant_id AND OK.wup_id =
            OV.wup_id AND OK.bon_id = OV.bon_id
    WHERE
        OK.bon_dat BETWEEN (
            SELECT MIN(dat)
            FROM dbp_data.tag
            WHERE akt_mo = -4) AND (
            SELECT dat_bis
            FROM dbp_msi_data.ek_sort_sortiment_mat_zeitraum
            WHERE
                kjmo_sort IN (
                    SELECT kjmo_sort
                    FROM `_xxx_woche_sort`
                )
        )
        AND OV.bon_dat BETWEEN (
            SELECT MIN(dat)
            FROM dbp_data.tag
            WHERE akt_mo = -4) AND (
            SELECT dat_bis
            FROM dbp_msi_data.ek_sort_sortiment_mat_zeitraum
            WHERE
                kjmo_sort IN (
                    SELECT kjmo_sort
                    FROM `_xxx_woche_sort`
                )
        )
        AND OK.mandant_id = 1
        AND OV.mandant_id = 1
        AND OK.turnover_fg = 1
        AND OV.talon_id = 0
        AND OV.wg_id <> 980
        AND (
            OK.bon_id, OK.bon_dat) NOT IN (
            SELECT (bon_id, bon_dat)
            FROM dbp_spezial.v_ods_bon_storno_union
        )
    GROUP BY
        OK.mandant_id,
        OK.wup_id,
        OK.bon_dat,
        OK.kasse_nr,
        OK.bon_nr,
        OK.bon_id,
        OV.kl_art_id
);


INSERT INTO dbp_etl.bf_bons_sort_basis_tmp_de
(
    SELECT
        OK.mandant_id ,
        OK.wup_id ,
        OK.bon_dat,
        OK.kasse_nr,
        OK.bon_nr ,
        OK.bon_id,
        OV.kl_art_id,
        0,
        0,
        0,
        0,
        CAST(SUM(CASE
            WHEN OV.aktion_id = ''
                THEN OV.umsatz_brutto
            ELSE 0
        END) AS NUMERIC) AS `_art_umsatz_af`,
        CAST(SUM(CASE
            WHEN OV.aktion_id <> ''
                THEN OV.umsatz_brutto
            ELSE 0
        END) AS NUMERIC) AS `_art_umsatz_sa`,
        CAST(SUM(CASE
            WHEN OV.aktion_id = ''
                THEN OV.menge
            ELSE 0
        END) AS NUMERIC) AS `_art_absatz_af`,
        CAST(SUM(CASE
            WHEN OV.aktion_id <> ''
                THEN OV.menge
            ELSE 0
        END) AS NUMERIC) AS `_art_absatz_sa`,
        0,
        0
    FROM dbp_spezial.v_ods_bon_kopf_union AS OK
    INNER JOIN dbp_spezial.v_ods_bon_verkauf_union AS OV
        ON
            OK.mandant_id = OV.mandant_id AND OK.wup_id =
            OV.wup_id AND OK.bon_id = OV.bon_id
    WHERE
        OK.bon_dat BETWEEN (
            SELECT MIN(dat)
            FROM dbp_data.tag
            WHERE akt_mo = -4) AND (
            SELECT dat_bis
            FROM dbp_msi_data.ek_sort_sortiment_mat_zeitraum
            WHERE
                kjmo_sort IN (
                    SELECT kjmo_sort
                    FROM `_xxx_woche_sort`
                )
        )
        AND OV.bon_dat BETWEEN (
            SELECT MIN(dat)
            FROM dbp_data.tag
            WHERE akt_mo = -4) AND (
            SELECT dat_bis
            FROM dbp_msi_data.ek_sort_sortiment_mat_zeitraum
            WHERE
                kjmo_sort IN (
                    SELECT kjmo_sort
                    FROM `_xxx_woche_sort`
                )
        )
        AND OK.mandant_id = 1
        AND OV.mandant_id = 1
        AND OK.turnover_fg = 1
        AND OV.talon_id <> 0
        AND (OK.wup_id, OV.talon_id) NOT IN (
            SELECT (K.wup_id, cast(Z.talon_id AS BIGNUMERIC))--PE_Review
            FROM dbp_spezial.v_ods_talon_union AS K
            INNER JOIN dbp_spezial.v_ods_talon_det_union AS Z ON K.talon_id = Z.talon_id AND K.wup_id = Z.wup_id
        )
        AND (
            OK.bon_id, OK.bon_dat) NOT IN (
            SELECT (bon_id, bon_dat)
            FROM dbp_spezial.v_ods_bon_storno_union
        )
    GROUP BY
        OK.mandant_id,
        OK.wup_id,
        OK.bon_dat,
        OK.kasse_nr,
        OK.bon_nr,
        OK.bon_id,
        OV.kl_art_id
);


UPDATE dbp_etl.bf_bons_sort_basis_tmp_de SET
    bon_umsatz_af = CAST(bf_bons_sort_basis_tmp_de.bon_umsatz_af + shop.`_bon_umsatz_af` AS NUMERIC),
    bon_umsatz_sa = CAST(bf_bons_sort_basis_tmp_de.bon_umsatz_sa + shop.`_bon_umsatz_sa` AS NUMERIC),
    bon_absatz_af = CAST(bf_bons_sort_basis_tmp_de.bon_absatz_af + shop.`_bon_absatz_af` AS NUMERIC),
    bon_absatz_sa = CAST(bf_bons_sort_basis_tmp_de.bon_absatz_sa + shop.`_bon_absatz_sa` AS NUMERIC) FROM (
    SELECT
        OK.mandant_id
            AS `_mandant_id`,
        OK.wup_id AS `_wup_id`,
        OK.bon_dat AS `_dat`,
        OK.kasse_nr AS `_kasse_nr`,
        OK.bon_nr AS `_bon_nr`,
        OK.bon_id AS `_bon_id`,
        SUM(CASE
            WHEN OV.aktion_id = ''
                THEN OV.umsatz_brutto
            ELSE 0
        END) AS `_bon_umsatz_af`,
        SUM(CASE
            WHEN OV.aktion_id <> ''
                THEN OV.umsatz_brutto
            ELSE 0
        END) AS `_bon_umsatz_sa`,
        SUM(CASE
            WHEN OV.aktion_id = ''
                THEN OV.menge
            ELSE 0
        END) AS `_bon_absatz_af`,
        SUM(CASE
            WHEN OV.aktion_id <> ''
                THEN OV.menge
            ELSE 0
        END) AS `_bon_absatz_sa`
    FROM dbp_spezial.v_ods_bon_kopf_union AS OK
    INNER JOIN dbp_spezial.v_ods_bon_verkauf_union AS OV
        ON
            OK.mandant_id = OV.mandant_id AND OK.wup_id =
            OV.wup_id AND OK.bon_id = OV.bon_id
    WHERE
        OK.bon_dat BETWEEN (
            SELECT MIN(dat)
            FROM dbp_data.tag
            WHERE akt_mo = -4) AND (
            SELECT dat_bis
            FROM dbp_msi_data.ek_sort_sortiment_mat_zeitraum
            WHERE
                kjmo_sort IN (
                    SELECT kjmo_sort
                    FROM `_xxx_woche_sort`
                )
        )
        AND OV.bon_dat BETWEEN (
            SELECT MIN(dat)
            FROM dbp_data.tag
            WHERE akt_mo = -4) AND (
            SELECT dat_bis
            FROM dbp_msi_data.ek_sort_sortiment_mat_zeitraum
            WHERE
                kjmo_sort IN (
                    SELECT kjmo_sort
                    FROM `_xxx_woche_sort`
                )
        )
        AND OK.mandant_id = 1
        AND OV.mandant_id = 1
        AND OK.turnover_fg = 1
        AND OV.talon_id = 0
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
    bf_bons_sort_basis_tmp_de.mandant_id = shop.`_mandant_id` AND bf_bons_sort_basis_tmp_de.wup_id = shop.`_wup_id`
    AND bf_bons_sort_basis_tmp_de.dat = shop.`_dat` AND bf_bons_sort_basis_tmp_de.kasse_nr = shop.`_kasse_nr` AND
    bf_bons_sort_basis_tmp_de.bon_nr = shop.`_bon_nr` AND bf_bons_sort_basis_tmp_de.bon_id = shop.`_bon_id`;


UPDATE dbp_etl.bf_bons_sort_basis_tmp_de SET
    bon_umsatz_af = CAST(bf_bons_sort_basis_tmp_de.bon_umsatz_af + shop.`_bon_umsatz_af` AS NUMERIC),
    bon_umsatz_sa = CAST(bf_bons_sort_basis_tmp_de.bon_umsatz_sa + shop.`_bon_umsatz_sa` AS NUMERIC),
    bon_absatz_af = CAST(bf_bons_sort_basis_tmp_de.bon_absatz_af + shop.`_bon_absatz_af` AS NUMERIC),
    bon_absatz_sa = CAST(bf_bons_sort_basis_tmp_de.bon_absatz_sa + shop.`_bon_absatz_sa` AS NUMERIC) FROM (
    SELECT
        OK.mandant_id
            AS `_mandant_id`,
        OK.wup_id AS `_wup_id`,
        OK.bon_dat AS `_dat`,
        OK.kasse_nr AS `_kasse_nr`,
        OK.bon_nr AS `_bon_nr`,
        OK.bon_id AS `_bon_id`,
        SUM(CASE
            WHEN OV.aktion_id = ''
                THEN OV.umsatz_brutto
            ELSE 0
        END) AS `_bon_umsatz_af`,
        SUM(CASE
            WHEN OV.aktion_id <> ''
                THEN OV.umsatz_brutto
            ELSE 0
        END) AS `_bon_umsatz_sa`,
        SUM(CASE
            WHEN OV.aktion_id = ''
                THEN OV.menge
            ELSE 0
        END) AS `_bon_absatz_af`,
        SUM(CASE
            WHEN OV.aktion_id <> ''
                THEN OV.menge
            ELSE 0
        END) AS `_bon_absatz_sa`
    FROM dbp_spezial.v_ods_bon_kopf_union AS OK
    INNER JOIN dbp_spezial.v_ods_bon_verkauf_union AS OV
        ON
            OK.mandant_id = OV.mandant_id AND OK.wup_id =
            OV.wup_id AND OK.bon_id = OV.bon_id
    WHERE
        OK.bon_dat BETWEEN (
            SELECT MIN(dat)
            FROM dbp_data.tag
            WHERE akt_mo = -4) AND (
            SELECT dat_bis
            FROM dbp_msi_data.ek_sort_sortiment_mat_zeitraum
            WHERE
                kjmo_sort IN (
                    SELECT kjmo_sort
                    FROM `_xxx_woche_sort`
                )
        )
        AND OV.bon_dat BETWEEN (
            SELECT MIN(dat)
            FROM dbp_data.tag
            WHERE akt_mo = -4) AND (
            SELECT dat_bis
            FROM dbp_msi_data.ek_sort_sortiment_mat_zeitraum
            WHERE
                kjmo_sort IN (
                    SELECT kjmo_sort
                    FROM `_xxx_woche_sort`
                )
        )
        AND OK.mandant_id = 1
        AND OV.mandant_id = 1
        AND OK.turnover_fg = 1
        AND OV.talon_id <> 0
        AND (OK.wup_id, OV.talon_id) NOT IN (
            SELECT (K.wup_id, CAST(Z.talon_id AS BIGNUMERIC))--PE_Review
            FROM dbp_spezial.v_ods_talon_union AS K
            INNER JOIN dbp_spezial.v_ods_talon_det_union AS Z ON K.talon_id = Z.talon_id AND K.wup_id = Z.wup_id
        )
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
    bf_bons_sort_basis_tmp_de.mandant_id = shop.`_mandant_id` AND bf_bons_sort_basis_tmp_de.wup_id = shop.`_wup_id`
    AND bf_bons_sort_basis_tmp_de.dat = shop.`_dat` AND bf_bons_sort_basis_tmp_de.kasse_nr = shop.`_kasse_nr` AND
    bf_bons_sort_basis_tmp_de.bon_nr = shop.`_bon_nr` AND bf_bons_sort_basis_tmp_de.bon_id = shop.`_bon_id`;


UPDATE dbp_etl.bf_bons_sort_basis_tmp_de SET
    cpsa_fg = 1
WHERE
    art_umsatz_sa / IF(bon_umsatz_af + bon_umsatz_sa = 0, NULL, bon_umsatz_af + bon_umsatz_sa) > 0.85 AND dat BETWEEN
    (
        SELECT MIN(dat)
        FROM dbp_data.tag
        WHERE akt_mo = -4) AND (
        SELECT dat_bis
        FROM dbp_msi_data.ek_sort_sortiment_mat_zeitraum
        WHERE
            kjmo_sort IN (
                SELECT kjmo_sort
                FROM `_xxx_woche_sort`
            )
    );


UPDATE dbp_etl.bf_bons_sort_basis_tmp_de SET
    cpsa_fg = 1
WHERE art_absatz_sa / IF(
    bon_absatz_af + bon_absatz_sa = 0, NULL, bon_absatz_af + bon_absatz_sa) > 0.6 AND dat BETWEEN (SELECT MIN(dat)
FROM dbp_data.tag
WHERE akt_mo = -4) AND (
    SELECT dat_bis
    FROM dbp_msi_data.ek_sort_sortiment_mat_zeitraum
    WHERE
        kjmo_sort IN (
            SELECT kjmo_sort
            FROM `_xxx_woche_sort`
        )
);


MERGE INTO dbp_etl.bf_bons_sort_basis AS A
USING dbp_etl.bf_bons_sort_basis_tmp_de AS b
    ON
        A.mandant_id = b.mandant_id AND A.wup_id = b.wup_id AND A.dat = b.dat AND A.kasse_nr = b.kasse_nr AND A.bon_nr = b.bon_nr
        AND A.bon_id = b.bon_id AND A.kl_art_id = b.kl_art_id
WHEN NOT MATCHED THEN INSERT VALUES (
    b.mandant_id, b.wup_id, b.dat, b.kasse_nr, b.bon_nr, b.bon_id, b.kl_art_id, b.bon_umsatz_af,
    b.bon_umsatz_sa, b.bon_absatz_af, b.bon_absatz_sa, b.art_umsatz_af, b.art_umsatz_sa, b.art_absatz_af, b.art_absatz_sa,
    b.cpaf_fg, b.cpsa_fg
);


DELETE FROM dbp_etl.bf_bons_sort_sum
WHERE dat BETWEEN (
    SELECT MIN(dat)
    FROM dbp_data.tag
    WHERE akt_mo = -4) AND (
    SELECT dat_bis
    FROM dbp_msi_data.ek_sort_sortiment_mat_zeitraum
    WHERE
        kjmo_sort IN (
            SELECT kjmo_sort
            FROM `_xxx_woche_sort`
        )
) AND mandant_id = 1;


INSERT INTO dbp_etl.bf_bons_sort_sum
SELECT
    mandant_id,
    wup_id,
    dat,
    kl_art_id,
    0 AS anz_bon,
    SUM(bon_umsatz_af),
    SUM(bon_umsatz_sa),
    SUM(bon_absatz_af),
    SUM(bon_absatz_sa),
    SUM(art_umsatz_af),
    SUM(art_umsatz_sa),
    SUM(art_absatz_af),
    SUM(art_absatz_sa),
    SUM(CASE
        WHEN art_umsatz_af > 0
            THEN bon_umsatz_af + bon_umsatz_sa - art_umsatz_af
        ELSE 0
    END) AS rb_af,
    SUM(CASE
        WHEN art_umsatz_sa > 0
            THEN bon_umsatz_af + bon_umsatz_sa - art_umsatz_sa
        ELSE 0
    END) AS rb_sa,
    SUM(CASE
        WHEN art_umsatz_af > 0
            THEN 1
        ELSE 0
    END) AS af_bons,
    SUM(CASE
        WHEN art_umsatz_sa > 0
            THEN 1
        ELSE 0
    END) AS sa_bons,
    SUM(cpaf_fg),
    SUM(cpsa_fg)
FROM dbp_etl.bf_bons_sort_basis
WHERE
    dat BETWEEN (
        SELECT MIN(dat)
        FROM dbp_data.tag
        WHERE akt_mo = -4) AND (
        SELECT dat_bis
        FROM dbp_msi_data.ek_sort_sortiment_mat_zeitraum
        WHERE
            kjmo_sort IN (
                SELECT kjmo_sort
                FROM `_xxx_woche_sort`
            )
    )
    AND mandant_id = 1
GROUP BY
    mandant_id,
    wup_id,
    dat,
    kl_art_id,
    anz_bon;


UPDATE dbp_etl.bf_bons_sort_sum SET
    anz_bons = b.anz_bons FROM (
    SELECT
        mandant_id,
        wup_id,
        dat,
        COUNT(DISTINCT bon_id) AS anz_bons
    FROM dbp_etl.bf_bons_sort_basis
    WHERE
        dat BETWEEN (
            SELECT MIN(dat)
            FROM dbp_data.tag
            WHERE akt_mo = -4) AND (
            SELECT dat_bis
            FROM dbp_msi_data.ek_sort_sortiment_mat_zeitraum
            WHERE
                kjmo_sort IN (
                    SELECT kjmo_sort
                    FROM `_xxx_woche_sort`
                )
        )
        AND mandant_id = 1
    GROUP BY
        mandant_id,
        wup_id,
        dat
) AS b
WHERE bf_bons_sort_sum.mandant_id = b.mandant_id AND bf_bons_sort_sum.wup_id = b.wup_id AND bf_bons_sort_sum.dat = b.dat;


TRUNCATE TABLE dbp_etl.bf_bons_sort_export;


INSERT INTO dbp_etl.bf_bons_sort_export
(
    SELECT
        W.mandant_id,
        CAST(MW.kjmo_sort AS INTEGER) AS kjmo_sort,
        CAST(MW.monate_anz AS INTEGER) AS monate_anz,
        'alle' AS bereich,
        AGG.kl_art_id,
        (SUM(
            AGG.restbon_af) + SUM(AGG.restbon_sa)) / IF(SUM(AGG.art_bons_af + AGG.art_bons_sa) = 0, NULL, SUM(
            AGG.art_bons_af
            + AGG.art_bons_sa
        )) AS rb_total,
        SUM(
            AGG.restbon_af) / IF(SUM(AGG.art_bons_af + AGG.art_bons_sa) = 0, NULL, SUM(AGG.art_bons_af + AGG.art_bons_sa)) AS
        rb_af,
        SUM(
            AGG.restbon_sa) / IF(SUM(AGG.art_bons_af + AGG.art_bons_sa) = 0, NULL, SUM(AGG.art_bons_af + AGG.art_bons_sa)) AS
        rb_sa,
        SUM(AGG.restbon_af) AS restbon_brutto_af,
        SUM(AGG.restbon_sa) AS restbon_brutto_sa,
        SUM(AGG.art_bons_af) AS artikel_bons_af,
        SUM(AGG.art_bons_sa) AS artikel_bons_sa,
        CAST((
            SUM(CAST(AGG.art_bons_af AS FLOAT64)) + SUM(CAST(AGG.art_bons_sa AS FLOAT64))) / IF(
            SUM(CAST(AGG.anz_bons AS FLOAT64)
            ) = 0, NULL, SUM(CAST(AGG.anz_bons AS FLOAT64))
        ) AS BIGNUMERIC) AS krw_total,
        CAST(SUM(
            CAST(AGG.art_bons_af AS FLOAT64)) / IF(
            SUM(CAST(AGG.anz_bons AS FLOAT64)) = 0, NULL, SUM(CAST(AGG.anz_bons AS FLOAT64)
            )
        ) AS BIGNUMERIC) AS krw_af,
        CAST(SUM(
            CAST(AGG.art_bons_sa AS FLOAT64)) / IF(
            SUM(CAST(AGG.anz_bons AS FLOAT64)) = 0, NULL, SUM(CAST(AGG.anz_bons AS FLOAT64)
            )
        ) AS BIGNUMERIC) AS krw_sa,
        SUM(AGG.anz_bons) AS bons,
        CAST((SUM(
            CAST(AGG.cp_bons_af AS FLOAT64)) + SUM(CAST(AGG.cp_bons_sa AS FLOAT64))) / IF(SUM(
            CAST(AGG.art_bons_af AS FLOAT64)
            + CAST(AGG.art_bons_sa AS FLOAT64)
        ) = 0, NULL, SUM(CAST(AGG.art_bons_af AS FLOAT64) + CAST(AGG.art_bons_sa AS FLOAT64)
        )) AS BIGNUMERIC) AS cpq_total,
        CAST(SUM(
            CAST(AGG.cp_bons_af AS FLOAT64)) / IF(
            SUM(CAST(AGG.art_bons_af AS FLOAT64)) = 0, NULL, SUM(CAST(AGG.art_bons_af AS FLOAT64)
            )
        ) AS BIGNUMERIC) AS cpq_af,
        CAST(SUM(
            CAST(AGG.cp_bons_sa AS FLOAT64)) / IF(
            SUM(CAST(AGG.art_bons_sa AS FLOAT64)) = 0, NULL, SUM(CAST(AGG.art_bons_sa AS FLOAT64)
            )
        ) AS BIGNUMERIC) AS cpq_sa,
        SUM(AGG.cp_bons_af) AS cherry_bons_af,
        SUM(AGG.cp_bons_sa) AS cherry_bons_sa,
        COUNT(DISTINCT AGG.dat) AS tage,
        COUNT(DISTINCT AGG.wup_id) AS maerkte
    FROM dbp_etl.bf_bons_sort_sum AS AGG
    INNER JOIN dbp_data.wup AS W ON TRUE
    INNER JOIN dbp_data.art AS A ON TRUE
    INNER JOIN dbp_data.art_wg_zu_per AS AW ON TRUE
    INNER JOIN dbp_process.bf_sort_wg AS SW ON TRUE
    INNER JOIN dbp_msi_data.ek_sort_sortiment_mat_zeitraum AS MW ON TRUE
    WHERE
        MW.kjmo_sort IN (
            SELECT kjmo_sort
            FROM `_xxx_woche_sort`
        )
        AND AGG.mandant_id = 1
        AND AGG.mandant_id = W.mandant_id
        AND AGG.dat BETWEEN MW.dat_von AND MW.dat_bis
        AND AGG.wup_id = W.wup_id
        AND AGG.mandant_id = A.mandant_id
        AND AGG.kl_art_id = A.kl_art_id
        AND A.dat_bis = DATE '9999-12-31'
        AND A.mandant_id = AW.mandant_id
        AND A.art_id = AW.art_id
        AND AW.arthiertyp_id = 2
        AND AW.dat_bis = DATE '9999-12-31'
        AND AW.mandant_id = SW.mandant_id
        AND AW.arthiertyp_id = SW.arthiertyp_id
        AND AW.wg_id = SW.wg_id
        AND AGG.art_bons_af + AGG.art_bons_sa > 0
    GROUP BY
        W.mandant_id,
        MW.kjmo_sort,
        MW.monate_anz,
        bereich,
        AGG.kl_art_id
);


DELETE FROM dbp_etl_process.sort_bon_receipt_de
WHERE mandant_id = 1 AND bon_dat > (
    SELECT MIN(dat)
    FROM dbp_data.tag
    WHERE akt_mo = -4
);


INSERT INTO dbp_etl_process.sort_bon_receipt_de
(
    SELECT DISTINCT
        OK.mandant_id,
        OK.wup_id,
        OK.bon_dat,
        A.art_id,
        COUNT(OK.bon_id) OVER (
            PARTITION BY OK.mandant_id, OK.wup_id, OK.bon_dat RANGE BETWEEN UNBOUNDED PRECEDING AND
            UNBOUNDED FOLLOWING
        ) AS total_receipt,
        SUM(CASE
            WHEN OV.aktion_id = '' AND OV.umsatz_brutto > 0
                THEN 1
            ELSE 0
        END) OVER (
            PARTITION BY OK.mandant_id, OK.wup_id, OK.bon_dat, OV.kl_art_id RANGE BETWEEN UNBOUNDED PRECEDING AND
            UNBOUNDED FOLLOWING
        ) AS anz_bons_af_fg,
        SUM(CASE
            WHEN OV.aktion_id <> '' AND OV.umsatz_brutto > 0
                THEN 1
            ELSE 0
        END) OVER (
            PARTITION BY OK.mandant_id, OK.wup_id, OK.bon_dat, OV.kl_art_id RANGE BETWEEN UNBOUNDED PRECEDING AND
            UNBOUNDED FOLLOWING
        ) AS anz_bons_sa_fg
    FROM dbp_spezial.v_ods_bon_kopf_union AS OK
    INNER JOIN dbp_spezial.v_ods_bon_verkauf_union AS OV
        ON
            OK.mandant_id = OV.mandant_id AND OK.wup_id =
            OV.wup_id AND OK.bon_id = OV.bon_id
    INNER JOIN dbp_data.art AS A ON OV.mandant_id = A.mandant_id AND OV.kl_art_id = A.kl_art_id
    WHERE
        OK.bon_dat > (
            SELECT MIN(dat)
            FROM dbp_data.tag
            WHERE akt_mo = -4
        )
        AND OV.bon_dat > (
            SELECT MIN(dat)
            FROM dbp_data.tag
            WHERE akt_mo = -4
        )
        AND OK.mandant_id = 1
        AND OV.mandant_id = 1
        AND OK.turnover_fg = 1
        AND OV.wg_id <> 980
        AND (
            OK.bon_id, OK.bon_dat) NOT IN (
            SELECT (bon_id, bon_dat)
            FROM dbp_spezial.v_ods_bon_storno_union
        )
);


DELETE FROM dbp_etl_process.sort_bon_receipt_de
WHERE mandant_id = 1 AND bon_dat < (
    SELECT MIN(dat)
    FROM dbp_data.tag
    WHERE akt_mo = -19
);
