CREATE OR REPLACE TEMPORARY TABLE _artbew_agg_woche (
    dat DATE NOT NULL,
    mandant_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    nb_id INTEGER NOT NULL,
    kjwo_kl INTEGER NOT NULL
);


INSERT INTO `_artbew_agg_woche` (dat, mandant_id, wup_id, nb_id, kjwo_kl)
(
    SELECT
        C.dat,
        A.mandant_id AS mandant_id,
        A.wup_id AS wup_id,
        A.nb_id AS nb_id,
        C.kjwo_kl AS kjwo_kl
    FROM dbp_data.artbew_agg_wt_1 AS A
    INNER JOIN dbp_data.tag_1 AS B ON A.dat = B.dat
    INNER JOIN dbp_data.tag_1 AS C ON B.kjwo_kl = C.kjwo_kl
    GROUP BY
        C.dat,
        mandant_id,
        wup_id,
        nb_id,
        kjwo_kl
);


DELETE FROM dbp_data.artbew_wo_sum_1
WHERE (
    mandant_id, wup_id, nb_id, kjwo_kl) IN (SELECT (mandant_id, wup_id, nb_id, kjwo_kl)
FROM `_artbew_agg_woche`) AND (kjwo_kl, mandant_id) IN (
    SELECT (kjwo_kl, mandant_id)
    FROM `_artbew_agg_woche`
);


