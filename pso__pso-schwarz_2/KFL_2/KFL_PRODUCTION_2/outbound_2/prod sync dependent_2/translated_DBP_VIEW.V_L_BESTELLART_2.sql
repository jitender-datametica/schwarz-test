CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_bestellart_2 (mandant_id, bestellart_id, td_update, td_insert) AS
SELECT mandant_id,
 bestellart_id,
 td_update,
 td_insert
FROM kfl_production_dbp_data.l_bestellart_2;