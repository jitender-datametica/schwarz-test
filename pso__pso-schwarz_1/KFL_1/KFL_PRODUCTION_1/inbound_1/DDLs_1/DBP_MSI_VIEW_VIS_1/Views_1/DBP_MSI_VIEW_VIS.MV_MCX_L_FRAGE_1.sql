CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_MCX_L_FRAGE_1 as
   -- LU : KMR/MCX Frage
   -- 20180502 twie: SPEC0037245 Neuanlage Lookup Frage IN Maritz, Eltern von Antwort, keine eindeutige Zuordnung zu Kategorie und Bereich
   -- 20190409 twie: SPEC0053317: umfrage_id im Schlüssel, für VIS aber nur 20 relevant
   -- 2019.0805 ssch0611 VTC-KMR Redesign (umfrage/quelle ergaenzt)

   SELECT
   frage_id, umfrage_id, 2::BYTEINT AS kmr_quelle_id, frage_ex_typ, frage_status
   FROM dbp_view.v_mcx_l_frage_1;