create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_GRIFFZONE_TYP_SPR_ZU(
	MANDANT_ID,
	GRIFFZONE_TYP_ID,
	SPR_ID,
	GRIFFZONE_TYP_BEZ
) as
-- 20230717 staeblern Umstellung auf Session Variable
SELECT
   v01.mandant_id,
   v01.griffzone_typ_id,
   v01.spr_id,
   v01.griffzone_typ_bez
FROM
   dbp_view.v_griffzone_typ_spr_zu v01
   JOIN DBP_MSI_VIEW3_MATERIALIZED.MV_USER_SPR_ZU v02
   ON v01.spr_id = v02.spr_id;