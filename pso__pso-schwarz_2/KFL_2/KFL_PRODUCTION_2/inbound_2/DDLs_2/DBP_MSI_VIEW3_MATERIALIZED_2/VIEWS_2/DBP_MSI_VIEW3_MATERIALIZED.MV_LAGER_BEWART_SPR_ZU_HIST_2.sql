create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_LAGER_BEWART_SPR_ZU_HIST_2(
	LAGER_BEWART_ID,
	BEWART_BEZ,
	MANDANT_ID,
	SPR_ID
) as 
-- AP0014173, srom0404, neu erstellt
-- kein Historien Flag vorhanden, aber dennoch als eigene View ausgeführt, um es zu trennen
-- 20230717 staeblern Umstellung auf Session Variable
SELECT
   v01.lager_bewart_id,
   v01.bewart_bez,
   v01.mandant_id,
   v01.spr_id
FROM
   DBP_MSI_VIEW3_MATERIALIZED.TBL_MV_LAGER_BEWART_SPR_ZU_HIST_2 v01
   JOIN DBP_MSI_VIEW3_MATERIALIZED.MV_USER_SPR_ZU_2 v02 
   ON v01.spr_id = v02.spr_id
WHERE
   --keine Berücksichtigung der SAP-Industriesysteme für DE + CZ
   v01.system_id NOT IN (2, 17, 28, 32, 48, 53);