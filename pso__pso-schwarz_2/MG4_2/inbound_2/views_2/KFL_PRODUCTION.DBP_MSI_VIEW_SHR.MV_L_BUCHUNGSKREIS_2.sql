create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_SHR.MV_L_BUCHUNGSKREIS_2(
	MANDANT_ID,
	BUCHUNGSKREIS_ID,
	GJ_VARIANTE_ID,
	LAND_ID,
	WRG_ID,
	SYSTEM_ID,
	KONTENPLAN_ID,
	BUCHUNGSKREIS_GLOB_ID
) as
   SELECT
   v01.mandant_id, v01.buchungskreis_id, v01.gj_variante_id, v01.land_id, v01.wrg_id, v01.system_id, v01.kontenplan_id, v01.buchungskreis_glob_id

   FROM dbp_view.v_l_buchungskreis_2 v01;