CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_l_tms_auftragstatus_1 (tms_auftrag_status_cd,
tms_auftrag_status_cd_bez) AS SELECT 10 AS tms_auftrag_status_cd,
 'offen' AS tms_auftrag_status_cd_bez
UNION ALL
SELECT 20 AS tms_auftrag_status_cd,
 'in Bearbeitung' AS tms_auftrag_status_cd_bez
UNION ALL
SELECT 30 AS tms_auftrag_status_cd,
 'disponierbar' AS tms_auftrag_status_cd_bez
UNION ALL
SELECT 40 AS tms_auftrag_status_cd,
 'disponiert' AS tms_auftrag_status_cd_bez
UNION ALL
SELECT 50 AS tms_auftrag_status_cd,
 'avisiert' AS tms_auftrag_status_cd_bez
UNION ALL
SELECT 60 AS tms_auftrag_status_cd,
 'teilweise geliefert' AS tms_auftrag_status_cd_bez
UNION ALL
SELECT 70 AS tms_auftrag_status_cd,
 'geliefert' AS tms_auftrag_status_cd_bez
UNION ALL
SELECT 99 AS tms_auftrag_status_cd,
 'gelöscht' AS tms_auftrag_status_cd_bez;