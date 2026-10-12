CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_rpw.mv_l_bestellart (mandant_id, bestellart_id, system_id) AS SELECT
 mandant_id,
 bestellart_id,
 7 AS system_id
FROM kfl_production_dbp_view.v_l_bestellart
WHERE mandant_id = 1;