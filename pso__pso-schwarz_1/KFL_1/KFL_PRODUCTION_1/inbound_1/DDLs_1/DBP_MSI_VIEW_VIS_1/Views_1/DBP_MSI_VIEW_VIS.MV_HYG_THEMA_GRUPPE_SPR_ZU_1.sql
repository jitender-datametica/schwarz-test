CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_HYG_THEMA_GRUPPE_SPR_ZU_1 as
   -- SPRACHE Gruppierung von Hygiene - Thema (pro GJ)
   -- Abloesung Konsolidierungen
   -- 2015KW26 : Initial - (noch) nicht mehrsprachig
   -- 2015KW50: M.Gill: Umbau der Internationalisierung von Tabellen auf Spalten

   SELECT
   tgs.hyg_thema_gruppe_id, MAX(CASE WHEN spr_id =   22 THEN hyg_thema_gruppe_bez ELSE NULL END)    AS hyg_thema_gruppe_bez        --standard=deutsch
   , MAX(CASE WHEN spr_id =   22 THEN hyg_thema_gruppe_bez ELSE NULL END)    AS hyg_thema_gruppe_bez_de     --deutsch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 124 THEN hyg_thema_gruppe_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 124 THEN hyg_thema_gruppe_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN hyg_thema_gruppe_bez ELSE NULL END)
   END  AS hyg_thema_gruppe_bez_cz                     --tschechisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 90 THEN hyg_thema_gruppe_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 90 THEN hyg_thema_gruppe_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN hyg_thema_gruppe_bez ELSE NULL END)
   END  AS hyg_thema_gruppe_bez_pl                   --polnisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 108 THEN hyg_thema_gruppe_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 108 THEN hyg_thema_gruppe_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN hyg_thema_gruppe_bez ELSE NULL END)
   END  AS hyg_thema_gruppe_bez_sk                   --slowakisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 65 THEN hyg_thema_gruppe_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 65 THEN hyg_thema_gruppe_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN hyg_thema_gruppe_bez ELSE NULL END)
   END  AS hyg_thema_gruppe_bez_hr                   --kroatisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 95 THEN hyg_thema_gruppe_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 95 THEN hyg_thema_gruppe_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN hyg_thema_gruppe_bez ELSE NULL END)
   END  AS hyg_thema_gruppe_bez_ro                   --rumänisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 18 THEN hyg_thema_gruppe_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 18 THEN hyg_thema_gruppe_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN hyg_thema_gruppe_bez ELSE NULL END)
   END  AS hyg_thema_gruppe_bez_bg                   --bulgarisch
   FROM dbp_msi_view_vis.ts_hyg_thema_gruppe_spr_zu_1  tgs
   GROUP BY
   tgs.hyg_thema_gruppe_id;