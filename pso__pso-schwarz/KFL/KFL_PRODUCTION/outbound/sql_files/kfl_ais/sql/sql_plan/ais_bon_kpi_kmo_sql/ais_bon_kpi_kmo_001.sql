CREATE OR REPLACE TABLE dbp_etl.st_bon_kpi_kmo (
    mandant_id INTEGER,
    kjmo_sort INTEGER,
    kl_art_id INTEGER,
    rb_total NUMERIC(29, 3),
    artikel_bons_af INTEGER,
    artikel_bons_sa INTEGER,
    krw_af BIGNUMERIC(38, 10),
    krw_sa BIGNUMERIC(38, 10),
    cpq_total BIGNUMERIC(38, 10),
    cherry_bons_af INTEGER,
    cherry_bons_sa INTEGER
);


CREATE OR REPLACE TABLE dbp_etl.bf_bons_sort_basis_tmp (
    mandant_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    dat DATE,
    kasse_nr INTEGER NOT NULL,
    bon_nr INTEGER NOT NULL,
    bon_id STRING(25) COLLATE 'und:ci',
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



INSERT INTO dbp_etl.bf_bons_sort_basis_tmp (
    mandant_id, wup_id, dat, kasse_nr, bon_nr, bon_id, kl_art_id,
    bon_umsatz_af,
    bon_umsatz_sa,
    bon_absatz_af,
    bon_absatz_sa,
    art_umsatz_af,
    art_umsatz_sa,
    art_absatz_af,
    art_absatz_sa, cpaf_fg, cpsa_fg
)
(
    SELECT DISTINCT
        OK.mandant_id,
        OK.wup_id,
        OK.bon_dat,
        OK.kasse_nr,
        OK.bon_nr,
        OK.bon_id,
        OV.kl_art_id,
        
            SUM(CASE
                WHEN OV.aktion_id = ''
                    THEN OV.umsatz_brutto
                ELSE 0
            END)
                OVER (
                    PARTITION BY
                        OK.bon_id
                    RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
                )
            
            AS
            bon_umsatz_af,
        
            SUM(CASE
                WHEN OV.aktion_id <> ''
                    THEN OV.umsatz_brutto
                ELSE 0
            END)
                OVER (
                    PARTITION BY
                        OK.bon_id
                    RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
                )
            
            AS
            bon_umsatz_sa,
        
            SUM(CASE
                WHEN OV.aktion_id = ''
                    THEN OV.menge
                ELSE 0
            END)
                OVER (
                    PARTITION BY
                        OK.bon_id
                    RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
                )
            
            AS
            bon_absatz_af,
        
            SUM(CASE
                WHEN OV.aktion_id <> ''
                    THEN OV.menge
                ELSE 0
            END)
                OVER (
                    PARTITION BY
                        OK.bon_id
                    RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
                )
            
            AS
            bon_absatz_sa,
        
            SUM(CASE
                WHEN OV.aktion_id = ''
                    THEN OV.umsatz_brutto
                ELSE 0
            END)
                OVER (
                    PARTITION BY
                        OK.bon_id, OV.kl_art_id
                    RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
                )
            
            AS art_umsatz_af,
        
            SUM(CASE
                WHEN OV.aktion_id <> ''
                    THEN OV.umsatz_brutto
                ELSE 0
            END)
                OVER (
                    PARTITION BY
                        OK.bon_id, OV.kl_art_id
                    RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
                )
            
            AS art_umsatz_sa,
        
            SUM(CASE
                WHEN OV.aktion_id = ''
                    THEN OV.menge
                ELSE 0
            END)
                OVER (
                    PARTITION BY
                        OK.bon_id, OV.kl_art_id
                    RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
                )
            
            AS art_absatz_af,
        
            SUM(CASE
                WHEN OV.aktion_id <> ''
                    THEN OV.menge
                ELSE 0
            END)
                OVER (
                    PARTITION BY
                        OK.bon_id, OV.kl_art_id
                    RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
                )
            
            AS art_absatz_sa,
        0 AS cpaf_fg,
        0 AS cpsa_fg
    FROM dbp_ods.ods_bon_kopf AS OK
    INNER JOIN dbp_ods.ods_bon_verkauf AS OV
        ON
            OK.mandant_id = OV.mandant_id AND OK.wup_id = OV.wup_id
            AND OK.bon_id = OV.bon_id AND OK.bon_dat = OV.bon_dat
    WHERE
        OK.bon_dat BETWEEN DATE_SUB(
            CURRENT_DATE("Europe/Berlin"), INTERVAL 60 DAY
        ) AND (DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 1 DAY))
        AND OV.bon_dat BETWEEN DATE_SUB(
            CURRENT_DATE("Europe/Berlin"), INTERVAL 60 DAY
        ) AND (DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 1 DAY))
        AND OK.mandant_id > 1
        AND OV.mandant_id > 1
        AND OK.turnover_fg = 1
        AND OV.wg_id NOT IN (
            SELECT wg_id
            FROM dbp_data.wg_filter_zu
            WHERE wg_filter_id = 5
        )
        AND (
            OK.bon_id, OK.bon_dat) NOT IN (
            SELECT (bon_id, bon_dat)
            FROM dbp_ods.ods_bon_storno
        )
);


