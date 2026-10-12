CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_f_handling_unit_det (mandant_id, handling_unit_id,
handling_unit_pos_id, anz_verk_menge_einh, verk_menge_einh_id) AS SELECT mandant_id,
 handling_unit_id,
 handling_unit_pos_id,
 anz_verk_menge_einh,
 verk_menge_einh_id
FROM kfl_production_dbp_view.v_flw_handling_unit_det;