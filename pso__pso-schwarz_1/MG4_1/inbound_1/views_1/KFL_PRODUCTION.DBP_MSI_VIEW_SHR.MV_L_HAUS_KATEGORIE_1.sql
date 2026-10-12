create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_SHR.MV_L_HAUS_KATEGORIE_1(
	MANDANT_ID,
	HAUS_KATEGORIE_ID
) as
   SELECT
   v01.mandant_id, v01.haus_kategorie_id

   FROM dbp_view.v_l_haus_kategorie_1 v01;