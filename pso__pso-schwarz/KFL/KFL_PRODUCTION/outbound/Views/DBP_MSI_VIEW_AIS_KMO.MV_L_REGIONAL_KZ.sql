CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_kmo.mv_l_regional_kz (regional_kz, regional_bez) AS SELECT 0 AS
 regional_kz,
 'national' AS regional_bez
FROM kfl_production_dbp_view.v_tag
WHERE dat = CURRENT_DATE
UNION DISTINCT
SELECT 1,
 'regional'
FROM kfl_production_dbp_view.v_tag
WHERE dat = CURRENT_DATE;