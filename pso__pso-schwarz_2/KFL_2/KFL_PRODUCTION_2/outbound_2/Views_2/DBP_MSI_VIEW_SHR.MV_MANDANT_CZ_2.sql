CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_shr.mv_mandant_cz_2 (mandant_id, mandant_bez, mandant_kbez,
mandant_sort_id, default_wrg, spr_id) AS SELECT mandant_id,
 mandant_bez,
  CASE
  WHEN mandant_id = 1
  THEN 'DE'
  ELSE mandant_kbez
  END AS mandant_kbez,
 mandant_sort_id,
 default_wrg,
 124 AS spr_id
FROM kfl_production_dbp_view.v_mandant_2 AS V01
WHERE mandant_id <> 4;