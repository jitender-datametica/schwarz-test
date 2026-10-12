CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_MCX_L_ANTWORT_2 as
   -- LU : KMR/MCX Antwort
   -- 20180502 twie: SPEC0037245 Neuanlage Lookup Antwort IN Maritz
   -- 20190409 twie: SPEC0053317: umfrage_id im Schlüssel, für VIS aber nur 20 relevant
   -- 2019.0805 ssch0611 VTC-KMR Redesign (umfrage ergaenzt)

   SELECT
   v01.antwort_id, v01.umfrage_id, 2::BYTEINT AS kmr_quelle_id, v01.frage_id, v01.scale_id, v01.antwort_gewichtung, v01.datzeit_aend, v02.ok_fg, v03.kat_id, v03.gesamt_fg, v04.invers_ber_id

   FROM dbp_view.v_mcx_l_antwort_2 v01
   INNER JOIN dbp_view.v_mcx_l_antwort_ok_fg_2 v02
   ON v01.antwort_id = v02.antwort_id AND v01.umfrage_id = v02.umfrage_id
   INNER JOIN dbp_view.v_mcx_antwort_kategorie_zu_2 v03
   ON v01.antwort_id = v03.antwort_id AND v01.umfrage_id = v03.umfrage_id
   INNER JOIN dbp_view.v_mcx_invers_antwort_bereich_zu_2 v04
   ON v01.antwort_id = v04.antwort_id AND v01.umfrage_id = v04.umfrage_id;