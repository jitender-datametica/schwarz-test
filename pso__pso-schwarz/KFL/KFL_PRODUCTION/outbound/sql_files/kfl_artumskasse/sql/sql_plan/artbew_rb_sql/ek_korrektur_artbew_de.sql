-- 06.10.2023, -dbay-
--
-- EK-Korrekturen (DE) fuer die ARTBEW. In diesem Skript nur die
-- gemeldeten Tage und Artikel einfuegen, dann laufen lassen.
--
-- Voraussetzung sind eine konsistente ZEKP und ART_GP_NM_ZU_PER!


CREATE OR REPLACE TEMPORARY TABLE _artikel (
    kl_art_id INTEGER
);


CREATE OR REPLACE TEMPORARY TABLE _artikel_id AS
SELECT B.art_id
FROM `_artikel` AS A
INNER JOIN dbp_data.art
    AS B ON A.kl_art_id = B.kl_art_id AND B.dat_bis = DATE '9999-12-31' AND B.mandant_id
= 1;


INSERT INTO `_artikel` (kl_art_id)
VALUES (10006);


CREATE OR REPLACE TABLE dbp_etl.de_wpuums_anr LIKE dbp_data.artbew;


CREATE OR REPLACE TABLE dbp_etl.de_wpuums_dat (
    dat DATE
);


CREATE OR REPLACE TABLE dbp_etl.de_wpuums_dat_min (
    dat DATE
);


CREATE OR REPLACE TEMPORARY TABLE _vol_art_gp_wup_zu_per (
    mandant_id INTEGER NOT NULL,
    art_id INTEGER NOT NULL,
    gp_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    nb_id INTEGER,
    einkaufsorganisation_id INTEGER NOT NULL,
    dat DATE NOT NULL,
    ek_brutto NUMERIC(29, 4),
    ek_netto NUMERIC(29, 4),
    ek_nettonetto NUMERIC(29, 4),
    ek_kal_basis NUMERIC(29, 4),
    ek_mep NUMERIC(29, 4),
    einstandspreis NUMERIC(29, 4),
    logistikkostenzuschlag NUMERIC(29, 4),
    ek_netto_bnk NUMERIC(29, 4),
    ek_netto_bnk_sachk NUMERIC(29, 4),
    ek_mep_vor_fwu NUMERIC(29, 4),
    bonusbasis NUMERIC(29, 4)
);


CREATE OR REPLACE TEMPORARY TABLE _art_wup_man_spanne_tmp (
    mandant_id INTEGER NOT NULL,
    art_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    nb_id INTEGER NOT NULL,
    dat DATE NOT NULL,
    zwgs NUMERIC(29, 4),
    zwgm NUMERIC(29, 4),
    zwge NUMERIC(29, 4)
);


INSERT INTO dbp_etl.de_wpuums_dat (dat)
(
    SELECT dat
    FROM dbp_data.tag
    WHERE dat BETWEEN DATE '2024-12-29' AND DATE '2025-01-02'
    GROUP BY dat
);


INSERT INTO dbp_etl.de_wpuums_dat_min (dat)
(
    SELECT MIN(dat)
    FROM dbp_data.tag
    WHERE dat BETWEEN DATE '2024-12-29' AND DATE '2025-01-02'
    HAVING MIN(dat) IS NOT NULL
);


