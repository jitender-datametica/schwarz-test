CREATE OR REPLACE VIEW kfl_production_dbp_view.v_flw_kalk_material_spr_zu_1 AS SELECT materialwert_kalk_id,
 spr_id,
 mandant_id,
 system_id,
 material_kalk_bez,
 td_insert,
 td_update
FROM kfl_production_dbp_data.flw_kalk_material_spr_zu_1;