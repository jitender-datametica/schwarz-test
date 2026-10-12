CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_kun.mv_cos_bonuskauf_tag_sum_2 (mandant_id, bonuskauf_id,
kampagnen_id, coupon_typ, aktions_typ, dat, anz_zielgruppengroesse, ausgespielter_kanal, anz_punkte_zu_zahlend,
anz_aktivierungen_kaufbar, anz_aktivierungen_nicht_kaufbar, anz_aktivierungen, rate_aktivierungsquote,
anz_einloesungen_kaufbar, anz_einloesungen_nicht_kaufbar, anz_einloesungen, rate_einloesequote,
anz_gesamt_punkte_einloesungen, anz_unique_kunden, betrag_bonuskauf_umsatz_brutto, betrag_bonuskauf_umsatz_netto,
menge_promo) AS SELECT v01.mandant_id,
 v01.bonuskauf_id,
 v01.kampagnen_id_liste_txt AS kampagnen_id,
 v01.coupon_typ_name AS coupon_typ,
 v01.aktion_typ_name AS aktions_typ,
 v01.dat,
 v01.anz_zielgruppengroesse,
 v01.kanal_liste_txt AS ausgespielter_kanal,
 v01.anz_punkte_coupon_benoetigt AS anz_punkte_zu_zahlend,
 v01.anz_aktivierungen_kaufbar,
 v01.anz_aktivierungen_nicht_kaufbar,
 v01.anz_gesamt_aktivierungen AS anz_aktivierungen,
 v01.rate_aktivierungsquote,
 v01.anz_einloesungen_kaufbar,
 v01.anz_einloesungen_nicht_kaufbar,
 v01.anz_gesamt_einloesungen AS anz_einloesungen,
 v01.rate_einloesequote,
 v01.anz_gesamt_punkte_einloesungen,
 v01.anz_unique_kunden -- ,BETRAG_BONUSKAUF_UMSATZ_NETTO_KONZ
 -- ,BETRAG_BONUSKAUF_UMSATZ_BRUTTO_KONZ

 -- ,BETRAG_BONUSKAUF_UMSATZ_NETTO
 -- ,BETRAG_BONUSKAUF_UMSATZ_BRUTTO
,
  CASE
  WHEN v02.wrg_typ_id = 0 AND v01.mandant_id > 1
  THEN CAST(v01.betrag_bonuskauf_umsatz_brutto_konz AS NUMERIC)
  ELSE CAST(v01.betrag_bonuskauf_umsatz_brutto AS NUMERIC)
  END AS betrag_bonuskauf_umsatz_brutto,
  CASE
  WHEN v02.wrg_typ_id = 0 AND v01.mandant_id > 1
  THEN CAST(v01.betrag_bonuskauf_umsatz_netto_konz AS NUMERIC)
  ELSE CAST(v01.betrag_bonuskauf_umsatz_netto AS NUMERIC)
  END AS betrag_bonuskauf_umsatz_netto,
 v01.menge_bonuskauf_bme AS menge_promo
FROM kfl_production_dbp_msi_v_view.v_cos_bonuskauf_tag_sum_2 AS v01
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_wrg_typ_zu_2 AS v02 ON TRUE;