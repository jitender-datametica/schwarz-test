CREATE OR REPLACE VIEW kfl_production_dbp_view.v_vis_wettbewerber_2 AS SELECT mandant_id,
 wup_id,
 nb_id,
 wb_rang,
 wb_name,
 wb_dat_von
FROM kfl_production_dbp_data.vis_wettbewerber_2;