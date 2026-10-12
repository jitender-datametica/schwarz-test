--[OK] statement is translated correctly (syntax and type checks are fine)


DROP TABLE IF EXISTS dbp_etl.kmo_artbew_wg_sum_tmp_2;


--[OK] statement is translated correctly (syntax and type checks are fine)


CREATE TABLE IF NOT EXISTS dbp_etl.kmo_artbew_wg_sum_tmp_2 LIKE dbp_data.artbew_wg_sum_2;


--[OK] statement is translated correctly (syntax and type checks are fine)


DELETE FROM dbp_etl.kmo_artbew_bon_2
WHERE mandant_id = 6 /* Kroatien */ AND kl_art_id IN (9800130, 9800131, 9800132);


--[OK] statement is translated correctly (syntax and type checks are fine)


DELETE FROM dbp_etl.kmo_artbew_bon_2
WHERE (
    mandant_id, lkp_art_id) IN (
    SELECT (mandant_id, art_id)
    FROM dbp_data.art_wg_zu_per_2
    WHERE
        mandant_id = 7
        AND arthiertyp_id = 2
        AND dat_bis = PARSE_DATE('%F', '9999-12-31')
        AND wg_id = 969
        AND wug_id = 6
);


--translated statement


-- Ermittlung Promotionsbetrag pro Bon Zeile
/* Kassen Direktentsorgung */
/* mue 13.01.2010: Nach Abstimmung mit Hr. Ferber/VIS auf Arthiertyp_2 2 gesetzt */ -- bartosiewiczadm - cloud migration

-- Schritt berechnet
-- Mai 2011: Promotionswert von Umsatz abziehen (addieren, weil negatives Vorzeichen)

-- (25.09.2017 cdab) Laut A. Wolter sind die Umsätze im KPOS ODS schon Promo bereinigt. Daher sollen die Umsatz im wg_sum ohne Abzug gespeichert werden.

/* Kassen Direktentsorgung */ -- die Konz Betraege werden in einem folgenden

-- ,(l.dat_booking / 100) +  190000 AS kjmo

