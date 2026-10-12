CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_FIPO_STANDARD_TEXT_SPR_ZU as
   SELECT

   fipo_standard_text_id, MAX(CASE WHEN spr_id =   22 THEN fipo_standard_text ELSE NULL END)    AS fipo_standard_text  --standard=deutsch
   , MAX(CASE WHEN spr_id =   22 THEN fipo_standard_text ELSE NULL END)    AS fipo_standard_text_de    --deutsch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 124 THEN fipo_standard_text ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 124 THEN fipo_standard_text ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN fipo_standard_text ELSE NULL END)
   END  AS fipo_standard_text_cz             --tschechisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 90 THEN fipo_standard_text ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 90 THEN fipo_standard_text ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN fipo_standard_text ELSE NULL END)
   END  AS fipo_standard_text_pl            --polnisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 108 THEN fipo_standard_text ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 108 THEN fipo_standard_text ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN fipo_standard_text ELSE NULL END)
   END  AS fipo_standard_text_sk           --slowakisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 65 THEN fipo_standard_text ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 65 THEN fipo_standard_text ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN fipo_standard_text ELSE NULL END)
   END  AS fipo_standard_text_hr           --kroatisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 95 THEN fipo_standard_text ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 95 THEN fipo_standard_text ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN fipo_standard_text ELSE NULL END)
   END  AS fipo_standard_text_ro           --rumänisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 18 THEN fipo_standard_text ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 18 THEN fipo_standard_text ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN fipo_standard_text ELSE NULL END)
   END  AS fipo_standard_text_bg           --bulgarisch

   FROM dbp_view.v_fipo_standard_text_spr_zu

   GROUP BY fipo_standard_text_id
   ;