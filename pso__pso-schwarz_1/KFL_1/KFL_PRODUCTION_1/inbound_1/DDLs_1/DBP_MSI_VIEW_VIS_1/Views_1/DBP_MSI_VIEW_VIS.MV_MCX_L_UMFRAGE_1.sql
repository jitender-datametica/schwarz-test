CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_MCX_L_UMFRAGE_1 as
   -- LU/SPR_1 : KMR/MCX Umfrage
   -- 20190402 twie: SPEC0053317 Neuanlage Lookup Umfrage in Maritz
   -- 2019.0805 ssch0611 VTC-KMR Redesign

   SELECT
   umfrage_id, 2::BYTEINT AS kmr_quelle_id, umfrage_bez
   FROM dbp_view.v_mcx_l_umfrage_1;