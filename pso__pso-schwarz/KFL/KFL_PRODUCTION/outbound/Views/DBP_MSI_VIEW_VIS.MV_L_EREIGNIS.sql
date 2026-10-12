CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_l_ereignis (ereignis_id, ereignistyp_id, mandant_id) AS (SELECT
  ereignis_id,
  ereignistyp_id,
  mandant_id
 FROM kfl_production_dbp_view.v_ereignis AS V01
 UNION DISTINCT
 SELECT - 1,
  100,
  mandant_id
 FROM kfl_production_dbp_view.v_mandant)
UNION DISTINCT
SELECT - 1,
 101,
 mandant_id
FROM kfl_production_dbp_view.v_mandant;