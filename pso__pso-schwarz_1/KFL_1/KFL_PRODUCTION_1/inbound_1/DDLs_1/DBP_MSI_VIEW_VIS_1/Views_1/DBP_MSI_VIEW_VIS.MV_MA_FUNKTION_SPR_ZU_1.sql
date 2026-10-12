CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_MA_FUNKTION_SPR_ZU_1 as
   -- SPRACHE Mitarbeiter-Funktion
   -- Enthaelt Funktionen aller Hiererchietypen (Sprache deutsch)
   -- 201201 Initial
   -- 20120405 Update
   -- 2015KW50: M.Gill: Umbau der Internationalisierung von Tabellen auf Spalten
   SELECT
   v01.mandant_id, v01.ma_funktion_id, MAX(CASE WHEN spr_id =   22 THEN ma_funktion_bez ELSE NULL END) AS ma_funktion_bez --standard=deutsch
   , MAX(CASE WHEN spr_id =   22 THEN ma_funktion_bez ELSE NULL END) AS ma_funktion_bez_de  --deutsch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 124 THEN ma_funktion_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 124 THEN ma_funktion_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN ma_funktion_bez  ELSE NULL END)
   END AS ma_funktion_bez_cz                   --tschechisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 90 THEN ma_funktion_bez  ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 90 THEN ma_funktion_bez  ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN ma_funktion_bez  ELSE NULL END)
   END AS ma_funktion_bez_pl                 --polnisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 108 THEN ma_funktion_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 108 THEN ma_funktion_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN ma_funktion_bez ELSE NULL END)
   END AS ma_funktion_bez_sk                 --slowakisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 65 THEN ma_funktion_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 65 THEN ma_funktion_bez  ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN ma_funktion_bez ELSE NULL END)
   END AS ma_funktion_bez_hr                 --kroatisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 95 THEN ma_funktion_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 95 THEN ma_funktion_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN ma_funktion_bez  ELSE NULL END)
   END AS ma_funktion_bez_ro                 --rumänisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 18 THEN ma_funktion_bez  ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 18 THEN ma_funktion_bez  ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN ma_funktion_bez ELSE NULL END)
   END AS ma_funktion_bez_bg                 --bulgarisch
   FROM dbp_view.v_ma_funktion_spr_zu_1  v01
   GROUP BY
   v01.mandant_id
   ,v01.ma_funktion_id;