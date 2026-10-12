CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_l_fakturaart_1 (fakturaart_id, mandant_id) AS (SELECT
  fakturaart_id,
  mandant_id
 FROM kfl_production_dbp_view.v_l_fakturaart_1
 UNION DISTINCT
 SELECT 'Z41' AS fakturaart_id,
  mandant_id
 FROM kfl_production_dbp_view.v_mandant_1)
UNION DISTINCT
SELECT 'Z42' AS fakturaart_id,
 mandant_id
FROM kfl_production_dbp_view.v_mandant_1;