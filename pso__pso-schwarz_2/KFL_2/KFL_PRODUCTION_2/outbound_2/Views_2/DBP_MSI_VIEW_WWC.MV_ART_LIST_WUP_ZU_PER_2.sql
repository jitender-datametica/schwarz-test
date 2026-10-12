CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_art_list_wup_zu_per_2 (art_id, mandant_id, wup_id, nb_id,
dat_erstlistung, dat_von, dat_bis, listungs_kz, list_quelle_id) AS SELECT V01.art_id,
 V01.mandant_id,
 V02.wup_id,
 V02.nb_id,
 COALESCE(MIN(V03.dat_von) OVER (PARTITION BY V01.art_id, V01.mandant_id, CAST(V02.wup_id AS STRING) ORDER BY 1 IS NULL
     , 1 RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING), DATE(NULL)) AS dat_erstlistung,
 COALESCE(V03.dat_von, DATE(NULL)) AS dat_von,
 COALESCE(V03.dat_bis, DATE(NULL)) AS dat_bis,
  CASE
  WHEN CURRENT_DATE BETWEEN V03.dat_von AND V03.dat_bis
  THEN 1
  WHEN V03.dat_bis > CURRENT_DATE
  THEN 2
  WHEN V03.dat_bis < CURRENT_DATE
  THEN 3
  ELSE 4
  END AS listungs_kz,
 COALESCE(V03.list_quelle_id, '') AS list_quelle_id
FROM kfl_production_dbp_view.v_art_2 AS V01
 INNER JOIN kfl_production_dbp_view.v_wup_2 AS V02 ON V01.mandant_id = V02.mandant_id
 LEFT JOIN kfl_production_dbp_view.v_art_list_wup_zu_per_2 AS V03 ON V01.art_id = V03.art_id AND V02.wup_id = V03.wup_id
  AND V01.mandant_id = V03.mandant_id
WHERE V01.mandant_id <> 1;