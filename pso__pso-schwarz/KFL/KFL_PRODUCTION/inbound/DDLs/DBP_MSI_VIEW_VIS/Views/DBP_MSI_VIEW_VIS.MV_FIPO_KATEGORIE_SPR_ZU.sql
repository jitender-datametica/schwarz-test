CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_FIPO_KATEGORIE_SPR_ZU as
   SELECT

   fipo_kategorie_id, MAX(CASE WHEN spr_id =   22 THEN fipo_kategorie_bez ELSE NULL END)    AS fipo_kategorie_bez  --standard=deutsch
   , MAX(CASE WHEN spr_id =   22 THEN fipo_kategorie_bez ELSE NULL END)    AS fipo_kategorie_bez_de    --deutsch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 124 THEN fipo_kategorie_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 124 THEN fipo_kategorie_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN fipo_kategorie_bez ELSE NULL END)
   END  AS fipo_kategorie_bez_cz             --tschechisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 90 THEN fipo_kategorie_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 90 THEN fipo_kategorie_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN fipo_kategorie_bez ELSE NULL END)
   END  AS fipo_kategorie_bez_pl            --polnisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 108 THEN fipo_kategorie_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 108 THEN fipo_kategorie_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN fipo_kategorie_bez ELSE NULL END)
   END  AS fipo_kategorie_bez_sk           --slowakisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 65 THEN fipo_kategorie_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 65 THEN fipo_kategorie_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN fipo_kategorie_bez ELSE NULL END)
   END  AS fipo_kategorie_bez_hr           --kroatisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 95 THEN fipo_kategorie_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 95 THEN fipo_kategorie_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN fipo_kategorie_bez ELSE NULL END)
   END  AS fipo_kategorie_bez_ro           --rumänisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 18 THEN fipo_kategorie_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 18 THEN fipo_kategorie_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN fipo_kategorie_bez ELSE NULL END)
   END  AS fipo_kategorie_bez_bg           --bulgarisch

   FROM dbp_view.v_fipo_kategorie_spr_zu

   GROUP BY fipo_kategorie_id
   ;