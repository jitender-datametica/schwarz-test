CREATE OR REPLACE VIEW kfl_production_dbp_view.v_pm AS SELECT pm_id,
 pm_bez,
 mandant_id,
 spr_id,
 td_insert,
 td_update
FROM kfl_production_dbp_data.pm;