--new logic of cherrypicker flag


UPDATE dbp_etl.bf_bons_sort_basis_tmp SET
    cpsa_fg = 1
WHERE
    art_umsatz_sa / IF(bon_umsatz_af + bon_umsatz_sa = 0, NULL, bon_umsatz_af + bon_umsatz_sa) > 0.85;


UPDATE dbp_etl.bf_bons_sort_basis_tmp SET
    cpsa_fg = 1
WHERE
    art_absatz_sa / IF(bon_absatz_af + bon_absatz_sa = 0, NULL, bon_absatz_af + bon_absatz_sa) > 0.6;


DELETE FROM dbp_etl.bf_bons_sort_sum
WHERE (
    mandant_id, dat, wup_id, kl_art_id) IN (
    SELECT (mandant_id, dat, wup_id, kl_art_id)
    FROM dbp_etl.bf_bons_sort_basis_tmp
);



INSERT INTO dbp_etl.bf_bons_sort_sum (
    mandant_id, wup_id, dat, kl_art_id, anz_bons, bon_ums_af,
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
        mandant_id,
        wup_id,
        dat,
        kl_art_id,
        0 AS anz_bons,
        SUM(bon_umsatz_af) AS bon_ums_af,
        SUM(bon_umsatz_sa) AS bon_ums_sa,
        SUM(bon_absatz_af) AS bon_abs_af,
        SUM(bon_absatz_sa) AS bon_abs_sa,
        SUM(art_umsatz_af) AS art_ums_af,
        SUM(art_umsatz_sa) AS art_ums_sa,
        SUM(art_absatz_af) AS art_abs_af,
        SUM(art_absatz_sa) AS art_abs_sa,
        SUM(CASE
            WHEN art_umsatz_af > 0
                THEN bon_umsatz_af + bon_umsatz_sa - art_umsatz_af
            ELSE 0
        END)  AS restbon_af,
        SUM(CASE
            WHEN art_umsatz_sa > 0
                THEN bon_umsatz_af + bon_umsatz_sa - art_umsatz_sa
            ELSE 0
        END)  AS restbon_sa,
        SUM(CASE
            WHEN art_umsatz_af > 0
                THEN 1
            ELSE 0
        END) AS art_bons_af,
        SUM(CASE
            WHEN art_umsatz_sa > 0
                THEN 1
            ELSE 0
        END) AS art_bons_sa,
        SUM(cpaf_fg) AS cp_bons_af,
        SUM(cpsa_fg) AS cp_bons_sa
    FROM dbp_etl.bf_bons_sort_basis_tmp
    GROUP BY
        mandant_id,
        wup_id,
        dat,
        kl_art_id,
        anz_bons
);


