CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_LAGER_BEWART_SPR_ZU (
   lager_bewart_id,
   bewart_bez,
   mandant_id,
   spr_id
) AS 
-- 20230717 staeblern Umstellung auf Session Variable
SELECT
   v01.lager_bewart_id,
   v01.bewart_bez,
   v01.mandant_id,
   v01.spr_id
FROM
   DBP_MSI_VIEW3.TBL_MV_LAGER_BEWART_SPR_ZU v01
   JOIN DBP_MSI_VIEW3.MV_USER_SPR_ZU v02 
   ON v01.spr_id = v02.spr_id
WHERE
   --keine Berücksichtigung der SAP-Industriesysteme für DE + CZ
   v01.system_id NOT IN (2, 17, 28, 32, 48, 53);