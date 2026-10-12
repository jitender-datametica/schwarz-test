CREATE OR REPLACE VIEW kfl_production_dbp_view.v_handling_unit_status_spr_zu AS SELECT mandant_id,
 spr_id,
 hu_status_id,
 hu_status_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.handling_unit_status_spr_zu;