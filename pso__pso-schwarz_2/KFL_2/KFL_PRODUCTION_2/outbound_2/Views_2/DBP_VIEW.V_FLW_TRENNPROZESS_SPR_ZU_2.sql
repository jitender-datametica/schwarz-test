CREATE OR REPLACE VIEW kfl_production_dbp_view.v_flw_trennprozess_spr_zu_2 AS SELECT werk_id,
 trennprozess_id,
 spr_id,
 mandant_id,
 trennprozess_bez,
 system_id,
 td_insert,
 td_update
FROM kfl_production_dbp_data.flw_trennprozess_spr_zu_2;