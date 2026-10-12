CREATE OR REPLACE VIEW kfl_production_dbp_view.v_crm_eingangskanal_spr_zu (crm_eingangskanal_id, spr_id,
crm_eingangskanal_bez, td_update, td_insert) AS SELECT crm_eingangskanal_id,
 spr_id,
 crm_eingangskanal_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.crm_eingangskanal_spr_zu;