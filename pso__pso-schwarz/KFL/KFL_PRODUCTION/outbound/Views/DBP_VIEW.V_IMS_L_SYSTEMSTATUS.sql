CREATE OR REPLACE VIEW kfl_production_dbp_view.v_ims_l_systemstatus AS SELECT mandant_id,
 systemstatus_id,
 td_update,
 td_insert
FROM kfl_production_dbp_data.ims_l_systemstatus;