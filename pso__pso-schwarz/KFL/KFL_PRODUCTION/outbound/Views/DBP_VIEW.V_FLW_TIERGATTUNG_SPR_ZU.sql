CREATE OR REPLACE VIEW kfl_production_dbp_view.v_flw_tiergattung_spr_zu AS SELECT mandant_id,
 tiergattung_id,
 spr_id,
 tiergattung_bez,
 td_insert,
 td_update
FROM kfl_production_dbp_data.flw_tiergattung_spr_zu;