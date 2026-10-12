CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_GEKU_KUNDENFAKTOR_SPR_ZU_1 as
   -- 2015KW50: M.Gill: Umbau der Internationalisierung von Tabellen auf Spalten

   SELECT
   kundenfaktor_id, MAX(CASE WHEN spr_id = 22 THEN kf_kommentar ELSE NULL END) AS kf_kommentar             --standard=deutsch
   , MAX(CASE WHEN spr_id = 22 THEN kf_bez ELSE NULL END)     AS kf_bez               --standard=deutsch
   , MAX(CASE WHEN spr_id = 22 THEN kf_kommentar ELSE NULL END) AS kf_kommentar_de          --deutsch
   , MAX(CASE WHEN spr_id = 22 THEN kf_bez ELSE NULL END)   AS kf_bez_de          --deutsch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 124 THEN kf_kommentar ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 124 THEN kf_kommentar ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN kf_kommentar ELSE NULL END)
   END  AS kf_kommentar_cz                       --tschechisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 124 THEN kf_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 124 THEN kf_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN kf_bez ELSE NULL END)
   END  AS kf_bez_cz                         --tschechisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 90 THEN kf_kommentar ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 90 THEN kf_kommentar ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN kf_kommentar ELSE NULL END)
   END  AS kf_kommentar_pl                     --polnisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 90 THEN kf_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 90 THEN kf_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN kf_bez ELSE NULL END)
   END  AS kf_bez_pl                       --polnisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 108 THEN kf_kommentar ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 108 THEN kf_kommentar ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN kf_kommentar ELSE NULL END)
   END  AS kf_kommentar_sk                     --slowakisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 108 THEN kf_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 108 THEN kf_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN kf_bez ELSE NULL END)
   END  AS kf_bez_sk                       --slowakisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 65 THEN kf_kommentar ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 65 THEN kf_kommentar ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN kf_kommentar ELSE NULL END)
   END  AS kf_kommentar_hr                     --kroatisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 65 THEN kf_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 65 THEN kf_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN kf_bez ELSE NULL END)
   END  AS kf_bez_hr                       --kroatisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 95 THEN kf_kommentar ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 95 THEN kf_kommentar ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN kf_kommentar ELSE NULL END)
   END  AS kf_kommentar_ro                     --rumänisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 95 THEN kf_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 95 THEN kf_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN kf_bez ELSE NULL END)
   END  AS kf_bez_ro                       --rumänisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 18 THEN kf_kommentar ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 18 THEN kf_kommentar ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN kf_kommentar ELSE NULL END)
   END  AS kf_kommentar_bg                     --bulgarisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 18 THEN kf_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 18 THEN kf_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN kf_bez ELSE NULL END)
   END  AS kf_bez_bg                       --bulgarisch
   FROM dbp_view.v_geku_kundenfaktor_spr_zu_1
   GROUP BY
   kundenfaktor_id;