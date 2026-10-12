CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_vw_2 AS SELECT mandant_id,
 vw_id,
 vw_bez,
 sap_vw_id
FROM kfl_production_dbp_view.v_l_vw_2
WHERE vwart_id = 1
 AND vw_id IN (0, 1, 2, 3, 10);