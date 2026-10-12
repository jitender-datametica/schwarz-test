CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ios.mv_mandant_1 (mandant_id, mandant_bez, mandant_kbez, mandant_sap_id
, default_wrg, mandant_sort_id) AS SELECT mandant_id,
 mandant_bez,
  CASE
  WHEN mandant_id = 1
  THEN 'DE'
  ELSE mandant_kbez
  END AS mandant_kbez,
 mandant_sap_id,
 default_wrg,
 mandant_sort_id
FROM kfl_production_dbp_view.v_mandant_1;