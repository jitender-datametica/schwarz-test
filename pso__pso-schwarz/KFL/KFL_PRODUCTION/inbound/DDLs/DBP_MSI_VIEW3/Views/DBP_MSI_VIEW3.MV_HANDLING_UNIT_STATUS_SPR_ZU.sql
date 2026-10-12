 CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_HANDLING_UNIT_STATUS_SPR_ZU (
   mandant_id,
   hu_status_id,
   hu_status_bez,
   spr_id
) AS 
-- 06.07.2017, AP0006317 - srom0404, kein deutscher Text für Ausland in SAP Tabelle
-- 20230717 staeblern Umstellung auf Session Variable
SELECT
   t2.mandant_id,
   t2.hu_status_id,
   t2.hu_status_bez,
   t2.spr_id
FROM
   DBP_MSI_VIEW3.TBL_MV_HANDLING_UNIT_STATUS_SPR_ZU t2
   JOIN DBP_MSI_VIEW3.MV_USER_SPR_ZU v04 
   ON t2.spr_id = v04.spr_id;