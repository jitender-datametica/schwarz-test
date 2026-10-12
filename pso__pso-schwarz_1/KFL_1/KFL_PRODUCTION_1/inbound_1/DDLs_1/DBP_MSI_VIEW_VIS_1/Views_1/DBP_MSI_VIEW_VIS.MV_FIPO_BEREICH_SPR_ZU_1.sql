CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_FIPO_BEREICH_SPR_ZU_1 as
   SELECT

   fipo_bereich_id, MAX(CASE WHEN spr_id =   22 THEN fipo_bereich_bez ELSE NULL END)    AS fipo_bereich_bez  --standard=deutsch
   , MAX(CASE WHEN spr_id =   22 THEN fipo_bereich_bez ELSE NULL END)    AS fipo_bereich_bez_de    --deutsch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 124 THEN fipo_bereich_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 124 THEN fipo_bereich_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN fipo_bereich_bez ELSE NULL END)
   END  AS fipo_bereich_bez_cz             --tschechisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 90 THEN fipo_bereich_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 90 THEN fipo_bereich_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN fipo_bereich_bez ELSE NULL END)
   END  AS fipo_bereich_bez_pl            --polnisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 108 THEN fipo_bereich_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 108 THEN fipo_bereich_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN fipo_bereich_bez ELSE NULL END)
   END  AS fipo_bereich_bez_sk           --slowakisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 65 THEN fipo_bereich_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 65 THEN fipo_bereich_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN fipo_bereich_bez ELSE NULL END)
   END  AS fipo_bereich_bez_hr           --kroatisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 95 THEN fipo_bereich_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 95 THEN fipo_bereich_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN fipo_bereich_bez ELSE NULL END)
   END  AS fipo_bereich_bez_ro           --rumänisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 18 THEN fipo_bereich_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 18 THEN fipo_bereich_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN fipo_bereich_bez ELSE NULL END)
   END  AS fipo_bereich_bez_bg           --bulgarisch

   FROM dbp_view.v_fipo_bereich_spr_zu_1

   GROUP BY fipo_bereich_id
   ;