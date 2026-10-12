CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ims.mv_tag_1 AS SELECT dat,
 gjmo,
 gj,
 akt_gj,
 mo_gj,
 dat AS dat_bez
FROM kfl_production_dbp_view.v_tag_1
UNION DISTINCT
SELECT CAST('2010' AS DATE) AS dat,
 190001 AS dm__operand1,
 1900 AS dm__operand2,
 - 9999 AS dm__operand3,
 1 AS dm__operand4,
 CAST(NULL AS DATE) AS dat_bez
FROM kfl_production_dbp_view.v_tag_1
WHERE dat = CURRENT_DATE;