CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_amx_l_kapitel_typ_1 (kapitel_typ_id, kapitel_typ_bez) AS SELECT
 kapitel_typ_id,
 kapitel_typ_bez
FROM kfl_production_dbp_view.v_amx_l_kapitel_typ_1
WHERE amx_system_id = 1;