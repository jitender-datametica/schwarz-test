CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_lager_bewgrund_spr_zu_hist_bg (mandant_id, grund, bwart,
grund_bez, spr_id) AS SELECT mandant_id,
 grund_id AS grund,
 lager_bewart_id AS bwart,
 grund_bez,
 spr_id
FROM kfl_production_dbp_view.v_lager_bewgrund_spr_zu AS V01
WHERE spr_id = 18
 AND hist_fg = 1;