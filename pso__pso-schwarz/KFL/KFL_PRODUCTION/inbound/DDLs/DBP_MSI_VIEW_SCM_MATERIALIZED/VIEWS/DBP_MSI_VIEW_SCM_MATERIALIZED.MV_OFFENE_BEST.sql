create or replace view DBP_MSI_VIEW_SCM_MATERIALIZED.MV_OFFENE_BEST(
	MANDANT_ID,
	WUP_ID,
	NB_ID,
	GP_ID,
	ART_ID,
	DAT_LIEF_NEXT,
	DAT_LIEF_MAX,
	MENGE_BEST_BME_OFFEN,
	MENGE_BEST_KOLLI_OFFEN,
	ANZ_BEST_POS,
	DIFF_TAGE,
	MENGE_BEST_BME_OFFEN_NEXT,
	MENGE_BEST_KOLLI_OFFEN_NEXT
) as
WITH offene_best
     AS (SELECT bbd.mandant_id
               ,bbd.wup_id
               ,bbd.nb_id
               ,bb.gp_id
               ,bbd.art_id
               ,eint.dat_lief_wunsch
               ,SUM(menge_best_bme)               AS menge_best_bme
               ,SUM(menge_best_kolli)             AS menge_best_kolli
               ,COUNT(DISTINCT bbd.best_beleg_id) AS anz_best_pos
         FROM   dbp_view.v_besch_best bb
                JOIN dbp_view.v_besch_best_det bbd
                  ON bb.mandant_id    = bbd.mandant_id
                 AND bb.best_beleg_id = bbd.best_beleg_id
                 
                JOIN dbp_view.v_lief_einteilung eint
                  ON bbd.mandant_id        = eint.mandant_id
                 AND bbd.best_beleg_id     = eint.best_beleg_id
                 AND bbd.best_beleg_pos_id = eint.best_beleg_pos_id
         WHERE eint.dat_lief_wunsch >= CURRENT_DATE - 1
           AND ((bb.mandant_id = 1 AND bb.bestellart_id = 'ZLLF' ) OR
                (bb.mandant_id <> 1 AND bb.bestellart_id IN ( 'ZBCZ', 'ZBPL', 'ZBSK','ZBHR','ZBRO', 'ZBBG' ))
                )
           AND bb.loesch_fg = 0
           AND bbd.loesch_fg = 0
           AND bbd.nb_id = -111
           AND eint.dat_lief_wunsch >= CURRENT_DATE - 1
           AND bbd.endlief_fg = 0
         GROUP BY bbd.mandant_id
                   ,bbd.wup_id
                   ,bbd.nb_id
                   ,bb.gp_id
                   ,bbd.art_id
                   ,eint.dat_lief_wunsch)
SELECT t1.mandant_id
      ,t1.wup_id
      ,t1.nb_id
      ,t1.gp_id
      ,t1.art_id
      ,t1.dat_lief_next
      ,t1.dat_lief_max
      ,t1.menge_best_bme_offen
      ,t1.menge_best_kolli_offen
      ,t1.anz_best_pos
      ,t1.dat_lief_max - t1.dat_lief_next AS diff_tage
      ,t2.menge_best_bme_offen_next
      ,t2.menge_best_kolli_offen_next
  FROM    
  -- aggregierte werte über ALLE offenen Bestellungen
  --t1
        ( 
         SELECT mandant_id
               ,wup_id
               ,nb_id
               ,gp_id
               ,art_id
               ,MIN(dat_lief_wunsch) dat_lief_next
               ,MAX(dat_lief_wunsch) dat_lief_max
               ,SUM(menge_best_bme)     menge_best_bme_offen
               ,SUM(menge_best_kolli)   menge_best_kolli_offen
               ,SUM(anz_best_pos)       anz_best_pos
         FROM   offene_best
         GROUP BY mandant_id
                 ,wup_id
                 ,nb_id
                 ,gp_id
                 ,art_id
          ) t1
       -- aggregierte werte zum NAECHSTEN Lieferdatum, statt Self-Join auch all-in-one über windowfunction abbildbar 
       --t2
       JOIN ( 
             SELECT mandant_id
                   ,wup_id
                   ,nb_id
                   ,gp_id
                   ,art_id
                   ,dat_lief_wunsch    dat_lief_next
                   ,SUM(menge_best_bme)   menge_best_bme_offen_next
                   ,SUM(menge_best_kolli) menge_best_kolli_offen_next
             FROM   offene_best
             GROUP  BY mandant_id, wup_id, nb_id, gp_id, art_id, dat_lief_wunsch
             HAVING dat_lief_wunsch = MIN(dat_lief_wunsch)
            ) t2
         ON t1.mandant_id = t2.mandant_id
            AND t1.wup_id = t2.wup_id
            AND t1.nb_id = t2.nb_id
            AND t1.gp_id = t2.gp_id
            AND t1.art_id = t2.art_id
            AND t1.dat_lief_next = t2.dat_lief_next;