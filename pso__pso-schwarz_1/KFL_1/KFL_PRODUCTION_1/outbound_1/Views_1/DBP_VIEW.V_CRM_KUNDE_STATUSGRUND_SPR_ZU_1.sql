CREATE OR REPLACE VIEW kfl_production_dbp_view.v_crm_kunde_statusgrund_spr_zu_1 AS SELECT kunde_statusgrund_id,
 spr_id,
 kunde_statusgrund_bez,
 td_insert,
 td_update
FROM kfl_production_dbp_data.crm_kunde_statusgrund_spr_zu_1;