-- auf Tag auffaechern
INSERT INTO `_vol_art_gp_wup_zu_per` (
    mandant_id, art_id, gp_id, wup_id, nb_id,
    einkaufsorganisation_id, dat, ek_brutto, ek_netto, ek_nettonetto, ek_kal_basis, ek_mep, einstandspreis,
    logistikkostenzuschlag, ek_netto_bnk, ek_netto_bnk_sachk, ek_mep_vor_fwu, bonusbasis
)
(
    SELECT
        a.mandant_id,
        a.art_id,
        a.gp_id,
        a.wup_id,
        a.nb_id,
        a.einkaufsorganisation_id,
        D.dat,
        a.ek_brutto,
        a.ek_netto,
        a.ek_nettonetto,
        a.ek_kal_basis,
        a.ek_mep,
        a.einstandspreis,
        a.logistikkostenzuschlag,
        a.ek_netto_bnk,
        a.ek_netto_bnk_sachk,
        a.ek_mep_vor_fwu,
        a.bonusbasis
    FROM (
        SELECT
            A.mandant_id,
            A.wup_id,
            A.nb_id,
            A.art_id,
            A.gp_id,
            A.einkaufsorganisation_id,
            A.dat_von,
            A.dat_bis,
            A.wrg_id,
            CAST(A.ek_brutto AS NUMERIC) AS ek_brutto,
            CAST(A.ek_netto AS NUMERIC) AS ek_netto,
            CAST(A.ek_nettonetto AS NUMERIC) AS ek_nettonetto,
            CAST(A.ek_kal_basis AS NUMERIC) AS ek_kal_basis,
            CAST(A.ek_mep AS NUMERIC) AS ek_mep,
            CAST(A.einstandspreis AS NUMERIC) AS einstandspreis,
            A.logistikkostenzuschlag,
            CAST(A.ek_netto_bnk AS NUMERIC) AS ek_netto_bnk,
            CAST(A.ek_netto_bnk_sachk AS NUMERIC) AS ek_netto_bnk_sachk,
            CAST(A.ek_mep_vor_fwu AS NUMERIC) AS ek_mep_vor_fwu,
            CAST(A.bonusbasis AS NUMERIC) AS bonusbasis
        FROM dbp_data.art_gp_wup_zu_per AS A
        INNER JOIN dbp_etl.de_wpuums_dat_min AS M ON A.dat_bis >= M.dat
        WHERE A.mandant_id = 1
    ) AS a
    INNER JOIN dbp_etl.de_wpuums_dat AS D ON D.dat BETWEEN a.dat_von AND a.dat_bis
);


-- Nun die betriebsuebergreifenden manuellen Spannenfaktoren


/* optional */ /* Einstandspreis zwingend erforderlich */ /* optional */ INSERT INTO `_art_wup_man_spanne_tmp` (
    mandant_id,
    art_id, wup_id, nb_id, dat, zwgs, zwgm, zwge
)
(
    SELECT
        EIN.mandant_id,
        EIN.art_id,
        -1 AS wup_id,
        -1 AS nb_id,
        A.dat,
        EIN.ek_faktor AS zwgs,
        COALESCE(MEP.ek_faktor, EIN.ek_faktor) AS zwgm,
        COALESCE(EKBNK.ek_faktor, MEP.ek_faktor, EIN.ek_faktor) AS zwge
    FROM dbp_etl.de_wpuums_dat AS A
    INNER JOIN dbp_data.art_man_spanne_per AS EIN
        ON
            EIN.konditionsart_id = 'ZWGS' /* einstandspreis */ AND
            EIN.loesch_fg = 0 AND A.dat BETWEEN EIN.dat_von AND EIN.dat_bis
    LEFT JOIN dbp_data.art_man_spanne_per AS MEP
        ON
            EIN.mandant_id = MEP.mandant_id AND EIN.art_id = MEP.art_id
            AND MEP.konditionsart_id = 'ZWGM' /* MEP */ AND MEP.loesch_fg = 0 AND A.dat BETWEEN MEP.dat_von AND MEP.dat_bis
    LEFT JOIN
        dbp_data.art_man_spanne_per
            AS EKBNK
        ON
            EIN.mandant_id = EKBNK.mandant_id AND EIN.art_id =
            EKBNK.art_id AND EKBNK.konditionsart_id = 'ZWGE' /* eknetto bnk */ AND EKBNK.loesch_fg = 0 AND A.dat BETWEEN
            EKBNK.dat_von AND EKBNK.dat_bis
);


-- Nun die betriebsspezifischen manuellen Spannenfaktoren!


