DROP TABLE IF EXISTS dbp_etl.artbew_mis_dat;


CREATE TABLE IF NOT EXISTS dbp_etl.artbew_mis_dat (
    dat DATE NOT NULL
);


INSERT INTO dbp_etl.artbew_mis_dat (dat)
(
    SELECT dat
    FROM dbp_etl.artbew_mis
    GROUP BY dat
);


DELETE FROM dbp_etl.artbew_mis
WHERE (
    mandant_id, wg_id, arthiertyp_id) IN (
    SELECT (mandant_id, wg_id, arthiertyp_id)
    FROM dbp_data.wg_filter_zu
    WHERE wg_filter_id = 38
) AND umsatz_mwst_betrag = 0;


DELETE FROM dbp_etl.artbew_mis
WHERE (
    mandant_id, wg_id, arthiertyp_id) IN (
    SELECT (mandant_id, wg_id, arthiertyp_id)
    FROM dbp_data.wg_filter_zu
    WHERE wg_filter_id = 49
);


DELETE FROM dbp_etl.artbew_mis
WHERE mandant_id = 1 AND art_id IN (590006700, 590006900);


-- 22.10.2024,-dba-
-- Absatz raus fuer 823|002-004


UPDATE dbp_etl.artbew_mis SET
    menge = 0 FROM (
    SELECT *
    FROM dbp_data.art_wg_zu_per
    WHERE
        arthiertyp_id = 2
        AND dat_bis = DATE '9999-12-31'
        AND wg_id = 823
        AND wug_id IN (2, 3, 4)
) AS b
WHERE artbew_mis.mandant_id = b.mandant_id AND artbew_mis.art_id = b.art_id;


DELETE FROM dbp_data.artbew_wg_sum
WHERE (
    mandant_id, wup_id, dat) IN (SELECT (mandant_id, wup_id, dat)
FROM dbp_etl.artbew_mis) AND dat IN (
    SELECT dat
    FROM dbp_etl.artbew_mis_dat
);


INSERT INTO dbp_data.artbew_wg_sum (
    mandant_id, nb_id, arthiertyp_id, wg_id, umrechnungskurs_hist, dat,
    wup_id,
    bewart_id,
    kjmo,
    umsatz_brutto,
    umsatz_netto,
    umsatz_wrg,
    umsatz_brutto_konz,
    umsatz_netto_konz,
    quelle,
    menge
)
(
    SELECT
        mandant_id,
        nb_id,
        arthiertyp_id,
        wg_id,
        1 AS umrechnungskurs_hist,
        dat,
        wup_id,
        1001 AS bewart_id_,
        CAST(ROUND(CAST(FORMAT_DATE('%Y%m', dat) AS BIGNUMERIC), 0) AS INTEGER)
            AS kjmo,
        SUM(umsatz_netto + umsatz_mwst_betrag) AS umsatz_brutto,
        SUM(umsatz_netto),
        wrg AS umsatz_wrg,
        SUM(
            umsatz_netto
            + umsatz_mwst_betrag
            + diff_umsatz_netto_konz
            + diff_umsatz_mwst_betrag_konz
        ) AS umsatz_brutto_konz,
        SUM(umsatz_netto + diff_umsatz_netto_konz) AS umsatz_netto_konz,
        1 AS quelle,
        SUM(menge) AS menge_
    FROM dbp_etl.artbew_mis
    WHERE wg_id IS NOT NULL
    GROUP BY
        mandant_id,
        wup_id,
        nb_id,
        wg_id,
        arthiertyp_id,
        bewart_id_,
        dat,
        umsatz_wrg,
        kjmo,
        quelle
);


UPDATE dbp_data.wupcal SET
    datenlieferung_artbew_wg_sum = 1,
    dat_extrakt_umsatz = CURRENT_DATE("Europe/Berlin")
WHERE (
    mandant_id, wup_id, dat) IN (
    SELECT (mandant_id, wup_id, dat)
    FROM dbp_etl.artbew_mis
    WHERE nb_id IN (0, 2, 7)
);


INSERT INTO dbp_etl_process.artbew_wg_sum_agg_wt (
    mandant_id, wup_id, nb_id, dat, calc_fg, dat_lief
)
(
    SELECT
        mandant_id,
        wup_id,
        nb_id,
        dat,
        0 AS calc_fg,
        CURRENT_DATE("Europe/Berlin") AS dat_lief
    FROM dbp_etl.artbew_mis
    WHERE (
        mandant_id, wup_id, nb_id, dat) NOT IN (
        SELECT (mandant_id, wup_id, nb_id, dat)
        FROM dbp_etl_process.artbew_wg_sum_agg_wt
    )
    GROUP BY
        mandant_id,
        wup_id,
        nb_id,
        dat,
        calc_fg,
        dat_lief
);


TRUNCATE TABLE dbp_etl.artbew_mis;
