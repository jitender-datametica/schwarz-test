CREATE OR REPLACE TEMPORARY TABLE _artbew_vw_sum_tmp (
    dat DATE NOT NULL,
    mandant_id INTEGER NOT NULL,
    vw_id INTEGER NOT NULL,
    art_id INTEGER NOT NULL,
    bewart_id INTEGER NOT NULL,
    herst_id INTEGER NOT NULL,
    ean_kasse INTEGER NOT NULL,
    gp_id INTEGER NOT NULL,
    bezugsweg_id INTEGER,
    menge NUMERIC(29, 4),
    umsatz_netto NUMERIC(29, 4),
    umsatz_mwst_betrag NUMERIC(29, 4),
    ek_nettonetto NUMERIC(29, 4),
    ek_mep NUMERIC(29, 4),
    einstandspreis NUMERIC(29, 4),
    wrg_id STRING(3) NOT NULL,
    bewart_det_id INTEGER NOT NULL,
    pv_aktion NUMERIC(29, 4),
    pv_bby NUMERIC(29, 4),
    pv_kdn_bby NUMERIC(29, 4),
    pv_kdp_bby NUMERIC(29, 4),
    pv_aktion_bby NUMERIC(29, 4),
    pv_aktion_kdn_bby NUMERIC(29, 4),
    pv_aktion_kdp_bby NUMERIC(29, 4),
    diff_einstandspreis_konz NUMERIC(29, 4),
    diff_ek_brutto_konz NUMERIC(29, 4),
    diff_ek_gld_konz NUMERIC(29, 4),
    diff_ek_kal_basis_konz NUMERIC(29, 4),
    diff_ek_mep_konz NUMERIC(29, 4),
    diff_ek_netto_bnk_konz NUMERIC(29, 4),
    diff_ek_netto_bnk_sachk_konz NUMERIC(29, 4),
    diff_ek_netto_konz NUMERIC(29, 4),
    diff_ek_nettonetto_konz NUMERIC(29, 4),
    diff_logkostenzuschlag_konz NUMERIC(29, 4),
    diff_umsatz_mwst_betrag_konz NUMERIC(29, 4),
    diff_umsatz_netto_konz NUMERIC(29, 4),
    ek_brutto NUMERIC(29, 4),
    ek_gld NUMERIC(29, 4),
    ek_kal_basis NUMERIC(29, 4),
    ek_netto NUMERIC(29, 4),
    ek_netto_bnk NUMERIC(29, 4),
    ek_netto_bnk_sachk NUMERIC(29, 4),
    logkostenzuschlag NUMERIC(29, 4),
    ek_mep_vor_fwu NUMERIC(29, 4),
    ek_mep_vor_fwu_konz NUMERIC(29, 4),
    bonusbasis NUMERIC(29, 4),
    bonusbasis_konz NUMERIC(29, 4),
    pv_bonrabatt_bby NUMERIC(29, 4),
    wup_bereinigt_fg INTEGER NOT NULL,
    umrechnungskurs_hist NUMERIC(29, 5),
    pv_aktion_konz NUMERIC(29, 4),
    pv_bby_konz NUMERIC(29, 4),
    pv_kdn_bby_konz NUMERIC(29, 4),
    pv_kdp_bby_konz NUMERIC(29, 4),
    pv_aktion_bby_konz NUMERIC(29, 4),
    pv_aktion_kdn_bby_konz NUMERIC(29, 4),
    pv_aktion_kdp_bby_konz NUMERIC(29, 4),
    pv_bonrabatt_bby_konz NUMERIC(29, 4),
    aktionsart_id_liste_txt STRING(300),	--> pe_review
    aktionsart_bez_liste_txt STRING(300),	--> pe_review
    aktion_typ_id_liste_txt STRING(300),	--> pe_review
    aktion_typ_bez_liste_txt STRING(300)	--> pe_review
);


CREATE OR REPLACE TEMPORARY TABLE _faecher (
    mandant_id INTEGER NOT NULL,
    vw_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    nb_id INTEGER NOT NULL,
    dat DATE NOT NULL
);


