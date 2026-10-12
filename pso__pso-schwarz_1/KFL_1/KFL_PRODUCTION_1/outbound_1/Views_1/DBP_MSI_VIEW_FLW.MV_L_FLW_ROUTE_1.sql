CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_l_flw_route_1 (mandant_id, werk_id, route_id) AS SELECT
 mandant_id,
 werk_id,
 route_id
FROM kfl_production_dbp_view.v_flw_l_route_1;