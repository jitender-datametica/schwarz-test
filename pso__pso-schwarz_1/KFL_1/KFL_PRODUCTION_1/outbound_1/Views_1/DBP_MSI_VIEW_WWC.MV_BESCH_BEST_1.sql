CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_besch_best_1 (mandant_id, best_beleg_id, bestellart_id) AS
SELECT mandant_id,
 best_beleg_id,
 bestellart_id
FROM kfl_production_dbp_view.v_besch_best_1
GROUP BY mandant_id,
 best_beleg_id,
 bestellart_id;