INSERT INTO `_faecher` (mandant_id, vw_id, wup_id, nb_id, dat)
(
    SELECT
        t0.mandant_id,
        B.vw_id,
        B.wup_id,
        B.nb_id,
        t0.dat
    FROM (
        SELECT
            X.mandant_id,
            Y.vw_id,
            X.dat
        FROM dbp_data.artbew_agg_wt AS X
        INNER JOIN dbp_data.wup AS Y ON X.mandant_id = Y.mandant_id AND X.wup_id = Y.wup_id AND X.nb_id = Y.nb_id

        GROUP BY
            X.mandant_id,
            X.dat,
            Y.vw_id
    ) AS t0
    INNER JOIN dbp_data.wup AS B ON t0.mandant_id = B.mandant_id AND t0.vw_id = B.vw_id
);


INSERT INTO `_artbew_vw_sum_tmp` (
    dat, mandant_id, vw_id, art_id, bewart_id, herst_id, ean_kasse, gp_id, bezugsweg_id,
    menge, umsatz_netto, umsatz_mwst_betrag, ek_nettonetto, ek_mep, einstandspreis, wrg_id, bewart_det_id, pv_aktion,
    pv_bby, pv_kdn_bby, pv_kdp_bby, pv_aktion_bby, pv_aktion_kdn_bby, pv_aktion_kdp_bby, diff_einstandspreis_konz,
    diff_ek_brutto_konz, diff_ek_gld_konz, diff_ek_kal_basis_konz, diff_ek_mep_konz, diff_ek_netto_bnk_konz,
    diff_ek_netto_bnk_sachk_konz, diff_ek_netto_konz, diff_ek_nettonetto_konz, diff_logkostenzuschlag_konz,
    diff_umsatz_mwst_betrag_konz, diff_umsatz_netto_konz, ek_brutto, ek_gld, ek_kal_basis, ek_netto, ek_netto_bnk,
    ek_netto_bnk_sachk, logkostenzuschlag, ek_mep_vor_fwu, ek_mep_vor_fwu_konz, bonusbasis, bonusbasis_konz,
    pv_bonrabatt_bby, wup_bereinigt_fg, umrechnungskurs_hist, pv_aktion_konz, pv_bby_konz, pv_kdn_bby_konz, pv_kdp_bby_konz,
    pv_aktion_bby_konz, pv_aktion_kdn_bby_konz, pv_aktion_kdp_bby_konz, pv_bonrabatt_bby_konz, aktionsart_id_liste_txt,
    aktionsart_bez_liste_txt, aktion_typ_id_liste_txt, aktion_typ_bez_liste_txt
)
(
    SELECT
        A.dat,
        A.mandant_id,
        B.vw_id,
        A.art_id,
        A.bewart_id,
        MAX(A.herst_id) AS herst_id,
        CAST(A.ean_kasse AS INTEGER) AS ean_kasse,
        A.gp_id,
        A.bezugsweg_id,
        SUM(COALESCE(A.menge, 0)) AS menge,
        SUM(COALESCE(A.umsatz_netto, 0)) AS umsatz_netto,
        SUM(COALESCE(A.umsatz_mwst_betrag, 0)) AS umsatz_mwst_betrag,
        SUM(COALESCE(CAST(A.ek_nettonetto AS NUMERIC), 0)) AS ek_nettonetto,
        SUM(COALESCE(CAST(A.ek_mep AS NUMERIC), 0)) AS ek_mep,
        SUM(COALESCE(CAST(A.einstandspreis AS NUMERIC), 0)) AS einstandspreis,
        A.wrg AS wrg_id,
        A.bewart_det_id,
        SUM(COALESCE(A.pv_aktion, 0)) AS pv_aktion,
        SUM(COALESCE(A.pv_bby, 0)) AS pv_bby,
        SUM(COALESCE(A.pv_kdn_bby, 0)) AS pv_kdn_bby,
        SUM(COALESCE(A.pv_kdp_bby, 0)) AS pv_kdp_bby,
        SUM(COALESCE(A.pv_aktion_bby, 0)) AS pv_aktion_bby,
        SUM(COALESCE(A.pv_aktion_kdn_bby, 0)) AS pv_aktion_kdn_bby,
        SUM(COALESCE(A.pv_aktion_kdp_bby, 0)) AS pv_aktion_kdp_bby,
        SUM(COALESCE(A.diff_einstandspreis_konz, 0)),
        SUM(COALESCE(A.diff_ek_brutto_konz, 0)),
        SUM(COALESCE(A.diff_ek_gld_konz, 0)),
        SUM(COALESCE(A.diff_ek_kal_basis_konz, 0)),
        SUM(COALESCE(A.diff_ek_mep_konz, 0)),
        SUM(COALESCE(A.diff_ek_netto_bnk_konz, 0)),
        SUM(COALESCE(A.diff_ek_netto_bnk_sachk_konz, 0)),
        SUM(COALESCE(A.diff_ek_netto_konz, 0)),
        SUM(COALESCE(A.diff_ek_nettonetto_konz, 0)),
        SUM(COALESCE(A.diff_logkostenzuschlag_konz, 0)),
        SUM(COALESCE(A.diff_umsatz_mwst_betrag_konz, 0)),
        SUM(COALESCE(A.diff_umsatz_netto_konz, 0)),
        SUM(COALESCE(A.ek_brutto, 0)),
        SUM(COALESCE(A.ek_gld, 0)),
        SUM(COALESCE(A.ek_kal_basis, 0)),
        SUM(COALESCE(A.ek_netto, 0)),
        SUM(COALESCE(A.ek_netto_bnk, 0)),
        SUM(COALESCE(A.ek_netto_bnk_sachk, 0)),
        SUM(COALESCE(A.logkostenzuschlag, 0)),
        SUM(COALESCE(A.ek_mep_vor_fwu, 0)),
        SUM(COALESCE(A.ek_mep_vor_fwu_konz, 0)),
        SUM(COALESCE(A.bonusbasis, 0)),
        SUM(COALESCE(A.bonusbasis_konz, 0)),
        SUM(COALESCE(A.pv_bonrabatt_bby, 0)),
        A.wup_bereinigt_fg,
        MAX(A.umrechnungskurs_hist),
        SUM(COALESCE(A.pv_aktion_konz, 0)),
        SUM(COALESCE(A.pv_bby_konz, 0)),
        SUM(COALESCE(A.pv_kdn_bby_konz, 0)),
        SUM(COALESCE(A.pv_kdp_bby_konz, 0)),
        SUM(COALESCE(A.pv_aktion_bby_konz, 0)),
        SUM(COALESCE(A.pv_aktion_kdn_bby_konz, 0)),
        SUM(COALESCE(A.pv_aktion_kdp_bby_konz, 0)),
        SUM(COALESCE(A.pv_bonrabatt_bby_konz, 0)),
        A.aktionsart_id_liste_txt,
        A.aktionsart_bez_liste_txt,
        A.aktion_typ_id_liste_txt,
        A.aktion_typ_bez_liste_txt
    FROM dbp_data.artbew AS A
    INNER JOIN `_faecher` AS B
        ON
            A.mandant_id = B.mandant_id AND A.wup_id = B.wup_id AND A.nb_id = B.nb_id AND A.dat = B.dat
    GROUP BY
        A.dat,
        A.mandant_id,
        B.vw_id,
        A.art_id,
        A.bewart_id,
        A.ean_kasse,
        A.gp_id,
        A.bezugsweg_id,
        wrg_id,
        A.bewart_det_id,
        A.wup_bereinigt_fg,
        A.aktionsart_id_liste_txt,
        A.aktionsart_bez_liste_txt,
        A.aktion_typ_id_liste_txt,
        A.aktion_typ_bez_liste_txt
);


