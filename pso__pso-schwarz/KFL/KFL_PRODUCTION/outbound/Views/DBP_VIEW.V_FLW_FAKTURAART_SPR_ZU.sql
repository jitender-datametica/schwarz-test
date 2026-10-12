CREATE OR REPLACE VIEW kfl_production_dbp_view.v_flw_fakturaart_spr_zu AS SELECT mandant_id,
 fakturaart_id,
 spr_id,
 fakturaart_bez,
 system_id,
 td_insert,
 td_update
FROM kfl_production_dbp_data.flw_fakturaart_spr_zu;