CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ims.mv_l_vkl_2 AS SELECT vkl_id,
 mandant_id,
  CASE
  WHEN vkl_id IN (0, - 1)
  THEN ''
  ELSE vkl_name
  END AS vkl_name,
 COALESCE(gf_id, - 1) AS gf_id
FROM kfl_production_dbp_view.v_vkl_2;