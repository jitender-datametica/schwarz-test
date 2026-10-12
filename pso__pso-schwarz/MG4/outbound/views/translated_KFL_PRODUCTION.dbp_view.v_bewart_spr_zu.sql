CREATE OR REPLACE VIEW kfl_production_dbp_view.v_bewart_spr_zu (spr_id, bewart_id, bewart_bez, mandant_id, td_insert,
td_update) AS SELECT *
FROM kfl_production_dbp_data.bewart_spr_zu;