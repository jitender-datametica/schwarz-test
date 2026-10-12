CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_aof_prognose_vs_bestellung_1 AS WITH AOF AS (SELECT V00.mandant_id
   ,
   V00.wup_id,
   V00.nb_id,
   V00.art_id,
   V00.dat,
   V00.zeitreihenart,
   V00.dat_prognoselauf,
   V00.menge
  FROM kfl_production_dbp_view.v_aof_prognose_1 AS V00
   INNER JOIN kfl_production_dbp_view.v_tag_1 AS V01 ON V00.dat = V01.dat AND V01.akt_kj BETWEEN - 2 AND 2) (SELECT v000.mandant_id
   ,
   v000.art_id,
   v000.dat AS aof_dat,
   - 1 AS bestellart_id,
    CASE
    WHEN v001.zeitreihenart1 = 'PLNGI_HIST'
    THEN plngihist.menge
    WHEN v001.zeitreihenart1 = 'AOF_HIST'
    THEN aofhist.menge
    ELSE NULL
    END AS menge_prognose,
   v000.wup_id,
   v000.nb_id,
   v001.zeitreihenart1 AS zeitreihenart,
   v000.dat_prognoselauf,
   v000.menge AS menge_best_bme
  FROM AOF AS v000
   INNER JOIN (SELECT 'PLNGI_HIST' AS zeitreihenart1
     UNION ALL
     SELECT 'AOF_HIST' AS zeitreihenart1) AS v001 ON TRUE
   INNER JOIN AOF AS plngihist ON v000.mandant_id = plngihist.mandant_id AND v000.art_id = plngihist.art_id AND v000.dat
        = plngihist.dat AND v000.wup_id = plngihist.wup_id AND v001.zeitreihenart1 = plngihist.zeitreihenart
   INNER JOIN AOF AS aofhist ON v000.mandant_id = aofhist.mandant_id AND v000.art_id = aofhist.art_id AND v000.dat =
       aofhist.dat AND v000.wup_id = aofhist.wup_id AND v001.zeitreihenart1 = aofhist.zeitreihenart
  WHERE v000.zeitreihenart = 'CONS_DATA');