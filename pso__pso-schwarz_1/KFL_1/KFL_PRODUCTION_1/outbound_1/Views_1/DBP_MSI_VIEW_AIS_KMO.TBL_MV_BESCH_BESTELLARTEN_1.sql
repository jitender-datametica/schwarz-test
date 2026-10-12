CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_kmo.tbl_mv_besch_bestellarten_1 (mandant_id, best_beleg_id,
best_beleg_pos_id, art_id, wup_id, nb_id, lagerort_id, loesch_fg_ekpo, menge_best_bme, menge_best_kolli, menge_best,
dat_best_beleg, wrg_id, gp_id, bestellart_id, lager_bewart_id, dat_buch, endlief_fg, dat_lief_wunsch, dat_lief_bewertung
, menge_lief_ist_kolli, anforderer_name, betrag_best_ek_n, betrag_lagerbew_ek_n, umrechnungskurs_akt,
umrechnungskurs_hist) AS SELECT T1.mandant_id,
 T1.best_beleg_id,
 T1.best_beleg_pos_id,
 T1.art_id,
 T1.wup_id,
 T1.nb_id,
 T1.lagerort_id,
 T1.loesch_fg_ekpo,
  CASE
  WHEN T1.endlief_fg = 1
  THEN T1.menge_best_bme * - 1
  ELSE T1.menge_best_bme
  END AS menge_best_bme,
  CASE
  WHEN T1.endlief_fg = 1
  THEN T1.menge_lief_soll_kolli * - 1
  ELSE T1.menge_lief_soll_kolli
  END AS menge_best_kolli,
  CASE
  WHEN T1.endlief_fg = 1
  THEN T1.menge_lief * - 1
  ELSE T1.menge_lief
  END AS menge_best,
 T1.dat_best_beleg,
 T1.wrg_id,
 T1.gp_id,
 T1.bestellart_id,
 T1.lager_bewart_id,
  CASE
  WHEN T1.lager_bewart_id IN ('101', '162', '901')
  THEN T1.dat_buch
  ELSE NULL
  END AS dat_buch,
 T1.endlief_fg,
 T1.dat_lief_wunsch,
 T1.dat_lief_bewertung,
 T1.menge_lief_ist_kolli,
 T4.anforderer_name,
 T1.betrag_best_ek_n,
 T1.betrag_lagerbew_ek_n,
 V300.umrechnungskurs AS umrechnungskurs_akt,
 V400.umrechnungskurs AS umrechnungskurs_hist
FROM kfl_production_dbp_view.v_besch_best_lief_lbs_1 AS T1_1
 INNER JOIN kfl_production_dbp_view.v_kurs_1 AS V300 ON V300.dat_bis = DATE '9999-12-31' AND T1.wrg_id = V300.von_wrg_id
   AND V300.kurstyp_id = 3 AND V300.nach_wrg_id = 'EUR'
 INNER JOIN kfl_production_dbp_view.v_kurs_1 AS V400 ON T1.dat_best_beleg BETWEEN V400.dat_von AND V400.dat_bis AND T1.wrg_id
      = V400.von_wrg_id AND V400.kurstyp_id = 3 AND V400.nach_wrg_id = 'EUR'
 LEFT JOIN kfl_production_dbp_view.v_besch_best_det_1 AS T4 ON T1.mandant_id = T4.mandant_id AND T1.best_beleg_id = T4.best_beleg_id
      AND T1.best_beleg_pos_id = T4.best_beleg_pos_id AND T1.dat_best_beleg = T4.dat_best_beleg
WHERE T1.mandant_id <> 1;