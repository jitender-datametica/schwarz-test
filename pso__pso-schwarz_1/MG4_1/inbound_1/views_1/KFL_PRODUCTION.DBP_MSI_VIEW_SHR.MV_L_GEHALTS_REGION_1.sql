create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_SHR.MV_L_GEHALTS_REGION_1(
	MANDANT_ID,
	GEHALTS_REGION_ID
) as
   SELECT
   v01.mandant_id, v01.gehalts_region_id

   FROM dbp_view.v_l_gehalts_region_1 v01

;