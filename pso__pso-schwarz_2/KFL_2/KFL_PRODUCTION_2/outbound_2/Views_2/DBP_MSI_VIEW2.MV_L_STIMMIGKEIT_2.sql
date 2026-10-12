CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_l_stimmigkeit_2 (stimmig_id, stimmig_bez) AS SELECT '1' AS
 stimmig_id,
 'nicht stimmig' AS stimmig_bez
UNION DISTINCT
SELECT '0' AS stimmig_id,
 'stimmig' AS stimmig_bez;