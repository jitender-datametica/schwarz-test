create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_SHR.MV_L_MITARBEITER_ABWESENH(
	MANDANT_ID,
	ABWESENHEIT_ID
) as
   SELECT
   v01.mandant_id, v01.abwesenheit_id

   FROM dbp_view.v_l_mitarbeiter_abwesenh v01;