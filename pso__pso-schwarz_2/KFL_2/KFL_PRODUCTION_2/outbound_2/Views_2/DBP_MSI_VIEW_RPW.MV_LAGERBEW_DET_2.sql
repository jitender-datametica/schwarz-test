CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_rpw.mv_lagerbew_det_2 (mandant_id, lagerbew_beleg_id,
lagerbew_beleg_pos_id, kj, lager_bewart_id, art_id, grund_id, wup_id, nb_id, autom_fg, lagerort_id, gp_id,
einkaufsorganisation_id, soll_haben_kz, wrg_id, best_beleg_id, best_beleg_pos_id, betrag_lagerbew, betrag_verkauf,
betrag_belegfluss_wg_art, erfsngs_menge_einh_id, lagerplatz_id, kunde_id, menge_kolli, menge_lagerbew, menge_palette,
menge_lieferschein, menge_lief, menge_erf, empfaenger_id, dat_buch, dat_beleg, dat_erfasst, vorgangsart_id, system_id,
lagerbew_beleg_storno_id, lagerbew_beleg_pos_storno_id, lagerbew_beleg_storno_kj, betrag_vk_netto) AS SELECT LBD.mandant_id
 ,
 LBD.lagerbew_beleg_id,
 LBD.lagerbew_beleg_pos_id,
 LBD.kj,
 LBD.lager_bewart_id,
 LBD.art_id,
 LBD.grund_id,
 LBD.wup_id,
 LBD.nb_id,
 LBD.auto_fg AS autom_fg,
 LBD.lagerort_id,
  CASE
  WHEN LBD.lager_bewart_id IN ('301', '641')
  THEN LBD.empfaenger_id
  ELSE LBD.gp_id
  END AS gp_id,
 LBD.einkaufsorganisation_id,
 LBD.soll_haben_kz,
 LBD.wrg_id,
 LBD.best_beleg_id,
 LBD.best_beleg_pos_id,
 LBD.betrag_lagerbew,
  CASE
  WHEN LBD.betrag_verkauf = 0
  THEN LBD.betrag_verkauf_ist
  ELSE LBD.betrag_verkauf
  END AS betrag_verkauf,
 LBD.betrag_belegfluss_wg_art,
 LBD.erfsngs_menge_einh_id,
 LBD.lagerplatz_id,
 LBD.kunde_id,
 LBD.menge_lagerbew_kolli AS menge_kolli,
 LBD.menge_lagerbew_bme AS menge_lagerbew,
 LBD.menge_lagerbew_palette AS menge_palette,
 LBD.menge_lieferschein,
 LBD.menge_lief,
 LBD.menge_erf,
 COALESCE(LBD.empfaenger_id, 0) AS empfaenger_id,
 LBD.dat_buch,
 LB.dat_beleg,
 LB.dat_erfasst,
 LB.vorgangsart_id,
 7 AS system_id,
 LBD.lagerbew_beleg_storno_id,
 LBD.lagerbew_beleg_pos_storno_id,
 LBD.lagerbew_beleg_storno_kj,
 LBD.betrag_vk_netto
FROM kfl_production_dbp_view.v_lagerbew_det_2 AS LBD
 INNER JOIN kfl_production_dbp_view.v_lagerbew_2 AS LB ON LBD.lagerbew_beleg_id = LB.lagerbew_beleg_id AND LBD.mandant_id
     = LB.mandant_id AND LBD.dat_buch = LB.dat_buch AND LBD.kj = LB.kj
WHERE LBD.mandant_id = 1;