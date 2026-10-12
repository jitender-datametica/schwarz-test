CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_lbs.mv_mandant_security_2 (mandant_id, mandant_bez, mandant_kbez) AS
SELECT mandant_id,
 mandant_bez,
 mandant_kbez
FROM kfl_production_dbp_view.v_mandant_2 AS V01;