create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_SHR.MV_L_MITARBEITER_GRUPPE_1(
	MANDANT_ID,
	MITARBEITER_GRUPPE_ID
) as
   SELECT
   v01.mandant_id, v01.mitarbeiter_gruppe_id

   FROM dbp_view.v_l_mitarbeiter_gruppe_1 v01;