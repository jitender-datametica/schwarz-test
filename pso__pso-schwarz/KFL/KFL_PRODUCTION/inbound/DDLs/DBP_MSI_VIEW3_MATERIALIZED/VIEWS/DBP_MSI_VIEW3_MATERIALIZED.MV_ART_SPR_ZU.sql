create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_ART_SPR_ZU(
	SPR_ID,
	ART_ID,
	MANDANT_ID,
	ART_BEZ,
	ART_ID_BEZ
) as
-- 20230717 staeblern Umstellung auf Session Variable
SELECT
   v01.spr_id,
   v01.art_id,
   v01.mandant_id,
   v01.art_bez,
   v01.art_id_bez
FROM
   DBP_MSI_VIEW3_MATERIALIZED.TBL_MV_ART_SPR_ZU v01
   JOIN DBP_MSI_VIEW3_MATERIALIZED.MV_USER_SPR_ZU v02 
   ON v01.spr_id = v02.spr_id;