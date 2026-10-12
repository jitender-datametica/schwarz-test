CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_l_direkte_zuordnung_2 (direkte_zuordnung_fg, direkte_zuordnung_bez
) AS SELECT 1 AS direkte_zuordnung_fg,
 'nur direkte Zuordnung' AS direkte_zuordnung_bez
UNION DISTINCT
SELECT 0 AS direkte_zuordnung_fg,
 'alle Märkte' AS direkte_zuordnung_bez;