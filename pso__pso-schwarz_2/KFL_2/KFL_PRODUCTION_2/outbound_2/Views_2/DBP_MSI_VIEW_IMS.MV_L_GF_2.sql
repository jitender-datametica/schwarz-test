CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ims.mv_l_gf_2 AS SELECT gf_id,
 mandant_id,
  CASE
  WHEN gf_id IN (0, - 1)
  THEN ''
  ELSE gf_name
  END AS gf_name
FROM kfl_production_dbp_view.v_gf_2
WHERE ek_fg = 0;