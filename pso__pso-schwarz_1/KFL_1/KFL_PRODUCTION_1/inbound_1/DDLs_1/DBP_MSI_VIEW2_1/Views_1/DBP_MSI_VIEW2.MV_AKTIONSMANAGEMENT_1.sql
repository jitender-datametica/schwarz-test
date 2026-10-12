CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_AKTIONSMANAGEMENT_1
-- Init 20200429 SPEC0074259
-- sanadze: 20210219 SPEC0074259 Dopplungen von Datensaetzen durch Subselect und max(avq) vermeiden
-- sanadze: 20210317 max(avq) durch max(umsatz_netto) ersetzen
-- lsvi0303: AP0107120,SPEC0160226
-- staeblern: 20240326 AP0212516 SPEC0243103 Bonrabattspalten entfernen 
AS
SELECT

 v01.mandant_id
 , v01.kjwo_ww
 , v01.kjwo
 , v01.mutter_wb_id
 , v01.konkat_kind_art_id
 , v01.konkat_aktion_thema_gruppe_id
 , v01.konkat_werbe_kat_id
 , v01.konkat_werbeteam_cd
 , v01.konkat_werbeteam_bez
 , v01.gp_id
 , v01.werbebereich_cd
 , v01.konkat_wg_id
 , v01.umsatz_netto_sa_west
 , v01.absatz_sa_west
 , v01.ek_mep_sa_west
 , v01.rohertrag_ek_mep_olk_sa_west
 , v01.spanne_ek_mep_olk_sa_west
 , v01.preisvorteil_west
 , v01.umsatz_netto_sa_ost
 , v01.absatz_sa_ost
 , v01.ek_mep_sa_ost
 , v01.rohertrag_ek_mep_olk_sa_ost
 , v01.spanne_ek_mep_olk_sa_ost
 , v01.preisvorteil_ost
 , v01.umsatz_netto_sa_sued
 , v01.absatz_sa_sued
 , v01.ek_mep_sa_sued
 , v01.rohertrag_ek_mep_olk_sa_sued
 , v01.spanne_ek_mep_olk_sa_sued
 , v01.preisvorteil_sued
 , v01.umsatz_netto_sa
 , v01.absatz_sa
 , v01.ek_mep_sa
 , v01.rohertrag_sa
 , v01.spanne_sa
 , v01.preisvorteil
 , v01.avq_1
 , v01.avq_3
 , v01.avq
 , v01.wareneingang_zl
 , v01.abverkaufte_menge_bestand
 , v01.abverkaufte_menge
 , v01.durchschnitt_menge_pro_filiale
 , v01.einheit_wb
 , v01.umsatz_netto
 , v01.durchschnitt_umsatz_pro_artike
 , v01.anz_nullbestand
 , v01.nullbestandsquote
 , v01.endbestand
 , v01.umschlagsquote
 , v01.anz_artikel
 , v01.anz_filialen
 , v01.umsatz_baseline
 , v01.umsatz_werbewoche
 , v01.umsatz_uplift
 , v01.umsatz_aktivierter_normalpreis
 , v01.absatz_baseline
 , v01.absatz_werbewoche
 , v01.absatz_uplift
 , v01.ertrag_baseline
 , v01.ertrag_werbewoche
 , v01.ertrag_uplift
 , v01.kaeufer_baseline
 , v01.kaeufer_werbewoche
 , v01.kaeufer_uplift
 , v01.kaeufer_reichweite_baseline
 , v01.kaeufer_reichweite_werbewoche
 , v01.kaeufer_reichweite_uplift
 , v01.cherrypicker_pp
 , v01.restbon_normalware
 , v01.restbon_gesamt
 , v01.restbon_tip
 , v01.anz_tage_sa
 , v01.anz_markt_sa
 , v01.baseline_wochen
  --AP0107120,SPEC0160226
 , v01.wa_kalk_nach_pv_sa
 , v01.wa_kalk_nach_pv_sa_sued
 , v01.wa_kalk_nach_pv_sa_ost
 , v01.wa_kalk_nach_pv_sa_west
 , v01.spanne_wa_kalk_nach_pv_sa
 , v01.spanne_wa_kalk_nach_pv_sa_sued
 , v01.spanne_wa_kalk_nach_pv_sa_ost
 , v01.spanne_wa_kalk_nach_pv_sa_west
 , v01.wa_kalk_nach_pv_sa_loy
 , v01.wa_kalk_nach_pv_sa_aktion_loy
 , v01.wa_kalk_nach_pv_sa_bby_loy
 , v01.wa_kalk_nach_pv_sa_kdn_bby_loy
 , v01.wa_kalk_nach_pv_sa_kdp_bby_loy
 , v01.wa_kalk_nach_pv_sa_non_loy
 , v01.wa_kalk_nach_pv_sa_aktion_non_loy
 , v01.wa_kalk_nach_pv_sa_bby_non_loy
 , v01.spanne_wa_kalk_nach_pv_sa_loy
 , v01.spanne_wa_kalk_nach_pv_sa_aktion_loy
 , v01.spanne_wa_kalk_nach_pv_sa_bby_loy
 , v01.spanne_wa_kalk_nach_pv_sa_kdn_bby_loy
 , v01.spanne_wa_kalk_nach_pv_sa_kdp_bby_loy
 , v01.spanne_wa_kalk_nach_pv_sa_non_loy
 , v01.spanne_wa_kalk_nach_pv_sa_aktion_non_loy
 , v01.spanne_wa_kalk_nach_pv_sa_bby_non_loy
 , v01.umsatz_netto_sa_aktion_non_loy
 , v01.umsatz_netto_sa_bby_non_loy
 , v01.umsatz_netto_sa_aktion_loy
 , v01.umsatz_netto_sa_bby_loy
 , v01.umsatz_netto_sa_kdn_bby_loy
 , v01.umsatz_netto_sa_kdp_bby_loy
 , v01.menge_sa_aktion_non_loy
 , v01.menge_sa_bby_non_loy
 , v01.menge_sa_aktion_loy
 , v01.menge_sa_bby_loy
 , v01.menge_sa_kdn_bby_loy
 , v01.menge_sa_kdp_bby_loy
 , v01.pv_aktion_loy
 , v01.pv_bby_loy
 , v01.pv_kdn_bby
 , v01.pv_kdp_bby
 , v01.pv_aktion_non_loy
 , v01.pv_bby_non_loy

