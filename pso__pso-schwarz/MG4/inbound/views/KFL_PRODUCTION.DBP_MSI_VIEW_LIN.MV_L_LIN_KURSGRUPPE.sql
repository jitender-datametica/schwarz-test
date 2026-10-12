create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_LIN.MV_L_LIN_KURSGRUPPE(
	MANDANT_ID,
	LIN_KURSGRUPPE_ID
) as
   SELECT mandant_id, lin_kursgruppe_id
   FROM dbp_view.v_l_lin_kursgruppe;