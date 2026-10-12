CREATE OR REPLACE VIEW kfl_production_dbp_view.v_flw_kalk_material AS SELECT mandant_id,
 materialwert_kalk_id,
 schnittliste_id,
 werk_id,
 dat_kalk_ab,
 dat_kalk_bis,
 fortgesch_kalk_fg,
 kalk_variante_id,
 system_id,
 plan_soll_kz,
 td_insert,
 td_update
FROM kfl_production_dbp_data.flw_kalk_material;