create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_SHR.MV_L_MITARBEITER_KREIS_2(
	MANDANT_ID,
	MITARBEITER_KREIS_ID
) as
   SELECT
   v01.mandant_id, v01.mitarbeiter_kreis_id

   FROM dbp_view.v_l_mitarbeiter_kreis_2 v01;