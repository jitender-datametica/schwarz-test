CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_GS_EREIGNISQUELLE_2 as
   -- LOOKUP/SPRACHE Ereignisquelle
   -- 2010KW17 GSS Redesign + Rollout KMO
   -- 2011KW37: Internationaliserung (feste Sprache)
   -- 2015KW50: M.Gill: Umbau der Internationalisierung von Tabellen auf Spalten

   SELECT
   mandant_id, ereignisquelle_id, MAX(CASE WHEN spr_id =   22 THEN ereignisquelle_bez ELSE NULL END)    AS ereignisquelle_bez    --standard=deutsch
   , MAX(CASE WHEN spr_id =   22 THEN ereignisquelle_bez ELSE NULL END)    AS ereignisquelle_bez_de --deutsch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 124 THEN ereignisquelle_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 124 THEN ereignisquelle_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN ereignisquelle_bez ELSE NULL END)
   END  AS ereignisquelle_bez_cz                   --tschechisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 90 THEN ereignisquelle_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 90 THEN ereignisquelle_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN ereignisquelle_bez ELSE NULL END)
   END  AS ereignisquelle_bez_pl                 --polnisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 108 THEN ereignisquelle_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 108 THEN ereignisquelle_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN ereignisquelle_bez ELSE NULL END)
   END  AS ereignisquelle_bez_sk                 --slowakisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 65 THEN ereignisquelle_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 65 THEN ereignisquelle_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN ereignisquelle_bez ELSE NULL END)
   END  AS ereignisquelle_bez_hr                 --kroatisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 95 THEN ereignisquelle_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 95 THEN ereignisquelle_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN ereignisquelle_bez ELSE NULL END)
   END  AS ereignisquelle_bez_ro                 --rumänisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 18 THEN ereignisquelle_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 18 THEN ereignisquelle_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN ereignisquelle_bez ELSE NULL END)
   END  AS ereignisquelle_bez_bg                 --bulgarisch
   FROM dbp_view.v_ereignisquelle_spr_zu_2 v01
   GROUP BY
   mandant_id
   ,ereignisquelle_id;