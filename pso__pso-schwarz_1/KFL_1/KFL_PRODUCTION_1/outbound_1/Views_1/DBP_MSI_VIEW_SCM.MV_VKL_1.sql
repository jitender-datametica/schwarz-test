CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_vkl_1 AS SELECT mandant_id,
 ma_id AS vkl_id,
 MAX(TRIM(ma_vorname || ' ' || ma_name)) AS vkl_name
FROM (SELECT mandant_id,
    ma_id,
    ma_name,
    ma_vorname
   FROM kfl_production_dbp_view.v_ma_spr_zu_1
   WHERE (mandant_id, ma_id) IN (SELECT (mandant_id, vkl_id)
      FROM kfl_production_dbp_view.v_wup_1
      WHERE nb_id IN (0, - 1, 2, 7)
       AND vkl_id <> wup_id)
   UNION ALL
   SELECT mandant_id,
      (1000 + mandant_id * 100 + vs_id * 10) * - 1,
    '--',
    ''
   FROM kfl_production_dbp_view.v_vs_1
   UNION ALL
   SELECT mandant_id,
    vkl_id,
    wup_standort,
    ''
   FROM kfl_production_dbp_view.v_wup_1
   WHERE nb_id = - 1
    AND vkl_id = wup_id
    AND wup_id > 0) AS t0
WHERE ma_id <> - 1
GROUP BY mandant_id,
 vkl_id
UNION ALL
SELECT mandant_id,
 - 1 AS vkl_id,
 'Alle VKL_1 (DIF)' AS vkl_name
FROM kfl_production_dbp_view.v_mandant_1 AS T1_1;