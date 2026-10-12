create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_VIS.MV_ABSCHRIFTART_INT_THEMA_ZU_2(
	ABSCHRIFTART_INT_ID,
	ABSCHRIFTART_THEMA_INT_ID
) as
   -- LOOKUP/ZUORDNUNG Abschriftart Int - Abschriftart Int Thema
   -- 2017-0221 : Initial

   SELECT
   aitz.abschriftart_int_id, aitz.abschriftart_thema_int_id
   FROM dbp_view.v_l_abschriftart_int_2  aitz
;
