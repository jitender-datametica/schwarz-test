CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_HYG_FRAGE_KATALOG as
   -- LOOKUP Hygienecheck - Frage-Katalog
   -- 20140325 Initial
   -- 2015KW26 Update GJ-Abhaengigkeit

   SELECT
   frage_katalog_id, frage_katalog_bez, frage_katalog_bez_lang, gj
   FROM dbp_view.v_hyg_frage_katalog
;