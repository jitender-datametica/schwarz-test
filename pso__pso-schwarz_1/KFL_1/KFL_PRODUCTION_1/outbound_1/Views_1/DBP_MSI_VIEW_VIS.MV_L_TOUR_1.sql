CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_l_tour_1 AS SELECT DISTINCT mandant_id,
 wup_id,
 tour_id
FROM kfl_production_dbp_view.v_rueckfuehrung_lt_1;