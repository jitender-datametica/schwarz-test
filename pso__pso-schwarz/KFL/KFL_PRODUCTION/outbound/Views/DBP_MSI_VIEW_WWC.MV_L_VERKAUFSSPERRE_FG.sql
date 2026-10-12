CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_l_verkaufssperre_fg (verkauf_sperre_fg, verkauf_sperre_fg_bez
) AS SELECT 1 AS verkauf_sperre_fg,
 'Verkaufssperre' AS verkauf_sperre_fg_bez
FROM kfl_production_dbp_view.v_mandant
WHERE mandant_id = 1
UNION ALL
SELECT 0 AS verkauf_sperre_fg,
 'keine Verkaufssperre' AS verkauf_sperre_fg_bez
FROM kfl_production_dbp_view.v_mandant
WHERE mandant_id = 1;