CREATE OR REPLACE VIEW kfl_production_dbp_view.v_ims_systemstatus_spr_zu AS SELECT mandant_id,
 systemstatus_id,
 spr_id,
 systemstatus_bez_kurz,
 systemstatus_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.ims_systemstatus_spr_zu;