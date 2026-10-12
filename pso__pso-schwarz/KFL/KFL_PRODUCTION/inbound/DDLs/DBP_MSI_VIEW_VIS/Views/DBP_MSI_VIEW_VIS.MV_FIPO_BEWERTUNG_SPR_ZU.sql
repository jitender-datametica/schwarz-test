CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_FIPO_BEWERTUNG_SPR_ZU as

   SELECT
   v01.flag AS fipo_antwort_bwz, MAX(CASE WHEN spr_id = 22 THEN v01.flag_bez ELSE NULL END) AS fipo_antwort_bwz_bez, MAX(CASE WHEN spr_id = 22 THEN v01.flag_bez ELSE NULL END) AS fipo_antwort_bwz_bez_de, CASE
   WHEN MAX(CASE WHEN spr_id = 124 THEN v01.flag_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 124 THEN v01.flag_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN v01.flag_bez ELSE NULL END)
   END  AS fipo_antwort_bwz_bez_cz             --tschechisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 90 THEN v01.flag_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 90 THEN v01.flag_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN v01.flag_bez ELSE NULL END)
   END  AS fipo_antwort_bwz_bez_pl            --polnisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 108 THEN v01.flag_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 108 THEN v01.flag_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN v01.flag_bez ELSE NULL END)
   END  AS fipo_antwort_bwz_bez_sk           --slowakisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 65 THEN v01.flag_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 65 THEN v01.flag_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN v01.flag_bez ELSE NULL END)
   END  AS fipo_antwort_bwz_bez_hr           --kroatisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 95 THEN v01.flag_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 95 THEN v01.flag_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN v01.flag_bez ELSE NULL END)
   END  AS fipo_antwort_bwz_bez_ro           --rumänisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 18 THEN v01.flag_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 18 THEN v01.flag_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN v01.flag_bez ELSE NULL END)
   END  AS fipo_antwort_bwz_bez_bg           --bulgarisch


   FROM dbp_view.v_flag_spr_zu v01

   WHERE flag_typ_id = 2 --für FIPO angelegt

   GROUP BY v01.flag


   UNION


   --Wenn Frage nicht beantwortet wurde -1
   SELECT
   -1, '-', '-', '-', '-', '-', '-', '-', '-'
   FROM dbp_view.v_mandant
   WHERE mandant_id = 1;