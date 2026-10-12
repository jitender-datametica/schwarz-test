CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_MCX_FRAGE_SPR_ZU_1 as
   -- SPR_1 : KMR/MCX Frage
   -- 20180502 twie: SPEC0037245 Neuanlage Sprachview Frage in Maritz, weitere Felder aktuell nicht benötigt
   -- 20190409 twie: SPEC0053317: umfrage_id im Schlüssel, für VIS aber nur 20 relevant
   -- 2019.0805 ssch0611 VTC-KMR Redesign (umfrage/quelle ergaenzt)

   SELECT
   frage_id, umfrage_id, 2::BYTEINT                                               AS kmr_quelle_id, Max(CASE WHEN spr_id =  22 THEN frage_bez ELSE NULL END)  AS frage_bez   --standard=deutsch
   , Max(CASE WHEN spr_id = 124 THEN frage_bez ELSE NULL END)  AS frage_bez_cz, Max(CASE WHEN spr_id =  90 THEN frage_bez ELSE NULL END)  AS frage_bez_pl, Max(CASE WHEN spr_id = 108 THEN frage_bez ELSE NULL END)  AS frage_bez_sk, Max(CASE WHEN spr_id =  65 THEN frage_bez ELSE NULL END)  AS frage_bez_hr, Max(CASE WHEN spr_id =  95 THEN frage_bez ELSE NULL END)  AS frage_bez_ro, Max(CASE WHEN spr_id =  18 THEN frage_bez ELSE NULL END)  AS frage_bez_bg, Max(frage_typ)                                            AS frage_typ, Max(frage_alias)                                          AS frage_alias
   FROM dbp_view.v_mcx_frage_spr_zu_1

   GROUP BY frage_id, umfrage_id, kmr_quelle_id;