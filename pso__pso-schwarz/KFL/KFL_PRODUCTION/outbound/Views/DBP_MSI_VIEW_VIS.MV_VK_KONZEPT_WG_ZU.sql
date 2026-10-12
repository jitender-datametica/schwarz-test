CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_vk_konzept_wg_zu AS SELECT v01.mandant_id,
 v01.abt_id,
 COALESCE(V02.vk_konzept_id, - 1) AS vk_konzept_id,
 v01.wg_id
FROM (SELECT mandant_id,
   abt_id,
   wg_id
  FROM kfl_production_dbp_view.v_wg_per
  WHERE dat_bis = DATE '9999-12-31'
   AND arthiertyp_id = 2) AS v01
 LEFT JOIN kfl_production_dbp_msi_v_view.v_vk_konzept_wg_zu AS V02 ON v01.mandant_id = V02.mandant_id AND v01.wg_id =
   V02.wg_id
UNION ALL
SELECT mandant_id,
 0 AS abt_id,
 - 1 AS vk_konzept_id,
 - 999 AS wg_id
FROM kfl_production_dbp_view.v_mandant
WHERE mandant_id = 1;