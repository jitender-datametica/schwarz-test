CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_regionalgesellschaft_2 (vs_id, mandant_id, vs_bez, vsvt_bez
, sortier_id_vz) AS SELECT V01.vs_id,
 V01.mandant_id,
 V02.vs_bez,
 V02.vsvt_bez,
  CASE
  WHEN V01.vs_id = 1 AND V01.mandant_id = 1
  THEN 2
  WHEN V01.vs_id = 2 AND V01.mandant_id = 1
  THEN 3
  WHEN V01.vs_id = 3 AND V01.mandant_id = 1
  THEN 1
  WHEN V01.vs_id = 6 AND V01.mandant_id = 1
  THEN 5
  WHEN V01.vs_id = 7 AND V01.mandant_id = 1
  THEN 4
  WHEN V01.vs_id = 8 AND V01.mandant_id = 1
  THEN 6
  WHEN V01.mandant_id = 2 OR V01.mandant_id = 3 AND V01.vs_id = 0
  THEN 1
  WHEN V01.mandant_id = 3 AND V01.vs_id = 1
  THEN 2
  WHEN V01.mandant_id = 3 AND V01.vs_id = 2
  THEN 3
  WHEN V01.mandant_id IN (4, 5, 6, 7, 8)
  THEN 1
  ELSE NULL
  END AS sortier_id_vz
FROM kfl_production_dbp_view.v_wup_2 AS V01
 INNER JOIN kfl_production_dbp_view.v_vs_2 AS V02 ON V01.mandant_id = V02.mandant_id AND V01.vs_id = V02.vs_id AND V02.vk_id
     IN (0, 1) AND (V01.mandant_id <> 1 OR V01.vs_id <> 0)
GROUP BY V01.mandant_id,
 V01.vs_id,
 V02.vs_bez,
 V02.vsvt_bez;