-- ,umsatz_brutto_ + umsatz_promotion_brutto_ AS umsatz_brutto  /*Belegbruttoumsatz - Promotionsumsatz = (Brutto)Kassenumsatz

INSERT INTO dbp_etl.kmo_artbew_wg_sum_tmp_2 (
    mandant_id, nb_id, arthiertyp_id, wg_id, dat, wup_id,
    bewart_id, kjmo, umsatz_brutto, umsatz_netto, umsatz_wrg, umsatz_brutto_konz, umsatz_netto_konz, quelle, menge
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
            ROUND(CAST(FORMAT_DATE('%Y%m', Z.dat_booking) AS BIGNUMERIC), 0) AS kjmo,
            1 AS quelle,
            SUM(Z.umsatz_brutto) AS umsatz_brutto,
            CAST(SUM(Z.umsatz_brutto) / (1 + Z.lkp_mwst / 100) AS NUMERIC) AS umsatz_netto,
            0 AS umsatz_brutto_konz,
            0 AS umsatz_netto_konz,
            SUM(Z.menge) AS menge
        FROM dbp_etl.kmo_artbew_bon_2 AS Z
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
                Z.mandant_id = p.mandant_id AND Z.bon_id = p.bon_id AND Z.dat_booking = p.dat_booking AND Z.bon_zeile
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


--[OK] statement is translated correctly (syntax and type checks are fine)


UPDATE dbp_etl.kmo_artbew_wg_sum_tmp_2 SET
    umsatz_brutto_konz = ROUND(CAST(kmo_artbew_wg_sum_tmp.umsatz_brutto * K.umrechnungskurs AS NUMERIC), 4),
    umsatz_netto_konz = ROUND(CAST(kmo_artbew_wg_sum_tmp.umsatz_netto * K.umrechnungskurs AS NUMERIC), 4) FROM
    dbp_data.kurs_2 AS K
WHERE
    kmo_artbew_wg_sum_tmp.umsatz_wrg = K.von_wrg_id AND kmo_artbew_wg_sum_tmp.dat BETWEEN K.dat_von AND K.dat_bis AND
    K.nach_wrg_id = 'EUR' AND K.kurstyp_id = 3;


--[OK] statement is translated correctly (syntax and type checks are fine)


DELETE FROM dbp_data.artbew_wg_sum_2
WHERE bewart_id = 1001 AND (
    mandant_id, wup_id, nb_id, dat) IN (
    SELECT (mandant_id, wup_id, nb_id, dat)
    FROM dbp_etl.kmo_artbew_wg_sum_tmp_2
) AND quelle = 1; -- Daten in der Zieltabelle stammen aus der Kasse


--[OK] statement is translated correctly (syntax and type checks are fine)


DELETE FROM dbp_data.artbew_wg_sum_2
WHERE bewart_id IN (
    1001, 1009) AND (mandant_id, wup_id, nb_id, dat) IN (SELECT (mandant_id, wup_id, nb_id, dat)
FROM dbp_etl.kmo_artbew_wg_sum_tmp_2) AND (mandant_id, wup_id, nb_id, dat) IN (
    SELECT (
        mandant_id,
        wup_id, nb_id, dat
    )
    FROM dbp_data.wupcal_2
    WHERE datenlieferung_artbew_wg_sum = 2
);


--[OK] statement is translated correctly (syntax and type checks are fine)


DELETE FROM dbp_etl.kmo_artbew_wg_sum_tmp_2
WHERE (
    mandant_id, wup_id, dat, nb_id) IN (
    SELECT (T.mandant_id, T.wup_id, T.dat, T.nb_id)
    FROM dbp_etl.kmo_artbew_wg_sum_tmp_2 AS T
    INNER JOIN
        dbp_data.artbew_wg_sum_2
            AS A
        ON
            T.mandant_id = A.mandant_id AND T.wup_id = A.wup_id AND T.nb_id
            = A.nb_id AND T.dat = A.dat AND A.bewart_id IN (1001, 1009)
);


--[OK] statement is translated correctly (syntax and type checks are fine)


INSERT INTO dbp_data.artbew_wg_sum_2 (
    mandant_id, nb_id, arthiertyp_id, wg_id, dat, wup_id, bewart_id, kjmo,
    umsatz_brutto, umsatz_netto, umsatz_wrg, umsatz_brutto_konz, umsatz_netto_konz, quelle, menge
)
(SELECT
    mandant_id,
    nb_id,
    arthiertyp_id,
    wg_id,
    dat,
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
FROM dbp_etl.kmo_artbew_wg_sum_tmp_2);


--[OK] statement is translated correctly (syntax and type checks are fine)


UPDATE dbp_data.wupcal_2 SET
    datenlieferung_artbew_wg_sum = 1
WHERE (
    mandant_id, wup_id, nb_id, dat) IN (
    SELECT (mandant_id, wup_id, nb_id, dat)
    FROM dbp_etl.kmo_artbew_wg_sum_tmp_2
);


--translated statement


-- ,DATE AS dat_lief
-- bartosiewiczadm - cloud migration
INSERT INTO dbp_etl_process.artbew_wg_sum_agg_wt_2
(mandant_id, wup_id, nb_id, dat, calc_fg, dat_lief)
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


--[OK] statement is translated correctly (syntax and type checks are fine)


DROP TABLE IF EXISTS dbp_etl.kmo_artbew_bon_2;


--[OK] statement is translated correctly (syntax and type checks are fine)


DROP TABLE IF EXISTS dbp_etl.kmo_artbew_bon_promotion_2;


--[OK] statement is translated correctly (syntax and type checks are fine)


DROP TABLE IF EXISTS dbp_etl.kmo_artbew_wg_sum_tmp_2;


--[OK] statement is translated correctly (syntax and type checks are fine)


TRUNCATE TABLE dbp_etl.kmo_artbew_bon_dat_2;


DELETE FROM dbp_etl_process.poslog_agg_wt_2
WHERE mandant_id > 1;
