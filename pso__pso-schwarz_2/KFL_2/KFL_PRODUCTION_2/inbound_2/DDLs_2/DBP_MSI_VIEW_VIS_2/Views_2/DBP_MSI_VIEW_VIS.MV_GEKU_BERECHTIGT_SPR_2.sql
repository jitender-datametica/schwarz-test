CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_GEKU_BERECHTIGT_SPR_2 as
   -- GEKU Sprach-Zuordnung Berechtigt (FG)
   -- 2011KW46 INITIAL
   -- 2015KW50: M.Gill: Umbau der Internationalisierung von Tabellen auf Spalten
   SELECT
   berechtigt_fg, MAX(CASE WHEN spr_id = 22 THEN berechtigt_bez ELSE NULL END) AS berechtigt_bez   --standard=deutsch
   , MAX(CASE WHEN spr_id = 22 THEN berechtigt_bez ELSE NULL END) AS berechtigt_bez_de  --deutsch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 124 THEN berechtigt_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 124 THEN berechtigt_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN berechtigt_bez ELSE NULL END)
   END  AS berechtigt_bez_cz                   --tschechisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 90 THEN berechtigt_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 90 THEN berechtigt_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN berechtigt_bez ELSE NULL END)
   END  AS berechtigt_bez_pl                 --polnisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 108 THEN berechtigt_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 108 THEN berechtigt_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN berechtigt_bez ELSE NULL END)
   END  AS berechtigt_bez_sk                 --slowakisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 65 THEN berechtigt_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 65 THEN berechtigt_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN berechtigt_bez ELSE NULL END)
   END  AS berechtigt_bez_hr                 --kroatisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 95 THEN berechtigt_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 95 THEN berechtigt_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN berechtigt_bez ELSE NULL END)
   END  AS berechtigt_bez_ro                 --rumänisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 18 THEN berechtigt_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 18 THEN berechtigt_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN berechtigt_bez ELSE NULL END)
   END  AS berechtigt_bez_bg                 --bulgarisch
   FROM dbp_view.v_geku_berechtigt_spr_zu_2
   GROUP BY
   berechtigt_fg;