UPDATE dbp_etl.bf_bons_sort_sum SET
    anz_bons = b.anz_bons FROM (
    SELECT
        mandant_id,
        wup_id,
        dat,
        COUNT(DISTINCT bon_id) AS anz_bons
    FROM dbp_etl.bf_bons_sort_basis_tmp
    GROUP BY
        mandant_id,
        wup_id,
        dat
) AS b
WHERE
    bf_bons_sort_sum.mandant_id = b.mandant_id AND bf_bons_sort_sum.wup_id = b.wup_id AND bf_bons_sort_sum.dat = b.dat;


DELETE FROM dbp_etl.st_bon_kpi_kmo
WHERE mandant_id > 1;


INSERT INTO dbp_etl.st_bon_kpi_kmo (
    mandant_id, kjmo_sort, kl_art_id, rb_total, artikel_bons_af,
    artikel_bons_sa, krw_af, krw_sa, cpq_total, cherry_bons_af, cherry_bons_sa
)
(
    SELECT
        A.mandant_id,
        D.kjmo_sort,
        A.kl_art_id,
        (
            SUM(A.restbon_af) + SUM(A.restbon_sa)
        )
        / IF(
            SUM(A.art_bons_af + A.art_bons_sa) = 0,
            NULL,
            SUM(A.art_bons_af + A.art_bons_sa
            )
        ) AS rb_total,
        SUM(A.art_bons_af) AS artikel_bons_af,
        SUM(A.art_bons_sa) AS artikel_bons_sa,
        CAST(
            SUM(CAST(A.art_bons_af AS FLOAT64))
            / IF(
                SUM(CAST(A.anz_bons AS FLOAT64)) = 0,
                NULL,
                SUM(CAST(A.anz_bons AS FLOAT64))
            ) AS BIGNUMERIC
        )
            AS krw_af,
        CAST(SUM(
            CAST(A.art_bons_sa AS FLOAT64)
        )
        / IF(
            SUM(CAST(A.anz_bons AS FLOAT64)) = 0,
            NULL,
            SUM(CAST(A.anz_bons AS FLOAT64)
            )
        ) AS BIGNUMERIC) AS krw_sa,
        CAST((SUM(
            CAST(A.cp_bons_af AS FLOAT64)
        ) + SUM(CAST(A.cp_bons_sa AS FLOAT64)))
        / IF(SUM(
            CAST(A.art_bons_af AS FLOAT64)
            + CAST(A.art_bons_sa AS FLOAT64)
        ) = 0,
        NULL,
        SUM(CAST(A.art_bons_af AS FLOAT64) + CAST(A.art_bons_sa AS FLOAT64)
        )) AS BIGNUMERIC) AS cpq_total,
        SUM(A.cp_bons_af) AS cherry_bons_af,
        SUM(A.cp_bons_sa) AS cherry_bons_sa
    FROM dbp_etl.bf_bons_sort_sum AS A
    INNER JOIN dbp_data.art AS B
        ON
            A.mandant_id = B.mandant_id
            AND A.kl_art_id = B.kl_art_id
            AND B.dat_bis
            = DATE '9999-12-31'
    INNER JOIN dbp_data.art_wg_zu_per AS C
        ON
            A.mandant_id = C.mandant_id
            AND B.art_id = C.art_id
            AND C.arthiertyp_id
            = 2 AND C.dat_bis = DATE '9999-12-31'
    INNER JOIN
        dbp_msi_data.ek_sort_sortiment_mat_zeitraum AS D
        ON A.dat BETWEEN D.dat_von AND D.dat_bis
    WHERE
        C.wg_id IN (
            SELECT wg_id
            FROM dbp_data.wg_filter_zu
            WHERE wg_filter_id = 47
        )
        AND A.mandant_id > 1
        AND A.art_bons_af + A.art_bons_sa > 0
        AND D.kjmo_sort IN (
            SELECT kjmo
            FROM dbp_data.monat
            WHERE akt_mo = -1
        )
    GROUP BY
        A.mandant_id,
        D.kjmo_sort,
        A.kl_art_id
);


