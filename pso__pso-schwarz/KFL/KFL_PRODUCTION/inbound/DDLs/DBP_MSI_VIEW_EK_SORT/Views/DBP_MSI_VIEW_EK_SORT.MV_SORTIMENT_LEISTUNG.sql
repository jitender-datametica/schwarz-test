CREATE OR REPLACE VIEW DBP_MSI_VIEW_EK_SORT.MV_SORTIMENT_LEISTUNG as
   SELECT
   v01.mandant_id, kjmo, matching_id, kjwo_update, v01.wrg_id, owg_id, wg_id, wug_id, rang_umsatz_wg, rang_umsatz_uwg, rang_absatz_uwg, art_id, kl_art_id, art_bez, art_status, gp_id, akt_lieferant, zek_id, disc_pe, disc_marke, lcf, vegan, gluten, bio, eigenmarke, tierwohl, posten_food, posten_nonfood, mwst, listung_k_sst_mvke, ost_basis, ost_gross, sued_ost, sued_west, west, nord, gewichtete_distribution, index_af_id, umsatz_af_pro_markt_woche, absatz_af_pro_markt_woche, ertrag_af_pro_markt_woche, bonreichweite_af, spanne_af, index_sa_id, umsatz_sa_pro_markt_woche, absatz_sa_pro_markt_woche, ertrag_sa_pro_markt_woche, bonreichweite_sa, spanne_sa, aktionsanteil_absatz, absatz_total, schnelldreherquote, schnelldreherquote_wg, schnelldreherquote_owg, kolliabverkaufsquote, kolliabverkaufsquote_wg, kolliabverkaufsquote_owg, abschriftsanteil, abschriftsanteil_wg, 
   abschriftsanteil_owg, cherrypicker_quote, cherrypicker_quote_wg, cherrypicker_quote_owg, restbon, restbon_wg, restbon_owg, vk_preis, durchschnittspreis, preislagenverteilung, 
   marktanteilbewertung, produktwissen_vp, lieferantenwissen_vp, produktwissen_pflege, lieferantenwissen_pflege, Coalesce(listung_sst_pflege,' ') AS listung_sst_pflege, ost_basis_pflege, 
   ost_gross_pflege, sued_ost_pflege, sued_west_pflege, west_pflege, nord_pflege, vorschlag, stk_re_pflege, umsatz_hr, absatz_hr, rohertrag_hr, nielsen_art_bez, gtin, distr_gew, umsatz_anteil_uwg, 
   umsatz_anteil_uwg_kumuliert, durchschnitt_anz_maerkte, durchschnitt_preis, kl_markt_anteil_owg, umsatz_artikel, absatz_artikel, anz_monate, anz_wochen, eigenmarke_fg, listung_sst_mvke, anz_maerkte_sst, 
   anz_maerkte_baustein_sonstige, anz_maerkte_listung_einzel, anz_maerkte_listung_gesamt, listungsaktion, anz_maerkte_k_sst, listung_k_sst_pflege, muki_wb_kz, muki_wb_kl_art_id_verkettung, muki_vk_kz, 
   muki_vk_kl_art_id_verkettung, muki_ek_kz, muki_ek_kl_art_id_verkettung, absatz_total_vj, max_anz_maerkte_sst, max_anz_maerkte_k_sst
   , kassenumsatz_kl_absolut_brutto
, kassenumsatz_kl_absolut_netto
, abschriften_wert_netto_absolut
   FROM dbp_view.v_sortiment_leistung v01;