/* optional */ /* Einstandspreis zwingend erforderlich */ /* optional */ INSERT INTO `_art_wup_man_spanne_tmp` (
    mandant_id,
    art_id, wup_id, nb_id, dat, zwgs, zwgm, zwge
)
(
    SELECT
        EIN.mandant_id,
        EIN.art_id,
        EIN.wup_id,
        EIN.nb_id,
        A.dat,
        EIN.ek_faktor AS zwgs,
        COALESCE(MEP.ek_faktor, EIN.ek_faktor) AS zwgm,
        COALESCE(EKBNK.ek_faktor, MEP.ek_faktor, EIN.ek_faktor) AS zwge
    FROM dbp_etl.de_wpuums_dat AS A
    INNER JOIN dbp_data.art_wup_man_spanne_per AS EIN
        ON
            EIN.konditionsart_id = 'ZWGS' /* einstandspreis */
            AND EIN.loesch_fg = 0 AND A.dat BETWEEN EIN.dat_von AND EIN.dat_bis
    LEFT JOIN dbp_data.art_wup_man_spanne_per AS MEP
        ON
            EIN.mandant_id = MEP.mandant_id AND EIN.wup_id =
            MEP.wup_id AND EIN.art_id = MEP.art_id AND MEP.konditionsart_id = 'ZWGM' /* MEP */ AND MEP.loesch_fg = 0 AND A.dat
            BETWEEN MEP.dat_von AND MEP.dat_bis
    LEFT JOIN
        dbp_data.art_wup_man_spanne_per
            AS EKBNK
        ON
            EIN.mandant_id = EKBNK.mandant_id AND EIN.wup_id
            = EKBNK.wup_id AND EIN.art_id = EKBNK.art_id AND EKBNK.konditionsart_id = 'ZWGE' /* eknetto bnk */ AND EKBNK.loesch_fg
            = 0 AND A.dat BETWEEN EKBNK.dat_von AND EKBNK.dat_bis
);