DELETE FROM dbp_etl.kpi_aggregat_kmo
WHERE kjmo_sort IN (
    SELECT kjmo
    FROM dbp_data.monat
    WHERE akt_mo = -1
);


INSERT INTO dbp_etl.kpi_aggregat_kmo (
    mandant_id, kjmo_sort, kl_art_id, rb_total, artikel_bons_af,
    artikel_bons_sa, krw_af, krw_sa, cpq_total, cherry_bons_af, cherry_bons_sa
)
(SELECT
    mandant_id,
    kjmo_sort,
    kl_art_id,
    rb_total,
    artikel_bons_af,
    artikel_bons_sa,
    krw_af,
    krw_sa,
    cpq_total,
    cherry_bons_af,
    cherry_bons_sa
FROM dbp_etl.st_bon_kpi_kmo
WHERE kjmo_sort IN (
    SELECT kjmo
    FROM dbp_data.monat
    WHERE akt_mo = -1
));


-----Bonreichweite


DELETE FROM dbp_etl_process.sort_bon_receipt_kmo
WHERE mandant_id > 1 AND bon_dat > (
    SELECT MIN(dat)
    FROM dbp_data.tag
    WHERE akt_mo = -4
);


INSERT INTO dbp_etl_process.sort_bon_receipt_kmo
(
    SELECT DISTINCT
        OK.mandant_id  AS mandant_id,
        OK.wup_id  AS wup_id,
        OK.bon_dat,
        A.art_id  AS art_id,
        COUNT(OK.bon_id) OVER (
            PARTITION BY
                OK.mandant_id, OK.wup_id, OK.bon_dat
            RANGE BETWEEN UNBOUNDED PRECEDING AND
            UNBOUNDED FOLLOWING
        ) AS total_receipt,
        SUM(CASE
            WHEN OV.aktion_id = '' AND OV.umsatz_brutto > 0
                THEN 1
            ELSE 0
        END) OVER (
            PARTITION BY
                OK.mandant_id, OK.wup_id, OK.bon_dat, OV.kl_art_id
            RANGE BETWEEN UNBOUNDED PRECEDING AND
            UNBOUNDED FOLLOWING
        ) AS anz_bons_af_fg,
        SUM(CASE
            WHEN OV.aktion_id <> '' AND OV.umsatz_brutto > 0
                THEN 1
            ELSE 0
        END) OVER (
            PARTITION BY
                OK.mandant_id, OK.wup_id, OK.bon_dat, OV.kl_art_id
            RANGE BETWEEN UNBOUNDED PRECEDING AND
            UNBOUNDED FOLLOWING
        ) AS anz_bons_sa_fg
    FROM dbp_spezial.v_ods_bon_kopf_union AS OK
    INNER JOIN dbp_spezial.v_ods_bon_verkauf_union AS OV
        ON
            OK.mandant_id = OV.mandant_id AND OK.wup_id
            = OV.wup_id AND OK.bon_id = OV.bon_id
    INNER JOIN
        dbp_data.art AS A
        ON OV.mandant_id = A.mandant_id AND OV.kl_art_id = A.kl_art_id
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
        AND OK.mandant_id > 1
        AND OV.mandant_id > 1
        AND OK.turnover_fg = 1
        AND OV.wg_id <> 980
        AND (
            OK.bon_id, OK.bon_dat) NOT IN (
            SELECT (bon_id, bon_dat)
            FROM dbp_spezial.v_ods_bon_storno_union
        )
);

DELETE FROM dbp_etl_process.sort_bon_receipt_kmo
WHERE mandant_id > 1 AND bon_dat < (
    SELECT MIN(dat)
    FROM dbp_data.tag
    WHERE akt_mo = -19
);
