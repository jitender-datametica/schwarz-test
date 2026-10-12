CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_HYG_FRAGE_SPR_ZU_2 as
   -- SPRACHE Hygienecheck - Frage
   -- 20140325 Initial
   -- 2015KW26 Update GJ-Abhaengigkeit
   -- 2015KW50: M.Gill: Umbau der Internationalisierung von Tabellen auf Spalten

   SELECT
   hf.frage_katalog_id, hf.hyg_frage_id, hf.gj, MAX(CASE WHEN spr_id =   22 THEN hyg_text ELSE NULL END)    AS hyg_frage_bez       --standard=deutsch
   , MAX(CASE WHEN spr_id =   22 THEN hyg_text ELSE NULL END)    AS hyg_frage_bez_de  --deutsch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 124 THEN hyg_text ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 124 THEN hyg_text ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN hyg_text ELSE NULL END)
   END  AS hyg_frage_bez_cz      --tschechisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 90 THEN hyg_text ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 90 THEN hyg_text ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN hyg_text ELSE NULL END)
   END  AS hyg_frage_bez_pl    --polnisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 108 THEN hyg_text ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 108 THEN hyg_text ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN hyg_text ELSE NULL END)
   END  AS hyg_frage_bez_sk    -- slowakisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 65 THEN hyg_text ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 65 THEN hyg_text ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN hyg_text ELSE NULL END)
   END  AS hyg_frage_bez_hr    -- kroatisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 95 THEN hyg_text ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 95 THEN hyg_text ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN hyg_text ELSE NULL END)
   END  AS hyg_frage_bez_ro    --rumänisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 18 THEN hyg_text ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 18 THEN hyg_text ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN hyg_text ELSE NULL END)
   END  AS hyg_frage_bez_bg    --bulgarisch
   FROM dbp_view.v_hyg_frage_2 hf
   INNER JOIN dbp_view.v_hyg_spr_zu_2 hs
   ON hf.hyg_frage_id = hs.hyg_ref_id
   AND hf.gj = hs.gj
   WHERE
   hs.hyg_column = 'QuestionText'
   GROUP BY
   hf.frage_katalog_id
   ,hf.hyg_frage_id
   ,hf.gj
   UNION ALL
   SELECT
   frage_katalog_id, 'ZZZZ'   hyg_frage_id, gj, 'Gesamt'  AS hyg_frage_bez, 'Gesamt'  AS hyg_frage_bez_de, 'Gesamt'  AS hyg_frage_bez_cz, 'Gesamt'  AS hyg_frage_bez_pl, 'Gesamt'  AS hyg_frage_bez_sk, 'Gesamt'  AS hyg_frage_bez_hr, 'Gesamt'  AS hyg_frage_bez_ro, 'Gesamt'  AS hyg_frage_bez_bg
   FROM dbp_view.v_hyg_frage_katalog_2;