CREATE OR REPLACE TABLE dbp_etl.kmo_wpuums_anr_2 LIKE dbp_data.artbew_2;


CREATE OR REPLACE TABLE dbp_etl.kmo_wpuums_dat_2 (
    dat DATE
);


CREATE OR REPLACE TABLE dbp_etl.kmo_wpuums_dat_min_2 (
    dat DATE
);


CREATE OR REPLACE TABLE dbp_etl.`__vol_art_gp_wup_zu_per` (
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


CREATE OR REPLACE TABLE dbp_etl.`_art_wup_man_spanne_tmp_$_2{TRANSIENT_TABLE_SUFFIX}` (
    mandant_id INTEGER NOT NULL,
    art_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    nb_id INTEGER NOT NULL,
    dat DATE NOT NULL,
    zwgs NUMERIC(29, 4),
    zwgm NUMERIC(29, 4),
    zwge NUMERIC(29, 4)
);


INSERT INTO dbp_etl.kmo_wpuums_dat_2 (dat)
(
    SELECT dat
    FROM dbp_etl.kmo_wpuums_art_gp_wup_zu_2
    GROUP BY dat
);


INSERT INTO dbp_etl.kmo_wpuums_dat_min_2 (dat)
(
    SELECT MIN(dat)
    FROM dbp_etl.kmo_wpuums_art_gp_wup_zu_2
);


-- auf Tag_2 auffaechern
INSERT INTO dbp_etl.`__vol_art_gp_wup_zu_per` (
    mandant_id, art_id, gp_id, wup_id,
    nb_id, einkaufsorganisation_id, dat, ek_brutto, ek_netto, ek_nettonetto, ek_kal_basis, ek_mep, einstandspreis,
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
        FROM dbp_data.art_gp_wup_zu_per_2 AS A
        INNER JOIN dbp_etl.kmo_wpuums_dat_min_2 AS M ON A.dat_bis >= M.dat
        WHERE A.mandant_id > 1
    ) AS a
    INNER JOIN dbp_etl.kmo_wpuums_dat_2 AS D ON D.dat BETWEEN a.dat_von AND a.dat_bis
);


/* optional */ /* Einstandspreis zwingend erforderlich */ /* optional */ INSERT INTO dbp_etl.`_art_wup_man_spanne_tmp_$_2{TRANSIENT_TABLE_SUFFIX}`
(mandant_id, art_id, wup_id, nb_id, dat, zwgs, zwgm, zwge)
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
    FROM dbp_etl.kmo_wpuums_dat_2 AS A
    INNER JOIN dbp_data.art_man_spanne_per_2 AS EIN
        ON
            EIN.konditionsart_id = 'ZWGS' /* einstandspreis */ AND
            EIN.loesch_fg = 0 AND A.dat BETWEEN EIN.dat_von AND EIN.dat_bis
    LEFT JOIN dbp_data.art_man_spanne_per_2 AS MEP
        ON
            EIN.mandant_id = MEP.mandant_id AND EIN.art_id = MEP.art_id
            AND MEP.konditionsart_id = 'ZWGM' /* MEP */ AND MEP.loesch_fg = 0 AND A.dat BETWEEN MEP.dat_von AND MEP.dat_bis
    LEFT JOIN
        dbp_data.art_man_spanne_per_2
            AS EKBNK
        ON
            EIN.mandant_id = EKBNK.mandant_id AND EIN.art_id =
            EKBNK.art_id AND EKBNK.konditionsart_id = 'ZWGE' /* eknetto bnk */ AND EKBNK.loesch_fg = 0 AND A.dat BETWEEN
            EKBNK.dat_von AND EKBNK.dat_bis
);


/* Einstandspreis zwingend erforderlich */ /* optional */ /* optional */ INSERT INTO dbp_etl.`_art_wup_man_spanne_tmp_$_2{TRANSIENT_TABLE_SUFFIX}`
(mandant_id, art_id, wup_id, nb_id, dat, zwgs, zwgm, zwge)
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
    FROM dbp_etl.kmo_wpuums_dat_2 AS A
    INNER JOIN dbp_data.art_wup_man_spanne_per_2 AS EIN
        ON
            EIN.konditionsart_id = 'ZWGS' /* einstandspreis */
            AND EIN.loesch_fg = 0 AND A.dat BETWEEN EIN.dat_von AND EIN.dat_bis
    LEFT JOIN dbp_data.art_wup_man_spanne_per_2 AS MEP
        ON
            EIN.mandant_id = MEP.mandant_id AND EIN.wup_id =
            MEP.wup_id AND EIN.art_id = MEP.art_id AND MEP.konditionsart_id = 'ZWGM' /* MEP */ AND MEP.loesch_fg = 0 AND A.dat
            BETWEEN MEP.dat_von AND MEP.dat_bis
    LEFT JOIN
        dbp_data.art_wup_man_spanne_per_2
            AS EKBNK
        ON
            EIN.mandant_id = EKBNK.mandant_id AND EIN.wup_id
            = EKBNK.wup_id AND EIN.art_id = EKBNK.art_id AND EKBNK.konditionsart_id = 'ZWGE' /* eknetto bnk */ AND EKBNK.loesch_fg
            = 0 AND A.dat BETWEEN EKBNK.dat_von AND EKBNK.dat_bis
);


