CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_angebot_art_wup_zu (mandant_id, angebot_nr,
dat_angebot_gueltig_von, dat_angebot_gueltig_bis, kjwo_ww, angebot_name, angebot_beschreibung_txt, angebot_status_id,
angebot_typ_cd, anz_angebot_limit, geschaeftsvorfall_id, hauptangebot_fg, hauptangebot_nr, bonuskauf_fg, bonuskauf_id,
konditionsart_id, aktion_id, bewart_id, aktion_typ_id, markt_version_txt, anz_market_version, transfer_status_id,
akzeptiert_fg, angebot_geloescht_fg, art_id, wup_id, nb_id, verkaufsorganisation_id, art_basismenge_einh_id, art_typ_cd
, art_gtin_id, mutter_wb_id, art_posten_fg, art_prio_nr, art_theken_verkauf_fg, art_nis_fg, art_national_fg,
art_export_werbemittel_fg, art_preisangabe_cd, art_werbe_prod_gruppe_name, gp_id, opv_markt_fg, opv_prospekt_fg,
anz_bonuskauf_bezahlt, anz_bonuskauf_kauf, anz_bonuskauf_gratis, proz_bonuskauf_rabatt, betrag_bonuskauf_rabatt,
betrag_bonuskauf_min, menge_bonuskauf_min, bonuskauf_bedingung_id, bonuskauf_dimension_id, bonuskauf_produktvariante_id
, bonuskauf_rabattzuordnung_id, wrg_id, rabatt_typ_id, preis_vk_brutto, preis_vk_brutto_aktion,
preis_vk_brutto_normalisiert, preis_vk_brutto_stk, preis_vk_brutto_aktion_stk, proz_preisnachlass, menge_prog_scm,
menge_prog_am, betrag_prog_rohertrag_scm, betrag_prog_pv, betrag_prog_umsatz_am, betrag_prog_umsatz_scm,
preis_ek_nettonetto, proz_art_rabatt, preis_ek_mep_vor_fwu, preis_ek_nettonetto_rabatt, preis_ek_mep_vor_fwu_rabatt,
proz_prog_spanne_ek_nettonetto, proz_prog_spanne_ek_mep_vor_fwu, proz_prog_spanne_ek_einstandspreis,
ek_preis_ermittlung_rabatt_typ_id) AS SELECT V01.mandant_id,
 V01.angebot_nr,
 V02.dat_angebot_gueltig_von,
 V02.dat_angebot_gueltig_bis,
 V02.kjwo_ww,
 V02.angebot_name,
 V02.angebot_beschreibung_txt,
 V02.angebot_status_id,
 V02.angebot_typ_cd,
 V02.anz_angebot_limit,
 V02.geschaeftsvorfall_id,
 V02.hauptangebot_fg,
 V02.hauptangebot_nr,
 V02.bonuskauf_fg,
 V02.bonuskauf_id,
 V02.konditionsart_id,
 V02.aktion_id,
 V02.bewart_id,
 V02.aktion_typ_id,
 V02.markt_version_txt,
 V02.anz_market_version,
 V02.transfer_status_id,
 V02.akzeptiert_fg,
 V02.angebot_geloescht_fg,
 V01.art_id,
 V01.wup_id,
 V01.nb_id,
 V01.verkaufsorganisation_id,
 V01.art_basismenge_einh_id,
 V01.art_typ_cd,
 V01.art_gtin_id,
  CASE
  WHEN V01.mutter_wb_id IN (NULL, - 1)
  THEN V01.art_id
  ELSE V01.mutter_wb_id
  END AS mutter_wb_id,
 V01.art_posten_fg,
 V01.art_prio_nr,
 V01.art_theken_verkauf_fg,
 V01.art_nis_fg,
 V01.art_national_fg,
 V01.art_export_werbemittel_fg,
 V01.art_preisangabe_cd,
 V01.art_werbe_prod_gruppe_name,
 V01.gp_id,
 V01.opv_markt_fg,
 V01.opv_prospekt_fg,
 V01.anz_bonuskauf_bezahlt,
 V01.anz_bonuskauf_kauf,
 V01.anz_bonuskauf_gratis,
 V01.proz_bonuskauf_rabatt,
  CASE
  WHEN V200.wrg_typ_id = 1
  THEN V01.betrag_bonuskauf_rabatt
  WHEN V200.wrg_typ_id = 0
  THEN V01.betrag_bonuskauf_rabatt * V300.umrechnungskurs
  ELSE NULL
  END AS betrag_bonuskauf_rabatt,
  CASE
  WHEN V200.wrg_typ_id = 1
  THEN V01.betrag_bonuskauf_min
  WHEN V200.wrg_typ_id = 0
  THEN V01.betrag_bonuskauf_min * V300.umrechnungskurs
  ELSE NULL
  END AS betrag_bonuskauf_min,
 V01.menge_bonuskauf_min,
 V01.bonuskauf_bedingung_id,
 V01.bonuskauf_dimension_id,
 V01.bonuskauf_produktvariante_id,
 V01.bonuskauf_rabattzuordnung_id,
 V01.wrg_id,
 V01.rabatt_typ_id,
  CASE
  WHEN V200.wrg_typ_id = 1
  THEN V01.preis_vk_brutto
  WHEN V200.wrg_typ_id = 0
  THEN V01.preis_vk_brutto * V300.umrechnungskurs
  ELSE NULL
  END AS preis_vk_brutto,
  CASE
  WHEN V200.wrg_typ_id = 1
  THEN V01.preis_vk_brutto_aktion
  WHEN V200.wrg_typ_id = 0
  THEN V01.preis_vk_brutto_aktion * V300.umrechnungskurs
  ELSE NULL
  END AS preis_vk_brutto_aktion,
  CASE
  WHEN V200.wrg_typ_id = 1
  THEN V01.preis_vk_brutto_normalisiert
  WHEN V200.wrg_typ_id = 0
  THEN V01.preis_vk_brutto_normalisiert * V300.umrechnungskurs
  ELSE NULL
  END AS preis_vk_brutto_normalisiert,
  CASE
  WHEN V200.wrg_typ_id = 1
  THEN V01.preis_vk_brutto_stk
  WHEN V200.wrg_typ_id = 0
  THEN V01.preis_vk_brutto_stk * V300.umrechnungskurs
  ELSE NULL
  END AS preis_vk_brutto_stk,
  CASE
  WHEN V200.wrg_typ_id = 1
  THEN V01.preis_vk_brutto_aktion_stk
  WHEN V200.wrg_typ_id = 0
  THEN V01.preis_vk_brutto_aktion_stk * V300.umrechnungskurs
  ELSE NULL
  END AS preis_vk_brutto_aktion_stk,
 V01.proz_preisnachlass,
 V01.menge_prog_scm,
 V01.menge_prog_am,
  CASE
  WHEN V200.wrg_typ_id = 1
  THEN V01.betrag_prog_rohertrag_scm
  WHEN V200.wrg_typ_id = 0
  THEN V01.betrag_prog_rohertrag_scm * V300.umrechnungskurs
  ELSE NULL
  END AS betrag_prog_rohertrag_scm,
  CASE
  WHEN V200.wrg_typ_id = 1
  THEN V01.betrag_prog_pv
  WHEN V200.wrg_typ_id = 0
  THEN V01.betrag_prog_pv * V300.umrechnungskurs
  ELSE NULL
  END AS betrag_prog_pv,
  CASE
  WHEN V200.wrg_typ_id = 1
  THEN V01.betrag_prog_umsatz_am
  WHEN V200.wrg_typ_id = 0
  THEN V01.betrag_prog_umsatz_am * V300.umrechnungskurs
  ELSE NULL
  END AS betrag_prog_umsatz_am,
  CASE
  WHEN V200.wrg_typ_id = 1
  THEN V01.betrag_prog_umsatz_scm
  WHEN V200.wrg_typ_id = 0
  THEN V01.betrag_prog_umsatz_scm * V300.umrechnungskurs
  ELSE NULL
  END AS betrag_prog_umsatz_scm,
  CASE
  WHEN V200.wrg_typ_id = 1
  THEN V01.preis_ek_nettonetto
  WHEN V200.wrg_typ_id = 0
  THEN V01.preis_ek_nettonetto * V300.umrechnungskurs
  ELSE NULL
  END AS preis_ek_nettonetto,
 V01.proz_art_rabatt,
  CASE
  WHEN V200.wrg_typ_id = 1
  THEN V01.preis_ek_mep_vor_fwu
  WHEN V200.wrg_typ_id = 0
  THEN V01.preis_ek_mep_vor_fwu * V300.umrechnungskurs
  ELSE NULL
  END AS preis_ek_mep_vor_fwu,
  CASE
  WHEN V200.wrg_typ_id = 1
  THEN V01.preis_ek_nettonetto_rabatt
  WHEN V200.wrg_typ_id = 0
  THEN V01.preis_ek_nettonetto_rabatt * V300.umrechnungskurs
  ELSE NULL
  END AS preis_ek_nettonetto_rabatt,
  CASE
  WHEN V200.wrg_typ_id = 1
  THEN V01.preis_ek_mep_vor_fwu_rabatt
  WHEN V200.wrg_typ_id = 0
  THEN V01.preis_ek_mep_vor_fwu_rabatt * V300.umrechnungskurs
  ELSE NULL
  END AS preis_ek_mep_vor_fwu_rabatt,
 V01.proz_prog_spanne_ek_nettonetto,
 V01.proz_prog_spanne_ek_mep_vor_fwu,
 V01.proz_prog_spanne_ek_einstandspreis,
 V01.ek_preis_ermittlung_rabatt_typ_id
FROM kfl_production_dbp_data.angebot_art_wup_zu AS V01
 INNER JOIN kfl_production_dbp_data.angebot AS V02 ON V01.mandant_id = V02.mandant_id AND V01.angebot_nr = V02.angebot_nr
   
 INNER JOIN kfl_production_dbp_data.kurs AS V300 ON V300.dat_bis = DATE '9999-12-31' AND V01.wrg_id = V300.von_wrg_id
   AND V300.kurstyp_id = 3 AND V300.nach_wrg_id = 'EUR'
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_wrg_typ_zu AS V200 ON TRUE;