create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_GEKU.MV_MCX_L_UMFRAGE_2(
	UMFRAGE_ID,
	UMFRAGE_BEZ
) as
-- 20190402 twie: SPEC0053317 Neuanlage Lookup Umfrage in Maritz

   SELECT

   umfrage_id
   , umfrage_bez

   FROM dbp_view.v_mcx_l_umfrage_2;