/* (2) EK-Preise ZEKP */ /* (2) EK-Preise ZEKP */ /* (3) kein Treffer; 0%-Spanne */ /* (1) manuelle Spanne */
/* (1) manuelle Spanne */ /* (3) kein Treffer; 0%-Spanne */ /* (1) manuelle Spanne */ /* (3) kein Treffer; 0%-Spanne */
/* (1) manuelle Spanne */ /* (2) EK-Preise ZEKP */ /* (2) EK-Preise ZEKP */ /* (2) EK-Preise ZEKP */
/* (1) manuelle Spanne */ /* (1) manuelle Spanne */ /* (2) EK-Preise ZEKP */ /* (3) kein Treffer; 0%-Spanne */
/* (2) EK-Preise ZEKP */ /* (3) kein Treffer; 0%-Spanne */ /* (2) EK-Preise ZEKP */ /* (3) kein Treffer; 0%-Spanne */
/* (1) manuelle Spanne */ /* (3) kein Treffer; 0%-Spanne */ /* (1) manuelle Spanne */ /* (3) kein Treffer; 0%-Spanne */
/* (1) manuelle Spanne */ /* (2) EK-Preise ZEKP */ /* (3) kein Treffer; 0%-Spanne */ INSERT INTO dbp_etl.de_wpuums_anr (
    mandant_id, wup_id, nb_id, dat, bewart_id, gp_id, art_id, aktion_id, promo_fg, ean_kasse,
    standard_aktion_id, einkaufsorganisation_id, herst_id, mwst_id, menge, wrg, umsatz_netto, diff_umsatz_netto_konz,
    umsatz_mwst_betrag, diff_umsatz_mwst_betrag_konz, ek_brutto, diff_ek_brutto_konz, ek_netto, diff_ek_netto_konz,
    ek_nettonetto, diff_ek_nettonetto_konz, ek_kal_basis, diff_ek_kal_basis_konz, ek_mep, diff_ek_mep_konz, ek_mep_vor_fwu,
    ek_mep_vor_fwu_konz, einstandspreis, diff_einstandspreis_konz, logkostenzuschlag, diff_logkostenzuschlag_konz,
    bezugsweg_id, ek_netto_bnk, diff_ek_netto_bnk_konz, ek_netto_bnk_sachk, diff_ek_netto_bnk_sachk_konz, posten_id,
    bq_findung_id, ek_gld, diff_ek_gld_konz, bonusbasis, bonusbasis_konz, bewart_det_id, wup_bereinigt_fg, pv_aktion,
    pv_bby, pv_kdn_bby, pv_kdp_bby, pv_aktion_bby, pv_aktion_kdn_bby, pv_aktion_kdp_bby
)
(
    SELECT
        A.mandant_id,
        A.wup_id,
        A.nb_id,
        A.dat,
        A.bewart_id,
        COALESCE(X.gp_id, A.gp_id) AS gp_id,
        A.art_id,
        A.aktion_id,
        A.promo_fg,
        A.ean_kasse,
        A.standard_aktion_id,
        COALESCE(X.einkaufsorganisation_id, A.einkaufsorganisation_id) AS einkaufsorganisation_id,
        A.herst_id,
        A.mwst_id,
        A.menge,
        A.wrg,
        A.umsatz_netto,
        A.diff_umsatz_netto_konz,
        A.umsatz_mwst_betrag,
        A.diff_umsatz_mwst_betrag_konz,
        CASE
            WHEN X.bq_findung_id = 25
                THEN CAST(A.umsatz_netto AS NUMERIC)
            ELSE COALESCE(ROUND(
                CAST(A.umsatz_netto * COALESCE(MA.zwge, MS.zwge) AS NUMERIC), 4), ROUND(
                CAST(A.menge * COALESCE(AGW.ek_brutto, AGWW.ek_brutto, AGWWW.ek_brutto) AS NUMERIC),
                4
            ), CAST(A.umsatz_netto AS NUMERIC
            ))
        END AS ek_brutto,
        0 AS diff_ek_brutto_konz,
        CASE
            WHEN X.bq_findung_id = 25
                THEN CAST(A.umsatz_netto AS NUMERIC)
            ELSE COALESCE(ROUND(
                CAST(A.umsatz_netto * COALESCE(MA.zwge, MS.zwge) AS NUMERIC), 4), ROUND(
                CAST(A.menge * COALESCE(AGW.ek_netto, AGWW.ek_netto, AGWWW.ek_netto) AS NUMERIC),
                4
            ), CAST(A.umsatz_netto AS NUMERIC
            ))
        END AS ek_netto,
        0 AS diff_ek_netto_konz,
        CASE
            WHEN X.bq_findung_id = 25
                THEN CAST(A.umsatz_netto AS NUMERIC)
            ELSE COALESCE(ROUND(
                CAST(A.umsatz_netto * COALESCE(MA.zwge, MS.zwge) AS NUMERIC), 4), ROUND(
                CAST(A.menge * COALESCE(AGW.ek_nettonetto, AGWW.ek_nettonetto, AGWWW.ek_nettonetto) AS NUMERIC),
                4
            ), CAST(A.umsatz_netto AS NUMERIC
            ))
        END AS ek_nettonetto,
        0 AS diff_ek_nettonetto_konz,
        CASE
            WHEN X.bq_findung_id = 25
                THEN CAST(A.umsatz_netto AS NUMERIC)
            ELSE COALESCE(ROUND(
                CAST(A.umsatz_netto * COALESCE(MA.zwge, MS.zwge) AS NUMERIC), 4), ROUND(
                CAST(A.menge * COALESCE(AGW.ek_kal_basis, AGWW.ek_kal_basis, AGWWW.ek_kal_basis) AS NUMERIC),
                4
            ), CAST(A.umsatz_netto AS NUMERIC
            ))
        END AS ek_kal_basis,
        0 AS diff_ek_kal_basis_konz,
        CASE
            WHEN X.bq_findung_id = 25
                THEN CAST(A.umsatz_netto AS NUMERIC)
            ELSE COALESCE(ROUND(
                CAST(A.umsatz_netto * COALESCE(MA.zwge, MS.zwge) AS NUMERIC), 4), ROUND(
                CAST(A.menge * COALESCE(AGW.ek_mep, AGWW.ek_mep, AGWWW.ek_mep) AS NUMERIC),
                4
            ), CAST(A.umsatz_netto AS NUMERIC
            ))
        END AS ek_mep,
        0 AS diff_ek_mep_konz,
        CASE
            WHEN X.bq_findung_id = 25
                THEN CAST(A.umsatz_netto AS NUMERIC)
            ELSE COALESCE(ROUND(
                CAST(A.umsatz_netto * COALESCE(MA.zwge, MS.zwge) AS NUMERIC), 4), ROUND(
                CAST(A.menge * COALESCE(AGW.ek_mep_vor_fwu, AGWW.ek_mep_vor_fwu, AGWWW.ek_mep_vor_fwu) AS NUMERIC),
                4
            ), CAST(A.umsatz_netto AS NUMERIC
            ))
        END AS ek_mep_vor_fwu,
        0 AS ek_mep_vor_fwu_konz,
        CASE
            WHEN X.bq_findung_id = 25
                THEN CAST(A.umsatz_netto AS NUMERIC)
            ELSE COALESCE(ROUND(
                CAST(A.umsatz_netto * COALESCE(MA.zwge, MS.zwge) AS NUMERIC), 4), ROUND(
                CAST(A.menge * COALESCE(AGW.einstandspreis, AGWW.einstandspreis, AGWWW.einstandspreis) AS NUMERIC),
                4
            ), CAST(A.umsatz_netto AS NUMERIC
            ))
        END AS einstandspreis,
        0 AS diff_einstandspreis_konz,
        CAST(
            A.menge * COALESCE(AGW.logistikkostenzuschlag, AGWW.logistikkostenzuschlag, 0.0000) AS NUMERIC) AS
        logkostenzuschlag_,
        0 AS diff_logkostenzuschlag_konz_,
        COALESCE(X.bezugsweg_id, A.bezugsweg_id) AS bezugsweg_id,
        CASE
            WHEN X.bq_findung_id = 25
                THEN CAST(A.umsatz_netto AS NUMERIC)
            ELSE COALESCE(ROUND(
                CAST(A.umsatz_netto * COALESCE(MA.zwge, MS.zwge) AS NUMERIC), 4), ROUND(
                CAST(A.menge * COALESCE(AGW.ek_netto_bnk, AGWW.ek_netto_bnk, AGWWW.ek_netto_bnk) AS NUMERIC),
                4
            ), CAST(A.umsatz_netto AS NUMERIC
            ))
        END AS ek_netto_bnk,
        0 AS diff_ek_netto_bnk_konz,
        CASE
            WHEN X.bq_findung_id = 25
                THEN CAST(A.umsatz_netto AS NUMERIC)
            ELSE COALESCE(ROUND(
                CAST(A.umsatz_netto * COALESCE(MA.zwge, MS.zwge) AS NUMERIC), 4), ROUND(
                CAST(A.menge * COALESCE(AGW.ek_netto_bnk_sachk, AGWW.ek_netto_bnk_sachk, AGWWW.ek_netto_bnk_sachk) AS NUMERIC),
                4
            ), CAST(A.umsatz_netto AS NUMERIC
            ))
        END AS ek_netto_bnk_sachk,
        0 AS diff_ek_netto_bnk_sachk_konz,
        A.posten_id,
        COALESCE(X.bq_findung_id, 30) AS bq_findung_id,
        A.ek_gld,
        A.diff_ek_gld_konz,
        CASE
            WHEN X.bq_findung_id = 25
                THEN CAST(A.umsatz_netto AS NUMERIC)
            ELSE COALESCE(ROUND(
                CAST(A.umsatz_netto * COALESCE(MA.zwge, MS.zwge) AS NUMERIC), 4), ROUND(
                CAST(A.menge * COALESCE(AGW.bonusbasis, AGWW.bonusbasis, AGWWW.bonusbasis) AS NUMERIC),
                4
            ), CAST(A.umsatz_netto AS NUMERIC
            ))
        END AS bonusbasis,
        0 AS bonusbasis_konz,
        A.bewart_det_id,
        A.wup_bereinigt_fg,
        A.pv_aktion,
        A.pv_bby,
        A.pv_kdn_bby,
        A.pv_kdp_bby,
        A.pv_aktion_bby,
        A.pv_aktion_kdn_bby,
        A.pv_aktion_kdp_bby
    FROM dbp_data.artbew AS A
    INNER JOIN dbp_etl.de_wpuums_dat AS D ON A.dat = D.dat -- Lieferant und Ausstiegspunkt ermitteln

    LEFT JOIN dbp_data.art_gp_nm_zu_per AS X
        ON
            A.mandant_id = X.mandant_id AND A.wup_id = X.wup_id AND A.art_id
            = X.art_id AND A.dat BETWEEN X.dat_von AND X.dat_bis
    LEFT JOIN dbp_data.ek_orderbuch AS XXX ON A.mandant_id = XXX.mandant_id AND X.gp_id = XXX.wup_id AND A.art_id = XXX.art_id AND A.dat BETWEEN XXX.dat_von AND XXX.dat_bis -- Betriebsuebergreifender EK Preis

    LEFT JOIN `_vol_art_gp_wup_zu_per` AS AGWWW
        ON
            X.mandant_id = AGWWW.mandant_id AND X.gp_id = AGWWW.wup_id AND X.art_id
            = AGWWW.art_id AND COALESCE(XXX.gp_id, X.gp_id) = AGWWW.gp_id AND A.dat = AGWWW.dat
    -- Betriebsspezifischer EK Preis

    LEFT JOIN `_vol_art_gp_wup_zu_per` AS AGW
        ON
            X.mandant_id = AGW.mandant_id AND X.vz_wup_id = AGW.wup_id AND X.art_id =
            AGW.art_id AND COALESCE(XXX.gp_id, X.gp_id) = AGW.gp_id AND A.dat = AGW.dat -- Betriebsuebergreifender EK Preis

    LEFT JOIN `_vol_art_gp_wup_zu_per` AS AGWW ON X.mandant_id = AGWW.mandant_id AND -1 = AGWW.wup_id AND X.art_id = AGWW.art_id AND X.gp_id = AGWW.gp_id AND A.dat = AGWW.dat
    -- Ermittlung betriebsuebergreifernde manuelle Spannenfaktoren

    LEFT JOIN `_art_wup_man_spanne_tmp` AS MS
        ON
            A.mandant_id = MS.mandant_id AND A.art_id = MS.art_id AND MS.wup_id = -1
            AND A.dat = MS.dat AND X.bq_findung_id = 27 -- Ermittlung Betriebsspezifischer manuelle Spannefaktoren

    LEFT JOIN `_art_wup_man_spanne_tmp` AS MA
        ON
            A.mandant_id = MA.mandant_id AND A.art_id = MA.art_id AND A.wup_id = MA.wup_id
            AND A.dat = MA.dat AND X.bq_findung_id = 26
    WHERE
        A.mandant_id = 1
        AND A.art_id IN (
            SELECT art_id
            FROM `_artikel_id`
        )
        AND A.dat BETWEEN DATE '2024-12-29' AND DATE '2025-01-02'
);


