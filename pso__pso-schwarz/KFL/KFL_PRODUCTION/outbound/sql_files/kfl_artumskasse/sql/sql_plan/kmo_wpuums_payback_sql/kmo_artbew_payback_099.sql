-- 1. Verarbeitung Payback (PL) fuers AIS


DROP TABLE IF EXISTS dbp_etl.kmo_artbew_payback_tmp;


CREATE TABLE IF NOT EXISTS dbp_etl.kmo_artbew_payback_tmp LIKE dbp_data.artbew;


/* Payback aus FI */ INSERT INTO dbp_etl.kmo_artbew_payback_tmp (
    mandant_id, wup_id, nb_id, dat,
    bewart_id, gp_id, art_id, aktion_id, promo_fg, ean_kasse, einkaufsorganisation_id, herst_id, mwst_id, menge, wrg,
    umsatz_netto, diff_umsatz_netto_konz, umsatz_mwst_betrag, diff_umsatz_mwst_betrag_konz, ek_brutto, diff_ek_brutto_konz,
    ek_netto, diff_ek_netto_konz, ek_nettonetto, diff_ek_nettonetto_konz, ek_kal_basis, diff_ek_kal_basis_konz, ek_mep,
    diff_ek_mep_konz, ek_mep_vor_fwu, ek_mep_vor_fwu_konz, einstandspreis, diff_einstandspreis_konz, logkostenzuschlag,
    diff_logkostenzuschlag_konz, bezugsweg_id, ek_netto_bnk, diff_ek_netto_bnk_konz, ek_netto_bnk_sachk,
    diff_ek_netto_bnk_sachk_konz, posten_id, bq_findung_id, ek_gld, diff_ek_gld_konz, bonusbasis, bonusbasis_konz
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
        T1.wrg_id AS wrg,
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
        0 AS ek_mep_vor_fwu,
        0 AS ek_mep_vor_fwu_konz,
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
        0 AS diff_ek_gld_konz,
        0 AS bonusbasis,
        0 AS bonusbasis_konz
    FROM dbp_etl_process.in_fi_beleg_det_agg_payback AS T1
    INNER JOIN dbp_data.l_einkaufsorganisation AS T3 ON T1.mandant_id = T3.mandant_id
    INNER JOIN (SELECT
        mandant_id,
        MAX(mwst_id) AS mwst_id
    FROM dbp_data.mwst_per
    WHERE
        dat_bis = PARSE_DATE('%Y%m%d', '99991231')
        AND mwst = 0
    GROUP BY mandant_id) AS t4 ON T1.mandant_id = t4.mandant_id
    INNER JOIN (SELECT
        mandant_id,
        0 AS zero_enc
    FROM dbp_data.mandant) AS t5 ON T1.mandant_id = t5.mandant_id AND (T1.verarbeitet_fg >> 2 & 1) = 0
);


UPDATE dbp_etl.kmo_artbew_payback_tmp SET
    diff_umsatz_netto_konz = ROUND(CAST(kmo_artbew_payback_tmp.umsatz_netto * K.umrechnungskurs AS NUMERIC), 4) FROM
    dbp_data.kurs AS K
WHERE kmo_artbew_payback_tmp.wrg = K.von_wrg_id
-- AND dbp_etl.kmo_artbew_payback_tmp.dat BETWEEN k.dat_von AND k.dat_bis
AND K.dat_bis = DATE '9999-12-31' AND K.nach_wrg_id
= 'EUR' AND K.kurstyp_id = 3;


DELETE FROM dbp_data.artbew
WHERE bewart_id = 1010 AND (
    mandant_id, wup_id, nb_id, dat) IN (
    SELECT (mandant_id, wup_id, nb_id, dat)
    FROM dbp_etl.kmo_artbew_payback_tmp
);


