CREATE OR REPLACE VIEW kfl_production_dbp_view.v_ims_l_anwenderstatus_1 AS SELECT mandant_id,
 anwenderstatus_id,
 td_update,
 td_insert
FROM kfl_production_dbp_data.ims_l_anwenderstatus_1;