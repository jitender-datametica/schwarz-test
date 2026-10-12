CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_ereignis_2 (ereignis_id, ereignistyp_id, default_offen) AS
SELECT ereignis_id,
 ereignistyp_id,
 default_offen
FROM kfl_production_dbp_view.v_ereignis_2;