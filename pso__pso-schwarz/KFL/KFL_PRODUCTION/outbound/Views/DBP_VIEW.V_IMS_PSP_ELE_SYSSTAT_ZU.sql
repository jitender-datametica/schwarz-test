CREATE OR REPLACE VIEW kfl_production_dbp_view.v_ims_psp_ele_sysstat_zu AS SELECT mandant_id,
 psp_id,
 systemstatus_id
FROM kfl_production_dbp_data.ims_psp_ele_sysstat_zu;