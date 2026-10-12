/*
#------------------------------------------------------------------------------
# Skriptname   : kmo_wpuums_mis.btq
# Erstelldatum : 03.11.2008
#------------------------------------------------------------------------------
# Projekt   : TP1_MIS
# Kommentar : Erweiterung des Umsatzes umd Payback aus FI ( dbp_etl_process.in_fi_beleg_det_agg_payback_1 bzw. dbp_data.in_fi_beleg_det_1
# Quelle    : Tabelle dbp_etl.kmo_wpuums_1
# Ziel      : Tabelle dbp_etl_rfi.kmo_wpuums_1
#             Tabelle dbp_data.artbew_wg_sum_1
#------------------------------------------------------------------------------
# History:
#  26.06.2018  Armin Smoor      Ersterstellung ...

#------------------------------------------------------------------------------
# Processing Steps

#------------------------------------------------------------------------------
*/


/*
#------------------------------------------------------------------------------
# 2.) Erzeugen der temporaeren Tabellen
#------------------------------------------------------------------------------
*/


DROP TABLE IF EXISTS dbp_etl.kmo_artbew_payback_tmp_1;


CREATE TABLE IF NOT EXISTS dbp_etl.kmo_artbew_payback_tmp_1 LIKE dbp_data.artbew_1;


/*
#------------------------------------------------------------------------------
# 3.) Befuellung der Temp-Tabelle kmo_artbew_payback_tmp_1
#------------------------------------------------------------------------------
#  1010: Datenherkunft FI Payback
#------------------------------------------------------------------------------
*/


/* Payback aus FI */ INSERT INTO dbp_etl.kmo_artbew_payback_tmp_1 (
    mandant_id, wup_id, nb_id, dat,
    bewart_id,
    gp_id,
    art_id,
    aktion_id,
    promo_fg,
    ean_kasse,
    einkaufsorganisation_id,
    herst_id,
    mwst_id,
    menge,
    wrg_1,
    umsatz_netto,
    diff_umsatz_netto_konz,
    umsatz_mwst_betrag,
    diff_umsatz_mwst_betrag_konz,
    ek_brutto,
    diff_ek_brutto_konz,
    ek_netto,
    diff_ek_netto_konz,
    ek_nettonetto,
    diff_ek_nettonetto_konz,
    ek_kal_basis,
    diff_ek_kal_basis_konz,
    ek_mep,
    diff_ek_mep_konz,
    einstandspreis,
    diff_einstandspreis_konz,
    logkostenzuschlag,
    diff_logkostenzuschlag_konz,
    bezugsweg_id,
    ek_netto_bnk,
    diff_ek_netto_bnk_konz,
    ek_netto_bnk_sachk,
    diff_ek_netto_bnk_sachk_konz,
    posten_id,
    bq_findung_id, ek_gld, diff_ek_gld_konz
)
(
    SELECT
        T1.mandant_id,
        T1.wup_id,
        T1.nb_id,
        T1.dat_buch AS dat,
        1010 AS bewart_id,
        -1 AS gp_id,
        T1.art_id,
        '          ' AS aktion_id,
        0 AS promo_fg,
        0 AS ean_kasse,
        T3.einkaufsorganisation_id,
        -1 AS herst_id,
        t4.mwst_id,
        0 AS menge,
        T1.wrg_id AS wrg_1,
        T1.betrag_fi_beleg_sum AS umsatz_netto,
        0 AS diff_umsatz_netto_konz,
        0 AS umsatz_mwst_betrag,
        0 AS diff_umsatz_mwst_betrag_konz,
        t5.zero_enc AS ek_brutto,
        t5.zero_enc AS diff_ek_brutto_konz,
        t5.zero_enc AS ek_netto,
        t5.zero_enc AS diff_ek_netto_konz,
        t5.zero_enc AS ek_nettonetto,
        t5.zero_enc AS diff_ek_nettonetto_konz,
        t5.zero_enc AS ek_kal_basis,
        t5.zero_enc AS diff_ek_kal_basis_konz,
        t5.zero_enc AS ek_mep,
        t5.zero_enc AS diff_ek_mep_konz,
        t5.zero_enc AS einstandspreis,
        t5.zero_enc AS diff_einstandspreis_konz,
        0 AS logkostenzuschlag,
        0 AS diff_logkostenzuschlag_konz,
        1 AS bezugsweg_id,
        t5.zero_enc AS ek_netto_bnk,
        t5.zero_enc AS diff_ek_netto_bnk_konz,
        t5.zero_enc AS ek_netto_bnk_sachk,
        t5.zero_enc AS diff_ek_netto_bnk_sachk_konz,
        SUBSTR(CAST(0 AS STRING), 1, 2) AS posten_id,
        25 AS bq_findung_id,
        0 AS ek_gld,
        0 AS diff_ek_gld_konz
    FROM dbp_etl_process.in_fi_beleg_det_agg_payback_1 AS T1_1
    INNER JOIN
        dbp_data.l_einkaufsorganisation_1 AS T3
        ON T1.mandant_id = T3.mandant_id
    INNER JOIN (SELECT
        mandant_id,
        MAX(mwst_id) AS mwst_id
    FROM dbp_data.mwst_per_1
    WHERE
        dat_bis = PARSE_DATE('%Y%m%d', '99991231')
        AND mwst = 0
    GROUP BY mandant_id) AS t4 ON T1.mandant_id = t4.mandant_id
    INNER JOIN (SELECT
        mandant_id,
        0 AS zero_enc
    FROM dbp_data.mandant_1) AS t5
        ON
            T1.mandant_id = t5.mandant_id AND (T1.verarbeitet_fg >> 2 & 1) = 0
);


