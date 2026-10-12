CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_l_flw_kalk_plan_2 (mandant_id, plan_kalk_id, schnittliste_id,
werk_id, dat_kalk_ab, dat_kalk_bis, fortgesch_kalk_fg, kalk_variante_id) AS SELECT mandant_id,
 plan_kalk_id,
 schnittliste_id,
 werk_id,
 dat_kalk_ab,
 dat_kalk_bis,
 fortgesch_kalk_fg,
 kalk_variante_id
FROM kfl_production_dbp_view.v_flw_kalk_plan_2;