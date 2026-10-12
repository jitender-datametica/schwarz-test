CREATE OR REPLACE VIEW kfl_production_dbp_view.v_konditionsart_spr_zu AS SELECT mandant_id,
 konditionsart_id,
 spr_id,
 system_id,
 konditionsart_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.konditionsart_spr_zu;