FROM dbp_view.v_aktionsmanagement_1 v01
INNER JOIN 
 (SELECT  DISTINCT 
 mandant_id 
 ,kjwo_ww 
 ,kjwo 
 ,mutter_wb_id 
 ,konkat_kind_art_id 
 ,konkat_aktion_thema_gruppe_id 
 ,konkat_werbe_kat_id 
 ,gp_id 
 ,konkat_wg_id 
 ,MAX(umsatz_netto) AS max_umsatz_netto
 FROM dbp_view.v_aktionsmanagement_1
 GROUP BY 
 mandant_id 
 ,kjwo_ww 
 ,kjwo 
 ,mutter_wb_id 
 ,konkat_kind_art_id 
 ,konkat_aktion_thema_gruppe_id 
 ,konkat_werbe_kat_id 
 ,gp_id 
 ,konkat_wg_id) AS s
ON s.mandant_id=v01.mandant_id
AND s.kjwo_ww=v01.kjwo_ww
AND s.kjwo=v01.kjwo
AND s.mutter_wb_id=v01.mutter_wb_id
AND s.konkat_kind_art_id=v01.konkat_kind_art_id
AND s.konkat_aktion_thema_gruppe_id=v01.konkat_aktion_thema_gruppe_id
AND s.konkat_werbe_kat_id=v01.konkat_werbe_kat_id
AND s.gp_id=v01.gp_id
AND s.konkat_wg_id=v01.konkat_wg_id
AND s.konkat_wg_id=v01.konkat_wg_id
WHERE s.max_umsatz_netto=v01.umsatz_netto OR v01.umsatz_netto IS NULL;