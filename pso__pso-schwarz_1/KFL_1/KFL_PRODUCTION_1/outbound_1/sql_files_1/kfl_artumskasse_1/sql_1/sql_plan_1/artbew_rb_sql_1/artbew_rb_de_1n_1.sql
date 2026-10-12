BEGIN
    DECLARE rb_date DATE;

    SET rb_date = (
        SELECT MIN(dat) AS dat
        FROM dbp_data.tag_1 AS T1_1
        WHERE
            dat < CURRENT_DATE("Europe/Berlin")
            AND (kj = EXTRACT(
                YEAR FROM CURRENT_DATE("Europe/Berlin")) OR kj = EXTRACT(YEAR FROM CURRENT_DATE("Europe/Berlin")) - 1 AND EXTRACT(
                MONTH FROM
                CURRENT_DATE("Europe/Berlin")
            ) IN (1, 2
            ))
    );


    INSERT INTO dbp_data.artbew_agg_wt_1 (mandant_id, wup_id, nb_id, dat)
    (
        SELECT
            mandant_id,
            wup_id,
            nb_id,
            dat
        FROM dbp_data.artbew_1
        WHERE
            dat >= DATE '2021-09-25'
            AND dat >= rb_date
            AND mandant_id = 1
            AND (
                mandant_id, wup_id, dat) NOT IN (
                SELECT (mandant_id, wup_id, dat)
                FROM dbp_data.artbew_agg_wt_1
            )
        GROUP BY
            mandant_id,
            wup_id,
            nb_id,
            dat
    );


    CREATE OR REPLACE TABLE dbp_etl.de_wpuums_anr_1 LIKE dbp_data.artbew_1;


    CREATE OR REPLACE TABLE dbp_etl.de_wpuums_dat_1 (
        dat DATE
    );


    CREATE OR REPLACE TABLE dbp_etl.de_wpuums_dat_min_1 (
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


    INSERT INTO dbp_etl.de_wpuums_dat_1 (dat)
    (
        SELECT dat
        FROM dbp_data.artbew_agg_wt_1
        WHERE
            mandant_id = 1
            AND dat >= DATE '2021-09-25'
        GROUP BY dat
    );


    INSERT INTO dbp_etl.de_wpuums_dat_min_1 (dat)
    (
        SELECT MIN(dat)
        FROM dbp_data.artbew_agg_wt_1
        WHERE
            mandant_id = 1
            AND dat >= DATE '2021-09-25'
        HAVING MIN(dat) IS NOT NULL
    );


    -- auf Tag_1 auffaechern
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
            FROM dbp_data.art_gp_wup_zu_per_1 AS A
            INNER JOIN dbp_etl.de_wpuums_dat_min_1 AS M ON A.dat_bis >= M.dat
            WHERE A.mandant_id = 1
        ) AS a
        INNER JOIN dbp_etl.de_wpuums_dat_1 AS D ON D.dat BETWEEN a.dat_von AND a.dat_bis
    );


    -- Nun die betriebsuebergreifenden manuellen Spannenfaktoren


    /* optional */ /* optional */ /* Einstandspreis zwingend erforderlich */ INSERT INTO `_art_wup_man_spanne_tmp` (
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
        FROM dbp_etl.de_wpuums_dat_1 AS A
        INNER JOIN dbp_data.art_man_spanne_per_1 AS EIN
            ON
                EIN.konditionsart_id = 'ZWGS' /* einstandspreis */ AND
                EIN.loesch_fg = 0 AND A.dat BETWEEN EIN.dat_von AND EIN.dat_bis
        LEFT JOIN dbp_data.art_man_spanne_per_1 AS MEP
            ON
                EIN.mandant_id = MEP.mandant_id AND EIN.art_id = MEP.art_id
                AND MEP.konditionsart_id = 'ZWGM' /* MEP */ AND MEP.loesch_fg = 0 AND A.dat BETWEEN MEP.dat_von AND MEP.dat_bis
        LEFT JOIN
            dbp_data.art_man_spanne_per_1
                AS EKBNK
            ON
                EIN.mandant_id = EKBNK.mandant_id AND EIN.art_id =
                EKBNK.art_id AND EKBNK.konditionsart_id = 'ZWGE' /* eknetto bnk */ AND EKBNK.loesch_fg = 0 AND A.dat BETWEEN
                EKBNK.dat_von AND EKBNK.dat_bis
    );


    -- Nun die betriebsspezifischen manuellen Spannenfaktoren!


    /* Einstandspreis zwingend erforderlich */ /* optional */ /* optional */ INSERT INTO `_art_wup_man_spanne_tmp` (
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
        FROM dbp_etl.de_wpuums_dat_1 AS A
        INNER JOIN dbp_data.art_wup_man_spanne_per_1 AS EIN
            ON
                EIN.konditionsart_id = 'ZWGS' /* einstandspreis */
                AND EIN.loesch_fg = 0 AND A.dat BETWEEN EIN.dat_von AND EIN.dat_bis
        LEFT JOIN dbp_data.art_wup_man_spanne_per_1 AS MEP
            ON
                EIN.mandant_id = MEP.mandant_id AND EIN.wup_id =
                MEP.wup_id AND EIN.art_id = MEP.art_id AND MEP.konditionsart_id = 'ZWGM' /* MEP */ AND MEP.loesch_fg = 0 AND A.dat
                BETWEEN MEP.dat_von AND MEP.dat_bis
        LEFT JOIN
            dbp_data.art_wup_man_spanne_per_1
                AS EKBNK
            ON
                EIN.mandant_id = EKBNK.mandant_id AND EIN.wup_id
                = EKBNK.wup_id AND EIN.art_id = EKBNK.art_id AND EKBNK.konditionsart_id = 'ZWGE' /* eknetto bnk */ AND EKBNK.loesch_fg
                = 0 AND A.dat BETWEEN EKBNK.dat_von AND EKBNK.dat_bis
    );


    /* (1) manuelle Spanne */ /* (2) EK-Preise ZEKP_1 */ /* (1) manuelle Spanne */ /* (3) kein Treffer; 0%-Spanne */
    /* (3) kein Treffer; 0%-Spanne */ /* (2) EK-Preise ZEKP_1 */ /* (2) EK-Preise ZEKP_1 */ /* (1) manuelle Spanne */
    /* (3) kein Treffer; 0%-Spanne */ /* (1) manuelle Spanne */ /* (1) manuelle Spanne */ /* (2) EK-Preise ZEKP_1 */
    /* (3) kein Treffer; 0%-Spanne */ /* (3) kein Treffer; 0%-Spanne */ /* (2) EK-Preise ZEKP_1 */ /* (1) manuelle Spanne */
    /* (1) manuelle Spanne */ /* (3) kein Treffer; 0%-Spanne */ /* (2) EK-Preise ZEKP_1 */ /* (1) manuelle Spanne */
    /* (2) EK-Preise ZEKP_1 */ /* (2) EK-Preise ZEKP_1 */ /* (3) kein Treffer; 0%-Spanne */ /* (2) EK-Preise ZEKP_1 */
    /* (3) kein Treffer; 0%-Spanne */ /* (3) kein Treffer; 0%-Spanne */ /* (1) manuelle Spanne */ INSERT INTO
    dbp_etl.de_wpuums_anr_1 (
        mandant_id, wup_id, nb_id, dat, bewart_id, gp_id, art_id, aktion_id, promo_fg,
        ean_kasse, standard_aktion_id, einkaufsorganisation_id, herst_id, mwst_id, menge, wrg_1, umsatz_netto,
        diff_umsatz_netto_konz, umsatz_mwst_betrag, diff_umsatz_mwst_betrag_konz, ek_brutto, diff_ek_brutto_konz, ek_netto,
        diff_ek_netto_konz, ek_nettonetto, diff_ek_nettonetto_konz, ek_kal_basis, diff_ek_kal_basis_konz, ek_mep,
        diff_ek_mep_konz, ek_mep_vor_fwu, ek_mep_vor_fwu_konz, einstandspreis, diff_einstandspreis_konz, logkostenzuschlag,
        diff_logkostenzuschlag_konz, bezugsweg_id, ek_netto_bnk, diff_ek_netto_bnk_konz, ek_netto_bnk_sachk,
        diff_ek_netto_bnk_sachk_konz, posten_id, bq_findung_id, ek_gld, diff_ek_gld_konz, bonusbasis, bonusbasis_konz,
        bewart_det_id, wup_bereinigt_fg, pv_aktion, pv_bby, pv_kdn_bby, pv_kdp_bby, pv_aktion_bby, pv_aktion_kdn_bby,
        pv_aktion_kdp_bby, umrechnungskurs_hist, aktionsart_id_liste_txt, aktionsart_bez_liste_txt, aktion_typ_id_liste_txt,
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
            A.wrg_1,
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
            A.pv_aktion_kdp_bby,
            A.umrechnungskurs_hist,
            A.aktionsart_id_liste_txt,
            A.aktionsart_bez_liste_txt,
            A.aktion_typ_id_liste_txt,
            A.aktion_typ_bez_liste_txt
        FROM dbp_data.artbew_1 AS A
        INNER JOIN dbp_etl.de_wpuums_dat_1 AS D ON A.dat = D.dat -- Lieferant und Ausstiegspunkt ermitteln

        LEFT JOIN dbp_data.art_gp_nm_zu_per_1 AS X
            ON
                A.mandant_id = X.mandant_id AND A.wup_id = X.wup_id AND A.art_id
                = X.art_id AND A.dat BETWEEN X.dat_von AND X.dat_bis
        LEFT JOIN dbp_data.ek_orderbuch_1 AS XXX_1
            ON
                A.mandant_id = XXX.mandant_id AND X.gp_id = XXX.wup_id AND A.art_id = XXX.art_id AND A.dat BETWEEN XXX.dat_von AND XXX.dat_bis -- Betriebsuebergreifender EK Preis

        LEFT JOIN `_vol_art_gp_wup_zu_per` AS AGWWW
            ON
                X.mandant_id = AGWWW.mandant_id AND X.gp_id = AGWWW.wup_id AND X.art_id
                = AGWWW.art_id AND COALESCE(XXX.gp_id, X.gp_id) = AGWWW.gp_id AND A.dat = AGWWW.dat
        -- Betriebsspezifischer EK Preis

        LEFT JOIN `_vol_art_gp_wup_zu_per` AS AGW
            ON
                X.mandant_id = AGW.mandant_id AND X.vz_wup_id = AGW.wup_id AND X.art_id =
                AGW.art_id AND COALESCE(XXX.gp_id, X.gp_id) = AGW.gp_id AND A.dat = AGW.dat -- Betriebsuebergreifender EK Preis

        LEFT JOIN `_vol_art_gp_wup_zu_per` AS AGWW
            ON
                X.mandant_id = AGWW.mandant_id AND -1 = AGWW.wup_id AND X.art_id = AGWW.art_id AND X.gp_id = AGWW.gp_id AND A.dat = AGWW.dat
        -- Ermittlung betriebsuebergreifernde manuelle Spannenfaktoren

        LEFT JOIN `_art_wup_man_spanne_tmp` AS MS
            ON
                A.mandant_id = MS.mandant_id AND A.art_id = MS.art_id AND MS.wup_id = -1
                AND A.dat = MS.dat -- Ermittlung Betriebsspezifischer manuelle Spannefaktoren

        LEFT JOIN `_art_wup_man_spanne_tmp` AS MA
            ON
                A.mandant_id = MA.mandant_id AND A.art_id = MA.art_id AND A.wup_id = MA.wup_id
                AND A.dat = MA.dat
        WHERE A.mandant_id = 1
    );


    DELETE FROM dbp_data.artbew_1 AS A
    WHERE dat IN (
        SELECT dat
        FROM dbp_etl.de_wpuums_dat_1
    ) AND mandant_id = 1;


    INSERT INTO dbp_data.artbew_1 (
        mandant_id, wup_id, nb_id, dat, bewart_id, gp_id, art_id, aktion_id,
        promo_fg, ean_kasse, standard_aktion_id, einkaufsorganisation_id, herst_id, mwst_id, menge, wrg_1, umsatz_netto,
        diff_umsatz_netto_konz, umsatz_mwst_betrag, diff_umsatz_mwst_betrag_konz, ek_brutto, diff_ek_brutto_konz, ek_netto,
        diff_ek_netto_konz, ek_nettonetto, diff_ek_nettonetto_konz, ek_kal_basis, diff_ek_kal_basis_konz, ek_mep,
        diff_ek_mep_konz, ek_mep_vor_fwu, ek_mep_vor_fwu_konz, einstandspreis, diff_einstandspreis_konz, logkostenzuschlag,
        diff_logkostenzuschlag_konz, bezugsweg_id, ek_netto_bnk, diff_ek_netto_bnk_konz, ek_netto_bnk_sachk,
        diff_ek_netto_bnk_sachk_konz, posten_id, bq_findung_id, ek_gld, diff_ek_gld_konz, bonusbasis, bonusbasis_konz,
        bewart_det_id, wup_bereinigt_fg, pv_aktion, pv_bby, pv_kdn_bby, pv_kdp_bby, pv_aktion_bby, pv_aktion_kdn_bby,
        pv_aktion_kdp_bby, td_update, td_insert, umrechnungskurs_hist, aktionsart_id_liste_txt, aktionsart_bez_liste_txt,
        aktion_typ_id_liste_txt, aktion_typ_bez_liste_txt
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
        CURRENT_TIMESTAMP() AS td_insert,
        umrechnungskurs_hist,
        aktionsart_id_liste_txt,
        aktionsart_bez_liste_txt,
        aktion_typ_id_liste_txt,
        aktion_typ_bez_liste_txt
    FROM dbp_etl.de_wpuums_anr_1);


    /*
    _---------------------------------------------------------------------------------------------------------
    _                                  STUECKLISTENAUFLOESUNG INKL. EK-BEWERTUNG
    _---------------------------------------------------------------------------------------------------------
    */


    CREATE OR REPLACE TEMPORARY TABLE _step01_1 (
        mandant_id INTEGER,
        wup_id INTEGER,
        nb_id INTEGER,
        art_id INTEGER,
        bewart_id INTEGER,
        bewart_det_id INTEGER,
        promo_fg INTEGER,
        aktion_id STRING(10),
        dat DATE,
        wrg_1 STRING(3),
        ean_kasse INTEGER,
        wg_id INTEGER,
        bezugsweg_id INTEGER,
        menge FLOAT64,
        umsatz_netto_alt NUMERIC(29, 4),
        umsatz_mwst_betrag_alt NUMERIC(29, 4),
        umsatz_bto NUMERIC(29, 4),
        umrechnungskurs FLOAT64,
        kopf_art_id INTEGER,
        komponentenmengen_faktor NUMERIC(29, 4),
        stueckliste_id INTEGER
    );


    CREATE OR REPLACE TEMPORARY TABLE _step02_1 (
        mandant_id INTEGER,
        wup_id INTEGER,
        nb_id INTEGER,
        art_id INTEGER,
        bewart_id INTEGER,
        bewart_det_id INTEGER,
        promo_fg INTEGER,
        aktion_id STRING(10),
        dat DATE,
        wrg_1 STRING(3),
        ean_kasse INTEGER,
        menge FLOAT64,
        umsatz_netto_alt NUMERIC(29, 4),
        umsatz_mwst_betrag_alt NUMERIC(29, 4),
        umsatz_bto NUMERIC(29, 4),
        umrechnungskurs FLOAT64,
        kopf_art_id INTEGER,
        komponentenmengen_faktor NUMERIC(29, 4),
        stueckliste_id INTEGER,
        bq_findung_id INTEGER,
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


    CREATE OR REPLACE TEMPORARY TABLE _step02a_1 (
        mandant_id INTEGER,
        wup_id INTEGER,
        nb_id INTEGER,
        art_id INTEGER,
        bewart_id INTEGER,
        bewart_det_id INTEGER,
        promo_fg INTEGER,
        aktion_id STRING(10),
        dat DATE,
        wrg_1 STRING(3),
        ean_kasse INTEGER,
        menge FLOAT64,
        umsatz_netto_alt NUMERIC(29, 4),
        umsatz_mwst_betrag_alt NUMERIC(29, 4),
        umsatz_bto NUMERIC(29, 4),
        umrechnungskurs FLOAT64,
        kopf_art_id INTEGER,
        komponentenmengen_faktor NUMERIC(29, 4),
        stueckliste_id INTEGER,
        bq_findung_id INTEGER,
        umsatz_anteil NUMERIC(29, 4),
        umsatz_netto NUMERIC(29, 4),
        umsatz_mwst NUMERIC(29, 4),
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
        bonusbasis NUMERIC(29, 4),
        diff_ek_brutto_konz NUMERIC(29, 4),
        diff_ek_netto_konz NUMERIC(29, 4),
        diff_ek_nettonetto_konz NUMERIC(29, 4),
        diff_ek_kal_basis_konz NUMERIC(29, 4),
        diff_ek_mep_konz NUMERIC(29, 4),
        diff_einstandspreis_konz NUMERIC(29, 4),
        diff_logkostenzuschlag_konz NUMERIC(29, 4),
        diff_ek_netto_bnk_konz NUMERIC(29, 4),
        diff_ek_netto_bnk_sachk_konz NUMERIC(29, 4),
        ek_mep_vor_fwu_konz NUMERIC(29, 4),
        bonusbasis_konz NUMERIC(29, 4)
    );


    CREATE OR REPLACE TEMPORARY TABLE _step03_1 (
        mandant_id INTEGER,
        wup_id INTEGER,
        nb_id INTEGER,
        art_id INTEGER,
        bewart_id INTEGER,
        bewart_det_id INTEGER,
        promo_fg INTEGER,
        aktion_id STRING(10),
        dat DATE,
        wrg_1 STRING(3),
        ean_kasse INTEGER,
        menge FLOAT64,
        umsatz_netto_alt NUMERIC(29, 4),
        umsatz_mwst_betrag_alt NUMERIC(29, 4),
        umsatz_bto NUMERIC(29, 4),
        umrechnungskurs FLOAT64,
        kopf_art_id INTEGER,
        komponentenmengen_faktor NUMERIC(29, 4),
        stueckliste_id INTEGER,
        bq_findung_id INTEGER,
        umsatz_anteil NUMERIC(29, 4),
        umsatz_netto NUMERIC(29, 4),
        umsatz_mwst NUMERIC(29, 4),
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
        bonusbasis NUMERIC(29, 4),
        diff_ek_brutto_konz NUMERIC(29, 4),
        diff_ek_netto_konz NUMERIC(29, 4),
        diff_ek_nettonetto_konz NUMERIC(29, 4),
        diff_ek_kal_basis_konz NUMERIC(29, 4),
        diff_ek_mep_konz NUMERIC(29, 4),
        diff_einstandspreis_konz NUMERIC(29, 4),
        diff_logkostenzuschlag_konz NUMERIC(29, 4),
        diff_ek_netto_bnk_konz NUMERIC(29, 4),
        diff_ek_netto_bnk_sachk_konz NUMERIC(29, 4),
        ek_mep_vor_fwu_konz NUMERIC(29, 4),
        bonusbasis_konz NUMERIC(29, 4)
    );


    CREATE OR REPLACE TEMPORARY TABLE _aggregat01_1 (
        mandant_id INTEGER,
        art_id INTEGER,
        bewart_id INTEGER,
        bewart_det_id INTEGER,
        promo_fg INTEGER,
        aktion_id STRING(10),
        wup_id INTEGER,
        nb_id INTEGER,
        dat DATE,
        ean_kasse INTEGER,
        umsatz_netto NUMERIC(29, 4)
    );


    CREATE OR REPLACE TEMPORARY TABLE _spannen_agg1 (
        mandant_id INTEGER,
        wup_id INTEGER,
        kopf_art_id INTEGER,
        bewart_id INTEGER,
        bewart_det_id INTEGER,
        promo_fg INTEGER,
        aktion_id STRING(10),
        stueckliste_id INTEGER,
        dat DATE,
        ean_kasse INTEGER,
        ek_netto_sum NUMERIC(29, 4)
    );


    -- 18.12.2012, -dba-
    --
    -- Aus der ARTBEW_1 werden zunaechst fuer die relevanten Tage alle betroffenen Kopfartikel ermittelt. Ueber den
    -- nachgelagerten JOIN gegen die Komponententabelle STUECKLISTE_DET_1 werden dann die zugehoerigen Fußartikel_1 mit
    -- der auf Basismengeneinheit geeichten Menge in die Zwischentabelle STEP01 eingespielt.


    -- falls eine_1 Komponente mehrfach in der Stueckliste_1 vorhanden ist: Menge aufsummieren
    INSERT INTO `_step01_1` (
        mandant_id,
        wup_id, nb_id, art_id, bewart_id, bewart_det_id, promo_fg, aktion_id, dat, wrg_1, ean_kasse, wg_id, bezugsweg_id, menge,
        umsatz_netto_alt, umsatz_mwst_betrag_alt, umsatz_bto, umrechnungskurs, kopf_art_id, komponentenmengen_faktor,
        stueckliste_id
    )
    (
        SELECT
            A.mandant_id,
            A.wup_id,
            A.nb_id,
            b.art_id,
            A.bewart_id,
            A.bewart_det_id,
            A.promo_fg,
            A.aktion_id,
            A.dat,
            A.wrg_1,
            CAST(A.ean_kasse AS INTEGER) AS ean_kasse,
            Y.wg_id,
            COALESCE(x.bezugsweg_id, A.bezugsweg_id) AS bezugsweg_id,
            SUM(CAST(A.menge AS FLOAT64)) AS menge,
            SUM(CAST(A.umsatz_netto AS NUMERIC)) AS umsatz_netto_alt,
            SUM(CAST(A.umsatz_mwst_betrag AS NUMERIC)) AS umsatz_mwst_betrag_alt,
            SUM(CAST(A.umsatz_netto + A.umsatz_mwst_betrag AS NUMERIC)) AS umsatz_bto,
            0 AS umrechnungskurs,
            A.art_id AS kopf_art_id,
            ROUND(CAST(SUM(
                CAST(A.menge AS FLOAT64) * CAST(b.komponentenmenge AS FLOAT64)) / MAX(
                COALESCE(C.umrech_faktor, 1.0000
                )
            ) AS NUMERIC), 4) AS komponentenmengen_faktor,
            b.stueckliste_id
        FROM dbp_data.artbew_1 AS A
        LEFT JOIN (
            SELECT
                mandant_id,
                wup_id,
                art_id,
                dat_von,
                dat_bis,
                bezugsweg_id
            FROM dbp_data.art_wup_zu_per_1
            WHERE
                mandant_id = 1
                AND dat_bis >= (
                    SELECT *
                    FROM dbp_etl.de_wpuums_dat_min_1
                )
        ) AS x
            ON
                A.wup_id = x.wup_id AND A.mandant_id = x.mandant_id AND A.art_id = x.art_id AND A.dat BETWEEN x.dat_von AND x.dat_bis
        INNER JOIN dbp_data.art_wg_zu_per_1 AS Y
            ON
                A.mandant_id = Y.mandant_id AND A.art_id = Y.art_id AND Y.arthiertyp_id
                = 2 AND Y.dat_bis = DATE '9999-12-31'
        INNER JOIN dbp_etl.de_wpuums_dat_1 AS D ON A.dat = D.dat -- Ermittlung Kopfartikel
        -- 

        -- 29.01.2013, DBA
        -- 
        -- Aenderung hinsichtlich des Abgreifens von Stuecklistenkoepfen! Die Stammtabelle ist laut

        -- Vorgabe (!!!) nicht eindeutig pro Kopfartikel versorgt, so dass zu einem Stichtag durchaus

        -- mehrere Koepfe in verschiedenen Stuecklisten gefuehrt werden koennen. Das ist natuerlich

        -- fachlich vollkommener Bloedsinn, aber laut FB sollte man hier mit einem MAX(...) das Ganze

        -- zurechtstutzen. (Aufgefallen war das Problem am 29.01.2013 bei den Artikeln 180600, 180580

        -- fuer den Mandant_1 8 mit Stichtag 28.01.2013.)
        -- 

        -- Des Weiteren die Filter auf STLAN=3 u. WERKS IS NULL fuer Stuecklistenkopf hinterlegt (s.

        -- IT-Konzept [DWH BE TP5-016-Abbildung VK_1 Set]).

        INNER JOIN (
            SELECT
                A0.mandant_id,
                A0.stueckliste_id,
                A0.dat_von,
                A0.dat_bis,
                A0.art_id,
                NULL AS wup_id,
                NULL AS nb_id,
                A0.stueckliste_verwendung_id
            FROM dbp_data.stueckliste_1 AS A0
            INNER JOIN dbp_etl.de_wpuums_dat_min_1 AS M ON A0.dat_bis >= M.dat
            WHERE -- a.wup_id IS NULL AND
                A0.stueckliste_verwendung_id = 3
                AND (
                    A0.mandant_id, A0.art_id, A0.stueckliste_id) IN (
                    SELECT (mandant_id, art_id, MAX(stueckliste_id))
                    FROM dbp_data.stueckliste_1
                    GROUP BY mandant_id,
                    art_id
                )
        ) AS k ON A.mandant_id = k.mandant_id AND A.art_id = k.art_id AND A.dat BETWEEN k.dat_von AND k.dat_bis
        -- Ermittlung Fußartikel_1

        INNER JOIN (
            SELECT *
            FROM dbp_data.stueckliste_det_1
            WHERE stueckliste_typ_id = 'M'
        ) AS b
            ON
                k.mandant_id = b.mandant_id AND k.stueckliste_id = b.stueckliste_id AND A.dat
                BETWEEN b.dat_von AND b.dat_bis
        -- Ermittlung Umrechnungsfaktor, damit korrekter Bezug zur Basismengeneinheit hergestellt wird.

        LEFT JOIN dbp_data.art_umrechnung_faktor_per_1 AS C
            ON
                b.mandant_id = C.mandant_id AND b.art_id = C.art_id
                AND b.komponentenmenge_einh_id = C.altnv_menge_einh_id AND C.dat_bis = DATE '9999-12-31'
        WHERE
            A.mandant_id = 1
            AND A.menge <> 0
            AND /* nur Positionen mit Abverkauf beruecksichtigen! */ A.umsatz_netto <> 0
            /* nur Positionen mit Abverkauf beruecksichtigen! */
        GROUP BY
            A.mandant_id,
            A.wup_id,
            A.nb_id,
            b.art_id,
            A.dat,
            kopf_art_id,
            b.stueckliste_id,
            A.wrg_1,
            A.ean_kasse,
            Y.wg_id,
            bezugsweg_id,
            A.bewart_id,
            A.bewart_det_id,
            A.promo_fg,
            A.aktion_id
    );


    -- 18.12.2012, -dba-
    --
    -- Nachgelagert werden dann alle Koepfe in dieselbe volatile Tabelle gespielt. Als Kennung wird in die Spalte
    -- KOPF_ART_ID nun der Wert "-100" eingestellt, um spaeter zwischen Kopf und Fuß unterscheiden zu koennen.


    INSERT INTO `_step01_1` (
        mandant_id, wup_id, nb_id, art_id, bewart_id, bewart_det_id, promo_fg, aktion_id, dat, wrg_1,
        ean_kasse, wg_id, bezugsweg_id, menge, umsatz_netto_alt, umsatz_mwst_betrag_alt, umsatz_bto, umrechnungskurs,
        kopf_art_id, komponentenmengen_faktor, stueckliste_id
    )
    (
        SELECT
            A.mandant_id,
            A.wup_id,
            A.nb_id,
            A.art_id,
            A.bewart_id,
            A.bewart_det_id,
            A.promo_fg,
            A.aktion_id,
            A.dat,
            A.wrg_1,
            CAST(A.ean_kasse AS INTEGER) AS ean_kasse,
            Y.wg_id,
            COALESCE(x.bezugsweg_id, A.bezugsweg_id) AS bezugsweg_id,
            SUM(CAST(A.menge AS FLOAT64)) AS menge,
            SUM(CAST(A.umsatz_netto AS NUMERIC)) AS umsatz_netto_alt,
            SUM(CAST(A.umsatz_mwst_betrag AS NUMERIC)) AS umsatz_mwst_betrag_alt,
            SUM(CAST(A.umsatz_netto + A.umsatz_mwst_betrag AS NUMERIC)) AS umsatz_bto,
            0 AS umrechnungskurs,
            -100 AS kopf_art_id,
            0 AS komponentenmengen_faktor,
            c.stueckliste_id
        FROM dbp_data.artbew_1 AS A
        LEFT JOIN (
            SELECT
                mandant_id,
                wup_id,
                art_id,
                dat_von,
                dat_bis,
                bezugsweg_id
            FROM dbp_data.art_wup_zu_per_1
            WHERE
                mandant_id = 1
                AND dat_bis >= (
                    SELECT *
                    FROM dbp_etl.de_wpuums_dat_min_1
                )
        ) AS x
            ON
                A.wup_id = x.wup_id AND A.mandant_id = x.mandant_id AND A.art_id = x.art_id AND A.dat BETWEEN x.dat_von AND x.dat_bis
        INNER JOIN dbp_data.art_wg_zu_per_1 AS Y
            ON
                A.mandant_id = Y.mandant_id AND A.art_id = Y.art_id AND Y.arthiertyp_id
                = 2 AND Y.dat_bis = DATE '9999-12-31'
        INNER JOIN dbp_etl.de_wpuums_dat_1 AS D ON A.dat = D.dat -- Ermittlung Kopfartikel
        -- 

        -- 29.01.2013, DBA
        -- 
        -- Aenderung hinsichtlich des Abgreifens von Stuecklistenkoepfen! Die Stammtabelle ist laut

        -- Vorgabe (!!!) nicht eindeutig pro Kopfartikel versorgt, so dass zu einem Stichtag durchaus

        -- mehrere Koepfe in verschiedenen Stuecklisten gefuehrt werden koennen. Das ist natuerlich

        -- fachlich vollkommener Bloedsinn, aber laut FB sollte man hier mit einem MAX(...) das Ganze

        -- zurechtstutzen. (Aufgefallen war das Problem am 29.01.2013 bei den Artikeln 180600, 180580

        -- fuer den Mandant_1 8 mit Stichtag 28.01.2013.)
        -- 

        -- Des Weiteren die Filter auf STLAN=3 u. WERKS IS NULL fuer Stuecklistenkopf hinterlegt (s.

        -- IT-Konzept [DWH BE TP5-016-Abbildung VK_1 Set]).

        INNER JOIN (
            SELECT
                A0.mandant_id,
                A0.stueckliste_id,
                A0.dat_von,
                A0.dat_bis,
                A0.art_id,
                NULL AS wup_id,
                NULL AS nb_id,
                A0.stueckliste_verwendung_id
            FROM dbp_data.stueckliste_1 AS A0
            INNER JOIN dbp_etl.de_wpuums_dat_min_1 AS M ON A0.dat_bis >= M.dat
            WHERE
                A0.stueckliste_verwendung_id = 3
                AND (
                    A0.mandant_id, A0.art_id, A0.stueckliste_id) IN (
                    SELECT (mandant_id, art_id, MAX(stueckliste_id))
                    FROM dbp_data.stueckliste_1
                    GROUP BY mandant_id,
                    art_id
                )
        ) AS c ON A.mandant_id = c.mandant_id AND A.art_id = c.art_id AND A.dat BETWEEN c.dat_von AND c.dat_bis
        WHERE
            A.mandant_id = 1
            AND A.menge <> 0
            AND /* nur Positionen mit Abverkauf beruecksichtigen! */ A.umsatz_netto <> 0
            /* nur Positionen mit Abverkauf beruecksichtigen! */
        GROUP BY
            A.mandant_id,
            A.wup_id,
            A.nb_id,
            A.art_id,
            A.dat,
            umrechnungskurs,
            c.stueckliste_id,
            A.wrg_1,
            A.ean_kasse,
            Y.wg_id,
            bezugsweg_id,
            A.bewart_id,
            A.bewart_det_id,
            A.promo_fg,
            A.aktion_id
    );


    -- 18.12.2012, -dba-
    --
    -- Standardmaeßige EK-Ermittlung, die an dieser Stelle nur fuer die Fußartikel_1 greift, da die VK_1-Set Kopfartikel
    -- NICHT in der EK-Tabelle gefuehrt werden! Somit sind selbige nach diesem Step noch NULL!


    INSERT INTO `_step02_1` (
        mandant_id, wup_id, nb_id, art_id, bewart_id, bewart_det_id, promo_fg, aktion_id, dat, wrg_1,
        ean_kasse, menge, umsatz_netto_alt, umsatz_mwst_betrag_alt, umsatz_bto, umrechnungskurs, kopf_art_id,
        komponentenmengen_faktor, stueckliste_id, bq_findung_id, ek_brutto, ek_netto, ek_nettonetto, ek_kal_basis, ek_mep,
        einstandspreis, logistikkostenzuschlag, ek_netto_bnk, ek_netto_bnk_sachk, ek_mep_vor_fwu, bonusbasis
    )
    (
        SELECT
            A.mandant_id,
            A.wup_id,
            A.nb_id,
            A.art_id,
            A.bewart_id,
            A.bewart_det_id,
            A.promo_fg,
            A.aktion_id,
            A.dat,
            A.wrg_1,
            A.ean_kasse,
            A.menge,
            A.umsatz_netto_alt,
            A.umsatz_mwst_betrag_alt,
            A.umsatz_bto,
            A.umrechnungskurs,
            A.kopf_art_id,
            A.komponentenmengen_faktor,
            A.stueckliste_id,
            X.bq_findung_id,
            CAST(A.komponentenmengen_faktor * COALESCE(AGW.ek_brutto, AGWW.ek_brutto) AS NUMERIC) AS ek_brutto_,
            CAST(A.komponentenmengen_faktor * COALESCE(AGW.ek_netto, AGWW.ek_netto) AS NUMERIC) AS ek_netto_,
            CAST(A.komponentenmengen_faktor * COALESCE(AGW.ek_nettonetto, AGWW.ek_nettonetto) AS NUMERIC) AS ek_nettonetto_,
            CAST(A.komponentenmengen_faktor * COALESCE(AGW.ek_kal_basis, AGWW.ek_kal_basis) AS NUMERIC) AS ek_kal_basis_,
            CAST(A.komponentenmengen_faktor * COALESCE(AGW.ek_mep, AGWW.ek_mep) AS NUMERIC) AS ek_mep_,
            CAST(A.komponentenmengen_faktor * COALESCE(AGW.einstandspreis, AGWW.einstandspreis) AS NUMERIC) AS einstandspreis_,
            CAST(A.komponentenmengen_faktor * COALESCE(AGW.logistikkostenzuschlag, AGWW.logistikkostenzuschlag, 0.0000) AS NUMERIC)
                AS logistikkostenzuschlag_,
            CAST(A.komponentenmengen_faktor * COALESCE(AGW.ek_netto_bnk, AGWW.ek_netto_bnk) AS NUMERIC) AS ek_netto_bnk_,
            CAST(
                A.komponentenmengen_faktor * COALESCE(AGW.ek_netto_bnk_sachk, AGWW.ek_netto_bnk_sachk) AS NUMERIC) AS
            ek_netto_bnk_sachk_,
            CAST(A.komponentenmengen_faktor * COALESCE(AGW.ek_mep_vor_fwu, AGWW.ek_mep_vor_fwu) AS NUMERIC) AS ek_mep_vor_fwu_,
            CAST(A.komponentenmengen_faktor * COALESCE(AGW.bonusbasis, AGWW.bonusbasis) AS NUMERIC) AS bonusbasis_
        FROM `_step01_1` AS A
        INNER JOIN dbp_data.art_gp_nm_zu_per_1 AS X
            ON
                A.mandant_id = X.mandant_id AND A.art_id = X.art_id AND A.wup_id = X.wup_id AND A.dat BETWEEN X.dat_von AND X.dat_bis
        -- Ermittlung betriebsspezifischer ZEKP_1 Satz mit VZ aus
        -- VZ Findung bei Bezugsweg 4 und Betrieb bei Bezugsweg 1

        LEFT JOIN `_vol_art_gp_wup_zu_per` AS AGW
            ON A.mandant_id = AGW.mandant_id AND X.vz_wup_id = AGW.wup_id
            /* hier Zugriff mit Wup_1/VZ aus Kreisprozess !! */ -- AND x.nb_id                   = agw.nb_id
            AND A.art_id =
            AGW.art_id AND X.gp_id = AGW.gp_id AND X.einkaufsorganisation_id = AGW.einkaufsorganisation_id AND A.dat = AGW.dat
            -- Betrieb = blank für Bezugsweg 1 und 4 beim ersten
            -- Zugriff nichts gefunden wird.

        LEFT JOIN `_vol_art_gp_wup_zu_per` AS AGWW
            ON A.mandant_id = AGWW.mandant_id AND AGWW.wup_id = -1
            /* Betrieb = 'blank' */ AND A.art_id = AGWW.art_id AND X.gp_id = AGWW.gp_id AND X.einkaufsorganisation_id = AGWW.einkaufsorganisation_id AND A.dat = AGWW.dat
    );


    -- 18.12.2012, -dba-
    --
    -- Im normalen Deltabetrieb eigentlich ein obsoleter Step. Allerdings können durch das Anziehen unserer neuen
    -- BQ-Tabelle ART_GP_NM_ZU_PER_1, die erst ab Oktober regelmaeßig mitlief, Ungenauigkeiten beim Lieferanten fuer
    -- historische Daten (z.B. auf Q fuer Initialbefuellung!) entstehen. Deswegen zur Sicherheit noch einmal ein
    -- Update und das Setzen auf den UMSATZ_NETTO (Spanne 0%) fuer solche Faelle.


    UPDATE `_step02_1` SET
        ek_brutto = `_step02_1`.umsatz_netto_alt,
        ek_netto = `_step02_1`.umsatz_netto_alt,
        ek_nettonetto = `_step02_1`.umsatz_netto_alt,
        ek_kal_basis = `_step02_1`.umsatz_netto_alt,
        ek_mep = `_step02_1`.umsatz_netto_alt,
        einstandspreis = `_step02_1`.umsatz_netto_alt,
        ek_netto_bnk = `_step02_1`.umsatz_netto_alt,
        ek_netto_bnk_sachk = `_step02_1`.umsatz_netto_alt,
        ek_mep_vor_fwu = `_step02_1`.umsatz_netto_alt,
        bonusbasis = `_step02_1`.umsatz_netto_alt
    WHERE kopf_art_id <> -100 AND ek_brutto = 0;


    -- 18.12.2012, -dba-
    --
    -- Zunaechst wird eine_1 Tabelle mit Kopfinformationen bzgl. UMSATZ_NETTO erstellt.


    INSERT INTO `_aggregat01_1` (
        mandant_id, art_id, bewart_id, bewart_det_id, promo_fg, aktion_id, wup_id, nb_id, dat,
        ean_kasse, umsatz_netto
    )
    (SELECT
        mandant_id,
        art_id,
        bewart_id,
        bewart_det_id,
        promo_fg,
        aktion_id,
        wup_id,
        nb_id,
        dat,
        ean_kasse,
        umsatz_netto_alt AS umsatz_netto
    FROM `_step02_1` AS A
    WHERE kopf_art_id = -100);


    -- 18.12.2012, -dba-
    --
    -- Hier die ungleich wichtigere Tabelle! Da wir bei der Bestimmung der Umsatzanteile pro Komponente uns am
    -- Verhaeltnis von EKN1 (Gesamt) zum EK-Wert eines Einzelartikels orientieren, wird hier in EK_NETTO_SUM 
    -- der gesamte EKN1-Wert der Komponenten gespeichert.


    INSERT INTO `_spannen_agg1` (
        mandant_id, wup_id, kopf_art_id, bewart_id, bewart_det_id, promo_fg, aktion_id,
        stueckliste_id, dat, ean_kasse, ek_netto_sum
    )
    (
        SELECT
            A.mandant_id,
            A.wup_id,
            A.kopf_art_id,
            A.bewart_id,
            A.bewart_det_id,
            A.promo_fg,
            A.aktion_id,
            A.stueckliste_id,
            A.dat,
            A.ean_kasse,
            SUM(A.ek_netto) AS ek_netto_sum
        FROM `_step02_1` AS A
        INNER JOIN `_aggregat01_1` AS B
            ON
                A.mandant_id = B.mandant_id AND A.wup_id = B.wup_id AND A.kopf_art_id = B.art_id AND
                A.dat = B.dat AND A.ean_kasse = B.ean_kasse AND A.bewart_det_id = B.bewart_det_id AND A.bewart_id = B.bewart_id
                AND A.promo_fg = B.promo_fg AND A.aktion_id = B.aktion_id
        GROUP BY
            A.mandant_id,
            A.wup_id,
            A.kopf_art_id,
            A.bewart_id,
            A.bewart_det_id,
            A.promo_fg,
            A.aktion_id,
            A.stueckliste_id,
            A.dat,
            A.ean_kasse
    );


    INSERT INTO `_step02a_1` (
        mandant_id, wup_id, nb_id, art_id, bewart_id, bewart_det_id, promo_fg, aktion_id, dat, wrg_1,
        ean_kasse, menge, umsatz_netto_alt, umsatz_mwst_betrag_alt, umsatz_bto, umrechnungskurs, kopf_art_id,
        komponentenmengen_faktor, stueckliste_id, bq_findung_id, umsatz_anteil, umsatz_netto, umsatz_mwst, ek_brutto, ek_netto,
        ek_nettonetto, ek_kal_basis, ek_mep, einstandspreis, logistikkostenzuschlag, ek_netto_bnk, ek_netto_bnk_sachk,
        ek_mep_vor_fwu, bonusbasis, diff_ek_brutto_konz, diff_ek_netto_konz, diff_ek_nettonetto_konz, diff_ek_kal_basis_konz,
        diff_ek_mep_konz, diff_einstandspreis_konz, diff_logkostenzuschlag_konz, diff_ek_netto_bnk_konz,
        diff_ek_netto_bnk_sachk_konz, ek_mep_vor_fwu_konz, bonusbasis_konz
    )
    (
        SELECT DISTINCT
            Z.mandant_id,
            Z.wup_id,
            Z.nb_id,
            Z.art_id,
            Z.bewart_id,
            Z.bewart_det_id,
            Z.promo_fg,
            Z.aktion_id,
            Z.dat,
            Z.wrg_1,
            Z.ean_kasse,
            Z.menge,
            Z.umsatz_netto_alt,
            Z.umsatz_mwst_betrag_alt,
            Z.umsatz_bto,
            Z.umrechnungskurs,
            Z.kopf_art_id,
            Z.komponentenmengen_faktor,
            Z.stueckliste_id,
            Z.bq_findung_id,
            CAST(CAST(Z.ek_netto AS BIGNUMERIC) / CAST(A.ek_netto_sum AS BIGNUMERIC) AS NUMERIC) AS umsatz_anteil_,
            CAST(
                Z.umsatz_netto_alt * (CAST(Z.ek_netto AS BIGNUMERIC) / CAST(A.ek_netto_sum AS BIGNUMERIC)) AS NUMERIC) AS
            umsatz_netto,
            CAST(
                Z.umsatz_mwst_betrag_alt * (CAST(Z.ek_netto AS BIGNUMERIC) / CAST(A.ek_netto_sum AS BIGNUMERIC)) AS NUMERIC) AS
            umsatz_mwst,
            Z.ek_brutto,
            Z.ek_netto,
            Z.ek_nettonetto,
            Z.ek_kal_basis,
            Z.ek_mep,
            Z.einstandspreis,
            Z.logistikkostenzuschlag,
            Z.ek_netto_bnk,
            Z.ek_netto_bnk_sachk,
            Z.ek_mep_vor_fwu,
            Z.bonusbasis,
            0 AS diff_ek_brutto_konz,
            0 AS diff_ek_netto_konz,
            0 AS diff_ek_nettonetto_konz,
            0 AS diff_ek_kal_basis_konz,
            0 AS diff_ek_mep_konz,
            0 AS diff_einstandspreis_konz,
            0 AS diff_logkostenzuschlag_konz,
            0 AS diff_ek_netto_bnk_konz,
            0 AS diff_ek_netto_bnk_sachk_konz,
            0 AS ek_mep_vor_fwu_konz,
            0 AS bonusbasis_konz
        FROM `_step02_1` AS Z
        INNER JOIN `_spannen_agg1` AS A
            ON
                Z.mandant_id = A.mandant_id AND Z.wup_id = A.wup_id AND Z.kopf_art_id = A.kopf_art_id
                AND Z.stueckliste_id = A.stueckliste_id AND Z.ean_kasse = A.ean_kasse AND Z.dat = A.dat AND Z.bewart_det_id
                = A.bewart_det_id AND Z.bewart_id = A.bewart_id AND Z.promo_fg = A.promo_fg AND Z.aktion_id = A.aktion_id
        WHERE A.ek_netto_sum <> 0
    );


    -- 18.12.2012, -dba-
    --
    -- Laut Konzept gilt die Regel: Manuelle Spannen stehen ueber der Stuecklistenaufloesung! Falls also fuer die
    -- Komponentenartikel manuelle Spannen gepflegt sein sollten, wird das Ganze wieder ueberschrieben!!! Es obliegt 
    -- somit dem Fachbereich, hier fuer eine_1 adäquate Pflege der VK_1-Set Artikel_1 zu sorgen, da ansonsten das Prozedere 
    -- obsolet waere!

    -- manuelle Spanne ohne Betriebsbezug


    UPDATE `_step02a_1` SET
        ek_brutto = ROUND(CAST(`_step02a_1`.umsatz_netto * ms.zwge AS NUMERIC), 4),
        ek_netto = ROUND(CAST(`_step02a_1`.umsatz_netto * ms.zwge AS NUMERIC), 4),
        ek_nettonetto = ROUND(CAST(`_step02a_1`.umsatz_netto * ms.zwgm AS NUMERIC), 4),
        ek_kal_basis = ROUND(CAST(`_step02a_1`.umsatz_netto * ms.zwgm AS NUMERIC), 4),
        ek_mep = ROUND(CAST(`_step02a_1`.umsatz_netto * ms.zwgm AS NUMERIC), 4),
        einstandspreis = ROUND(CAST(`_step02a_1`.umsatz_netto * ms.zwgs AS NUMERIC), 4),
        ek_netto_bnk = ROUND(CAST(`_step02a_1`.umsatz_netto * ms.zwge AS NUMERIC), 4),
        ek_netto_bnk_sachk = ROUND(CAST(`_step02a_1`.umsatz_netto * ms.zwgm AS NUMERIC), 4),
        ek_mep_vor_fwu = ROUND(CAST(`_step02a_1`.umsatz_netto * ms.zwgm AS NUMERIC), 4),
        bonusbasis = ROUND(CAST(`_step02a_1`.umsatz_netto * ms.zwgm AS NUMERIC), 4) FROM (
        SELECT
            EIN.mandant_id,
            EIN.art_id,
            A.dat,
            EIN.ek_faktor AS zwgs,
            COALESCE(MEP.ek_faktor, EIN.ek_faktor) AS zwgm,
            COALESCE(EKBNK.ek_faktor, MEP.ek_faktor, EIN.ek_faktor) AS zwge
        FROM dbp_etl.de_wpuums_dat_1 AS A
        INNER JOIN dbp_data.art_man_spanne_per_1 AS EIN
            ON
                EIN.konditionsart_id = 'ZWGS' /* einstandspreis */
                AND EIN.loesch_fg = 0 AND A.dat BETWEEN EIN.dat_von AND EIN.dat_bis
        LEFT JOIN dbp_data.art_man_spanne_per_1 AS MEP
            ON
                EIN.mandant_id = MEP.mandant_id AND EIN.art_id = MEP.art_id
                AND MEP.konditionsart_id = 'ZWGM' /* MEP */ AND MEP.loesch_fg = 0 AND A.dat BETWEEN MEP.dat_von AND MEP.dat_bis

        LEFT JOIN
            dbp_data.art_man_spanne_per_1
                AS EKBNK
            ON
                EIN.mandant_id = EKBNK.mandant_id AND EIN.art_id =
                EKBNK.art_id AND EKBNK.konditionsart_id = 'ZWGE' /* eknetto bnk */ AND EKBNK.loesch_fg = 0 AND A.dat BETWEEN
                EKBNK.dat_von AND EKBNK.dat_bis
    ) AS ms
    WHERE
        `_step02a_1`.mandant_id = ms.mandant_id AND `_step02a_1`.art_id = ms.art_id AND `_step02a_1`.dat = ms.dat AND `_step02a_1`
        .kopf_art_id <> -100;


    -- Hier die betriebsspezifischen manuellen Spannenfaktoren


    UPDATE `_step02a_1` SET
        ek_brutto = ROUND(CAST(`_step02a_1`.umsatz_netto * ms.zwge AS NUMERIC), 4),
        ek_netto = ROUND(CAST(`_step02a_1`.umsatz_netto * ms.zwge AS NUMERIC), 4),
        ek_nettonetto = ROUND(CAST(`_step02a_1`.umsatz_netto * ms.zwgm AS NUMERIC), 4),
        ek_kal_basis = ROUND(CAST(`_step02a_1`.umsatz_netto * ms.zwgm AS NUMERIC), 4),
        ek_mep = ROUND(CAST(`_step02a_1`.umsatz_netto * ms.zwgm AS NUMERIC), 4),
        einstandspreis = ROUND(CAST(`_step02a_1`.umsatz_netto * ms.zwgs AS NUMERIC), 4),
        ek_netto_bnk = ROUND(CAST(`_step02a_1`.umsatz_netto * ms.zwge AS NUMERIC), 4),
        ek_netto_bnk_sachk = ROUND(CAST(`_step02a_1`.umsatz_netto * ms.zwgm AS NUMERIC), 4),
        ek_mep_vor_fwu = ROUND(CAST(`_step02a_1`.umsatz_netto * ms.zwgm AS NUMERIC), 4),
        bonusbasis = ROUND(CAST(`_step02a_1`.umsatz_netto * ms.zwgm AS NUMERIC), 4) FROM (
        SELECT
            EIN.mandant_id,
            EIN.wup_id,
            EIN.art_id,
            A.dat,
            EIN.ek_faktor AS zwgs,
            COALESCE(MEP.ek_faktor, EIN.ek_faktor) AS zwgm,
            COALESCE(EKBNK.ek_faktor, MEP.ek_faktor, EIN.ek_faktor) AS zwge
        FROM dbp_etl.de_wpuums_dat_1 AS A
        INNER JOIN dbp_data.art_wup_man_spanne_per_1 AS EIN
            ON EIN.konditionsart_id = 'ZWGS'
            /* einstandspreis */ AND EIN.loesch_fg = 0 AND A.dat BETWEEN EIN.dat_von AND EIN.dat_bis
        LEFT JOIN dbp_data.art_wup_man_spanne_per_1 AS MEP
            ON
                EIN.mandant_id = MEP.mandant_id AND EIN.wup_id =
                MEP.wup_id AND EIN.art_id = MEP.art_id AND MEP.konditionsart_id = 'ZWGM' /* MEP */ AND MEP.loesch_fg = 0 AND A.dat BETWEEN MEP.dat_von AND MEP.dat_bis
        LEFT JOIN
            dbp_data.art_wup_man_spanne_per_1
                AS EKBNK
            ON
                EIN.mandant_id = EKBNK.mandant_id AND EIN.wup_id
                = EKBNK.wup_id AND EIN.art_id = EKBNK.art_id AND EKBNK.konditionsart_id = 'ZWGE' /* eknetto bnk */ AND EKBNK.loesch_fg
                = 0 AND A.dat BETWEEN EKBNK.dat_von AND EKBNK.dat_bis
    ) AS ms
    WHERE
        `_step02a_1`.mandant_id = ms.mandant_id AND `_step02a_1`.wup_id = ms.wup_id AND `_step02a_1`.art_id = ms.art_id AND
        `_step02a_1`.dat = ms.dat AND `_step02a_1`.kopf_art_id <> -100;


    -- 18.12.2012, -dba-
    --
    -- Des Weiteren werden fuer die einzelnen Konditionsstufen die zugrunde liegende Spanne im Verhaeltnis zum 
    -- Gesamtabverkauf (UMSATZ_NETTO ermittelt. Mit diesen Spannen werden spaeter die EK-Werte fuer die Kom-
    -- ponentenartikel festgeschrieben.


    CREATE OR REPLACE TEMPORARY TABLE _spannen_agg2_1 AS
    SELECT
        A.mandant_id,
        A.wup_id,
        A.kopf_art_id,
        A.bewart_id,
        A.bewart_det_id,
        A.promo_fg,
        A.aktion_id,
        A.ean_kasse,
        A.stueckliste_id,
        A.dat,
        1 - SUM(A.ek_brutto / B.umsatz_netto) AS ek_brutto_spn,
        1 - SUM(A.ek_netto / B.umsatz_netto) AS ek_netto_spn,
        1 - SUM(A.ek_nettonetto / B.umsatz_netto) AS ek_nettonetto_spn,
        1 - SUM(A.ek_kal_basis / B.umsatz_netto) AS ek_kal_basis_spn,
        1 - SUM(A.ek_mep / B.umsatz_netto) AS ek_mep_spn,
        1 - SUM(A.einstandspreis / B.umsatz_netto) AS einstandspreis_spn,
        1 - SUM(A.logistikkostenzuschlag / B.umsatz_netto) AS logkostenzuschlag_spn,
        1 - SUM(A.ek_netto_bnk / B.umsatz_netto) AS ek_netto_bnk_spn,
        1 - SUM(A.ek_netto_bnk_sachk / B.umsatz_netto) AS ek_netto_bnk_sachk_spn,
        1 - SUM(A.ek_mep_vor_fwu / B.umsatz_netto) AS ek_mep_vor_fwu_spn,
        1 - SUM(A.bonusbasis / B.umsatz_netto) AS bonusbasis_spn
    FROM `_step02a_1` AS A
    INNER JOIN `_aggregat01_1` AS B
        ON
            A.mandant_id = B.mandant_id AND A.wup_id = B.wup_id AND A.kopf_art_id = B.art_id AND A.dat = B.dat AND A.ean_kasse = B.ean_kasse AND A.bewart_det_id = B.bewart_det_id AND A.bewart_id = B.bewart_id
            AND A.promo_fg = B.promo_fg AND A.aktion_id = B.aktion_id
    WHERE B.umsatz_netto <> 0
    GROUP BY
        A.mandant_id,
        A.wup_id,
        A.kopf_art_id,
        A.bewart_id,
        A.bewart_det_id,
        A.promo_fg,
        A.aktion_id,
        A.ean_kasse,
        A.stueckliste_id,
        A.dat;


    -- 18.12.2012, -dba-
    --
    -- Wie dem obigen Titel zu entnehmen ist, werden hier fuer saemtliche Komponenten eines VK_1-Set die entsprechenden
    -- Werte ermittelt. Als Anmerkung waere hier noch zu erwaehnen, dass aufgrund von Rundungsungenauigkeiten im Teradata-
    -- Umfeld bei der EK-Berechnung laut Spanne leider die Genauigkeit von NUMBER(29,4) auf NUMBER(29,2) gesetzt werden
    -- musste, da wir ansonsten kein stimmiges Verhaeltnis der EK-Werte im Vergleich von vorher zu nachher gehabt haetten.


    INSERT INTO `_step03_1` (
        mandant_id, wup_id, nb_id, art_id, bewart_id, bewart_det_id, promo_fg, aktion_id, dat, wrg_1,
        ean_kasse, menge, umsatz_netto_alt, umsatz_mwst_betrag_alt, umsatz_bto, umrechnungskurs, kopf_art_id,
        komponentenmengen_faktor, stueckliste_id, bq_findung_id, umsatz_anteil, umsatz_netto, umsatz_mwst, ek_brutto, ek_netto,
        ek_nettonetto, ek_kal_basis, ek_mep, einstandspreis, logistikkostenzuschlag, ek_netto_bnk, ek_netto_bnk_sachk,
        ek_mep_vor_fwu, bonusbasis, diff_ek_brutto_konz, diff_ek_netto_konz, diff_ek_nettonetto_konz, diff_ek_kal_basis_konz,
        diff_ek_mep_konz, diff_einstandspreis_konz, diff_logkostenzuschlag_konz, diff_ek_netto_bnk_konz,
        diff_ek_netto_bnk_sachk_konz, ek_mep_vor_fwu_konz, bonusbasis_konz
    )
    (
        SELECT DISTINCT
            Z.mandant_id,
            Z.wup_id,
            Z.nb_id,
            Z.art_id,
            Z.bewart_id,
            Z.bewart_det_id,
            Z.promo_fg,
            Z.aktion_id,
            Z.dat,
            Z.wrg_1,
            Z.ean_kasse,
            Z.menge,
            Z.umsatz_netto_alt,
            Z.umsatz_mwst_betrag_alt,
            Z.umsatz_bto,
            Z.umrechnungskurs,
            Z.kopf_art_id,
            Z.komponentenmengen_faktor,
            Z.stueckliste_id,
            Z.bq_findung_id,
            Z.umsatz_anteil,
            Z.umsatz_netto,
            Z.umsatz_mwst,
            CAST(-1 * (A.ek_brutto_spn * ROUND(CAST(Z.umsatz_netto AS NUMERIC), 2) - ROUND(CAST(Z.umsatz_netto AS NUMERIC), 2)) AS NUMERIC)
                AS ek_brutto_,
            CAST(
                -1 * (A.ek_netto_spn * ROUND(CAST(Z.umsatz_netto AS NUMERIC), 2) - ROUND(CAST(Z.umsatz_netto AS NUMERIC), 2)) AS
                NUMERIC
            ) AS ek_netto_,
            CAST(-1 * (
                A.ek_nettonetto_spn * ROUND(CAST(Z.umsatz_netto AS NUMERIC), 2) - ROUND(CAST(Z.umsatz_netto AS NUMERIC), 2
                )
            ) AS NUMERIC) AS ek_nettonetto_,
            CAST(-1 * (
                A.ek_kal_basis_spn * ROUND(CAST(Z.umsatz_netto AS NUMERIC), 2) - ROUND(CAST(Z.umsatz_netto AS NUMERIC), 2
                )
            ) AS NUMERIC) AS ek_kal_basis_,
            CAST(
                -1 * (A.ek_mep_spn * ROUND(CAST(Z.umsatz_netto AS NUMERIC), 2) - ROUND(CAST(Z.umsatz_netto AS NUMERIC), 2)) AS
                NUMERIC
            ) AS ek_mep_,
            CAST(-1 * (A.einstandspreis_spn * ROUND(
                CAST(Z.umsatz_netto AS NUMERIC), 2) - ROUND(
                CAST(Z.umsatz_netto AS NUMERIC),
                2
            )) AS NUMERIC) AS einstandspreis_,
            CAST(-1 * (A.logkostenzuschlag_spn * ROUND(
                CAST(Z.umsatz_netto AS NUMERIC), 2) - ROUND(
                CAST(Z.umsatz_netto AS NUMERIC),
                2
            )) AS NUMERIC) AS logistikkostenzuschlag_,
            CAST(-1 * (
                A.ek_netto_bnk_spn * ROUND(CAST(Z.umsatz_netto AS NUMERIC), 2) - ROUND(CAST(Z.umsatz_netto AS NUMERIC), 2
                )
            ) AS NUMERIC) AS ek_netto_bnk_,
            CAST(-1 * (A.ek_netto_bnk_sachk_spn * ROUND(
                CAST(Z.umsatz_netto AS NUMERIC), 2) - ROUND(
                CAST(Z.umsatz_netto AS NUMERIC),
                2
            )) AS NUMERIC) AS ek_netto_bnk_sachk_,
            CAST(-1 * (A.ek_mep_vor_fwu_spn * ROUND(
                CAST(Z.umsatz_netto AS NUMERIC), 2) - ROUND(
                CAST(Z.umsatz_netto AS NUMERIC),
                2
            )) AS NUMERIC) AS ek_mep_vor_fwu_,
            CAST(
                -1 * (A.bonusbasis_spn * ROUND(CAST(Z.umsatz_netto AS NUMERIC), 2) - ROUND(CAST(Z.umsatz_netto AS NUMERIC), 2))
                AS NUMERIC
            ) AS bonusbasis_,
            ROUND(CAST(-1 * (A.ek_brutto_spn * ROUND(
                CAST(Z.umsatz_netto AS NUMERIC), 2) - ROUND(
                CAST(Z.umsatz_netto AS NUMERIC),
                2
            )) * Z.umrechnungskurs AS NUMERIC), 4) AS diff_ek_brutto_konz,
            ROUND(CAST(-1 * (A.ek_netto_spn * ROUND(
                CAST(Z.umsatz_netto AS NUMERIC), 2) - ROUND(
                CAST(Z.umsatz_netto AS NUMERIC),
                2
            )) * Z.umrechnungskurs AS NUMERIC), 4) AS diff_ek_netto_konz,
            ROUND(CAST(-1 * (A.ek_nettonetto_spn * ROUND(
                CAST(Z.umsatz_netto AS NUMERIC), 2) - ROUND(
                CAST(Z.umsatz_netto AS NUMERIC),
                2
            )) * Z.umrechnungskurs AS NUMERIC), 4) AS diff_ek_nettonetto_konz,
            ROUND(CAST(-1 * (A.ek_kal_basis_spn * ROUND(
                CAST(Z.umsatz_netto AS NUMERIC), 2) - ROUND(
                CAST(Z.umsatz_netto AS NUMERIC),
                2
            )) * Z.umrechnungskurs AS NUMERIC), 4) AS diff_ek_kal_basis_konz,
            ROUND(CAST(-1 * (
                A.ek_mep_spn * ROUND(CAST(Z.umsatz_netto AS NUMERIC), 2) - ROUND(CAST(Z.umsatz_netto AS NUMERIC), 2
                )
            ) * Z.umrechnungskurs AS NUMERIC), 4) AS diff_ek_mep_konz,
            ROUND(CAST(-1 * (A.einstandspreis_spn * ROUND(
                CAST(Z.umsatz_netto AS NUMERIC), 2) - ROUND(
                CAST(Z.umsatz_netto AS NUMERIC),
                2
            )) * Z.umrechnungskurs AS NUMERIC), 4) AS diff_einstandspreis_konz,
            ROUND(CAST(-1 * (A.logkostenzuschlag_spn * ROUND(
                CAST(Z.umsatz_netto AS NUMERIC), 2) - ROUND(
                CAST(Z.umsatz_netto AS NUMERIC),
                2
            )) * Z.umrechnungskurs AS NUMERIC), 4) AS diff_logkostenzuschlag_konz,
            ROUND(CAST(-1 * (A.ek_netto_bnk_spn * ROUND(
                CAST(Z.umsatz_netto AS NUMERIC), 2) - ROUND(
                CAST(Z.umsatz_netto AS NUMERIC),
                2
            )) * Z.umrechnungskurs AS NUMERIC), 4) AS diff_ek_netto_bnk_konz,
            ROUND(CAST(-1 * (A.ek_netto_bnk_sachk_spn * ROUND(
                CAST(Z.umsatz_netto AS NUMERIC), 2) - ROUND(
                CAST(Z.umsatz_netto AS NUMERIC),
                2
            )) * Z.umrechnungskurs AS NUMERIC), 4) AS diff_ek_netto_bnk_sachk_konz,
            ROUND(CAST(-1 * (A.ek_mep_vor_fwu_spn * ROUND(
                CAST(Z.umsatz_netto AS NUMERIC), 2) - ROUND(
                CAST(Z.umsatz_netto AS NUMERIC),
                2
            )) * Z.umrechnungskurs AS NUMERIC), 4) AS ek_mep_vor_fwu_konz,
            ROUND(CAST(-1 * (A.bonusbasis_spn * ROUND(
                CAST(Z.umsatz_netto AS NUMERIC), 2) - ROUND(
                CAST(Z.umsatz_netto AS NUMERIC),
                2
            )) * Z.umrechnungskurs AS NUMERIC), 4) AS bonusbasis_konz
        FROM `_step02a_1` AS Z
        INNER JOIN
            `_spannen_agg2_1`
                AS A
            ON
                Z.mandant_id = A.mandant_id AND Z.wup_id = A.wup_id AND Z.kopf_art_id = A.kopf_art_id
                AND Z.stueckliste_id = A.stueckliste_id AND Z.dat = A.dat AND Z.ean_kasse = A.ean_kasse AND Z.bewart_det_id
                = A.bewart_det_id AND Z.bewart_id = A.bewart_id AND Z.promo_fg = A.promo_fg AND Z.aktion_id = A.aktion_id
    );


    INSERT INTO `_step03_1` (
        mandant_id, wup_id, nb_id, art_id, bewart_id, bewart_det_id, promo_fg, aktion_id, dat, wrg_1,
        ean_kasse, menge, umsatz_netto_alt, umsatz_mwst_betrag_alt, umsatz_bto, umrechnungskurs, kopf_art_id,
        komponentenmengen_faktor, stueckliste_id, bq_findung_id, umsatz_anteil, umsatz_netto, umsatz_mwst, ek_brutto, ek_netto,
        ek_nettonetto, ek_kal_basis, ek_mep, einstandspreis, logistikkostenzuschlag, ek_netto_bnk, ek_netto_bnk_sachk,
        ek_mep_vor_fwu, bonusbasis, diff_ek_brutto_konz, diff_ek_netto_konz, diff_ek_nettonetto_konz, diff_ek_kal_basis_konz,
        diff_ek_mep_konz, diff_einstandspreis_konz, diff_logkostenzuschlag_konz, diff_ek_netto_bnk_konz,
        diff_ek_netto_bnk_sachk_konz, ek_mep_vor_fwu_konz, bonusbasis_konz
    )
    (
        SELECT DISTINCT
            Z.mandant_id,
            Z.wup_id,
            Z.nb_id,
            Z.art_id,
            Z.bewart_id,
            Z.bewart_det_id,
            Z.promo_fg,
            Z.aktion_id,
            Z.dat,
            Z.wrg_1,
            Z.ean_kasse,
            Z.menge,
            Z.umsatz_netto_alt,
            Z.umsatz_mwst_betrag_alt,
            Z.umsatz_bto,
            Z.umrechnungskurs,
            Z.kopf_art_id,
            Z.komponentenmengen_faktor,
            Z.stueckliste_id,
            Z.bq_findung_id,
            0 AS umsatz_anteil,
            Z.umsatz_netto_alt AS umsatz_netto,
            Z.umsatz_mwst_betrag_alt AS umsatz_mwst,
            CAST((1 - A.ek_brutto_spn) * ROUND(CAST(Z.umsatz_netto_alt AS NUMERIC), 2) AS NUMERIC) AS ek_brutto_,
            CAST((1 - A.ek_netto_spn) * ROUND(CAST(Z.umsatz_netto_alt AS NUMERIC), 2) AS NUMERIC) AS ek_netto_,
            CAST((1 - A.ek_nettonetto_spn) * ROUND(CAST(Z.umsatz_netto_alt AS NUMERIC), 2) AS NUMERIC) AS ek_nettonetto_,
            CAST((1 - A.ek_kal_basis_spn) * ROUND(CAST(Z.umsatz_netto_alt AS NUMERIC), 2) AS NUMERIC) AS ek_kal_basis_,
            CAST((1 - A.ek_mep_spn) * ROUND(CAST(Z.umsatz_netto_alt AS NUMERIC), 2) AS NUMERIC) AS ek_mep_,
            CAST((1 - A.einstandspreis_spn) * ROUND(CAST(Z.umsatz_netto_alt AS NUMERIC), 2) AS NUMERIC) AS einstandspreis_,
            CAST(
                (1 - A.logkostenzuschlag_spn) * ROUND(CAST(Z.umsatz_netto_alt AS NUMERIC), 2) AS NUMERIC) AS
            logistikkostenzuschlag_,
            CAST((1 - A.ek_netto_bnk_spn) * ROUND(CAST(Z.umsatz_netto_alt AS NUMERIC), 2) AS NUMERIC) AS ek_netto_bnk_,
            CAST((1 - A.ek_netto_bnk_sachk_spn) * ROUND(CAST(Z.umsatz_netto_alt AS NUMERIC), 2) AS NUMERIC) AS ek_netto_bnk_sachk_
            ,
            CAST((1 - A.ek_mep_vor_fwu_spn) * ROUND(CAST(Z.umsatz_netto_alt AS NUMERIC), 2) AS NUMERIC) AS ek_mep_vor_fwu_,
            CAST((1 - A.bonusbasis_spn) * ROUND(CAST(Z.umsatz_netto_alt AS NUMERIC), 2) AS NUMERIC) AS bonusbasis_,
            ROUND(CAST((1 - A.ek_brutto_spn) * ROUND(CAST(Z.umsatz_netto_alt AS NUMERIC), 2) * Z.umrechnungskurs AS NUMERIC), 4)
                AS diff_ek_brutto_konz,
            ROUND(
                CAST((1 - A.ek_netto_spn) * ROUND(CAST(Z.umsatz_netto_alt AS NUMERIC), 2) * Z.umrechnungskurs AS NUMERIC), 4) AS
            diff_ek_netto_konz,
            ROUND(
                CAST((1 - A.ek_nettonetto_spn) * ROUND(CAST(Z.umsatz_netto_alt AS NUMERIC), 2) * Z.umrechnungskurs AS NUMERIC),
                4
            ) AS diff_ek_nettonetto_konz,
            ROUND(CAST((1 - A.ek_kal_basis_spn) * ROUND(CAST(Z.umsatz_netto_alt AS NUMERIC), 2) * Z.umrechnungskurs AS NUMERIC), 4
            ) AS diff_ek_kal_basis_konz,
            ROUND(
                CAST((1 - A.ek_mep_spn) * ROUND(CAST(Z.umsatz_netto_alt AS NUMERIC), 2) * Z.umrechnungskurs AS NUMERIC), 4) AS
            diff_ek_mep_konz,
            ROUND(
                CAST((1 - A.einstandspreis_spn) * ROUND(CAST(Z.umsatz_netto_alt AS NUMERIC), 2) * Z.umrechnungskurs AS NUMERIC),
                4
            ) AS diff_einstandspreis_konz,
            ROUND(CAST(
                (1 - A.logkostenzuschlag_spn) * ROUND(CAST(Z.umsatz_netto_alt AS NUMERIC), 2) * Z.umrechnungskurs AS
                NUMERIC
            ), 4) AS diff_logkostenzuschlag_konz,
            ROUND(CAST((1 - A.ek_netto_bnk_spn) * ROUND(CAST(Z.umsatz_netto_alt AS NUMERIC), 2) * Z.umrechnungskurs AS NUMERIC), 4
            ) AS diff_ek_netto_bnk_konz,
            ROUND(CAST(
                (1 - A.ek_netto_bnk_sachk_spn) * ROUND(CAST(Z.umsatz_netto_alt AS NUMERIC), 2) * Z.umrechnungskurs AS
                NUMERIC
            ), 4) AS diff_ek_netto_bnk_sachk_konz,
            ROUND(
                CAST((1 - A.ek_mep_vor_fwu_spn) * ROUND(CAST(Z.umsatz_netto_alt AS NUMERIC), 2) * Z.umrechnungskurs AS NUMERIC),
                4
            ) AS ek_mep_vor_fwu_konz,
            ROUND(CAST((1 - A.bonusbasis_spn) * ROUND(CAST(Z.umsatz_netto_alt AS NUMERIC), 2) * Z.umrechnungskurs AS NUMERIC), 4)
                AS bonusbasis_konz
        FROM `_step02_1` AS Z
        INNER JOIN `_spannen_agg2_1` AS A
            ON
                Z.mandant_id = A.mandant_id AND Z.wup_id = A.wup_id AND Z.art_id = A.kopf_art_id
                AND Z.stueckliste_id = A.stueckliste_id AND Z.dat = A.dat AND Z.ean_kasse = A.ean_kasse AND Z.bewart_det_id = A.bewart_det_id AND Z.bewart_id = A.bewart_id AND Z.promo_fg = A.promo_fg AND Z.aktion_id = A.aktion_id
        WHERE Z.kopf_art_id = -100
    );


    MERGE INTO dbp_data.artbew_1 AS A
    USING (
        SELECT *
        FROM `_step03_1`
        WHERE kopf_art_id = -100
    ) AS b
        ON
            A.mandant_id = b.mandant_id AND A.wup_id = b.wup_id AND A.nb_id = b.nb_id AND A.art_id = b.art_id AND A.ean_kasse = b.ean_kasse AND A.dat = b.dat AND A.bewart_det_id = b.bewart_det_id AND A.bewart_id = b.bewart_id AND A.promo_fg
            = b.promo_fg AND A.aktion_id = b.aktion_id AND A.menge >= 0
    WHEN MATCHED THEN UPDATE SET
        ek_brutto = b.ek_brutto,
        ek_netto = b.ek_netto,
        ek_nettonetto = b.ek_nettonetto,
        ek_kal_basis = b.ek_kal_basis,
        ek_mep = b.ek_mep,
        einstandspreis = b.einstandspreis,
        logkostenzuschlag = b.logistikkostenzuschlag,
        ek_netto_bnk = b.ek_netto_bnk,
        ek_netto_bnk_sachk = b.ek_netto_bnk_sachk,
        ek_mep_vor_fwu = b.ek_mep_vor_fwu,
        bonusbasis = b.bonusbasis;


    MERGE INTO dbp_data.artbew_1 AS A
    USING (
        SELECT *
        FROM `_step03_1`
        WHERE kopf_art_id = -100
    ) AS b
        ON
            A.mandant_id = b.mandant_id AND A.wup_id = b.wup_id AND A.nb_id = b.nb_id AND A.art_id = b.art_id AND A.ean_kasse = b.ean_kasse AND A.dat = b.dat AND A.bewart_det_id = b.bewart_det_id AND A.bewart_id = b.bewart_id AND A.promo_fg
            = b.promo_fg AND A.aktion_id = b.aktion_id AND A.menge < 0
    WHEN MATCHED THEN UPDATE SET
        ek_brutto = 0,
        ek_netto = 0,
        ek_nettonetto = 0,
        ek_kal_basis = 0,
        ek_mep = 0,
        einstandspreis = 0,
        logkostenzuschlag = 0,
        ek_netto_bnk = 0,
        ek_netto_bnk_sachk = 0,
        ek_mep_vor_fwu = 0,
        bonusbasis = 0;


    DELETE FROM dbp_data.artbew_stueckliste_zu_1
    WHERE (
        mandant_id, wup_id, dat) IN (
        SELECT (mandant_id, wup_id, dat)
        FROM `_step03_1`
        WHERE mandant_id = 1
    );


    INSERT INTO dbp_data.artbew_stueckliste_zu_1 (
        art_id, mandant_id, wup_id, nb_id, dat, komponente_art_id,
        stueckliste_id, umrech_faktor, menge_komponente_in_vk_set, wrg_id, umsatz_netto, umsatz_mwst_betrag, menge, ek_brutto,
        ek_netto, ek_nettonetto, ek_kal_basis, ek_mep, ek_mep_vor_fwu, einstandspreis, logkostenzuschlag, ek_netto_bnk,
        ek_netto_bnk_sachk, bq_findung_id, umrechnungskurs, umrechnungskurs_hist, bonusbasis, td_update, td_insert
    )
    (
        SELECT
            x.kopf_art_id AS art_id,
            x.mandant_id,
            x.wup_id,
            x.nb_id,
            x.dat,
            x.art_id AS komponente_art_id,
            x.stueckliste_id,
            1 AS umrech_faktor,
            NULL AS menge_komponente_in_vk_set,
            x.wrg_1 AS wrg_id,
            COALESCE(x.umsatz_netto, 0) AS umsatz_netto,
            COALESCE(x.umsatz_mwst, 0) AS umsatz_mwst_betrag,
            x.komponentenmengen_faktor AS menge,
            COALESCE(x.ek_brutto, 0) AS ek_brutto,
            COALESCE(x.ek_netto, 0) AS ek_netto,
            COALESCE(x.ek_nettonetto, 0) AS ek_nettonetto,
            COALESCE(x.ek_kal_basis, 0) AS ek_kal_basis,
            COALESCE(x.ek_mep, 0) AS ek_mep,
            COALESCE(x.ek_mep_vor_fwu, 0) AS ek_mep_vor_fwu,
            COALESCE(x.einstandspreis, 0) AS einstandspreis,
            COALESCE(x.logistikkostenzuschlag, 0) AS logkostenzuschlag,
            COALESCE(x.ek_netto_bnk, 0) AS ek_netto_bnk,
            COALESCE(x.ek_netto_bnk_sachk, 0) AS ek_netto_bnk_sachk,
            COALESCE(x.bq_findung_id, 30) AS bq_findung_id,
            1 AS umrechnungskurs,
            K.umrechnungskurs AS umrechnungskurs_hist,
            COALESCE(x.bonusbasis, 0) AS bonusbasis,
            CURRENT_TIMESTAMP() AS td_update,
            CURRENT_TIMESTAMP() AS td_insert
        FROM (
            SELECT
                mandant_id,
                wup_id,
                nb_id,
                kopf_art_id,
                dat,
                art_id,
                stueckliste_id,
                wrg_1,
                SUM(umsatz_netto) AS umsatz_netto,
                SUM(umsatz_mwst) AS umsatz_mwst,
                SUM(komponentenmengen_faktor) AS komponentenmengen_faktor,
                SUM(ek_brutto) AS ek_brutto,
                SUM(ek_netto) AS ek_netto,
                SUM(ek_nettonetto) AS ek_nettonetto,
                SUM(ek_kal_basis) AS ek_kal_basis,
                SUM(ek_mep) AS ek_mep,
                SUM(einstandspreis) AS einstandspreis,
                SUM(logistikkostenzuschlag) AS logistikkostenzuschlag,
                SUM(ek_netto_bnk) AS ek_netto_bnk,
                SUM(ek_netto_bnk_sachk) AS ek_netto_bnk_sachk,
                bq_findung_id,
                MAX(umrechnungskurs) AS umrechnungskurs,
                SUM(ek_mep_vor_fwu) AS ek_mep_vor_fwu,
                SUM(bonusbasis) AS bonusbasis
            FROM `_step03_1`
            WHERE kopf_art_id <> -100
            GROUP BY
                mandant_id,
                wup_id,
                nb_id,
                art_id,
                dat,
                wrg_1,
                kopf_art_id,
                stueckliste_id,
                bq_findung_id
        ) AS x
        LEFT JOIN
            dbp_data.kurs_1
                AS K
            ON
                x.wrg_1 = K.von_wrg_id AND x.dat BETWEEN K.dat_von AND K.dat_bis AND K.nach_wrg_id
                = 'EUR' AND K.kurstyp_id = 3
    );


    UPDATE dbp_data.artbew_stueckliste_zu_1 SET
        umrech_faktor = b.umrech_faktor,
        menge_komponente_in_vk_set = CAST(b.umrech_faktor * b.menge_komponente_in_vk_set AS NUMERIC) FROM (
        SELECT
            A.mandant_id
            ,
            A.art_id,
            A.komponente_art_id,
            A.wup_id,
            A.dat,
            A.stueckliste_id,
            MAX(COALESCE(C.umrech_faktor, 1.00000)) AS umrech_faktor,
            MAX(b.komponentenmenge) AS menge_komponente_in_vk_set
        FROM dbp_data.artbew_stueckliste_zu_1 AS A
        INNER JOIN (
            SELECT *
            FROM dbp_data.stueckliste_det_1
            WHERE stueckliste_typ_id = 'M'
        ) AS b
            ON
                A.mandant_id = b.mandant_id AND A.stueckliste_id = b.stueckliste_id AND A.komponente_art_id
                = b.art_id AND A.dat BETWEEN b.dat_von AND b.dat_bis
        LEFT JOIN dbp_data.art_umrechnung_faktor_per_1 AS C
            ON
                b.mandant_id = C.mandant_id AND b.art_id = C.art_id
                AND b.komponentenmenge_einh_id = C.altnv_menge_einh_id AND A.dat BETWEEN C.dat_von AND C.dat_bis
        WHERE
            A.dat >= (
                SELECT MIN(dat)
                FROM dbp_data.tag_1
                WHERE akt_kj = -2
            )
            AND A.mandant_id = 1
        GROUP BY
            A.mandant_id,
            A.art_id,
            A.komponente_art_id,
            A.wup_id,
            A.dat,
            A.stueckliste_id
    ) AS b
    WHERE
        artbew_stueckliste_zu.mandant_id = b.mandant_id AND artbew_stueckliste_zu.art_id = b.art_id AND
        artbew_stueckliste_zu.komponente_art_id = b.komponente_art_id AND artbew_stueckliste_zu.wup_id = b.wup_id AND
        artbew_stueckliste_zu.dat = b.dat AND artbew_stueckliste_zu.stueckliste_id = b.stueckliste_id;

END;
