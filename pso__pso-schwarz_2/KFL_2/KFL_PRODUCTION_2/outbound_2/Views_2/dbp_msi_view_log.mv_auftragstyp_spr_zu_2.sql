CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_auftragstyp_spr_zu_2 (auftragstyp_id, auftragstyp_bez) AS SELECT
 0 AS auftragstyp_id,
 'Standard' AS auftragstyp_bez
UNION ALL
SELECT 1 AS auftragstyp_id,
 'Wartung' AS auftragstyp_bez
UNION ALL
SELECT 2 AS auftragstyp_id,
 'Ausfall' AS auftragstyp_bez
UNION ALL
SELECT 3 AS auftragstyp_id,
 'Ausfall + Wartung' AS auftragstyp_bez;