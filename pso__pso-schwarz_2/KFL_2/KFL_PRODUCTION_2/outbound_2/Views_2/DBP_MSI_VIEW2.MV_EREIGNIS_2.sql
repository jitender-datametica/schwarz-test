CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_ereignis_2 (ereignis_id, ereignistyp_id) AS SELECT ereignis_id,
 ereignistyp_id
FROM kfl_production_dbp_view.v_ereignis_2;