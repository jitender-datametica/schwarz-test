CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ims.mv_l_wup AS SELECT wup_id,
 mandant_id,
 nb_id,
  CASE
  WHEN wup_id IN (0, - 1)
  THEN ''
  ELSE wup_standort
  END AS wup_standort,
 COALESCE(vkl_id, - 1) AS vkl_id,
 COALESCE(vs_id, 0) AS vs_id,
 laengengrad,
 breitengrad
FROM kfl_production_dbp_view.v_wup;