CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_TEKU_FRAGE_SPR_ZU as
   SELECT
   teku_frage_id, MAX(CASE WHEN spr_id =  22 THEN teku_frage_bez ELSE NULL END) AS teku_frage_bez      --standard=deutsch
   , MAX(CASE WHEN spr_id =  22 THEN teku_frage_bez ELSE NULL END) AS teku_frage_bez_de   --deutsch
   , MAX(CASE WHEN spr_id = 124 THEN teku_frage_bez ELSE NULL END) AS teku_frage_bez_cz   --tschechisch
   , MAX(CASE WHEN spr_id =  90 THEN teku_frage_bez ELSE NULL END) AS teku_frage_bez_pl   --polnisch
   , MAX(CASE WHEN spr_id = 108 THEN teku_frage_bez ELSE NULL END) AS teku_frage_bez_sk   --slowakisch
   , MAX(CASE WHEN spr_id =  65 THEN teku_frage_bez ELSE NULL END) AS teku_frage_bez_hr   --kroatisch
   , MAX(CASE WHEN spr_id =  95 THEN teku_frage_bez ELSE NULL END) AS teku_frage_bez_ro   --rumänisch
   , MAX(CASE WHEN spr_id =  18 THEN teku_frage_bez ELSE NULL END) AS teku_frage_bez_bg   --bulgarisch
   , MAX(CASE WHEN spr_id =  22 THEN teku_frage_bez_lang ELSE NULL END) AS teku_frage_bez_lang      --standard=deutsch
   , MAX(CASE WHEN spr_id =  22 THEN teku_frage_bez_lang ELSE NULL END) AS teku_frage_bez_lang_de   --deutsch
   , MAX(CASE WHEN spr_id = 124 THEN teku_frage_bez_lang ELSE NULL END) AS teku_frage_bez_lang_cz   --tschechisch
   , MAX(CASE WHEN spr_id =  90 THEN teku_frage_bez_lang ELSE NULL END) AS teku_frage_bez_lang_pl   --polnisch
   , MAX(CASE WHEN spr_id = 108 THEN teku_frage_bez_lang ELSE NULL END) AS teku_frage_bez_lang_sk   --slowakisch
   , MAX(CASE WHEN spr_id =  65 THEN teku_frage_bez_lang ELSE NULL END) AS teku_frage_bez_lang_hr   --kroatisch
   , MAX(CASE WHEN spr_id =  95 THEN teku_frage_bez_lang ELSE NULL END) AS teku_frage_bez_lang_ro   --rumänisch
   , MAX(CASE WHEN spr_id =  18 THEN teku_frage_bez_lang ELSE NULL END) AS teku_frage_bez_lang_bg   --bulgarisch
   FROM dbp_view.v_teku_frage_spr_zu
   GROUP BY
   teku_frage_id;