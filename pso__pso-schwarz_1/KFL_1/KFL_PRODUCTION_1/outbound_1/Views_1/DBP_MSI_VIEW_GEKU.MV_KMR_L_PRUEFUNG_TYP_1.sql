CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku.mv_kmr_l_pruefung_typ_1 (pruefung_typ_id, amx_system_id,
pruefung_typ_bez) AS SELECT pruefung_typ_id,
 amx_system_id,
 pruefung_typ_bez
FROM kfl_production_dbp_view.v_kmr_l_pruefung_typ_1 AS V01;