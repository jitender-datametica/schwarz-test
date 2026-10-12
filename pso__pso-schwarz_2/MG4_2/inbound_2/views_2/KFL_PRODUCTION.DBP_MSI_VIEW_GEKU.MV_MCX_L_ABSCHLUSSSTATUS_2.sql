create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_GEKU.MV_MCX_L_ABSCHLUSSSTATUS_2(
	ABSCHLUSS_ID,
	UMFRAGE_ID,
	ABSCHLUSS_BEZ
) as
   SELECT

   abschluss_id
   , umfrage_id
   , abschluss_bez

   FROM dbp_view.v_mcx_l_abschlussstatus_2;