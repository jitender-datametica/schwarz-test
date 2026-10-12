/*
#------------------------------------------------------------------------------
# Skriptname   : kmo_wpuums_mis.btq
# Erstelldatum : 03.11.2008
#------------------------------------------------------------------------------
# Projekt   : TP1_MIS
# Kommentar : Erweiterung des Umsatzes umd Payback aus FI ( dbp_etl_process.in_fi_beleg_det_agg_payback_2 bzw. dbp_data.in_fi_beleg_det_2
# Quelle    : Tabelle dbp_etl.kmo_wpuums_2
# Ziel      : Tabelle dbp_etl_rfi.kmo_wpuums_2
#             Tabelle dbp_data.artbew_wg_sum_2
#------------------------------------------------------------------------------
# History:
#  26.06.2018  Armin Smoor      Ersterstellung ...

#------------------------------------------------------------------------------
# Processing Steps
# 1.) Logon auf der Datenbank
# 2.) Erzeugen der temporaeren Tabellen
# 3.) Befuellung der Temp-Tabelle kmo_wpuums_tmp_2
# 4.) Berechnung der Umsaetze in Euro Waehrung
# 5.) Loeschen der bestehenden Daten aus der Zieltabelle artbew_wg_sum_2
# 6.) Befuellung der artbew_wg_sum_2
# 7.) Fullen der dbp_etl_process.artbew_wg_sum_agg_wt_2
#------------------------------------------------------------------------------
*/


/*
#------------------------------------------------------------------------------
# 2.) Erzeugen der temporaeren Tabellen
#------------------------------------------------------------------------------
*/


DROP TABLE IF EXISTS dbp_etl.kmo_wpuums_payback_tmp_2;


CREATE TABLE IF NOT EXISTS dbp_etl.kmo_wpuums_payback_tmp_2 LIKE dbp_data.artbew_wg_sum_2;


INSERT INTO dbp_etl.kmo_wpuums_payback_tmp_2 (
    mandant_id, nb_id, arthiertyp_id, wg_id, dat, wup_id,
    bewart_id, kjmo, umsatz_brutto, umsatz_netto, umsatz_wrg, umsatz_brutto_konz, umsatz_netto_konz, quelle, menge
)
(
    SELECT
        T1.mandant_id,
        T1.nb_id,
        T2.arthiertyp_id,
        T2.wg_id,
        T1.dat_buch AS dat,
        T1.wup_id,
        1010 AS bewart_id,
        CAST(ROUND(CAST(FORMAT_DATE('%Y%m', T1.dat_buch) AS BIGNUMERIC), 0) AS INTEGER) AS kjmo,
        T1.betrag_fi_beleg_sum AS umsatz_brutto,
        T1.betrag_fi_beleg_sum AS umsatz_netto,
        T1.wrg_id AS umsatz_wrg,
        T1.betrag_fi_beleg_sum AS umsatz_brutto_konz,
        T1.betrag_fi_beleg_sum AS umsatz_netto_konz,
        10 AS quelle,
        0 AS menge
    FROM dbp_etl_process.in_fi_beleg_det_agg_payback_2 AS T1_2
    INNER JOIN
        dbp_data.art_wg_zu_per_2
            AS T2
        ON
            T1.mandant_id = T2.mandant_id AND T1.art_id = T2.art_id AND
            T2.dat_bis = PARSE_DATE('%Y%m%d', '99991231') AND T2.arthiertyp_id = 2 AND (T1.verarbeitet_fg >> 1 & 1) = 0
);


UPDATE dbp_etl.kmo_wpuums_payback_tmp_2 SET
    umsatz_brutto_konz = ROUND(CAST(kmo_wpuums_payback_tmp.umsatz_brutto * K.umrechnungskurs AS NUMERIC), 4),
    umsatz_netto_konz = ROUND(CAST(kmo_wpuums_payback_tmp.umsatz_netto * K.umrechnungskurs AS NUMERIC), 4) FROM
    dbp_data.kurs_2 AS K
WHERE
    kmo_wpuums_payback_tmp.umsatz_wrg = K.von_wrg_id AND kmo_wpuums_payback_tmp.dat BETWEEN K.dat_von AND K.dat_bis
    AND K.nach_wrg_id = 'EUR' AND K.kurstyp_id = 3;


DELETE FROM dbp_data.artbew_wg_sum_2
WHERE bewart_id = 1010 AND (
    mandant_id, wup_id, nb_id, dat) IN (
    SELECT (mandant_id, wup_id, nb_id, dat)
    FROM dbp_etl.kmo_wpuums_payback_tmp_2
) AND quelle = 10;


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
FROM dbp_etl.kmo_wpuums_payback_tmp_2);


UPDATE dbp_etl_process.in_fi_beleg_det_agg_payback_2 SET
    verarbeitet_fg = IF(
        1 < 63, (in_fi_beleg_det_agg_payback.verarbeitet_fg | (1 << 1)), in_fi_beleg_det_agg_payback.verarbeitet_fg
        + CAST(POWER(2, 1) AS BIGINT)
    )
WHERE (
    mandant_id, wup_id, dat_buch) IN (
    SELECT (mandant_id, wup_id, dat)
    FROM dbp_etl.kmo_wpuums_payback_tmp_2
);


INSERT INTO dbp_etl_process.artbew_wg_sum_agg_wt_2 (mandant_id, wup_id, nb_id, dat, calc_fg, dat_lief)
(
    SELECT
        mandant_id,
        wup_id,
        nb_id,
        dat,
        0 AS calc_fg,
        CURRENT_DATE("Europe/Berlin") AS dat_lief
    FROM dbp_etl.kmo_wpuums_payback_tmp_2
    WHERE (
        mandant_id, wup_id, nb_id, dat) NOT IN (
        SELECT (mandant_id, wup_id, nb_id, dat)
        FROM dbp_etl_process.artbew_wg_sum_agg_wt_2
    )
    GROUP BY
        mandant_id,
        wup_id,
        nb_id,
        dat,
        calc_fg,
        dat_lief
);
