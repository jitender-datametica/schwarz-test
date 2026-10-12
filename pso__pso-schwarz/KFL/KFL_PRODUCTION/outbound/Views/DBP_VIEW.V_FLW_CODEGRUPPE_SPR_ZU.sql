CREATE OR REPLACE VIEW kfl_production_dbp_view.v_flw_codegruppe_spr_zu AS SELECT mandant_id,
 katalogart_id,
 codegruppe_id,
 spr_id,
 codegruppe_bez,
 system_id,
 td_insert,
 td_update
FROM kfl_production_dbp_data.flw_codegruppe_spr_zu;