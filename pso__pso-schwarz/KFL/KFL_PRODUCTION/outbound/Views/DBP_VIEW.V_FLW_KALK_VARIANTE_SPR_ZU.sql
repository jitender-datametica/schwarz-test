CREATE OR REPLACE VIEW kfl_production_dbp_view.v_flw_kalk_variante_spr_zu AS SELECT mandant_id,
 kalk_variante_id,
 spr_id,
 kalk_variante_bez,
 td_insert,
 td_update
FROM kfl_production_dbp_data.flw_kalk_variante_spr_zu;