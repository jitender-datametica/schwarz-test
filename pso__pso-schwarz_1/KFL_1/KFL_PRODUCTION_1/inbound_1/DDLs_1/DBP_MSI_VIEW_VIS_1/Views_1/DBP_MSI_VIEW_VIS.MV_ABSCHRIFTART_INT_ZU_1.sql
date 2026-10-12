create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_VIS.MV_ABSCHRIFTART_INT_ZU_1(
	MANDANT_ID,
	ABSCHRIFTART_ID,
	ABSCHRIFTART_INT_ID
) as
   -- ZUORDNUNG Abschriftart - Abschriftart Int
   -- 2017-0221 : Initial

   SELECT
   aiz.mandant_id, aiz.abschriftart_id, aiz.abschriftart_int_id
   FROM dbp_view.v_abschriftart_int_zu_1  aiz
;