/*
#------------------------------------------------------------------------------
# 5.) Berechnung der Umsaetze in Euro Waehrung
#     (ACHTUNG: Berechnung mit Kurstyp 3 und nicht wie bei Artbew_1 mit Kurstyp 9)
#------------------------------------------------------------------------------
*/


UPDATE dbp_etl.kmo_artbew_payback_tmp_1 SET
    diff_umsatz_netto_konz
    = ROUND(
        CAST(
            kmo_artbew_payback_tmp.umsatz_netto * K.umrechnungskurs AS NUMERIC
        ),
        4
    )
FROM
    dbp_data.kurs_1 AS K
WHERE
    kmo_artbew_payback_tmp.wrg_1 = K.von_wrg_id
    AND kmo_artbew_payback_tmp.dat BETWEEN K.dat_von AND K.dat_bis
    AND K.nach_wrg_id
    = 'EUR' AND K.kurstyp_id = 9;


/*
#------------------------------------------------------------------------------
# 6.) Loeschen der bestehenden Daten aus der Zieltabelle artbew_1
#
#------------------------------------------------------------------------------
*/


DELETE FROM dbp_data.artbew_1
WHERE bewart_id = 1010 AND (
    mandant_id, wup_id, nb_id, dat) IN (
    SELECT (mandant_id, wup_id, nb_id, dat)
    FROM dbp_etl.kmo_artbew_payback_tmp_1
);


/*
#------------------------------------------------------------------------------
# 7.) Befuellung der artbew_1
#------------------------------------------------------------------------------
*/


INSERT INTO dbp_data.artbew_1 (
    mandant_id, wup_id, nb_id, dat, bewart_id, gp_id, art_id, aktion_id,
    promo_fg,
    ean_kasse,
    einkaufsorganisation_id,
    herst_id,
    mwst_id,
    menge,
    wrg_1,
    umsatz_netto,
    diff_umsatz_netto_konz,
    umsatz_mwst_betrag,
    diff_umsatz_mwst_betrag_konz,
    ek_brutto,
    diff_ek_brutto_konz,
    ek_netto,
    diff_ek_netto_konz,
    ek_nettonetto,
    diff_ek_nettonetto_konz,
    ek_kal_basis,
    diff_ek_kal_basis_konz,
    ek_mep,
    diff_ek_mep_konz,
    einstandspreis,
    diff_einstandspreis_konz,
    logkostenzuschlag,
    diff_logkostenzuschlag_konz,
    bezugsweg_id,
    ek_netto_bnk,
    diff_ek_netto_bnk_konz,
    ek_netto_bnk_sachk,
    diff_ek_netto_bnk_sachk_konz,
    posten_id,
    bq_findung_id,
    ek_gld,
    diff_ek_gld_konz
)
(SELECT
    mandant_id,
    wup_id,
    nb_id,
    dat,
    bewart_id,
    gp_id,
    art_id,
    aktion_id,
    promo_fg,
    ean_kasse,
    einkaufsorganisation_id,
    herst_id,
    mwst_id,
    menge,
    wrg_1,
    umsatz_netto,
    diff_umsatz_netto_konz,
    umsatz_mwst_betrag,
    diff_umsatz_mwst_betrag_konz,
    ek_brutto,
    diff_ek_brutto_konz,
    ek_netto,
    diff_ek_netto_konz,
    ek_nettonetto,
    diff_ek_nettonetto_konz,
    ek_kal_basis,
    diff_ek_kal_basis_konz,
    ek_mep,
    diff_ek_mep_konz,
    einstandspreis,
    diff_einstandspreis_konz,
    logkostenzuschlag,
    diff_logkostenzuschlag_konz,
    bezugsweg_id,
    ek_netto_bnk,
    diff_ek_netto_bnk_konz,
    ek_netto_bnk_sachk,
    diff_ek_netto_bnk_sachk_konz,
    posten_id,
    bq_findung_id,
    ek_gld,
    diff_ek_gld_konz
FROM dbp_etl.kmo_artbew_payback_tmp_1);


UPDATE dbp_etl_process.in_fi_beleg_det_agg_payback_1 SET
    verarbeitet_fg = IF(
        0 < 63,
        (in_fi_beleg_det_agg_payback.verarbeitet_fg | (1 << 0)),
        in_fi_beleg_det_agg_payback.verarbeitet_fg
        + SAFE_CAST(POWER(2, 0) as BIGINT)
    )
WHERE (
    mandant_id, wup_id, dat_buch) IN (
    SELECT (mandant_id, wup_id, dat)
    FROM dbp_etl.kmo_artbew_payback_tmp_1
);


/*
#------------------------------------------------------------------------------
# 10.) Fullen der dbp_etl_process.artbew_agg_wt_1
#------------------------------------------------------------------------------
*/


INSERT INTO dbp_data.artbew_agg_wt_1 (mandant_id, wup_id, nb_id, dat)
(
    SELECT
        mandant_id,
        wup_id,
        nb_id,
        dat
    FROM dbp_etl.kmo_artbew_payback_tmp_1
    WHERE (
        mandant_id, wup_id, nb_id, dat) NOT IN (
        SELECT (mandant_id, wup_id, nb_id, dat)
        FROM dbp_data.artbew_agg_wt_1
    )
    GROUP BY
        mandant_id,
        wup_id,
        nb_id,
        dat
);


/*
#------------------------------------------------------------------------------
# 11.) Bteq beenden
#------------------------------------------------------------------------------
*/
