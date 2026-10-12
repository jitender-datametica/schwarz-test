CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku.mv_amx_l_pruefung_typ (pruefung_typ_id, amx_system_id,
pruefung_typ_bez, ad_hoc_fg) AS SELECT pruefung_typ_id,
 amx_system_id,
 pruefung_typ_bez,
 ad_hoc_fg
FROM kfl_production_dbp_view.v_amx_l_pruefung_typ;