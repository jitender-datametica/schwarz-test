CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_HYG_THEMA_SPR_ZU as
   -- SPRACHE Hygienecheck - Thema
   -- 20140325 Initial
   -- 2015KW26 Update GJ-Abhaengigkeit
   -- 2015KW50: M.Gill: Umbau der Internationalisierung von Tabellen auf Spalten

   SELECT
   th.frage_katalog_id, th.hyg_thema_id, th.gj, MAX(CASE WHEN spr_id =   22 THEN hyg_text ELSE NULL END)    AS hyg_thema_bez           --standard=deutsch
   , MAX(CASE WHEN spr_id =   22 THEN hyg_text ELSE NULL END)    AS hyg_thema_bez_de      --deutsch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 124 THEN hyg_text ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 124 THEN hyg_text ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN hyg_text ELSE NULL END)
   END  AS hyg_thema_bez_cz                    --tschechisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 90 THEN hyg_text ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 90 THEN hyg_text ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN hyg_text ELSE NULL END)
   END  AS hyg_thema_bez_pl                  --polnisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 108 THEN hyg_text ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 108 THEN hyg_text ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN hyg_text ELSE NULL END)
   END  AS hyg_thema_bez_sk                  --slowakisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 65 THEN hyg_text ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 65 THEN hyg_text ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN hyg_text ELSE NULL END)
   END  AS hyg_thema_bez_hr                  --kroatisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 95 THEN hyg_text ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 95 THEN hyg_text ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN hyg_text ELSE NULL END)
   END  AS hyg_thema_bez_ro                  --rumänisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 18 THEN hyg_text ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 18 THEN hyg_text ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN hyg_text ELSE NULL END)
   END  AS hyg_thema_bez_bg                  --bulgarisch
   FROM dbp_view.v_hyg_thema th
   INNER JOIN dbp_view.v_hyg_spr_zu hs
   ON th.hyg_thema_id = hs.hyg_ref_id
   AND th.gj = hs.gj
   WHERE
   hs.hyg_column = 'Name'
   GROUP BY
   th.frage_katalog_id
   ,th.hyg_thema_id
   ,th.gj;