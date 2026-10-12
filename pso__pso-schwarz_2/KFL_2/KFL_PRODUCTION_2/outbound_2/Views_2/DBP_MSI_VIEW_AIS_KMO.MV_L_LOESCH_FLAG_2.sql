CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_kmo.mv_l_loesch_flag_2 (loesch_fg, loesch_fg_bez) AS SELECT 0 AS
 loesch_fg,
 SUBSTR('Anlegen   ', 1, 10) AS loesch_fg_bez
UNION DISTINCT
SELECT 1 AS loesch_fg,
 SUBSTR('Löschen   ', 1, 10) AS loesch_fg_bez;