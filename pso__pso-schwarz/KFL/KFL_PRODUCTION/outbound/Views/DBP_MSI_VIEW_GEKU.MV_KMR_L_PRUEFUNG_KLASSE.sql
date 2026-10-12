CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku.mv_kmr_l_pruefung_klasse (pruefung_klasse_id, amx_system_id,
pruefung_klasse_bez) AS SELECT pruefung_klasse_id,
 amx_system_id,
 pruefung_klasse_bez
FROM kfl_production_dbp_view.v_kmr_l_pruefung_klasse AS V01;