DELETE FROM dbp_data.artbew_vw_sum
WHERE (
    mandant_id, vw_id, dat) IN (
    SELECT (mandant_id, vw_id, dat)
    FROM `_faecher`
);


INSERT INTO dbp_data.artbew_vw_sum (
    mandant_id, dat, bewart_id, gp_id, art_id, vw_id, bezugsweg_id,
    wup_bereinigt_fg, menge, umsatz_netto, umsatz_mwst_betrag, ek_mep, ek_mep_vor_fwu, ek_mep_vor_fwu_konz, einstandspreis,
    ek_nettonetto, wrg_id, umrechnungskurs_hist, diff_einstandspreis_konz, diff_ek_brutto_konz, diff_ek_gld_konz,
    diff_ek_kal_basis_konz, diff_ek_mep_konz, diff_ek_netto_bnk_konz, diff_ek_netto_bnk_sachk_konz, diff_ek_netto_konz,
    diff_ek_nettonetto_konz, diff_logkostenzuschlag_konz, diff_umsatz_mwst_betrag_konz, diff_umsatz_netto_konz, ean_kasse,
    ek_brutto, ek_gld, ek_kal_basis, ek_netto, ek_netto_bnk, ek_netto_bnk_sachk, herst_id, logkostenzuschlag, bonusbasis,
    bonusbasis_konz, bewart_det_id, pv_aktion, pv_aktion_konz, pv_bby, pv_bby_konz, pv_kdn_bby, pv_kdn_bby_konz, pv_kdp_bby,
    pv_kdp_bby_konz, pv_aktion_bby, pv_aktion_bby_konz, pv_aktion_kdn_bby, pv_aktion_kdn_bby_konz, pv_aktion_kdp_bby,
    pv_aktion_kdp_bby_konz,
    pv_bonrabatt_bby,
    pv_bonrabatt_bby_konz,
    aktionsart_bez_liste_txt,  	--> pe_review
    aktion_typ_id_liste_txt,	--> pe_review
    aktion_typ_bez_liste_txt, 	--> pe_review
    aktionsart_id_liste_txt	--> pe_review
)
(
    SELECT
        A.mandant_id,
        A.dat,
        A.bewart_id,
        A.gp_id,
        A.art_id,
        A.vw_id,
        COALESCE(A.bezugsweg_id, -1) AS bezugsweg_id,
        A.wup_bereinigt_fg,
        A.menge,
        A.umsatz_netto,
        A.umsatz_mwst_betrag,
        A.ek_mep,
        A.ek_mep_vor_fwu,
        A.ek_mep_vor_fwu_konz,
        A.einstandspreis,
        A.ek_nettonetto,
        COALESCE(A.wrg_id, B.default_wrg) AS wrg_id,
        A.umrechnungskurs_hist,
        A.diff_einstandspreis_konz,
        A.diff_ek_brutto_konz,
        A.diff_ek_gld_konz,
        A.diff_ek_kal_basis_konz,
        A.diff_ek_mep_konz,
        A.diff_ek_netto_bnk_konz,
        A.diff_ek_netto_bnk_sachk_konz,
        A.diff_ek_netto_konz,
        A.diff_ek_nettonetto_konz,
        A.diff_logkostenzuschlag_konz,
        A.diff_umsatz_mwst_betrag_konz,
        A.diff_umsatz_netto_konz,
        A.ean_kasse,
        A.ek_brutto,
        A.ek_gld,
        A.ek_kal_basis,
        A.ek_netto,
        A.ek_netto_bnk,
        A.ek_netto_bnk_sachk,
        A.herst_id,
        A.logkostenzuschlag,
        A.bonusbasis,
        A.bonusbasis_konz,
        A.bewart_det_id,
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
        A.aktionsart_bez_liste_txt,
        A.aktion_typ_id_liste_txt,
        A.aktion_typ_bez_liste_txt,
        A.aktionsart_id_liste_txt
    FROM `_artbew_vw_sum_tmp` AS A
    LEFT JOIN dbp_data.mandant AS B ON A.mandant_id = B.mandant_id
);
