CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_regionalgesellschaft_1 (vs_id, vs_bez, vsvt_bez, sortier_id_vz,
sortier_ekco) AS SELECT V01.vs_id,
 V02.vs_bez,
 V02.vsvt_bez,
  CASE
  WHEN V01.vs_id = 1
  THEN 2
  WHEN V01.vs_id = 2
  THEN 3
  WHEN V01.vs_id = 3
  THEN 1
  WHEN V01.vs_id = 6
  THEN 5
  WHEN V01.vs_id = 7
  THEN 4
  WHEN V01.vs_id = 8
  THEN 6
  ELSE NULL
  END AS sortier_id_vz,
  CASE
  WHEN V01.vs_id = 1
  THEN 4
  WHEN V01.vs_id = 2
  THEN 2
  WHEN V01.vs_id = 3
  THEN 3
  WHEN V01.vs_id = 6
  THEN 6
  WHEN V01.vs_id = 7
  THEN 1
  WHEN V01.vs_id = 8
  THEN 5
  ELSE NULL
  END AS sortier_ekco
FROM kfl_production_dbp_view.v_wup_1 AS V01
 INNER JOIN kfl_production_dbp_view.v_vs_1 AS V02 ON V01.mandant_id = V02.mandant_id AND V01.vs_id = V02.vs_id AND V01.mandant_id
     = 1 AND V02.vk_id = 1
GROUP BY sortier_id_vz,
 V02.vsvt_bez,
 V02.vs_bez,
 V01.vs_id;