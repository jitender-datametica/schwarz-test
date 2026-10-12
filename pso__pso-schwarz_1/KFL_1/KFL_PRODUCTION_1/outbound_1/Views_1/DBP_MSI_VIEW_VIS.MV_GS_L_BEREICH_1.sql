CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_gs_l_bereich_1 AS SELECT mandant_id,
 ausgeber_typ_id
FROM kfl_production_dbp_view.v_l_ausgeber_typ_1 AS V01;