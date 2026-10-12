CREATE OR REPLACE VIEW kfl_production_dbp_view.v_flw_l_fehlgrund AS SELECT mandant_id,
 fehlgrund_id,
 system_id,
 fehlgrund_bez,
 td_insert,
 td_update
FROM kfl_production_dbp_data.flw_l_fehlgrund;