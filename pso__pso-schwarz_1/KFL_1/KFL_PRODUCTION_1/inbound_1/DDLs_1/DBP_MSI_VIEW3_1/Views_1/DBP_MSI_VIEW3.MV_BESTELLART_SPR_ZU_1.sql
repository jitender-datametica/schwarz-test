CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_BESTELLART_SPR_ZU_1 (
   mandant_id,
   bestellart_id,
   spr_id,
   bestellart_bez
) AS 
-- 08.07.2018, AP0012522, srom0404 - Dummy_1 Daten 'unbekannte Bestellart'
-- 20230717 staeblern Umstellung auf Session Variable
SELECT
   v01.mandant_id,
   v01.bestellart_id,
   v01.spr_id,
   v01.bestellart_bez
FROM
   DBP_MSI_VIEW3.TBL_MV_BESTELLART_SPR_ZU_1 v01
   INNER JOIN DBP_MSI_VIEW3.MV_USER_SPR_ZU_1 v03 
   ON v01.spr_id = v03.spr_id;