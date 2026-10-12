CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_amx_l_pruefung_typ_1 (pruefung_typ_id, pruefung_typ_bez,
ad_hoc_fg) AS SELECT pruefung_typ_id,
 pruefung_typ_bez,
 ad_hoc_fg
FROM kfl_production_dbp_view.v_amx_l_pruefung_typ_1
WHERE amx_system_id = 1;