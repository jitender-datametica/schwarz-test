CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_rpw.mv_l_zahlart_2 (mandant_id, zahlart_id, system_id) AS SELECT
 mandant_id,
 zahlart_id,
 7 AS system_id
FROM kfl_production_dbp_view.v_l_zahlart_2
WHERE mandant_id = 1;