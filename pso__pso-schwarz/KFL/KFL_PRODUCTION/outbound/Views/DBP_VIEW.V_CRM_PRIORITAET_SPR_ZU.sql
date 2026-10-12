CREATE OR REPLACE VIEW kfl_production_dbp_view.v_crm_prioritaet_spr_zu AS SELECT crm_prioritaet_id,
 spr_id,
 crm_prioritaet_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.crm_prioritaet_spr_zu;