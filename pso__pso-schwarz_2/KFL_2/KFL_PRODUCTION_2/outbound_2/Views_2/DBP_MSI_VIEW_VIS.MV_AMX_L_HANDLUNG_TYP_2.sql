CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_amx_l_handlung_typ_2 (amx_handlung_typ_id, amx_handlung_typ_bez
) AS SELECT amx_handlung_typ_id,
 amx_handlung_typ_bez
FROM kfl_production_dbp_view.v_amx_l_handlung_typ_2
WHERE amx_system_id = 1;