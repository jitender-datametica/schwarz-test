create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_BRAND_ABSCHNITT_SPR_ZU(
	BRAND_ABSCHNITT_ID,
	MANDANT_ID,
	LAGERNUMMER_ID,
	SPR_ID,
	BRAND_ABSCHNITT_BEZ
) as 
-- 20230717 staeblern Umstellung auf Session Variable
SELECT
   v01.brand_abschnitt_id,
   v01.mandant_id,
   v01.lagernummer_id,
   v01.spr_id,
   v01.brand_abschnitt_bez
FROM
   DBP_MSI_VIEW3_MATERIALIZED.TBL_MV_BRAND_ABSCHNITT_SPR_ZU v01
   INNER JOIN DBP_MSI_VIEW3_MATERIALIZED.MV_USER_SPR_ZU v02 
   ON v01.spr_id = v02.spr_id;