create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_GEKU.MV_MCX_L_BEREICH_2(
	BER_ID,
	UMFRAGE_ID
) as
-- 20180502 twie: SPEC0037245 Neuanlage Lookup Bereich in Maritz
--                           Bereich wird in DWH generiert, existiert nicht im Quellsystem Maritz
-- 20190404 twie: SPEC0053317 FK auf Umfrage

   SELECT

   ber_id
   , umfrage_id

   FROM dbp_view.v_mcx_l_bereich_2;