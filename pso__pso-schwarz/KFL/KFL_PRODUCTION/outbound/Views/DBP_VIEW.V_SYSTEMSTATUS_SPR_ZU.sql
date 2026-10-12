CREATE OR REPLACE VIEW kfl_production_dbp_view.v_systemstatus_spr_zu AS SELECT mandant_id,
 systemstatus_id,
 spr_id,
 system_id,
 systemstatus_bez_kurz,
 systemstatus_bez
FROM kfl_production_dbp_data.systemstatus_spr_zu;