CREATE OR REPLACE VIEW kfl_production_dbp_view.v_flw_l_ek_notierung AS SELECT ek_notierung_id,
 mandant_id,
 system_id,
 ek_notierung_bez
FROM kfl_production_dbp_data.flw_l_ek_notierung;