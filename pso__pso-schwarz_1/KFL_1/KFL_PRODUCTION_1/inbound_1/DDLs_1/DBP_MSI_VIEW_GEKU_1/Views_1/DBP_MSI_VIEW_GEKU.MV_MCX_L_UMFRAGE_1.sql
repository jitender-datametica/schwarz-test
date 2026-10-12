CREATE OR REPLACE VIEW DBP_MSI_VIEW_GEKU.MV_MCX_L_UMFRAGE_1
(
umfrage_id
,umfrage_bez
)
AS
-- 20190402 twie: SPEC0053317 Neuanlage Lookup Umfrage in Maritz

   SELECT

   umfrage_id
   , umfrage_bez

   FROM dbp_view.v_mcx_l_umfrage_1;