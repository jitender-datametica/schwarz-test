CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_amx_l_pruefung_klasse (pruefung_klasse_id, pruefung_klasse_bez
) AS SELECT pruefung_klasse_id,
 pruefung_klasse_bez
FROM kfl_production_dbp_view.v_amx_l_pruefung_klasse
WHERE amx_system_id = 1;