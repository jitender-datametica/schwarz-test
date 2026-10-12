CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_scm.mv_dt_pmr_counts_1
 AS
SELECT mandant_id,
 dat_von,
 dat_bis,
 art_id,
 wup_id,
 nb_id,
 STRING_AGG(`A11869`, '|' ORDER BY distinct_wup_count ) AS wup_count_angebot,
 STRING_AGG(`A118611`, '|' ORDER BY distinct_art_count ) AS art_count_angebot
FROM (SELECT t3.mandant_id,
   t3.dat_von,
   t3.dat_bis,
   t3.art_id,
   t3.wup_id,
   t3.nb_id,
   COUNT(t3.wup_id) OVER (PARTITION BY t3.art_id, t3.mandant_id, t3.dat_von, t3.dat_bis, t3.angebot_id RANGE BETWEEN
    UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS distinct_wup_count,
   COUNT(t3.art_id) OVER (PARTITION BY t3.mandant_id, t3.dat_von, t3.dat_bis, t3.angebot_id RANGE BETWEEN
    UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS distinct_art_count,
   CAST(COUNT(t3.wup_id) OVER (PARTITION BY t3.art_id, t3.mandant_id, t3.dat_von, t3.dat_bis, t3.angebot_id RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS STRING)
   AS `A11869`,
   '|' AS `A118610`,
   CAST(COUNT(t3.art_id) OVER (PARTITION BY t3.mandant_id, t3.dat_von, t3.dat_bis, t3.angebot_id RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS STRING)
   AS `A118611`
  FROM (SELECT V05B.mandant_id,
     V05BB.dat_angebot_gueltig_von AS dat_von,
     V05BB.dat_angebot_gueltig_bis AS dat_bis,
     V05B.angebot_nr AS angebot_id,
     V05B.art_id,
     V05B.wup_id,
     V05B.nb_id
    FROM kfl_production_dbp_view.v_angebot_art_wup_zu_1 AS V05B
     INNER JOIN kfl_production_dbp_view.v_angebot_1 AS V05BB ON V05B.mandant_id = V05BB.mandant_id AND V05B.angebot_nr =
       V05BB.angebot_nr
    WHERE V05BB.dat_angebot_gueltig_von >= CURRENT_DATE
     AND V05BB.angebot_geloescht_fg = 0
     AND EXISTS (SELECT 1
      FROM kfl_production_dbp_view.v_art_list_wup_zu_per_1 AS V02
      WHERE dat_von <= V05BB.dat_angebot_gueltig_von
       AND dat_bis >= V05BB.dat_angebot_gueltig_bis
       AND V05B.mandant_id = mandant_id
       AND V05B.wup_id = wup_id
       AND V05B.art_id = art_id)
     AND V05BB.angebot_status_id = 6
     AND V05BB.transfer_status_id IN (3, 5, 6)
     AND V05BB.angebot_typ_cd NOT IN ('ZAI', 'ZAIR', 'ZAIM')
    GROUP BY V05B.mandant_id,
     dat_von,
     dat_bis,
     angebot_id,
     V05B.art_id,
     V05B.wup_id,
     V05B.nb_id) AS t3) AS t4
GROUP BY mandant_id,
 dat_von,
 dat_bis,
 art_id,
 wup_id,
 nb_id;

