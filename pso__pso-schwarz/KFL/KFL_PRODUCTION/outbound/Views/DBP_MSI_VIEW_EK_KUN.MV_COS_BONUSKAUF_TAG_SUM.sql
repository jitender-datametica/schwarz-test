CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_kun.mv_cos_bonuskauf_tag_sum (mandant_id, bonuskauf_id,
kampagnen_id, coupon_typ, aktions_typ, dat, anz_zielgruppengroesse, ausgespielter_kanal, anz_punkte_zu_zahlend,
anz_aktivierungen_kaufbar, anz_aktivierungen_nicht_kaufbar, anz_aktivierungen, rate_aktivierungsquote,
anz_einloesungen_kaufbar, anz_einloesungen_nicht_kaufbar, anz_einloesungen, rate_einloesequote,
anz_gesamt_punkte_einloesungen, anz_unique_kunden, betrag_bonuskauf_umsatz_brutto, betrag_bonuskauf_umsatz_netto,
menge_promo) AS SELECT V01.mandant_id,
 V01.bonuskauf_id,
 V01.kampagnen_id_liste_txt AS kampagnen_id,
 V01.coupon_typ_name AS coupon_typ,
 V01.aktion_typ_name AS aktions_typ,
 V01.dat,
 V01.anz_zielgruppengroesse,
 V01.kanal_liste_txt AS ausgespielter_kanal,
 V01.anz_punkte_coupon_benoetigt AS anz_punkte_zu_zahlend,
 V01.anz_aktivierungen_kaufbar,
 V01.anz_aktivierungen_nicht_kaufbar,
 V01.anz_gesamt_aktivierungen AS anz_aktivierungen,
 V01.rate_aktivierungsquote,
 V01.anz_einloesungen_kaufbar,
 V01.anz_einloesungen_nicht_kaufbar,
 V01.anz_gesamt_einloesungen AS anz_einloesungen,
 V01.rate_einloesequote,
 V01.anz_gesamt_punkte_einloesungen,
 V01.anz_unique_kunden,
  CASE
  WHEN V02.wrg_typ_id = 0 AND V01.mandant_id > 1
  THEN CAST(V01.betrag_bonuskauf_umsatz_brutto_konz AS BIGNUMERIC)
  ELSE CAST(V01.betrag_bonuskauf_umsatz_brutto AS BIGNUMERIC)
  END AS betrag_bonuskauf_umsatz_brutto,
  CASE
  WHEN V02.wrg_typ_id = 0 AND V01.mandant_id > 1
  THEN CAST(V01.betrag_bonuskauf_umsatz_netto_konz AS BIGNUMERIC)
  ELSE CAST(V01.betrag_bonuskauf_umsatz_netto AS BIGNUMERIC)
  END AS betrag_bonuskauf_umsatz_netto,
 V01.menge_bonuskauf_bme AS menge_promo
FROM kfl_production_dbp_msi_v_view.v_cos_bonuskauf_tag_sum AS V01
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_wrg_typ_zu AS V02 ON TRUE;