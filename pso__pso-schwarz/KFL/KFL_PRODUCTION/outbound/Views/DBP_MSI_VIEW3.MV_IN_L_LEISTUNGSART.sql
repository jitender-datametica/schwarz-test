CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_in_l_leistungsart (mandant_id, co_leistungsart_id) AS SELECT
 mandant_id,
 co_leistungsart_id
FROM kfl_production_dbp_view.v_in_l_leistungsart;