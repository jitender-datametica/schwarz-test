CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm_materialized.mv_offene_best_2 AS WITH OFFENE_BEST AS (SELECT BBD.mandant_id
   ,
   BBD.wup_id,
   BBD.nb_id,
   BB.gp_id,
   BBD.art_id,
   EINT.dat_lief_wunsch,
   SUM(BBD.menge_best_bme) AS menge_best_bme,
   SUM(BBD.menge_best_kolli) AS menge_best_kolli,
   COUNT(DISTINCT BBD.best_beleg_id) AS anz_best_pos
  FROM kfl_production_dbp_view.v_besch_best_2 AS BB
   INNER JOIN kfl_production_dbp_view.v_besch_best_det_2 AS BBD ON BB.mandant_id = BBD.mandant_id AND BB.best_beleg_id =
     BBD.best_beleg_id
   INNER JOIN kfl_production_dbp_view.v_lief_einteilung_2 AS EINT ON BBD.mandant_id = EINT.mandant_id AND BBD.best_beleg_id
       = EINT.best_beleg_id AND BBD.best_beleg_pos_id = EINT.best_beleg_pos_id
  WHERE EINT.dat_lief_wunsch >= DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY)
   AND (BB.mandant_id = 1 AND BB.bestellart_id = 'ZLLF' OR BB.mandant_id <> 1 AND BB.bestellart_id IN ('ZBCZ', 'ZBPL',
        'ZBSK', 'ZBHR', 'ZBRO', 'ZBBG'))
   AND BB.loesch_fg = 0
   AND BBD.loesch_fg = 0
   AND BBD.nb_id = -111
   AND BBD.endlief_fg = 0
  GROUP BY BB.gp_id,
   BBD.mandant_id,
   BBD.art_id,
   BBD.wup_id,
   BBD.nb_id,
   EINT.dat_lief_wunsch) (-- aggregierte werte über ALLE offenen Bestellungen
 -- t1_2

  -- aggregierte werte zum NAECHSTEN Lieferdatum, statt Self-Join auch all-in-one über windowfunction abbildbar
 -- t2

  SELECT t1.mandant_id,
   t1.wup_id,
   t1.nb_id,
   t1.gp_id,
   t1.art_id,
   t1.dat_lief_next,
   t1.dat_lief_max,
   t1.menge_best_bme_offen,
   t1.menge_best_kolli_offen,
   t1.anz_best_pos,
   DATE_DIFF(t1.dat_lief_max, t1.dat_lief_next, DAY) AS diff_tage,
   t2.menge_best_bme_offen_next,
   t2.menge_best_kolli_offen_next
  FROM (SELECT mandant_id,
     wup_id,
     nb_id,
     gp_id,
     art_id,
     MIN(dat_lief_wunsch) AS dat_lief_next,
     MAX(dat_lief_wunsch) AS dat_lief_max,
     SUM(menge_best_bme) AS menge_best_bme_offen,
     SUM(menge_best_kolli) AS menge_best_kolli_offen,
     SUM(anz_best_pos) AS anz_best_pos
    FROM OFFENE_BEST
    GROUP BY mandant_id,
     wup_id,
     nb_id,
     gp_id,
     art_id) AS t1_2
   INNER JOIN (SELECT mandant_id,
     wup_id,
     nb_id,
     gp_id,
     art_id,
     dat_lief_wunsch AS dat_lief_next,
     SUM(menge_best_bme) AS menge_best_bme_offen_next,
     SUM(menge_best_kolli) AS menge_best_kolli_offen_next
    FROM OFFENE_BEST
    GROUP BY mandant_id,
     wup_id,
     nb_id,
     gp_id,
     art_id,
     dat_lief_next
    HAVING dat_lief_next = MIN(dat_lief_wunsch)) AS t2 ON t1.mandant_id = t2.mandant_id AND t1.wup_id = t2.wup_id AND t1_2
        .nb_id = t2.nb_id AND t1.gp_id = t2.gp_id AND t1.art_id = t2.art_id AND t1.dat_lief_next = t2.dat_lief_next);