INSERT INTO dbp_data.artbew (
    mandant_id, wup_id, nb_id, dat, bewart_id, gp_id, art_id, aktion_id,
    promo_fg, ean_kasse, standard_aktion_id, einkaufsorganisation_id, herst_id, mwst_id, menge, wrg, umsatz_netto,
    diff_umsatz_netto_konz, umsatz_mwst_betrag, diff_umsatz_mwst_betrag_konz, ek_brutto, diff_ek_brutto_konz, ek_netto,
    diff_ek_netto_konz, ek_nettonetto, diff_ek_nettonetto_konz, ek_kal_basis, diff_ek_kal_basis_konz, ek_mep,
    diff_ek_mep_konz, ek_mep_vor_fwu, ek_mep_vor_fwu_konz, einstandspreis, diff_einstandspreis_konz, logkostenzuschlag,
    diff_logkostenzuschlag_konz, bezugsweg_id, ek_netto_bnk, diff_ek_netto_bnk_konz, ek_netto_bnk_sachk,
    diff_ek_netto_bnk_sachk_konz, posten_id, bq_findung_id, ek_gld, diff_ek_gld_konz, bonusbasis, bonusbasis_konz,
    bewart_det_id, wup_bereinigt_fg, td_update, td_insert, umrechnungskurs_hist
)
(
    SELECT
        A.mandant_id,
        A.wup_id,
        A.nb_id,
        A.dat,
        A.bewart_id,
        A.gp_id,
        A.art_id,
        A.aktion_id,
        A.promo_fg,
        A.ean_kasse,
        '' AS standard_aktion_id,
        A.einkaufsorganisation_id,
        A.herst_id,
        A.mwst_id,
        A.menge,
        A.wrg,
        A.umsatz_netto,
        A.diff_umsatz_netto_konz,
        A.umsatz_mwst_betrag,
        A.diff_umsatz_mwst_betrag_konz,
        A.ek_brutto,
        A.diff_ek_brutto_konz,
        A.ek_netto,
        A.diff_ek_netto_konz,
        A.ek_nettonetto,
        A.diff_ek_nettonetto_konz,
        A.ek_kal_basis,
        A.diff_ek_kal_basis_konz,
        A.ek_mep,
        A.diff_ek_mep_konz,
        A.ek_mep_vor_fwu,
        A.ek_mep_vor_fwu_konz,
        A.einstandspreis,
        A.diff_einstandspreis_konz,
        A.logkostenzuschlag,
        A.diff_logkostenzuschlag_konz,
        A.bezugsweg_id,
        A.ek_netto_bnk,
        A.diff_ek_netto_bnk_konz,
        A.ek_netto_bnk_sachk,
        A.diff_ek_netto_bnk_sachk_konz,
        A.posten_id,
        A.bq_findung_id,
        A.ek_gld,
        A.diff_ek_gld_konz,
        A.bonusbasis,
        A.bonusbasis_konz,
        100110 AS bewart_det_id,
        COALESCE(B.wup_bereinigt_fg, 0) AS wup_bereinigt_fg,
        CURRENT_TIMESTAMP() AS td_update,
        CURRENT_TIMESTAMP() AS td_insert,
        K.umrechnungskurs AS umrechnungskurs_hist
    FROM dbp_etl.kmo_artbew_payback_tmp AS A
    LEFT JOIN dbp_etl_process.wup_fg AS B
        ON
            A.mandant_id = B.mandant_id AND A.wup_id = B.wup_id AND A.dat
            = B.dat
    LEFT JOIN
        dbp_data.kurs
            AS K
        ON
            A.wrg = K.von_wrg_id AND A.dat BETWEEN K.dat_von AND K.dat_bis AND K.nach_wrg_id
            = 'EUR' AND K.kurstyp_id = 3
);


UPDATE dbp_etl_process.in_fi_beleg_det_agg_payback SET
    verarbeitet_fg = IF(
        0 < 63, (in_fi_beleg_det_agg_payback.verarbeitet_fg | (1 << 0)), in_fi_beleg_det_agg_payback.verarbeitet_fg
        + SAFE_CAST(POWER(2, 0) as BIGINT)
    )
WHERE (
    mandant_id, wup_id, dat_buch) IN (
    SELECT (mandant_id, wup_id, dat)
    FROM dbp_etl.kmo_artbew_payback_tmp
);


INSERT INTO dbp_data.artbew_agg_wt (mandant_id, wup_id, nb_id, dat)
(
    SELECT
        mandant_id,
        wup_id,
        nb_id,
        dat
    FROM dbp_etl.kmo_artbew_payback_tmp
    WHERE (
        mandant_id, wup_id, nb_id, dat) NOT IN (
        SELECT (mandant_id, wup_id, nb_id, dat)
        FROM dbp_data.artbew_agg_wt
    )
    GROUP BY
        mandant_id,
        wup_id,
        nb_id,
        dat
);


INSERT INTO dbp_etl_process.uapc_artbew_delta (
    mandant_id, wup_id, dat, row_id, processed_at, td_insert,
    td_update
)
(
    SELECT
        mandant_id,
        wup_id,
        dat,
        (ROW_NUMBER()
            OVER (ORDER BY mandant_id IS NULL, mandant_id, wup_id IS NULL, wup_id, dat IS NULL, dat)) + COALESCE((
            SELECT MAX(row_id)
            FROM dbp_etl_process.uapc_artbew_delta
        ), 0) AS row_id,
        CAST(NULL AS TIMESTAMP) AS processed_at,
        CURRENT_TIMESTAMP() AS td_insert,
        CURRENT_TIMESTAMP() AS td_update
    FROM dbp_etl.kmo_artbew_payback_tmp
    WHERE (
        mandant_id, wup_id, dat, DATE(CURRENT_TIMESTAMP())) NOT IN (
        SELECT (mandant_id, wup_id, dat, DATE(td_insert))
        FROM dbp_etl_process.uapc_artbew_delta
    )
    GROUP BY
        mandant_id,
        wup_id,
        dat
);


