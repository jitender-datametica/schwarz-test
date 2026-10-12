CREATE OR REPLACE VIEW kfl_production_dbp_view.v_fakturaart_spr_zu AS SELECT mandant_id,
 fakturaart_id,
 spr_id,
 fakturaart_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.fakturaart_spr_zu;