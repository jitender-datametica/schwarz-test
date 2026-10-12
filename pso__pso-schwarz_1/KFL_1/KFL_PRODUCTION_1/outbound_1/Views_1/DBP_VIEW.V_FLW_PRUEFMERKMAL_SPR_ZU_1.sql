CREATE OR REPLACE VIEW kfl_production_dbp_view.v_flw_pruefmerkmal_spr_zu_1 AS SELECT werk_id,
 stp_merkmal_id,
 spr_id,
 mandant_id,
 system_id,
 merkmal_bez,
 td_insert,
 td_update
FROM kfl_production_dbp_data.flw_pruefmerkmal_spr_zu_1;