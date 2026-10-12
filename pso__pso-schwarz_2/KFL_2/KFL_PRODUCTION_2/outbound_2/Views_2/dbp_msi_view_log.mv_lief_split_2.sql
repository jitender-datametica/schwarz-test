-- 2021-03-12 | nw | temporäre_2 view für dossier die split-lieferpositionen für BSH der letzten 14 tage anzeigt; wird entfernt wenn SAP-seitig gefixed

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_lief_split_2 AS WITH T AS (SELECT mandant_id,
   dat_lief_soll,
   wup_id,
   lief_beleg_id,
   lief_beleg_pos_id,
   vorlage_beleg_id,
   vorlage_beleg_pos_id
  FROM kfl_production_dbp_view.v_besch_lief_det_2) (-- orginallieferung
 -- splitlieferung
 SELECT t0.mandant_id,
   t0.wup_id,
   t0.dat_lief_soll,
   t0.lief_beleg_id,
   t0.lief_beleg_pos_id,
   t1.lief_beleg_id AS lief_beleg_id_split,
   t1.lief_beleg_pos_id AS lief_beleg_pos_id_split
  FROM T AS t0
   INNER JOIN T AS t1_2 ON t0.mandant_id = t1.mandant_id AND t0.lief_beleg_pos_id = t1.lief_beleg_pos_id AND t0.vorlage_beleg_id
        = t1.vorlage_beleg_id AND t0.vorlage_beleg_pos_id = t1.vorlage_beleg_pos_id AND LEFT(CAST(t1.lief_beleg_id AS STRING)
      , 4) = '1000'
  WHERE LEFT(CAST(t0.lief_beleg_id AS STRING), 4) <> '1000'
   AND t0.mandant_id = 1
   AND t0.dat_lief_soll BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 15 DAY) AND (DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY))
   AND t0.wup_id = 6909);