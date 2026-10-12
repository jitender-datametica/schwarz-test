CREATE OR REPLACE VIEW kfl_production_dbp_view.v_flw_handling_unit_det_2 AS SELECT mandant_id,
 handling_unit_id,
 handling_unit_pos_id,
 anz_verk_menge_einh,
 verk_menge_einh_id,
 td_insert,
 td_update
FROM kfl_production_dbp_data.flw_handling_unit_det_2;