CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_HYG_ANTWORT_1 as
   -- SPRACHE Hygienecheck - Antwort
   -- 20140325 Initial
   -- 2015KW26 Update GJ-Abhaengigkeit, Defaultvalue auf Basis frage_katalog
   -- 2015KW50: M.Gill: Umbau der Internationalisierung von Tabellen auf Spalten

   SELECT
   hyg_ref_id  AS hyg_antwort_id, gj, MAX(CASE WHEN spr_id =   22 THEN hyg_text ELSE NULL END)    AS hyg_antwort_bez     --standard=deutsch
   , MAX(CASE WHEN spr_id =   22 THEN hyg_text ELSE NULL END)    AS hyg_antwort_bez_de      --deutsch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 124 THEN hyg_text ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 124 THEN hyg_text ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN hyg_text ELSE NULL END)
   END  AS hyg_antwort_bez_cz                  --tschechisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 90 THEN hyg_text ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 90 THEN hyg_text ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN hyg_text ELSE NULL END)
   END  AS hyg_antwort_bez_pl                  --polnisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 108 THEN hyg_text ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 108 THEN hyg_text ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN hyg_text ELSE NULL END)
   END  AS hyg_antwort_bez_sk                  --slowakisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 65 THEN hyg_text ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 65 THEN hyg_text ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN hyg_text ELSE NULL END)
   END  AS hyg_antwort_bez_hr                  --kroatisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 95 THEN hyg_text ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 95 THEN hyg_text ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN hyg_text ELSE NULL END)
   END  AS hyg_antwort_bez_ro                  --rumänisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 18 THEN hyg_text ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 18 THEN hyg_text ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN hyg_text ELSE NULL END)
   END  AS hyg_antwort_bez_bg                  --bulgarisch
   FROM dbp_view.v_hyg_spr_zu_1
   WHERE
   hyg_column = 'AnswerText'
   GROUP BY
   hyg_ref_id
   ,gj
   UNION ALL
   SELECT
   CAST ('00000000-0000-0000-0000-000000000000' AS CHAR(36))  AS hyg_antwort_id, gj, ''   AS hyg_antwort_bez, ''   AS hyg_antwort_bez_de, ''   AS hyg_antwort_bez_cz, ''   AS hyg_antwort_bez_pl, ''   AS hyg_antwort_bez_sk, ''   AS hyg_antwort_bez_hr, ''   AS hyg_antwort_bez_ro, ''   AS hyg_antwort_bez_bg
   FROM dbp_view.v_hyg_frage_katalog_1;