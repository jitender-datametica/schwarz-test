DELETE FROM dbp_data.artbew_wg_tp2_sum
WHERE (
    mandant_id, wup_id, dat) IN (
    SELECT (a.mandant_id, a.wup_id, T.dat)
    FROM (
        SELECT
            mandant_id,
            wup_id,
            MAX(dat) AS dat_max,
            MIN(dat) AS dat_min
        FROM dbp_data.artbew_agg_wt
        GROUP BY
            mandant_id,
            wup_id
    ) AS a
    INNER JOIN dbp_data.tag AS T ON T.dat BETWEEN a.dat_min AND a.dat_max
);


INSERT INTO dbp_data.artbew_wg_tp2_sum (
    mandant_id, dat, wg_id, wup_id, nb_id, arthiertyp_id, bewart_id,
    posten_id, menge, menge_ohne_wg_erf_art, umsatz_netto, diff_umsatz_netto_konz, umsatz_mwst_betrag,
    diff_umsatz_mwst_betrag_konz, ek_brutto, diff_ek_brutto_konz, ek_netto, diff_ek_netto_konz, ek_nettonetto,
    diff_ek_nettonetto_konz, ek_kal_basis, diff_ek_kal_basis_konz, ek_mep, diff_ek_mep_konz, einstandspreis,
    diff_einstandspreis_konz, logkostenzuschlag, diff_logkostenzuschlag_konz, ek_netto_bnk, diff_ek_netto_bnk_konz,
    ek_netto_bnk_sachk, diff_ek_netto_bnk_sachk_konz, diff_ek_gld_konz, ek_gld, bewart_det_id, pv_aktion, pv_bby,
    pv_kdn_bby, pv_kdp_bby, pv_aktion_bby, pv_aktion_kdn_bby, pv_aktion_kdp_bby, wrg_id, ek_mep_vor_fwu,
    ek_mep_vor_fwu_konz, bonusbasis, bonusbasis_konz, pv_bonrabatt_bby, wup_bereinigt_fg, pv_aktion_konz, pv_bby_konz,
    pv_kdn_bby_konz, pv_kdp_bby_konz, pv_aktion_bby_konz, pv_aktion_kdn_bby_konz, pv_aktion_kdp_bby_konz,
    pv_bonrabatt_bby_konz, umrechnungskurs_hist, aktionsart_id_liste_txt, aktionsart_bez_liste_txt, aktion_typ_id_liste_txt,
    aktion_typ_bez_liste_txt
)
(
    SELECT
        AB.mandant_id,
        AB.dat,
        A.wg_id AS wg_id,
        AB.wup_id,
        AB.nb_id,
        A.arthiertyp_id AS arthiertyp_id,
        AB.bewart_id,
        AB.posten_id,
        SUM(AB.menge),
        SUM(CASE
            WHEN ART.wg_art_fg = 0
                THEN AB.menge
            ELSE 0
        END) AS menge_ohne_wg_erf_art,
        SUM(AB.umsatz_netto),
        SUM(AB.diff_umsatz_netto_konz),
        SUM(AB.umsatz_mwst_betrag),
        SUM(AB.diff_umsatz_mwst_betrag_konz),
        SUM(CAST(AB.ek_brutto AS NUMERIC)),
        SUM(CAST(AB.diff_ek_brutto_konz AS NUMERIC)),
        SUM(CAST(AB.ek_netto AS NUMERIC)),
        SUM(CAST(AB.diff_ek_netto_konz AS NUMERIC)),
        SUM(CAST(AB.ek_nettonetto AS NUMERIC)),
        SUM(CAST(AB.diff_ek_nettonetto_konz AS NUMERIC)),
        SUM(CAST(AB.ek_kal_basis AS NUMERIC)),
        SUM(CAST(AB.diff_ek_kal_basis_konz AS NUMERIC)),
        SUM(CAST(AB.ek_mep AS NUMERIC)),
        SUM(CAST(AB.diff_ek_mep_konz AS NUMERIC)),
        SUM(CAST(AB.einstandspreis AS NUMERIC)),
        SUM(CAST(AB.diff_einstandspreis_konz AS NUMERIC)),
        SUM(AB.logkostenzuschlag),
        SUM(AB.diff_logkostenzuschlag_konz),
        SUM(CAST(AB.ek_netto_bnk AS NUMERIC)),
        SUM(CAST(AB.diff_ek_netto_bnk_konz AS NUMERIC)),
        SUM(CAST(AB.ek_netto_bnk_sachk AS NUMERIC)),
        SUM(CAST(AB.diff_ek_netto_bnk_sachk_konz AS NUMERIC)),
        SUM(AB.diff_ek_gld_konz),
        SUM(AB.ek_gld),
        AB.bewart_det_id,
        SUM(AB.pv_aktion),
        SUM(AB.pv_bby),
        SUM(AB.pv_kdn_bby),
        SUM(AB.pv_kdp_bby),
        SUM(AB.pv_aktion_bby),
        SUM(AB.pv_aktion_kdn_bby),
        SUM(AB.pv_aktion_kdp_bby),
        AB.wrg,
        SUM(AB.ek_mep_vor_fwu),
        SUM(AB.ek_mep_vor_fwu_konz),
        SUM(AB.bonusbasis),
        SUM(AB.bonusbasis_konz),
        SUM(AB.pv_bonrabatt_bby),
        AB.wup_bereinigt_fg,
        SUM(AB.pv_aktion_konz),
        SUM(AB.pv_bby_konz),
        SUM(AB.pv_kdn_bby_konz),
        SUM(AB.pv_kdp_bby_konz),
        SUM(AB.pv_aktion_bby_konz),
        SUM(AB.pv_aktion_kdn_bby_konz),
        SUM(AB.pv_aktion_kdp_bby_konz),
        SUM(AB.pv_bonrabatt_bby_konz),
        MAX(AB.umrechnungskurs_hist),
        AB.aktionsart_id_liste_txt,
        AB.aktionsart_bez_liste_txt,
        AB.aktion_typ_id_liste_txt,
        AB.aktion_typ_bez_liste_txt
    FROM dbp_data.artbew AS AB
    INNER JOIN (
        SELECT
            a.mandant_id,
            a.wup_id,
            T.dat
        FROM (
            SELECT
                mandant_id,
                wup_id,
                MAX(dat) AS dat_max,
                MIN(dat) AS dat_min
            FROM dbp_data.artbew_agg_wt
            GROUP BY
                mandant_id,
                wup_id
        ) AS a
        INNER JOIN dbp_data.tag AS T ON T.dat BETWEEN a.dat_min AND a.dat_max
        GROUP BY
            a.mandant_id,
            a.wup_id,
            T.dat
    ) AS x ON AB.mandant_id = x.mandant_id AND AB.wup_id = x.wup_id AND AB.dat = x.dat
    INNER JOIN dbp_data.art AS ART
        ON AB.art_id = ART.art_id AND AB.mandant_id = ART.mandant_id AND CASE
            WHEN
                AB.mandant_id = 2 AND AB.art_id = 208124500 OR AB.mandant_id = 3 AND AB.art_id = 208113690 OR AB.mandant_id =
                5 AND AB.art_id = 206731500 OR AB.mandant_id = 6 AND AB.art_id = 208131570 OR AB.mandant_id IN (4, 7) AND AB.art_id = 208114740 OR AB.mandant_id = 8 AND AB.art_id = 208131640
                THEN 0
            ELSE 1
        END = 1
    INNER JOIN dbp_data.art_wg_zu_per AS A
        ON
            AB.art_id = A.art_id AND AB.mandant_id = A.mandant_id AND A.dat_bis
            = DATE '9999-12-31' AND A.arthiertyp_id = 2
    GROUP BY
        AB.mandant_id,
        AB.wup_id,
        AB.nb_id,
        AB.dat,
        AB.bewart_id,
        AB.wrg,
        AB.posten_id,
        AB.bewart_det_id,
        AB.wup_bereinigt_fg,
        AB.aktionsart_id_liste_txt,
        AB.aktionsart_bez_liste_txt,
        AB.aktion_typ_id_liste_txt,
        AB.aktion_typ_bez_liste_txt,
        A.arthiertyp_id,
        A.wg_id
);
