CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_GEKU_DWH_ART_VIS_SPR_ZU as
   -- Sprach Lookup für GEKU DWH Artikel VIS
   -- 2012KW25 TB INITIAL
   -- 2015KW50: M.Gill: Umbau der Internationalisierung von Tabellen auf Spalten
   -- 20160229 UNION / VIS Artikel entfernt!

   SELECT
   geku_dwh_artikel_id  AS geku_dwh_artikel_vis_id, MAX(CASE WHEN spr_id = 22 THEN geku_dwh_artikel_bez ELSE NULL END) AS geku_dwh_artikel_vis_bez         --standard=deutsch
   , MAX(CASE WHEN spr_id = 22 THEN geku_dwh_artikel_bez ELSE NULL END) AS geku_dwh_artikel_vis_bez_de --deutsch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 124 THEN geku_dwh_artikel_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 124 THEN geku_dwh_artikel_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN geku_dwh_artikel_bez ELSE NULL END)
   END  AS geku_dwh_artikel_vis_bez_cz             --tschechisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 90 THEN geku_dwh_artikel_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 90 THEN geku_dwh_artikel_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN geku_dwh_artikel_bez ELSE NULL END)
   END  AS geku_dwh_artikel_vis_bez_pl            --polnisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 108 THEN geku_dwh_artikel_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 108 THEN geku_dwh_artikel_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN geku_dwh_artikel_bez ELSE NULL END)
   END  AS geku_dwh_artikel_vis_bez_sk            --slowakisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 65 THEN geku_dwh_artikel_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 65 THEN geku_dwh_artikel_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN geku_dwh_artikel_bez ELSE NULL END)
   END  AS geku_dwh_artikel_vis_bez_hr            --kroatisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 95 THEN geku_dwh_artikel_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 95 THEN geku_dwh_artikel_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN geku_dwh_artikel_bez ELSE NULL END)
   END  AS geku_dwh_artikel_vis_bez_ro            --rumänisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 18 THEN geku_dwh_artikel_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 18 THEN geku_dwh_artikel_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN geku_dwh_artikel_bez ELSE NULL END)
   END  AS geku_dwh_artikel_vis_bez_bg            --bulgarisch

   FROM dbp_view.v_geku_dwh_artikel_spr_zu
   GROUP BY  geku_dwh_artikel_id

   /* UNION ALL
   SELECT
   -99 AS geku_dwh_artikel_vis_id
   ,'' AS geku_dwh_artikel_vis_bez
   ,'' AS geku_dwh_artikel_vis_bez_de
   ,'' AS geku_dwh_artikel_vis_bez_cz
   ,'' AS geku_dwh_artikel_vis_bez_pl
   ,'' AS geku_dwh_artikel_vis_bez_sk
   ,'' AS geku_dwh_artikel_vis_bez_hr
   ,'' AS geku_dwh_artikel_vis_bez_ro
   ,'' AS geku_dwh_artikel_vis_bez_bg
   FROM
   dbp_view.v_tag
   WHERE
   dat = DATE */
   ;