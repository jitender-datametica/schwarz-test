CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_scm.mv_dt_pmr_counts_1 (
MANDANT_ID BIGNUMERIC(38,0),
DAT_VON DATE,
DAT_BIS DATE,
ART_ID BIGNUMERIC(38,0),
WUP_ID BIGNUMERIC(38,0),
NB_ID BIGNUMERIC(38,0),
WUP_COUNT_ANGEBOT STRING(16777216),
ART_COUNT_ANGEBOT STRING(16777216)
) AS
SELECT mandant_id,
 dat_von,
 dat_bis,
 art_id,
 wup_id,
 nb_id,
 STRING_AGG(`A11869`, '|' ORDER BY distinct_wup_count IS NULL, distinct_wup_count) AS wup_count_angebot,
 STRING_AGG(`A118611`, '|' ORDER BY distinct_art_count IS NULL, distinct_art_count) AS art_count_angebot
FROM (SELECT mandant_id,
   dat_von,
   dat_bis,
   art_id,
   wup_id,
   nb_id,
   COUNT(wup_id) OVER (PARTITION BY CAST(art_id AS STRING), CAST(mandant_id AS STRING), dat_von, dat_bis, CAST(angebot_id AS STRING)
      RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS distinct_wup_count,
   COUNT(art_id) OVER (PARTITION BY CAST(mandant_id AS STRING), dat_von, dat_bis, CAST(angebot_id AS STRING)
    RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS distinct_art_count,
   CAST(COUNT(wup_id) OVER (PARTITION BY CAST(art_id AS STRING), CAST(mandant_id AS STRING), dat_von, dat_bis, CAST(angebot_id AS STRING)
       RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS STRING) AS `A11869`,
   '|' AS `A118610`,
   CAST(COUNT(art_id) OVER (PARTITION BY CAST(mandant_id AS STRING), dat_von, dat_bis, CAST(angebot_id AS STRING)
     RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS STRING) AS `A118611`
  FROM kfl_production_dbp_view.v_pmr_angebot_art_wup_zu_1 AS V05B
  WHERE dat_von >= CURRENT_DATE
  GROUP BY mandant_id,
   dat_von,
   dat_bis,
   angebot_id,
   art_id,
   wup_id,
   nb_id) AS t2
GROUP BY mandant_id,
 dat_von,
 dat_bis,
 art_id,
 wup_id,
 nb_id;