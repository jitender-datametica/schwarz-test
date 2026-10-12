CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_demo.mv_land AS SELECT mandant_id,
 land_id,
 land_bez
FROM kfl_production_dbp_view.v_land AS V01;