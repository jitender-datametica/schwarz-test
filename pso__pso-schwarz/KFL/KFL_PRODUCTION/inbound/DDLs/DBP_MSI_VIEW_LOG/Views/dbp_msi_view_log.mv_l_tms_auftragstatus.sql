CREATE OR REPLACE VIEW DBP_MSI_VIEW_LOG.MV_L_TMS_AUFTRAGSTATUS(
	TMS_AUFTRAG_STATUS_CD,
	TMS_AUFTRAG_STATUS_CD_BEZ
) AS--2025-05-15, AP0252146 , dknop, initial
SELECT 
 10 AS tms_auftrag_status_cd
,'offen' AS tms_auftrag_status_cd_bez
UNION
SELECT 
 20 AS tms_auftrag_status_cd
,'in Bearbeitung' AS tms_auftrag_status_cd_bez
UNION
SELECT 
 30 AS tms_auftrag_status_cd
,'disponierbar' AS tms_auftrag_status_cd_bez
UNION
SELECT 
 40 AS tms_auftrag_status_cd
,'disponiert' AS tms_auftrag_status_cd_bez
UNION
SELECT 
 50 AS tms_auftrag_status_cd
,'avisiert' AS tms_auftrag_status_cd_bez
UNION
SELECT 
 60 AS tms_auftrag_status_cd
,'teilweise geliefert' AS tms_auftrag_status_cd_bez
UNION
SELECT 
 70 AS tms_auftrag_status_cd
,'geliefert' AS tms_auftrag_status_cd_bez
UNION
SELECT 
 99 AS tms_auftrag_status_cd
,'gelöscht' AS tms_auftrag_status_cd_bez
;