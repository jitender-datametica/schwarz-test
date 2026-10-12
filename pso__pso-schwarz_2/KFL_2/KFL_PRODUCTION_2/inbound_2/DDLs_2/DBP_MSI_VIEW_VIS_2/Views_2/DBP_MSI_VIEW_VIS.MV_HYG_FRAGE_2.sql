CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_HYG_FRAGE_2 as
   -- LOOKUP Hygienecheck - Frage
   -- 20140325 Initial
   -- 2015KW26 Update GJ-Abhaengigkeit

   SELECT
   frage_katalog_id, hyg_frage_id, antwort_gruppe_id, gj
   FROM dbp_view.v_hyg_frage_2

   UNION ALL
   SELECT
   frage_katalog_id, 'ZZZZ' AS hyg_frage_id, 'ZZZZ' AS antwort_gruppe_id, gj
   FROM dbp_view.v_hyg_frage_katalog_2
;