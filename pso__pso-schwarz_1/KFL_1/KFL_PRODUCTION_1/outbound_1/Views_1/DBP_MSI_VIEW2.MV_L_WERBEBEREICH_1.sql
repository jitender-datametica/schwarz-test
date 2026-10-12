CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_l_werbebereich_1 (mandant_id, werbebereich_cd, werbebereich_bez) AS
SELECT mandant_id,
 werbebereich_cd,
 werbebereich_bez
FROM kfl_production_dbp_view.v_l_werbebereich_1 AS V01
WHERE mandant_id = 1;