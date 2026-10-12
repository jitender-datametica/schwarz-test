create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_BESTELLART_SPR_ZU_2(
	MANDANT_ID,
	BESTELLART_ID,
	SPR_ID,
	BESTELLART_BEZ
) as 
-- 08.07.2018, AP0012522, srom0404 - Dummy_2 Daten 'unbekannte Bestellart'
-- 20230717 staeblern Umstellung auf Session Variable
SELECT
   v01.mandant_id,
   v01.bestellart_id,
   v01.spr_id,
   v01.bestellart_bez
FROM
   DBP_MSI_VIEW3_MATERIALIZED.TBL_MV_BESTELLART_SPR_ZU_2 v01
   INNER JOIN DBP_MSI_VIEW3_MATERIALIZED.MV_USER_SPR_ZU_2 v03 
   ON v01.spr_id = v03.spr_id;