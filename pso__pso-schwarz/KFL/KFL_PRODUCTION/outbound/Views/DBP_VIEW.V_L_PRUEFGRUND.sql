CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_pruefgrund AS SELECT mandant_id,
 spr_id,
 z_arbeitsgebiet_id,
 pruef_id,
 pruef_bez,
 vis_pruef_bez
FROM kfl_production_dbp_data.l_pruefgrund;