CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_ZEITFENSTER_SPR_ZU_2 as

   SELECT
   mandant_id, zeitfenster_id, MAX(CASE WHEN spr_id =   22 THEN zeitfenster_bez ELSE NULL END)    AS zeitfenster_bez    --standard=deutsch
   , MAX(CASE WHEN spr_id =   22 THEN zeitfenster_bez ELSE NULL END)    AS zeitfenster_bez_de     --deutsch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 124 THEN zeitfenster_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 124 THEN zeitfenster_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN zeitfenster_bez ELSE NULL END)
   END  AS zeitfenster_bez_cz                    --tschechisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 90 THEN zeitfenster_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 90 THEN zeitfenster_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN zeitfenster_bez ELSE NULL END)
   END  AS zeitfenster_bez_pl                    --polnisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 108 THEN zeitfenster_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 108 THEN zeitfenster_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN zeitfenster_bez ELSE NULL END)
   END  AS zeitfenster_bez_sk                    --slowakisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 65 THEN zeitfenster_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 65 THEN zeitfenster_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN zeitfenster_bez ELSE NULL END)
   END  AS zeitfenster_bez_hr                    --kroatisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 95 THEN zeitfenster_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 95 THEN zeitfenster_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN zeitfenster_bez ELSE NULL END)
   END  AS zeitfenster_bez_ro                    --rumänisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 18 THEN zeitfenster_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 18 THEN zeitfenster_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN zeitfenster_bez ELSE NULL END)
   END  AS zeitfenster_bez_bg                    --bulgarisch
   FROM dbp_view.v_zeitfenster_spr_zu_2
   GROUP BY
   mandant_id
   ,zeitfenster_id;