/* (3) kein Treffer; 0%-Spanne */ /* (3) kein Treffer; 0%-Spanne */ /* (3) kein Treffer; 0%-Spanne */
/* (3) kein Treffer; 0%-Spanne */ /* (1) manuelle Spanne */ /* (2) EK-Preise ZEKP_2 */ /* (2) EK-Preise ZEKP_2 */
/* (3) kein Treffer; 0%-Spanne */ /* (3) kein Treffer; 0%-Spanne */ /* (1) manuelle Spanne */ /* (1) manuelle Spanne */
/* (3) kein Treffer; 0%-Spanne */ /* (3) kein Treffer; 0%-Spanne */ /* (2) EK-Preise ZEKP_2 */ /* (2) EK-Preise ZEKP_2 */
/* (2) EK-Preise ZEKP_2 */ /* (1) manuelle Spanne */ /* (2) EK-Preise ZEKP_2 */ /* (3) kein Treffer; 0%-Spanne */
/* (3) kein Treffer; 0%-Spanne */ /* (2) EK-Preise ZEKP_2 */ /* (3) kein Treffer; 0%-Spanne */ /* (2) EK-Preise ZEKP_2 */
/* (2) EK-Preise ZEKP_2 */ /* (2) EK-Preise ZEKP_2 */ /* (3) kein Treffer; 0%-Spanne */ /* (3) kein Treffer; 0%-Spanne */
/* (2) EK-Preise ZEKP_2 */ /* (1) manuelle Spanne */ /* (2) EK-Preise ZEKP_2 */ /* (3) kein Treffer; 0%-Spanne */
/* (1) manuelle Spanne */ /* (1) manuelle Spanne */ /* (2) EK-Preise ZEKP_2 */ /* (1) manuelle Spanne */
/* (2) EK-Preise ZEKP_2 */ /* (2) EK-Preise ZEKP_2 */ /* (1) manuelle Spanne */ /* (2) EK-Preise ZEKP_2 */
/* (3) kein Treffer; 0%-Spanne */ /* (3) kein Treffer; 0%-Spanne */ /* (1) manuelle Spanne */ /* (1) manuelle Spanne */
/* (1) manuelle Spanne */ /* (3) kein Treffer; 0%-Spanne */ /* (1) manuelle Spanne */ /* (1) manuelle Spanne */
/* (2) EK-Preise ZEKP_2 */ /* (2) EK-Preise ZEKP_2 */ /* (3) kein Treffer; 0%-Spanne */ /* (1) manuelle Spanne */
/* (2) EK-Preise ZEKP_2 */ /* (1) manuelle Spanne */ /* (1) manuelle Spanne */ /* (1) manuelle Spanne */
/* (2) EK-Preise ZEKP_2 */ /* (1) manuelle Spanne */ /* (3) kein Treffer; 0%-Spanne */ /* (1) manuelle Spanne */
/* (3) kein Treffer; 0%-Spanne */ INSERT INTO dbp_etl.kmo_wpuums_anr_2 (
    mandant_id, wup_id, nb_id, dat,
    bewart_id, gp_id, art_id, aktion_id, promo_fg, ean_kasse, standard_aktion_id, einkaufsorganisation_id, herst_id,
    mwst_id, menge, wrg_2, umsatz_netto, diff_umsatz_netto_konz, umsatz_mwst_betrag, diff_umsatz_mwst_betrag_konz, ek_brutto,
    diff_ek_brutto_konz, ek_netto, diff_ek_netto_konz, ek_nettonetto, diff_ek_nettonetto_konz, ek_kal_basis,
    diff_ek_kal_basis_konz, ek_mep, diff_ek_mep_konz, ek_mep_vor_fwu, ek_mep_vor_fwu_konz, einstandspreis,
    diff_einstandspreis_konz, logkostenzuschlag, diff_logkostenzuschlag_konz, bezugsweg_id, ek_netto_bnk,
    diff_ek_netto_bnk_konz, ek_netto_bnk_sachk, diff_ek_netto_bnk_sachk_konz, posten_id, bq_findung_id, ek_gld,
    diff_ek_gld_konz, bonusbasis, bonusbasis_konz, bewart_det_id, wup_bereinigt_fg, pv_aktion, pv_aktion_konz, pv_bby,
    pv_bby_konz, pv_kdn_bby, pv_kdn_bby_konz, pv_kdp_bby, pv_kdp_bby_konz, pv_aktion_bby, pv_aktion_bby_konz,
    pv_aktion_kdn_bby, pv_aktion_kdn_bby_konz, pv_aktion_kdp_bby, pv_aktion_kdp_bby_konz, pv_bonrabatt_bby,
    pv_bonrabatt_bby_konz, umrechnungskurs_hist, aktionsart_id_liste_txt, aktionsart_bez_liste_txt, aktion_typ_id_liste_txt,
    aktion_typ_bez_liste_txt
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
        A.wrg_2,
        A.umsatz_netto,
        A.diff_umsatz_netto_konz,
        A.umsatz_mwst_betrag,
        A.diff_umsatz_mwst_betrag_konz,
        CASE
            WHEN X.bq_findung_id = 25
                THEN CAST(A.umsatz_netto AS NUMERIC)
            ELSE COALESCE(ROUND(
                CAST(A.umsatz_netto * COALESCE(MA.zwge, MS.zwge) AS NUMERIC), 4), ROUND(
                CAST(A.menge * COALESCE(AGW.ek_brutto, AGWW.ek_brutto) AS NUMERIC),
                4
            ), CAST(A.umsatz_netto AS NUMERIC
            ))
        END AS ek_brutto,
        CASE
            WHEN X.bq_findung_id = 25
                THEN CAST(A.diff_umsatz_netto_konz AS NUMERIC)
            ELSE COALESCE(ROUND(CAST(A.diff_umsatz_netto_konz * COALESCE(MA.zwge, MS.zwge) AS NUMERIC), 4), ROUND(CAST(CASE
                WHEN X.bq_findung_id = 25
                    THEN CAST(A.umsatz_netto AS NUMERIC)
                ELSE COALESCE(ROUND(
                    CAST(A.umsatz_netto * COALESCE(MA.zwge, MS.zwge) AS NUMERIC), 4), ROUND(
                    CAST(A.menge * COALESCE(AGW.ek_brutto, AGWW.ek_brutto) AS NUMERIC),
                    4
                ), CAST(A.umsatz_netto AS NUMERIC
                ))
            END * CASE
                WHEN y.conv_fg = 1
                    THEN 1
                ELSE Z.umrechnungskurs
            END AS NUMERIC), 4), CAST(A.diff_umsatz_netto_konz AS NUMERIC))
        END AS diff_ek_brutto_konz,
        CASE
            WHEN X.bq_findung_id = 25
                THEN CAST(A.umsatz_netto AS NUMERIC)
            ELSE COALESCE(ROUND(
                CAST(A.umsatz_netto * COALESCE(MA.zwge, MS.zwge) AS NUMERIC), 4), ROUND(
                CAST(A.menge * COALESCE(AGW.ek_netto, AGWW.ek_netto) AS NUMERIC),
                4
            ), CAST(A.umsatz_netto AS NUMERIC
            ))
        END AS ek_netto,
        CASE
            WHEN X.bq_findung_id = 25
                THEN CAST(A.diff_umsatz_netto_konz AS NUMERIC)
            ELSE COALESCE(ROUND(CAST(A.diff_umsatz_netto_konz * COALESCE(MA.zwge, MS.zwge) AS NUMERIC), 4), ROUND(CAST(CASE
                WHEN X.bq_findung_id = 25
                    THEN CAST(A.umsatz_netto AS NUMERIC)
                ELSE COALESCE(ROUND(
                    CAST(A.umsatz_netto * COALESCE(MA.zwge, MS.zwge) AS NUMERIC), 4), ROUND(
                    CAST(A.menge * COALESCE(AGW.ek_netto, AGWW.ek_netto) AS NUMERIC),
                    4
                ), CAST(A.umsatz_netto AS NUMERIC
                ))
            END * CASE
                WHEN y.conv_fg = 1
                    THEN 1
                ELSE Z.umrechnungskurs
            END AS NUMERIC), 4), CAST(A.diff_umsatz_netto_konz AS NUMERIC))
        END AS diff_ek_netto_konz,
        CASE
            WHEN X.bq_findung_id = 25
                THEN CAST(A.umsatz_netto AS NUMERIC)
            ELSE COALESCE(ROUND(
                CAST(A.umsatz_netto * COALESCE(MA.zwge, MS.zwge) AS NUMERIC), 4), ROUND(
                CAST(A.menge * COALESCE(AGW.ek_nettonetto, AGWW.ek_nettonetto) AS NUMERIC),
                4
            ), CAST(A.umsatz_netto AS NUMERIC
            ))
        END AS ek_nettonetto,
        CASE
            WHEN X.bq_findung_id = 25
                THEN CAST(A.diff_umsatz_netto_konz AS NUMERIC)
            ELSE COALESCE(ROUND(CAST(A.diff_umsatz_netto_konz * COALESCE(MA.zwge, MS.zwge) AS NUMERIC), 4), ROUND(CAST(CASE
                WHEN X.bq_findung_id = 25
                    THEN CAST(A.umsatz_netto AS NUMERIC)
                ELSE COALESCE(ROUND(
                    CAST(A.umsatz_netto * COALESCE(MA.zwge, MS.zwge) AS NUMERIC), 4), ROUND(
                    CAST(A.menge * COALESCE(AGW.ek_nettonetto, AGWW.ek_nettonetto) AS NUMERIC),
                    4
                ), CAST(A.umsatz_netto AS NUMERIC
                ))
            END * CASE
                WHEN y.conv_fg = 1
                    THEN 1
                ELSE Z.umrechnungskurs
            END AS NUMERIC), 4), CAST(A.diff_umsatz_netto_konz AS NUMERIC))
        END AS diff_ek_nettonetto_konz,
        CASE
            WHEN X.bq_findung_id = 25
                THEN CAST(A.umsatz_netto AS NUMERIC)
            ELSE COALESCE(ROUND(
                CAST(A.umsatz_netto * COALESCE(MA.zwge, MS.zwge) AS NUMERIC), 4), ROUND(
                CAST(A.menge * COALESCE(AGW.ek_kal_basis, AGWW.ek_kal_basis) AS NUMERIC),
                4
            ), CAST(A.umsatz_netto AS NUMERIC
            ))
        END AS ek_kal_basis,
        CASE
            WHEN X.bq_findung_id = 25
                THEN CAST(A.diff_umsatz_netto_konz AS NUMERIC)
            ELSE COALESCE(ROUND(CAST(A.diff_umsatz_netto_konz * COALESCE(MA.zwge, MS.zwge) AS NUMERIC), 4), ROUND(CAST(CASE
                WHEN X.bq_findung_id = 25
                    THEN CAST(A.umsatz_netto AS NUMERIC)
                ELSE COALESCE(ROUND(
                    CAST(A.umsatz_netto * COALESCE(MA.zwge, MS.zwge) AS NUMERIC), 4), ROUND(
                    CAST(A.menge * COALESCE(AGW.ek_kal_basis, AGWW.ek_kal_basis) AS NUMERIC),
                    4
                ), CAST(A.umsatz_netto AS NUMERIC
                ))
            END * CASE
                WHEN y.conv_fg = 1
                    THEN 1
                ELSE Z.umrechnungskurs
            END AS NUMERIC), 4), CAST(A.diff_umsatz_netto_konz AS NUMERIC))
        END AS diff_ek_kal_basis_konz,
        CASE
            WHEN X.bq_findung_id = 25
                THEN CAST(A.umsatz_netto AS NUMERIC)
            ELSE COALESCE(ROUND(
                CAST(A.umsatz_netto * COALESCE(MA.zwge, MS.zwge) AS NUMERIC), 4), ROUND(
                CAST(A.menge * COALESCE(AGW.ek_mep, AGWW.ek_mep) AS NUMERIC),
                4
            ), CAST(A.umsatz_netto AS NUMERIC
            ))
        END AS ek_mep,
        CASE
            WHEN X.bq_findung_id = 25
                THEN CAST(A.diff_umsatz_netto_konz AS NUMERIC)
            ELSE COALESCE(ROUND(CAST(A.diff_umsatz_netto_konz * COALESCE(MA.zwge, MS.zwge) AS NUMERIC), 4), ROUND(CAST(CASE
                WHEN X.bq_findung_id = 25
                    THEN CAST(A.umsatz_netto AS NUMERIC)
                ELSE COALESCE(ROUND(
                    CAST(A.umsatz_netto * COALESCE(MA.zwge, MS.zwge) AS NUMERIC), 4), ROUND(
                    CAST(A.menge * COALESCE(AGW.ek_mep, AGWW.ek_mep) AS NUMERIC),
                    4
                ), CAST(A.umsatz_netto AS NUMERIC
                ))
            END * CASE
                WHEN y.conv_fg = 1
                    THEN 1
                ELSE Z.umrechnungskurs
            END AS NUMERIC), 4), CAST(A.diff_umsatz_netto_konz AS NUMERIC))
        END AS diff_ek_mep_konz,
        CASE
            WHEN X.bq_findung_id = 25
                THEN CAST(A.umsatz_netto AS NUMERIC)
            ELSE COALESCE(ROUND(
                CAST(A.umsatz_netto * COALESCE(MA.zwge, MS.zwge) AS NUMERIC), 4), ROUND(
                CAST(A.menge * COALESCE(AGW.ek_mep_vor_fwu, AGWW.ek_mep_vor_fwu) AS NUMERIC),
                4
            ), CAST(A.umsatz_netto AS NUMERIC
            ))
        END AS ek_mep_vor_fwu,
        CASE
            WHEN X.bq_findung_id = 25
                THEN CAST(A.diff_umsatz_netto_konz AS NUMERIC)
            ELSE COALESCE(ROUND(CAST(A.diff_umsatz_netto_konz * COALESCE(MA.zwge, MS.zwge) AS NUMERIC), 4), ROUND(CAST(CASE
                WHEN X.bq_findung_id = 25
                    THEN CAST(A.umsatz_netto AS NUMERIC)
                ELSE COALESCE(ROUND(
                    CAST(A.umsatz_netto * COALESCE(MA.zwge, MS.zwge) AS NUMERIC), 4), ROUND(
                    CAST(A.menge * COALESCE(AGW.ek_mep_vor_fwu, AGWW.ek_mep_vor_fwu) AS NUMERIC),
                    4
                ), CAST(A.umsatz_netto AS NUMERIC
                ))
            END * CASE
                WHEN y.conv_fg = 1
                    THEN 1
                ELSE Z.umrechnungskurs
            END AS NUMERIC), 4), CAST(A.diff_umsatz_netto_konz AS NUMERIC))
        END AS ek_mep_vor_fwu_konz,
        CASE
            WHEN X.bq_findung_id = 25
                THEN CAST(A.umsatz_netto AS NUMERIC)
            ELSE COALESCE(ROUND(
                CAST(A.umsatz_netto * COALESCE(MA.zwge, MS.zwge) AS NUMERIC), 4), ROUND(
                CAST(A.menge * COALESCE(AGW.einstandspreis, AGWW.einstandspreis) AS NUMERIC),
                4
            ), CAST(A.umsatz_netto AS NUMERIC
            ))
        END AS einstandspreis,
        CASE
            WHEN X.bq_findung_id = 25
                THEN CAST(A.diff_umsatz_netto_konz AS NUMERIC)
            ELSE COALESCE(ROUND(CAST(A.diff_umsatz_netto_konz * COALESCE(MA.zwge, MS.zwge) AS NUMERIC), 4), ROUND(CAST(CASE
                WHEN X.bq_findung_id = 25
                    THEN CAST(A.umsatz_netto AS NUMERIC)
                ELSE COALESCE(ROUND(
                    CAST(A.umsatz_netto * COALESCE(MA.zwge, MS.zwge) AS NUMERIC), 4), ROUND(
                    CAST(A.menge * COALESCE(AGW.einstandspreis, AGWW.einstandspreis) AS NUMERIC),
                    4
                ), CAST(A.umsatz_netto AS NUMERIC
                ))
            END * CASE
                WHEN y.conv_fg = 1
                    THEN 1
                ELSE Z.umrechnungskurs
            END AS NUMERIC), 4), CAST(A.diff_umsatz_netto_konz AS NUMERIC))
        END AS diff_einstandspreis_konz,
        CAST(
            A.menge * COALESCE(AGW.logistikkostenzuschlag, AGWW.logistikkostenzuschlag, 0.0000) AS NUMERIC) AS
        logkostenzuschlag_,
        CAST(
            A.menge * COALESCE(AGW.logistikkostenzuschlag, AGWW.logistikkostenzuschlag, 0.0000) * Z.umrechnungskurs AS NUMERIC) AS
        diff_logkostenzuschlag_konz_,
        COALESCE(X.bezugsweg_id, A.bezugsweg_id) AS bezugsweg_id,
        CASE
            WHEN X.bq_findung_id = 25
                THEN CAST(A.umsatz_netto AS NUMERIC)
            ELSE COALESCE(ROUND(
                CAST(A.umsatz_netto * COALESCE(MA.zwge, MS.zwge) AS NUMERIC), 4), ROUND(
                CAST(A.menge * COALESCE(AGW.ek_netto_bnk, AGWW.ek_netto_bnk) AS NUMERIC),
                4
            ), CAST(A.umsatz_netto AS NUMERIC
            ))
        END AS ek_netto_bnk,
        CASE
            WHEN X.bq_findung_id = 25
                THEN CAST(A.diff_umsatz_netto_konz AS NUMERIC)
            ELSE COALESCE(ROUND(CAST(A.diff_umsatz_netto_konz * COALESCE(MA.zwge, MS.zwge) AS NUMERIC), 4), ROUND(CAST(CASE
                WHEN X.bq_findung_id = 25
                    THEN CAST(A.umsatz_netto AS NUMERIC)
                ELSE COALESCE(ROUND(
                    CAST(A.umsatz_netto * COALESCE(MA.zwge, MS.zwge) AS NUMERIC), 4), ROUND(
                    CAST(A.menge * COALESCE(AGW.ek_netto_bnk, AGWW.ek_netto_bnk) AS NUMERIC),
                    4
                ), CAST(A.umsatz_netto AS NUMERIC
                ))
            END * CASE
                WHEN y.conv_fg = 1
                    THEN 1
                ELSE Z.umrechnungskurs
            END AS NUMERIC), 4), CAST(A.diff_umsatz_netto_konz AS NUMERIC))
        END AS diff_ek_netto_bnk_konz,
        CASE
            WHEN X.bq_findung_id = 25
                THEN CAST(A.umsatz_netto AS NUMERIC)
            ELSE COALESCE(ROUND(
                CAST(A.umsatz_netto * COALESCE(MA.zwge, MS.zwge) AS NUMERIC), 4), ROUND(
                CAST(A.menge * COALESCE(AGW.ek_netto_bnk_sachk, AGWW.ek_netto_bnk_sachk) AS NUMERIC),
                4
            ), CAST(A.umsatz_netto AS NUMERIC
            ))
        END AS ek_netto_bnk_sachk,
        CASE
            WHEN X.bq_findung_id = 25
                THEN CAST(A.diff_umsatz_netto_konz AS NUMERIC)
            ELSE COALESCE(ROUND(CAST(A.diff_umsatz_netto_konz * COALESCE(MA.zwge, MS.zwge) AS NUMERIC), 4), ROUND(CAST(CASE
                WHEN X.bq_findung_id = 25
                    THEN CAST(A.umsatz_netto AS NUMERIC)
                ELSE COALESCE(ROUND(
                    CAST(A.umsatz_netto * COALESCE(MA.zwge, MS.zwge) AS NUMERIC), 4), ROUND(
                    CAST(A.menge * COALESCE(AGW.ek_netto_bnk_sachk, AGWW.ek_netto_bnk_sachk) AS NUMERIC),
                    4
                ), CAST(A.umsatz_netto AS NUMERIC
                ))
            END * CASE
                WHEN y.conv_fg = 1
                    THEN 1
                ELSE Z.umrechnungskurs
            END AS NUMERIC), 4), CAST(A.diff_umsatz_netto_konz AS NUMERIC))
        END AS diff_ek_netto_bnk_sachk_konz,
        A.posten_id,
        COALESCE(X.bq_findung_id, 30) AS bq_findung_id,
        A.ek_gld,
        A.diff_ek_gld_konz,
        CASE
            WHEN X.bq_findung_id = 25
                THEN CAST(A.umsatz_netto AS NUMERIC)
            ELSE COALESCE(ROUND(
                CAST(A.umsatz_netto * COALESCE(MA.zwge, MS.zwge) AS NUMERIC), 4), ROUND(
                CAST(A.menge * COALESCE(AGW.bonusbasis, AGWW.bonusbasis) AS NUMERIC),
                4
            ), CAST(A.umsatz_netto AS NUMERIC
            ))
        END AS bonusbasis,
        CASE
            WHEN X.bq_findung_id = 25
                THEN CAST(A.diff_umsatz_netto_konz AS NUMERIC)
            ELSE COALESCE(ROUND(CAST(A.diff_umsatz_netto_konz * COALESCE(MA.zwge, MS.zwge) AS NUMERIC), 4), ROUND(CAST(CASE
                WHEN X.bq_findung_id = 25
                    THEN CAST(A.umsatz_netto AS NUMERIC)
                ELSE COALESCE(ROUND(
                    CAST(A.umsatz_netto * COALESCE(MA.zwge, MS.zwge) AS NUMERIC), 4), ROUND(
                    CAST(A.menge * COALESCE(AGW.bonusbasis, AGWW.bonusbasis) AS NUMERIC),
                    4
                ), CAST(A.umsatz_netto AS NUMERIC
                ))
            END * CASE
                WHEN y.conv_fg = 1
                    THEN 1
                ELSE Z.umrechnungskurs
            END AS NUMERIC), 4), CAST(A.diff_umsatz_netto_konz AS NUMERIC))
        END AS bonusbasis_konz,
        A.bewart_det_id,
        A.wup_bereinigt_fg,
        A.pv_aktion,
        A.pv_aktion_konz,
        A.pv_bby,
        A.pv_bby_konz,
        A.pv_kdn_bby,
        A.pv_kdn_bby_konz,
        A.pv_kdp_bby,
        A.pv_kdp_bby_konz,
        A.pv_aktion_bby,
        A.pv_aktion_bby_konz,
        A.pv_aktion_kdn_bby,
        A.pv_aktion_kdn_bby_konz,
        A.pv_aktion_kdp_bby,
        A.pv_aktion_kdp_bby_konz,
        A.pv_bonrabatt_bby,
        A.pv_bonrabatt_bby_konz,
        A.umrechnungskurs_hist,
        A.aktionsart_id_liste_txt,
        A.aktionsart_bez_liste_txt,
        A.aktion_typ_id_liste_txt,
        A.aktion_typ_bez_liste_txt
    FROM dbp_data.artbew_2 AS A
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
    ) AS y ON A.mandant_id = y.mandant_id AND A.wrg_2 = y.wrg_id
    INNER JOIN dbp_etl.kmo_wpuums_dat_2 AS D ON A.dat = D.dat
    INNER JOIN dbp_etl.kmo_wpuums_art_gp_wup_zu_2 AS Z
        ON
            A.mandant_id = Z.mandant_id AND A.art_id = Z.art_id
            AND A.wup_id = Z.wup_id AND A.nb_id = Z.nb_id AND A.dat = Z.dat -- Lieferant und Ausstiegspunkt ermitteln

    LEFT JOIN dbp_data.art_gp_nm_zu_per_2 AS X
        ON
            A.mandant_id = X.mandant_id AND A.wup_id = X.wup_id AND A.art_id
            = X.art_id AND A.dat BETWEEN X.dat_von AND X.dat_bis -- Betriebsspezifischer EK Preis

    LEFT JOIN dbp_etl.`__vol_art_gp_wup_zu_per` AS AGW
        ON
            X.mandant_id = AGW.mandant_id AND X.vz_wup_id =
            AGW.wup_id AND X.art_id = AGW.art_id AND X.gp_id = AGW.gp_id AND A.dat = AGW.dat
    -- Betriebsuebergreifender EK Preis

    LEFT JOIN dbp_etl.`__vol_art_gp_wup_zu_per` AS AGWW
        ON
            X.mandant_id = AGWW.mandant_id AND -1 = AGWW.wup_id
            AND X.art_id = AGWW.art_id AND X.gp_id = AGWW.gp_id AND A.dat = AGWW.dat
    -- Ermittlung betriebsuebergreifernde manuelle Spannenfaktoren

    LEFT JOIN dbp_etl.`_art_wup_man_spanne_tmp_$_2{TRANSIENT_TABLE_SUFFIX}` AS MS ON A.mandant_id = MS.mandant_id AND A.art_id = MS.art_id AND MS.wup_id = -1 AND A.dat = MS.dat AND X.bq_findung_id = 27
    -- Ermittlung Betriebsspezifischer manuelle Spannefaktoren

    LEFT JOIN dbp_etl.`_art_wup_man_spanne_tmp_$_2{TRANSIENT_TABLE_SUFFIX}` AS MA ON A.mandant_id = MA.mandant_id AND A.art_id = MA.art_id AND A.wup_id = MA.wup_id AND A.dat = MA.dat AND X.bq_findung_id = 26
);


