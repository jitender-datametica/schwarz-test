CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_LAGERBEW_WBNK
 (
 mandant_id
 ,lagerbew_beleg_id
 ,lagerbew_beleg_pos_id
 ,kj
 ,lager_bewart_id
 ,art_id
 ,grund_id
 ,wup_id
 ,nb_id
 ,auto_fg
 ,lagerort_id
 ,gp_id
 ,einkaufsorganisation_id
 ,soll_haben_kz
 ,wrg_id
 ,best_beleg_id
 ,best_beleg_pos_id
 ,betrag_lagerbew
 ,betrag_verkauf
 ,erfsngs_menge_einh_id
 ,lagerplatz_id_id
 ,kunde_id
 ,menge_kolli
 ,menge_lagerbew
 ,menge_palette
 ,menge_lieferschein
 ,menge_lief
 ,menge_erf
 ,empfaenger_id
 ,dat_buch
 ,dat_beleg
 ,dat_erfasst
 ,system_id
 ,lagerbew_beleg_storno_id
 ,lagerbew_beleg_pos_storno_id
 ,lagerbew_beleg_storno_kj
 ,betrag_vk_netto
 ,wert_auslandsfracht
 ,wert_auslandsfracht2
 ,wert_zoll
 ,wert_antidump
 ,wert_inlandsfracht
 ,wert_gem_rueckn
 ,wert_duales_system
 ,wert_gema
 ,wert_verbrauchsst
 ,wert_verpackung
 ,wert_prov
 ,wert_hk_prov
 ,wert_agentur_prov
 ,wert_mto
 ,wert_pruefkosten
 ,wert_eu_regelung
 ,wert_sonst_kosten
 )
 AS
    SELECT
det.mandant_id,
    det.lagerbew_beleg_id,
    det.lagerbew_beleg_pos_id,
    det.kj,
    lager_bewart_id,
    det.art_id,
    grund_id,
    det.wup_id,
    det.nb_id,
    auto_fg,
    lagerort_id,
    det.gp_id,
    det.einkaufsorganisation_id,
    soll_haben_kz,
    wrg_id,
    best_beleg_id,
    best_beleg_pos_id,
    betrag_lagerbew,
    COALESCE(betrag_verkauf, betrag_lagerbew) AS betrag_verkauf,
    erfsngs_menge_einh_id,
    lagerplatz_id,
    kunde_id,
    menge_lagerbew_kolli,
    menge_lagerbew_bme,
    menge_lagerbew_palette,
    menge_lieferschein,
    menge_lief,
    menge_erf,
    empfaenger_id,
    det.dat_buch,
    lb.dat_beleg,
    lb.dat_erfasst,
    7 AS system_id,
    lagerbew_beleg_storno_id,
    lagerbew_beleg_pos_storno_id,
    lagerbew_beleg_storno_kj,
    betrag_vk_netto,
    (betrag_auslandsfracht *  menge_lagerbew_bme)  AS wert_auslandsfracht,
    (betrag_auslandsfracht2 *  menge_lagerbew_bme)  AS wert_auslandsfracht2,
    (betrag_zoll  *  menge_lagerbew_bme)   AS wert_zoll,
    (betrag_antidump *  menge_lagerbew_bme)   AS wert_antidump,
    (betrag_inlandsfracht *  menge_lagerbew_bme)  AS wert_inlandsfracht,
    (betrag_gem_rueckn *  menge_lagerbew_bme)  AS wert_gem_rueckn,
    (betrag_duales_system *  menge_lagerbew_bme)  AS wert_duales_system,
    (betrag_gema *  menge_lagerbew_bme)   AS wert_gema,
    (betrag_verbrauchsst *  menge_lagerbew_bme)  AS wert_verbrauchsst,
    (betrag_verpackung * menge_lagerbew_bme)  AS wert_verpackung,
    (betrag_prov *  menge_lagerbew_bme)   AS wert_prov,
    (betrag_hk_prov *  menge_lagerbew_bme)  AS wert_hk_prov,
    (betrag_agentur_prov *  menge_lagerbew_bme)  AS wert_agentur_prov,
    (betrag_mto *  menge_lagerbew_bme)   AS wert_mto,
    (betrag_pruefkosten *  menge_lagerbew_bme)  AS wert_pruefkosten,
    (betrag_eu_regelung *  menge_lagerbew_bme)  AS wert_eu_regelung,
    (betrag_sonst_kosten *  menge_lagerbew_bme)  AS wert_sonst_kosten
    FROM dbp_view.v_lagerbew_det det

    JOIN dbp_view.v_lagerbew lb
    ON lb.lagerbew_beleg_id = det.lagerbew_beleg_id
    AND lb.mandant_id = det.mandant_id
    AND lb.kj=det.kj
    AND lb.dat_buch = det.dat_buch

    JOIN dbp_view.v_art_gp_wup_bnk_zu_per agpwbzp
    ON det.art_id=agpwbzp.art_id
    AND det.gp_id=agpwbzp.gp_id
    AND det.einkaufsorganisation_id=agpwbzp.einkaufsorganisation_id
    AND det.wup_id=agpwbzp.wup_id
    AND det.mandant_id=agpwbzp.mandant_id
    AND det.nb_id=agpwbzp.nb_id
    AND det.dat_buch BETWEEN agpwbzp.dat_von AND agpwbzp.dat_bis

    WHERE det.mandant_id = 1;