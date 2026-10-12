CREATE OR REPLACE TEMPORARY TABLE _artbew_agg_monat (
    dat DATE NOT NULL,
    mandant_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    nb_id INTEGER NOT NULL,
    kjmo INTEGER NOT NULL
);


INSERT INTO `_artbew_agg_monat` (dat, mandant_id, wup_id, nb_id, kjmo)
(
    SELECT
        C.dat,
        A.mandant_id,
        A.wup_id,
        A.nb_id,
        C.kjmo
    FROM dbp_data.artbew_agg_wt_1 AS A
    INNER JOIN dbp_data.tag_1 AS B ON A.dat = B.dat
    INNER JOIN dbp_data.tag_1 AS C ON B.kjmo = C.kjmo
    GROUP BY
        A.mandant_id,
        A.wup_id,
        A.nb_id,
        C.dat,
        C.kjmo
);


DELETE FROM dbp_data.artbew_mo_sum_1
WHERE (
    mandant_id, wup_id, nb_id, kjmo) IN (
    SELECT (mandant_id, wup_id, nb_id, kjmo)
    FROM `_artbew_agg_monat`
)
AND (kjmo, mandant_id) IN (
    SELECT (kjmo, mandant_id)
    FROM `_artbew_agg_monat`
);


INSERT INTO dbp_data.artbew_mo_sum_1 (
    mandant_id, wup_id, nb_id, kjmo, gp_id, art_id, bewart_id, posten_id,
    bewart_det_id,
    ean_kasse,
    wrg_id,
    umrechnungskurs_hist,
    menge,
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
    herst_id,
    ek_netto_bnk,
    diff_ek_netto_bnk_konz,
    ek_netto_bnk_sachk,
    diff_ek_netto_bnk_sachk_konz,
    ek_gld,
    diff_ek_gld_konz,
    bonusbasis,
    bonusbasis_konz,
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
    aktionsart_id_liste_txt,
    aktionsart_bez_liste_txt,
    aktion_typ_id_liste_txt,
    aktion_typ_bez_liste_txt
)
(
    SELECT
        A.mandant_id,
        A.wup_id,
        A.nb_id,
        B.kjmo,
        A.gp_id,
        A.art_id,
        A.bewart_id,
        A.posten_id,
        A.bewart_det_id,
        A.ean_kasse,
        A.wrg_1,
        MAX(A.umrechnungskurs_hist),
        SUM(A.menge),
        SUM(A.umsatz_netto),
        SUM(A.diff_umsatz_netto_konz),
        SUM(A.umsatz_mwst_betrag),
        SUM(A.diff_umsatz_mwst_betrag_konz),
        SUM(CAST(A.ek_brutto AS NUMERIC)),
        SUM(CAST(A.diff_ek_brutto_konz AS NUMERIC)),
        SUM(CAST(A.ek_netto AS NUMERIC)),
        SUM(CAST(A.diff_ek_netto_konz AS NUMERIC)),
        SUM(CAST(A.ek_nettonetto AS NUMERIC)),
        SUM(CAST(A.diff_ek_nettonetto_konz AS NUMERIC)),
        SUM(CAST(A.ek_kal_basis AS NUMERIC)),
        SUM(CAST(A.diff_ek_kal_basis_konz AS NUMERIC)),
        SUM(CAST(A.ek_mep AS NUMERIC)),
        SUM(CAST(A.diff_ek_mep_konz AS NUMERIC)),
        SUM(A.ek_mep_vor_fwu),
        SUM(A.ek_mep_vor_fwu_konz),
        SUM(CAST(A.einstandspreis AS NUMERIC)),
        SUM(CAST(A.diff_einstandspreis_konz AS NUMERIC)),
        SUM(A.logkostenzuschlag),
        SUM(A.diff_logkostenzuschlag_konz),
        MAX(A.herst_id),
        SUM(CAST(A.ek_netto_bnk AS NUMERIC)),
        SUM(CAST(A.diff_ek_netto_bnk_konz AS NUMERIC)),
        SUM(CAST(A.ek_netto_bnk_sachk AS NUMERIC)),
        SUM(CAST(A.diff_ek_netto_bnk_sachk_konz AS NUMERIC)),
        SUM(A.ek_gld),
        SUM(A.diff_ek_gld_konz),
        SUM(A.bonusbasis),
        SUM(A.bonusbasis_konz),
        SUM(A.pv_aktion),
        SUM(A.pv_aktion_konz),
        SUM(A.pv_bby),
        SUM(A.pv_bby_konz),
        SUM(A.pv_kdn_bby),
        SUM(A.pv_kdn_bby_konz),
        SUM(A.pv_kdp_bby),
        SUM(A.pv_kdp_bby_konz),
        SUM(A.pv_aktion_bby),
        SUM(A.pv_aktion_bby_konz),
        SUM(A.pv_aktion_kdn_bby),
        SUM(A.pv_aktion_kdn_bby_konz),
        SUM(A.pv_aktion_kdp_bby),
        SUM(A.pv_aktion_kdp_bby_konz),
        SUM(A.pv_bonrabatt_bby),
        SUM(A.pv_bonrabatt_bby_konz),
        A.aktionsart_id_liste_txt,
        A.aktionsart_bez_liste_txt,
        A.aktion_typ_id_liste_txt,
        A.aktion_typ_bez_liste_txt
    FROM dbp_data.artbew_1 AS A
    INNER JOIN `_artbew_agg_monat` AS B
        ON
            A.mandant_id = B.mandant_id
            AND A.wup_id = B.wup_id
            AND A.nb_id = B.nb_id
            AND A
            .dat = B.dat
    GROUP BY
        A.art_id,
        A.wup_id,
        A.nb_id,
        B.kjmo,
        A.mandant_id,
        A.bewart_id,
        A.bewart_det_id,
        A.gp_id,
        A.posten_id,
        A.wrg_1,
        A.ean_kasse,
        A.aktionsart_id_liste_txt,
        A.aktionsart_bez_liste_txt,
        A.aktion_typ_id_liste_txt,
        A.aktion_typ_bez_liste_txt
);