-- 2. Verarbeitung Payback (PL) fuers VIS


DROP TABLE IF EXISTS dbp_etl.kmo_wpuums_payback_tmp;


CREATE TABLE IF NOT EXISTS dbp_etl.kmo_wpuums_payback_tmp LIKE dbp_data.artbew_wg_sum;


/* Payback aus FI */ -- ,t1.dat_buch /100 + 190000 as kjmo
/* Payback aus FI */ INSERT INTO dbp_etl.kmo_wpuums_payback_tmp
(
    mandant_id, nb_id, arthiertyp_id, wg_id, dat, wup_id, bewart_id, kjmo, umsatz_brutto, umsatz_netto, umsatz_wrg,
    umsatz_brutto_konz, umsatz_netto_konz, quelle, menge
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
    FROM dbp_etl_process.in_fi_beleg_det_agg_payback AS T1
    INNER JOIN
        dbp_data.art_wg_zu_per
            AS T2
        ON
            T1.mandant_id = T2.mandant_id AND T1.art_id = T2.art_id AND
            T2.dat_bis = PARSE_DATE('%Y%m%d', '99991231') AND T2.arthiertyp_id = 2 AND (T1.verarbeitet_fg >> 1 & 1) = 0
);


UPDATE dbp_etl.kmo_wpuums_payback_tmp SET
    umsatz_brutto_konz = ROUND(CAST(kmo_wpuums_payback_tmp.umsatz_brutto * K.umrechnungskurs AS NUMERIC), 4),
    umsatz_netto_konz = ROUND(CAST(kmo_wpuums_payback_tmp.umsatz_netto * K.umrechnungskurs AS NUMERIC), 4) FROM
    dbp_data.kurs AS K
WHERE
    kmo_wpuums_payback_tmp.umsatz_wrg = K.von_wrg_id AND kmo_wpuums_payback_tmp.dat BETWEEN K.dat_von AND K.dat_bis
    AND K.nach_wrg_id = 'EUR' AND K.kurstyp_id = 3;


DELETE FROM dbp_data.artbew_wg_sum
WHERE bewart_id = 1010 AND (
    mandant_id, wup_id, nb_id, dat) IN (
    SELECT (mandant_id, wup_id, nb_id, dat)
    FROM dbp_etl.kmo_wpuums_payback_tmp
) AND quelle = 10;
-- Daten in der Zieltabelle stammen aus der Payback aus FI


INSERT INTO dbp_data.artbew_wg_sum (
    mandant_id, nb_id, arthiertyp_id, wg_id, umrechnungskurs_hist, dat,
    wup_id, bewart_id, kjmo, umsatz_brutto, umsatz_netto, umsatz_wrg, umsatz_brutto_konz, umsatz_netto_konz, quelle, menge
)
(
    SELECT
        A.mandant_id,
        A.nb_id,
        A.arthiertyp_id,
        A.wg_id,
        K.umrechnungskurs AS umrechnungskurs_hist,
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
    FROM dbp_etl.kmo_wpuums_payback_tmp AS A
    LEFT JOIN
        dbp_data.kurs
            AS K
        ON
            A.umsatz_wrg = K.von_wrg_id AND A.dat BETWEEN K.dat_von AND K.dat_bis
            AND K.nach_wrg_id = 'EUR' AND K.kurstyp_id = 3
);


UPDATE dbp_etl_process.in_fi_beleg_det_agg_payback SET
    verarbeitet_fg = IF(
        1 < 63, (in_fi_beleg_det_agg_payback.verarbeitet_fg | (1 << 1)), in_fi_beleg_det_agg_payback.verarbeitet_fg
        + SAFE_CAST(POWER(2, 1) as BIGINT)
    )
WHERE (
    mandant_id, wup_id, dat_buch) IN (
    SELECT (mandant_id, wup_id, dat)
    FROM dbp_etl.kmo_wpuums_payback_tmp
);


INSERT INTO dbp_etl_process.artbew_wg_sum_agg_wt (mandant_id, wup_id, nb_id, dat, calc_fg, dat_lief)
(
    SELECT
        mandant_id,
        wup_id,
        nb_id,
        dat,
        0 AS calc_fg,
        CURRENT_DATE("Europe/Berlin") AS dat_lief
    FROM dbp_etl.kmo_wpuums_payback_tmp
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