-- 564.034


DELETE FROM dbp_data.artbew AS A
WHERE (
    mandant_id, wup_id, art_id, dat) IN (
    SELECT (mandant_id, wup_id, art_id, dat)
    FROM dbp_etl.de_wpuums_anr
);


INSERT INTO dbp_data.artbew (
    mandant_id, wup_id, nb_id, dat, bewart_id, gp_id, art_id, aktion_id,
    promo_fg, ean_kasse, standard_aktion_id, einkaufsorganisation_id, herst_id, mwst_id, menge, wrg, umsatz_netto,
    diff_umsatz_netto_konz, umsatz_mwst_betrag, diff_umsatz_mwst_betrag_konz, ek_brutto, diff_ek_brutto_konz, ek_netto,
    diff_ek_netto_konz, ek_nettonetto, diff_ek_nettonetto_konz, ek_kal_basis, diff_ek_kal_basis_konz, ek_mep,
    diff_ek_mep_konz, ek_mep_vor_fwu, ek_mep_vor_fwu_konz, einstandspreis, diff_einstandspreis_konz, logkostenzuschlag,
    diff_logkostenzuschlag_konz, bezugsweg_id, ek_netto_bnk, diff_ek_netto_bnk_konz, ek_netto_bnk_sachk,
    diff_ek_netto_bnk_sachk_konz, posten_id, bq_findung_id, ek_gld, diff_ek_gld_konz, bonusbasis, bonusbasis_konz,
    bewart_det_id, wup_bereinigt_fg, pv_aktion, pv_bby, pv_kdn_bby, pv_kdp_bby, pv_aktion_bby, pv_aktion_kdn_bby,
    pv_aktion_kdp_bby, td_update, td_insert
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
    standard_aktion_id,
    einkaufsorganisation_id,
    herst_id,
    mwst_id,
    menge,
    wrg,
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
    ek_mep_vor_fwu,
    ek_mep_vor_fwu_konz,
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
    diff_ek_gld_konz,
    bonusbasis,
    bonusbasis_konz,
    bewart_det_id,
    wup_bereinigt_fg,
    pv_aktion,
    pv_bby,
    pv_kdn_bby,
    pv_kdp_bby,
    pv_aktion_bby,
    pv_aktion_kdn_bby,
    pv_aktion_kdp_bby,
    CURRENT_TIMESTAMP() AS td_update,
    CURRENT_TIMESTAMP() AS td_insert
FROM dbp_etl.de_wpuums_anr);
