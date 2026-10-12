CREATE OR REPLACE TABLE dbp_etl.kmo_artbew_wg_sum_tmp_2 LIKE dbp_data.artbew_wg_sum_2;


DELETE FROM dbp_etl.kmo_artbew_bon_2
WHERE mandant_id = 6 AND kl_art_id IN (9800130, 9800131, 9800132);


DELETE FROM dbp_etl.kmo_artbew_bon_2
WHERE mandant_id = 2 AND kl_art_id IN (81841, 20268540, 148593, 20769937);


DELETE FROM dbp_etl.kmo_artbew_bon_2
WHERE (
    mandant_id, lkp_art_id) IN (
    SELECT (mandant_id, art_id)
    FROM dbp_data.art_wg_zu_per_2
    WHERE
        mandant_id = 7
        AND arthiertyp_id = 2
        AND dat_bis = DATE '9999-12-31'
        AND wg_id = 969
        AND wug_id = 6
);


DELETE FROM dbp_etl.kmo_artbew_bon_2
WHERE (
    mandant_id, lkp_art_id) IN (
    SELECT (mandant_id, art_id)
    FROM dbp_data.art_wg_zu_per_2
    WHERE
        mandant_id = 7
        AND arthiertyp_id = 2
        AND dat_bis = DATE '9999-12-31'
        AND wg_id = 980
);


DELETE FROM dbp_etl.kmo_artbew_bon_2
WHERE (
    mandant_id, lkp_wg_id) IN (
    SELECT (mandant_id, wg_id)
    FROM dbp_data.wg_filter_zu_2
    WHERE wg_filter_id = 49
);


DELETE FROM dbp_etl.kmo_artbew_bon_2
WHERE (
    mandant_id, lkp_art_id) IN (
    SELECT (mandant_id, art_id)
    FROM dbp_data.art_wg_zu_per_2
    WHERE
        mandant_id IN (2, 5, 6)
        AND arthiertyp_id = 2
        AND dat_bis = DATE '9999-12-31'
        AND wg_id = 969
        AND wug_id BETWEEN 1 AND 4
);


-- 22.10.2024,-dba-
-- Absatz raus fuer 823|002-004


UPDATE dbp_etl.kmo_artbew_bon_2 SET
    menge = 0 FROM (
    SELECT *
    FROM dbp_data.art_wg_zu_per_2
    WHERE
        arthiertyp_id = 2
        AND dat_bis = DATE '9999-12-31'
        AND wg_id = 823
        AND wug_id IN (2, 3, 4)
) AS b
WHERE
    kmo_artbew_bon.mandant_id = b.mandant_id AND kmo_artbew_bon.lkp_art_id = b.art_id;


INSERT INTO dbp_etl.kmo_artbew_wg_sum_tmp_2 (
    mandant_id, nb_id, arthiertyp_id, wg_id, dat, wup_id,
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
        dat,
        wup_id,
        bewart_id,
        CAST(kjmo AS INTEGER) AS kjmo,
        SUM(umsatz_brutto),
        SUM(umsatz_netto),
        umsatz_wrg,
        SUM(umsatz_brutto_konz),
        SUM(umsatz_netto_konz),
        quelle,
        SUM(menge)
    FROM (
        SELECT
            Z.mandant_id,
            Z.wup_id,
            Z.lkp_wg_id AS wg_id,
            1001 AS bewart_id,
            Z.dat_booking AS dat,
            Z.lkp_nb_id AS nb_id,
            2 AS arthiertyp_id,
            Z.lkp_wrg AS umsatz_wrg,
            ROUND(CAST(FORMAT_DATE('%Y%m', Z.dat_booking) AS BIGNUMERIC), 0)
                AS kjmo,
            1 AS quelle,
            SUM(ROUND(CAST(Z.umsatz_brutto * CASE
                WHEN y.conv_fg = 1
                    THEN Z.lkp_umrechnungskurs
                ELSE 1
            END AS NUMERIC), 8)) AS umsatz_brutto,
            CAST(SUM(ROUND(CAST(Z.umsatz_brutto * CASE
                WHEN y.conv_fg = 1
                    THEN Z.lkp_umrechnungskurs
                ELSE 1
            END AS NUMERIC), 8)) / (1 + Z.lkp_mwst / 100) AS NUMERIC)
                AS umsatz_netto,
            0 AS umsatz_brutto_konz,
            0 AS umsatz_netto_konz,
            SUM(Z.menge) AS menge
        FROM dbp_etl.kmo_artbew_bon_2 AS Z
        LEFT JOIN (
            SELECT
                mandant_id,
                wrg_id,
                dat_von,
                dat_bis,
                von_wrg_id,
                umrechnungskurs,
                td_update,
                td_insert,
                1 AS conv_fg
            FROM dbp_data.mandant_wrg_zu_per_2 AS A
            WHERE
                von_wrg_id IS NOT NULL
                AND wrg_id <> von_wrg_id
                AND CURRENT_DATE("Europe/Berlin") BETWEEN dat_von AND dat_bis
        ) AS y ON Z.mandant_id = y.mandant_id AND Z.lkp_wrg = y.wrg_id
        LEFT JOIN (
            SELECT
                mandant_id,
                bon_id,
                dat_booking,
                bon_zeile,
                SUM(umsatz_brutto) AS promotion_brutto
            FROM dbp_etl.kmo_artbew_bon_promotion_2
            GROUP BY
                mandant_id,
                bon_id,
                dat_booking,
                bon_zeile
        ) AS p
            ON
                Z.mandant_id = p.mandant_id
                AND Z.bon_id = p.bon_id
                AND Z.dat_booking = p.dat_booking
                AND Z.bon_zeile
                = p.bon_zeile
        GROUP BY
            Z.mandant_id,
            Z.wup_id,
            Z.lkp_wg_id,
            Z.dat_booking,
            Z.lkp_posten_id,
            Z.lkp_nb_id,
            Z.lkp_mwst,
            Z.lkp_wrg
    ) AS a
    GROUP BY
        mandant_id,
        wup_id,
        wg_id,
        bewart_id,
        dat,
        nb_id,
        arthiertyp_id,
        umsatz_wrg,
        kjmo,
        quelle
);


