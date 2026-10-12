CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_l_mbew_fg_2 (mbew_fg, mbew_fg_bez) AS SELECT '1' AS mbew_fg,
 'MBEW' AS mbew_fg_bez
FROM kfl_production_dbp_view.v_mandant_2
WHERE mandant_id = 1
UNION ALL
SELECT '0' AS mbew_fg,
 'MBEWH' AS mbew_fg_bez
FROM kfl_production_dbp_view.v_mandant_2
WHERE mandant_id = 1;