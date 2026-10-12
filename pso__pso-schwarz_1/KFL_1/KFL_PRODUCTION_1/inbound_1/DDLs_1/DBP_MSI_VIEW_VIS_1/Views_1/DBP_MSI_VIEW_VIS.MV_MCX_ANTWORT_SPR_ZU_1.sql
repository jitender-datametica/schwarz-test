CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_MCX_ANTWORT_SPR_ZU_1 as
   -- SPR_1 : KMR/MCX Antwort
   -- 20180502 twie: SPEC0037245 Neuanlage Sprachview Antwort IN Maritz
   -- 20190409 twie: SPEC0053317: umfrage_id im Schlüssel, für VIS aber nur 20 relevant
   -- 2019.0805 ssch0611 VTC-KMR Redesign (umfrage/quelle ergaenzt)

   SELECT
   antwort_id, umfrage_id, 2::BYTEINT                                                 AS kmr_quelle_id, Max(CASE WHEN spr_id =  22 THEN antwort_bez ELSE NULL END)  AS antwort_bez   --standard=deutsch
   , Max(CASE WHEN spr_id = 124 THEN antwort_bez ELSE NULL END)  AS antwort_bez_cz, Max(CASE WHEN spr_id =  90 THEN antwort_bez ELSE NULL END)  AS antwort_bez_pl, Max(CASE WHEN spr_id = 108 THEN antwort_bez ELSE NULL END)  AS antwort_bez_sk, Max(CASE WHEN spr_id =  65 THEN antwort_bez ELSE NULL END)  AS antwort_bez_hr, Max(CASE WHEN spr_id =  95 THEN antwort_bez ELSE NULL END)  AS antwort_bez_ro, Max(CASE WHEN spr_id =  18 THEN antwort_bez ELSE NULL END)  AS antwort_bez_bg, Max(antwort_datentyp)                                       AS antwort_datentyp
   FROM dbp_view.v_mcx_antwort_spr_zu_1

   GROUP BY antwort_id, umfrage_id, kmr_quelle_id;