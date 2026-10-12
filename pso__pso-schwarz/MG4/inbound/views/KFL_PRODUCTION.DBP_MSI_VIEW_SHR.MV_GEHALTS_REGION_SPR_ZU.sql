create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_SHR.MV_GEHALTS_REGION_SPR_ZU(
	MANDANT_ID,
	GEHALTS_REGION_ID,
	SPR_ID,
	GEHALTS_REGION_BEZ
) as
   SELECT
   v01.mandant_id, v01.gehalts_region_id, v01.spr_id, v01.gehalts_region_bez

   FROM dbp_view.v_gehalts_region_spr_zu v01
   WHERE spr_id = 22
;