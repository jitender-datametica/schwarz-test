CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_l_abschriftart AS SELECT mandant_id,
 abschriftart_id
FROM kfl_production_dbp_view.v_l_abschriftart AS V01;