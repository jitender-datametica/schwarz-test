CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_bestellart_2 (mandant_id, bestellart_id) AS SELECT mandant_id,
 bestellart_id
FROM kfl_production_dbp_view.v_l_bestellart_2;