INSERT INTO dbp_data.artbew_wo_sum_1 (
    mandant_id, wup_id, nb_id, kjwo_kl, bewart_id, gp_id, art_id,
    aktion_id, bezugsweg_id, ean_kasse, bewart_det_id, posten_id, standard_aktion_id, menge, umsatz_netto,
    diff_umsatz_netto_konz, umsatz_mwst_betrag, diff_umsatz_mwst_betrag_konz, ek_mep, ek_mep_vor_fwu, ek_mep_vor_fwu_konz,
    einstandspreis, diff_einstandspreis_konz, ek_nettonetto, diff_ek_nettonetto_konz, wrg_id, umrechnungskurs_hist,
    diff_ek_brutto_konz, diff_ek_gld_konz, diff_ek_kal_basis_konz, diff_ek_mep_konz, diff_ek_netto_bnk_konz,
    diff_ek_netto_bnk_sachk_konz, diff_ek_netto_konz, diff_logkostenzuschlag_konz, ek_brutto, ek_gld, ek_kal_basis,
    ek_netto, ek_netto_bnk, ek_netto_bnk_sachk, herst_id, logkostenzuschlag, promo_fg, bonusbasis, bonusbasis_konz,
    wup_bereinigt_fg, pv_aktion, pv_aktion_konz, pv_bby, pv_bby_konz, pv_kdn_bby, pv_kdn_bby_konz, pv_kdp_bby,
    pv_kdp_bby_konz, pv_aktion_bby, pv_aktion_bby_konz, pv_aktion_kdn_bby, pv_aktion_kdn_bby_konz, pv_aktion_kdp_bby,
    pv_aktion_kdp_bby_konz, pv_bonrabatt_bby, pv_bonrabatt_bby_konz, aktionsart_id_liste_txt, aktionsart_bez_liste_txt,
    aktion_typ_id_liste_txt, aktion_typ_bez_liste_txt
)
(
    SELECT
        A.mandant_id,
        A.wup_id,
        A.nb_id,
        B.kjwo_kl,
        A.bewart_id,
        A.gp_id,
        A.art_id,
        A.aktion_id,
        COALESCE(A.bezugsweg_id, -1) AS bezugsweg_id,
        A.ean_kasse,
        A.bewart_det_id,
        A.posten_id,
        A.standard_aktion_id,
        SUM(COALESCE(A.menge, 0)) AS menge,
        SUM(COALESCE(A.umsatz_netto, 0)) AS umsatz_netto,
        SUM(COALESCE(A.diff_umsatz_netto_konz, 0)) AS diff_umsatz_netto_konz,
        SUM(COALESCE(A.umsatz_mwst_betrag, 0)) AS umsatz_mwst_betrag,
        SUM(COALESCE(A.diff_umsatz_mwst_betrag_konz, 0)) AS diff_umsatz_mwst_betrag_konz,
        SUM(COALESCE(CAST(A.ek_mep AS NUMERIC), 0)) AS ek_mep,
        SUM(COALESCE(A.ek_mep_vor_fwu, 0)),
        SUM(COALESCE(A.ek_mep_vor_fwu_konz, 0)),
        SUM(COALESCE(CAST(A.einstandspreis AS NUMERIC), 0)) AS einstandspreis,
        SUM(COALESCE(CAST(A.diff_einstandspreis_konz AS NUMERIC), 0)) AS diff_einstandspreis_konz,
        SUM(COALESCE(CAST(A.ek_nettonetto AS NUMERIC), 0)) AS ek_nettonetto,
        SUM(COALESCE(CAST(A.diff_ek_nettonetto_konz AS NUMERIC), 0)) AS diff_ek_nettonetto_konz,
        COALESCE(A.wrg_1, C.default_wrg) AS wrg_id,
        MAX(A.umrechnungskurs_hist),
        SUM(COALESCE(A.diff_ek_brutto_konz, 0)),
        SUM(COALESCE(A.diff_ek_gld_konz, 0)),
        SUM(COALESCE(A.diff_ek_kal_basis_konz, 0)),
        SUM(COALESCE(A.diff_ek_mep_konz, 0)),
        SUM(COALESCE(A.diff_ek_netto_bnk_konz, 0)),
        SUM(COALESCE(A.diff_ek_netto_bnk_sachk_konz, 0)),
        SUM(COALESCE(A.diff_ek_netto_konz, 0)),
        SUM(COALESCE(A.diff_logkostenzuschlag_konz, 0)),
        SUM(COALESCE(A.ek_brutto, 0)),
        SUM(COALESCE(A.ek_gld, 0)),
        SUM(COALESCE(A.ek_kal_basis, 0)),
        SUM(COALESCE(A.ek_netto, 0)),
        SUM(COALESCE(A.ek_netto_bnk, 0)),
        SUM(COALESCE(A.ek_netto_bnk_sachk, 0)),
        MAX(A.herst_id) AS herst_id,
        SUM(COALESCE(A.logkostenzuschlag, 0)),
        A.promo_fg,
        SUM(COALESCE(A.bonusbasis, 0)),
        SUM(COALESCE(A.bonusbasis_konz, 0)),
        A.wup_bereinigt_fg,
        SUM(COALESCE(A.pv_aktion, 0)) AS pv_aktion,
        SUM(COALESCE(A.pv_aktion_konz, 0)),
        SUM(COALESCE(A.pv_bby, 0)) AS pv_bby,
        SUM(COALESCE(A.pv_bby_konz, 0)),
        SUM(COALESCE(A.pv_kdn_bby, 0)) AS pv_kdn_bby,
        SUM(COALESCE(A.pv_kdn_bby_konz, 0)),
        SUM(COALESCE(A.pv_kdp_bby, 0)) AS pv_kdp_bby,
        SUM(COALESCE(A.pv_kdp_bby_konz, 0)),
        SUM(COALESCE(A.pv_aktion_bby, 0)) AS pv_aktion_bby,
        SUM(COALESCE(A.pv_aktion_bby_konz, 0)),
        SUM(COALESCE(A.pv_aktion_kdn_bby, 0)) AS pv_aktion_kdn_bby,
        SUM(COALESCE(A.pv_aktion_kdn_bby_konz, 0)),
        SUM(COALESCE(A.pv_aktion_kdp_bby, 0)) AS pv_aktion_kdp_bby,
        SUM(COALESCE(A.pv_aktion_kdp_bby_konz, 0)),
        SUM(COALESCE(A.pv_bonrabatt_bby, 0)),
        SUM(COALESCE(A.pv_bonrabatt_bby_konz, 0)),
        A.aktionsart_id_liste_txt,
        A.aktionsart_bez_liste_txt,
        A.aktion_typ_id_liste_txt,
        A.aktion_typ_bez_liste_txt
    FROM dbp_data.artbew_1 AS A
    INNER JOIN `_artbew_agg_woche` AS B
        ON
            A.mandant_id = B.mandant_id AND A.wup_id = B.wup_id AND A.nb_id = B.nb_id AND A.dat = B.dat
    LEFT JOIN dbp_data.mandant_1 AS C ON A.mandant_id = C.mandant_id
    GROUP BY
        B.kjwo_kl,
        A.mandant_id,
        A.wup_id,
        A.nb_id,
        A.art_id,
        A.bewart_id,
        A.ean_kasse,
        A.promo_fg,
        A.posten_id,
        A.gp_id,
        A.aktion_id,
        A.standard_aktion_id,
        bezugsweg_id,
        wrg_id,
        A.bewart_det_id,
        A.wup_bereinigt_fg,
        A.aktionsart_id_liste_txt,
        A.aktionsart_bez_liste_txt,
        A.aktion_typ_id_liste_txt,
        A.aktion_typ_bez_liste_txt
);


INSERT INTO dbp_etl_process.ekc_artbew_agg_wt_1 (mandant_id, wup_id, nb_id, dat)
(
    SELECT
        mandant_id AS mandant_id,
        wup_id,
        nb_id,
        dat
    FROM dbp_data.artbew_agg_wt_1
    WHERE (mandant_id, wup_id, nb_id, dat) NOT IN (SELECT (
        mandant_id, wup_id, nb_id,
        dat
    )
    FROM dbp_etl_process.ekc_artbew_agg_wt_1)
    GROUP BY
        mandant_id,
        wup_id,
        nb_id,
        dat
);


TRUNCATE TABLE dbp_data.artbew_agg_wt_1;
