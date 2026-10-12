CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_bis.tbl_mv_mandant AS SELECT mandant_id,
 mandant_bez,
 mandant_kbez,
  CASE
  WHEN mandant_id = 1
  THEN 2
  WHEN mandant_id = 3
  THEN 3
  WHEN mandant_id = 2
  THEN 4
  WHEN mandant_id = 7
  THEN 5
  WHEN mandant_id = 5
  THEN 6
  WHEN mandant_id = 8
  THEN 7
  WHEN mandant_id = 6
  THEN 8
  ELSE NULL
  END AS bis_sort_id,
 default_wrg
FROM kfl_production_dbp_view.v_mandant AS V01;