CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_sort.mv_bewart_sortiment AS SELECT DISTINCT CASE
  WHEN bewart_id IN (1001, 1002)
  THEN bewart_id
  ELSE 1000
  END AS bewart_id
FROM kfl_production_dbp_view.v_bewart;