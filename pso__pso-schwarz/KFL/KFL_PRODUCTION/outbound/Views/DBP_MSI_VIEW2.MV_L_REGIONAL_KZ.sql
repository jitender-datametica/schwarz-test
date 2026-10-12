CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_l_regional_kz AS SELECT 1 AS mandant_id,
 0 AS regional_kz,
 'national' AS regional_bez
FROM kfl_production_dbp_view.v_tag
WHERE dat = CURRENT_DATE
UNION DISTINCT
SELECT 1 AS dm__operand0,
 1 AS dm__operand1,
 'regional' AS dm__operand2
FROM kfl_production_dbp_view.v_tag
WHERE dat = CURRENT_DATE;