UPDATE dbp_etl.kmo_wpuums_anr_2 SET
    ek_gld = kmo_wpuums_anr.umsatz_netto,
    diff_ek_gld_konz = kmo_wpuums_anr.diff_umsatz_netto_konz
WHERE art_id = -1; /* unbekannter Artikel_2 */


UPDATE dbp_etl.kmo_wpuums_anr_2 SET
    ek_gld = kmo_wpuums_anr.ek_netto,
    diff_ek_gld_konz = kmo_wpuums_anr.diff_ek_netto_konz
FROM dbp_data.art_2 AS A
WHERE
    kmo_wpuums_anr.mandant_id = A.mandant_id AND kmo_wpuums_anr.art_id = A.art_id AND kmo_wpuums_anr.art_id > -1 AND
    A.wg_art_fg = 1; /* Warengruppenerfassartikel */


UPDATE dbp_etl.kmo_wpuums_anr_2 SET
    ek_gld = CAST(g.ek_gld_ * kmo_wpuums_anr.menge AS NUMERIC),
    diff_ek_gld_konz = CAST(g.ek_gld_ * kmo_wpuums_anr.menge * K.umrechnungskurs AS NUMERIC) FROM (
    SELECT
        G.mandant_id,
        G.wup_id,
        G.art_id,
        G.dat,
        COALESCE(G.ek_gld, 0) AS ek_gld_
    FROM dbp_data.art_wup_tag_gld_2 AS G
    INNER JOIN
        dbp_data.art_2
            AS A
        ON
            G.mandant_id = A.mandant_id AND G.art_id = A.art_id AND A.wg_art_fg =
            0 /* keine WG Erfassartiekel */ AND A.art_id > -1
) AS g, dbp_data.kurs_2 AS K
WHERE
    kmo_wpuums_anr.mandant_id = g.mandant_id AND kmo_wpuums_anr.wup_id = g.wup_id AND kmo_wpuums_anr.art_id = g.art_id
    AND kmo_wpuums_anr.dat = g.dat -- Umrechnungskurs ermitteln
    AND kmo_wpuums_anr.wrg_2 = K.von_wrg_id
    -- AND DBP_ETL.kmo_wpuums_anr.dat  BETWEEN k.dat_von AND k.dat_bis
    AND K.dat_bis = DATE '9999-12-31' AND K.kurstyp_id
    = 3 AND K.nach_wrg_id = 'EUR';