UPDATE dbp_etl.kmo_artbew_wg_sum_tmp_2 SET
    umsatz_brutto_konz
    = ROUND(
        CAST(
            kmo_artbew_wg_sum_tmp.umsatz_brutto * K.umrechnungskurs AS NUMERIC
        ),
        4
    ),
    umsatz_netto_konz
    = ROUND(
        CAST(kmo_artbew_wg_sum_tmp.umsatz_netto * K.umrechnungskurs AS NUMERIC),
        4
    )
FROM
    dbp_data.kurs_2 AS K
WHERE
    kmo_artbew_wg_sum_tmp.umsatz_wrg = K.von_wrg_id
    AND kmo_artbew_wg_sum_tmp.dat BETWEEN K.dat_von AND K.dat_bis
    AND K.nach_wrg_id = 'EUR' AND K.kurstyp_id = 3;


DELETE FROM dbp_data.artbew_wg_sum_2
WHERE bewart_id = 1001 AND (
    mandant_id, wup_id, nb_id, dat) IN (
    SELECT (mandant_id, wup_id, nb_id, dat)
    FROM dbp_etl.kmo_artbew_wg_sum_tmp_2
) AND quelle = 1;


DELETE FROM dbp_data.artbew_wg_sum_2
WHERE bewart_id IN (
    1001, 1009
)
AND (
    mandant_id, wup_id, nb_id, dat) IN (
    SELECT (mandant_id, wup_id, nb_id, dat)
    FROM dbp_etl.kmo_artbew_wg_sum_tmp_2
)
AND (mandant_id, wup_id, nb_id, dat) IN (
    SELECT (
        mandant_id,
        wup_id, nb_id, dat
    )
    FROM dbp_data.wupcal_2
    WHERE datenlieferung_artbew_wg_sum = 2
);


DELETE FROM dbp_etl.kmo_artbew_wg_sum_tmp_2
WHERE (
    mandant_id, wup_id, dat, nb_id) IN (
    SELECT (T.mandant_id, T.wup_id, T.dat, T.nb_id)
    FROM dbp_etl.kmo_artbew_wg_sum_tmp_2 AS T
    INNER JOIN dbp_data.artbew_wg_sum_2
        AS A ON T.mandant_id = A.mandant_id AND T.wup_id = A.wup_id AND T.nb_id
    = A.nb_id AND T.dat = A.dat AND A.bewart_id IN (1001, 1009)
);


INSERT INTO dbp_data.artbew_wg_sum_2 (
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
        A.mandant_id,
        A.nb_id,
        A.arthiertyp_id,
        A.wg_id,
        K.umrechnungskurs,
        A.dat,
        A.wup_id,
        A.bewart_id,
        A.kjmo,
        A.umsatz_brutto,
        A.umsatz_netto,
        A.umsatz_wrg,
        A.umsatz_brutto_konz,
        A.umsatz_netto_konz,
        A.quelle,
        A.menge
    FROM dbp_etl.kmo_artbew_wg_sum_tmp_2 AS A
    LEFT JOIN
        dbp_data.kurs_2
            AS K
        ON
            A.umsatz_wrg = K.von_wrg_id
            AND A.dat BETWEEN K.dat_von AND K.dat_bis
            AND K.nach_wrg_id = 'EUR' AND K.kurstyp_id = 3
);


UPDATE dbp_data.wupcal_2 SET
    datenlieferung_artbew_wg_sum = 1
WHERE (
    mandant_id, wup_id, nb_id, dat) IN (
    SELECT (mandant_id, wup_id, nb_id, dat)
    FROM dbp_etl.kmo_artbew_wg_sum_tmp_2
);


INSERT INTO dbp_etl_process.artbew_wg_sum_agg_wt_2 (
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
    FROM dbp_etl.kmo_artbew_wg_sum_tmp_2
    GROUP BY
        mandant_id,
        wup_id,
        nb_id,
        dat,
        calc_fg,
        dat_lief
);


TRUNCATE TABLE dbp_etl.kmo_artbew_bon_2;


TRUNCATE TABLE dbp_etl.kmo_artbew_bon_promotion_2;


TRUNCATE TABLE dbp_etl.kmo_artbew_wg_sum_tmp_2;


TRUNCATE TABLE dbp_etl.kmo_artbew_bon_dat_2;
