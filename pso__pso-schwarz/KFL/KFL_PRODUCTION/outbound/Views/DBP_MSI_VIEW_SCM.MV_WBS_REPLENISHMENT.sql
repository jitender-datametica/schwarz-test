CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_wbs_replenishment (mandant_id, wup_id, nb_id, art_id,
diff_tage, aktion_id_set, kjwo_von, dat_von, dat_bis, wtag_id_von, mutter_wb_id, anz_akt_selbe_dauer, aktion_rang,
aktion_label, aktion_dat_von, aktion_dat_bis, menge, korrigierte_menge, sales_fg, menge_af_2wo, perc_uplift, wmape, rmse
, bias, in_gruppe_fg, tv_fg, titelseite_fg, rueckseite_fg, mit_historie_fg, vk_aktion_brutto, vk_vor_aktion_brutto,
anz_art_in_gruppe, anz_art_in_gruppe_referenzperiode, kjwo_hist_aktion, faktor_flaki_hist_aktion, menge_hist_aktion,
menge_aktionsstart_hist_aktion, menge_we_zentrale_hist_aktion, anzahl_nullbestand_hist_aktion,
anzahl_tage_aktion_hist_aktion, menge_historie_af_hist_aktion, sollbestand_hist_aktion, min_sicherh_bestand_hist_aktion
, menge_endbestand_hist_aktion, umsatz_netto_hist_aktion, anteil_wup_abvk, abweichung_fg, gk_history_fg, mandant_id_vz,
dat_beladung) AS SELECT V01.mandant_id,
 V05.aktuell_wup_id AS wup_id,
 V01.nb_id,
 V01.art_id,
 V01.diff_tage,
 V01.aktion_id_set,
 V01.kjwo_von,
 V01.dat_von,
 V01.dat_bis,
 V01.wtag_id_von,
 V01.mutter_wb_id,
 V01.anz_akt_selbe_dauer,
 V01.aktion_rang,
 V01.aktion_label,
 V01.aktion_dat_von,
 V01.aktion_dat_bis,
 V01.menge,
 V01.korrigierte_menge,
 COALESCE(V01.sales_fg, 0) AS sales_fg,
 V01.menge_af_2wo,
 V01.perc_uplift,
 V01.wmape,
 V01.rmse,
 V01.bias,
 COALESCE(V01.in_gruppe_fg, 0) AS in_gruppe_fg,
 COALESCE(V01.tv_fg, 0) AS tv_fg,
 COALESCE(V01.titelseite_fg, 0) AS titelseite_fg,
 COALESCE(V01.rueckseite_fg, 0) AS rueckseite_fg,
 COALESCE(V01.mit_historie_fg, 0) AS mit_historie_fg,
 V01.vk_aktion_brutto,
 V01.vk_vor_aktion_brutto,
 V01.anz_art_in_gruppe,
 V01.anz_art_in_gruppe_referenzperiode,
 V02.kjwo AS kjwo_hist_aktion,
 WKW1.faktor_flaki AS faktor_flaki_hist_aktion,
       WKW1.menge_tag1 + WKW1.menge_tag2 + WKW1.menge_tag3 + WKW1.menge_tag4 + WKW1.menge_tag5 + WKW1.menge_tag6 + WKW1
  .menge_tag7 AS menge_hist_aktion,
 WKW1.menge_aktionsstart AS menge_aktionsstart_hist_aktion,
 WKW1.we_menge_zentral AS menge_we_zentrale_hist_aktion,
 WKW1.anzahl_nullbestand AS anzahl_nullbestand_hist_aktion,
 WKW1.anzahl_tage_aktion AS anzahl_tage_aktion_hist_aktion,
 WKW1.menge_historie_af AS menge_historie_af_hist_aktion,
 WKW1.sollbestand AS sollbestand_hist_aktion,
 WKW1.min_sicherh_bestand AS min_sicherh_bestand_hist_aktion,
 WKW1.menge_endbestand AS menge_endbestand_hist_aktion,
       WKW1.umsatz_netto_tag1 + WKW1.umsatz_netto_tag2 + WKW1.umsatz_netto_tag3 + WKW1.umsatz_netto_tag4 + WKW1.umsatz_netto_tag5
     + WKW1.umsatz_netto_tag6 + WKW1.umsatz_netto_tag7 AS umsatz_netto_hist_aktion,
 V01.anteil_wup_abvk,
 COALESCE(V01.abweichung_fg, 0) AS abweichung_fg,
 COALESCE(V01.gk_history_fg, 0) AS gk_history_fg,
 v011.mandant_id_vz,
 v011.dat_beladung
FROM kfl_production_dbp_view.v_wbs_replenishment AS V01
 INNER JOIN kfl_production_dbp_view.v_wup AS V05 ON V01.mandant_id = V05.mandant_id AND V01.wup_id = V05.wup_id AND (V05
      .nb_id IN (2, 0, - 111) AND V05.wup_id > 0 OR V05.nb_id = - 1 AND V05.wup_id = 0)
 LEFT JOIN kfl_production_dbp_view.v_tag AS V02 ON V01.aktion_dat_von = V02.dat
 INNER JOIN (SELECT DISTINCT mandant_id,
    CASE
    WHEN wup_id_vz = 6140
    THEN 4
    ELSE mandant_id_vz
    END AS mandant_id_vz,
   art_id,
   wup_id,
   nb_id,
   dat_ab,
   dat_bis,
   dat_beladung
  FROM kfl_production_dbp_view.v_wbs_werbeaenderungen) AS v011 ON V01.mandant_id = v011.mandant_id AND V01.art_id = v011
       .art_id AND V01.dat_von = v011.dat_ab AND V01.dat_bis = v011.dat_bis AND V01.wup_id = v011.wup_id AND V01.nb_id =
   v011.nb_id
 LEFT JOIN kfl_production_dbp_view.v_werbung_kennzahlen_woche AS WKW1 ON V01.mandant_id = WKW1.mandant_id AND V01.art_id
      = WKW1.art_id AND V01.wup_id = WKW1.wup_id AND V02.kjwo = WKW1.kjwo
WHERE 1 = 0;