DELETE FROM dbp_data.artbew_2 AS A
WHERE dat IN (
    SELECT dat
    FROM dbp_etl.kmo_wpuums_dat_2
) AND mandant_id > 1 AND (mandant_id, wup_id, nb_id, art_id, dat, promo_fg
) IN (
    SELECT (mandant_id, wup_id, nb_id, art_id, dat, promo_fg)
    FROM dbp_etl.kmo_wpuums_anr_2
);


INSERT INTO dbp_data.artbew_2 (
    mandant_id, wup_id, nb_id, dat, bewart_id, gp_id, art_id, aktion_id,
    promo_fg, ean_kasse, standard_aktion_id, einkaufsorganisation_id, herst_id, mwst_id, menge, wrg_2, umsatz_netto,
    diff_umsatz_netto_konz, umsatz_mwst_betrag, diff_umsatz_mwst_betrag_konz, ek_brutto, diff_ek_brutto_konz, ek_netto,
    diff_ek_netto_konz, ek_nettonetto, diff_ek_nettonetto_konz, ek_kal_basis, diff_ek_kal_basis_konz, ek_mep,
    diff_ek_mep_konz, ek_mep_vor_fwu, ek_mep_vor_fwu_konz, einstandspreis, diff_einstandspreis_konz, logkostenzuschlag,
    diff_logkostenzuschlag_konz, bezugsweg_id, ek_netto_bnk, diff_ek_netto_bnk_konz, ek_netto_bnk_sachk,
    diff_ek_netto_bnk_sachk_konz, posten_id, bq_findung_id, ek_gld, diff_ek_gld_konz, bonusbasis, bonusbasis_konz,
    bewart_det_id, wup_bereinigt_fg, pv_aktion, pv_aktion_konz, pv_bby, pv_bby_konz, pv_kdn_bby, pv_kdn_bby_konz,
    pv_kdp_bby, pv_kdp_bby_konz, pv_aktion_bby, pv_aktion_bby_konz, pv_aktion_kdn_bby, pv_aktion_kdn_bby_konz,
    pv_aktion_kdp_bby, pv_aktion_kdp_bby_konz, pv_bonrabatt_bby, pv_bonrabatt_bby_konz, td_update, td_insert,
    umrechnungskurs_hist, aktionsart_id_liste_txt, aktionsart_bez_liste_txt, aktion_typ_id_liste_txt,
    aktion_typ_bez_liste_txt
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
    wrg_2,
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
    pv_aktion_konz,
    pv_bby,
    pv_bby_konz,
    pv_kdn_bby,
    pv_kdn_bby_konz,
    pv_kdp_bby,
    pv_kdp_bby_konz,
    pv_aktion_bby,
    pv_aktion_bby_konz,
    pv_aktion_kdn_bby,
    pv_aktion_kdn_bby_konz,
    pv_aktion_kdp_bby,
    pv_aktion_kdp_bby_konz,
    pv_bonrabatt_bby,
    pv_bonrabatt_bby_konz,
    CURRENT_TIMESTAMP() AS td_update,
    CURRENT_TIMESTAMP() AS td_insert,
    umrechnungskurs_hist,
    aktionsart_id_liste_txt,
    aktionsart_bez_liste_txt,
    aktion_typ_id_liste_txt,
    aktion_typ_bez_liste_txt
FROM dbp_etl.kmo_wpuums_anr_2);
