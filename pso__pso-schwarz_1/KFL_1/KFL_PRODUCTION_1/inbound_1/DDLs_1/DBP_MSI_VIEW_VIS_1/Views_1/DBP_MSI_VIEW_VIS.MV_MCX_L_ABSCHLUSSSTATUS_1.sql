CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_MCX_L_ABSCHLUSSSTATUS_1 as
   -- LU/SPR_1 : KMR/MCX Abschlussstatus
   -- 20180502 twie: SPEC0037245 Neuanlage Lookup Abschlussstatus in Maritz
   -- 20190409 twie: SPEC0053317: umfrage_id im Schlüssel, für VIS aber nur 20 relevant
   -- 2019.0805 ssch0611 VTC-KMR Redesign (umfrage/quelle ergaenzt)

   SELECT
   abschluss_id, umfrage_id, 2::BYTEINT  AS kmr_quelle_id, abschluss_bez
   FROM dbp_view.v_mcx_l_abschlussstatus_1;