create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_HANDLING_UNIT_STATUS_SPR_ZU(
	MANDANT_ID,
	HU_STATUS_ID,
	HU_STATUS_BEZ,
	SPR_ID
) as 
-- 06.07.2017, AP0006317 - srom0404, kein deutscher Text für Ausland in SAP Tabelle
-- 20230717 staeblern Umstellung auf Session Variable
SELECT
   t2.mandant_id,
   t2.hu_status_id,
   t2.hu_status_bez,
   t2.spr_id
FROM
   DBP_MSI_VIEW3_MATERIALIZED.TBL_MV_HANDLING_UNIT_STATUS_SPR_ZU t2
   JOIN DBP_MSI_VIEW3_MATERIALIZED.MV_USER_SPR_ZU v04 
   ON t2.spr_id = v04.spr_id;