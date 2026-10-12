CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_l_filialebene AS SELECT DISTINCT 1 AS filialebene_id,
 'Offensiv < -20.1%' AS filialebene
FROM kfl_production_dbp_view.v_mandant
UNION ALL
SELECT DISTINCT 2 AS filialebene_id,
 'Offensiv -20 bis -10.1%' AS filialebene
FROM kfl_production_dbp_view.v_mandant
UNION ALL
SELECT DISTINCT 3 AS filialebene_id,
 'Offensiv -10 bis -5.1%' AS filialebene
FROM kfl_production_dbp_view.v_mandant
UNION ALL
SELECT DISTINCT 4 AS filialebene_id,
 'Neutral -5 bis -2.6%' AS filialebene
FROM kfl_production_dbp_view.v_mandant
UNION ALL
SELECT DISTINCT 5 AS filialebene_id,
 'Neutral -2.5 bis -1.1%' AS filialebene
FROM kfl_production_dbp_view.v_mandant
UNION ALL
SELECT DISTINCT 6 AS filialebene_id,
 'Neutral -1 bis +1%' AS filialebene
FROM kfl_production_dbp_view.v_mandant
UNION ALL
SELECT DISTINCT 7 AS filialebene_id,
 'Neutral +1.1 bis +2.5%' AS filialebene
FROM kfl_production_dbp_view.v_mandant
UNION ALL
SELECT DISTINCT 8 AS filialebene_id,
 'Defensiv +2.6 bis +5%' AS filialebene
FROM kfl_production_dbp_view.v_mandant
UNION ALL
SELECT DISTINCT 9 AS filialebene_id,
 'Defensiv +5.1 bis +10%' AS filialebene
FROM kfl_production_dbp_view.v_mandant
UNION ALL
SELECT DISTINCT 10 AS filialebene_id,
 'Defensiv +10.1 bis +20%' AS filialebene
FROM kfl_production_dbp_view.v_mandant
UNION ALL
SELECT DISTINCT 11 AS filialebene_id,
 'Defensiv > +20.1%' AS filialebene
FROM kfl_production_dbp_view.v_mandant
UNION ALL
SELECT DISTINCT - 1 AS filialebene_id,
 'N/A' AS filialebene
FROM kfl_production_dbp_view.v_mandant;