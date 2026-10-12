CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_PROBLEMCODE_SPR_ZU as
   SELECT
   mandant_id, problemcode_id, MAX(CASE WHEN spr_id =  22 THEN problemcode_bez ELSE NULL END) AS problemcode_bez      --standard=deutsch
   , MAX(CASE WHEN spr_id =  22 THEN problemcode_bez ELSE NULL END) AS problemcode_bez_de   --deutsch
   , MAX(CASE WHEN spr_id = 124 THEN problemcode_bez ELSE NULL END) AS problemcode_bez_cz   --tschechisch
   , MAX(CASE WHEN spr_id =  90 THEN problemcode_bez ELSE NULL END) AS problemcode_bez_pl   --polnisch
   , MAX(CASE WHEN spr_id = 108 THEN problemcode_bez ELSE NULL END) AS problemcode_bez_sk   --slowakisch
   , MAX(CASE WHEN spr_id =  65 THEN problemcode_bez ELSE NULL END) AS problemcode_bez_hr   --kroatisch
   , MAX(CASE WHEN spr_id =  95 THEN problemcode_bez ELSE NULL END) AS problemcode_bez_ro   --rumänisch
   , MAX(CASE WHEN spr_id =  18 THEN problemcode_bez ELSE NULL END) AS problemcode_bez_bg   --bulgarisch
   , MAX(CASE WHEN spr_id =  22 THEN problemcode_bez_kurz ELSE NULL END) AS problemcode_bez_kurz      --standard=deutsch
   , MAX(CASE WHEN spr_id =  22 THEN problemcode_bez_kurz ELSE NULL END) AS problemcode_bez_kurz_de   --deutsch
   , MAX(CASE WHEN spr_id = 124 THEN problemcode_bez_kurz ELSE NULL END) AS problemcode_bez_kurz_cz   --tschechisch
   , MAX(CASE WHEN spr_id =  90 THEN problemcode_bez_kurz ELSE NULL END) AS problemcode_bez_kurz_pl   --polnisch
   , MAX(CASE WHEN spr_id = 108 THEN problemcode_bez_kurz ELSE NULL END) AS problemcode_bez_kurz_sk   --slowakisch
   , MAX(CASE WHEN spr_id =  65 THEN problemcode_bez_kurz ELSE NULL END) AS problemcode_bez_kurz_hr   --kroatisch
   , MAX(CASE WHEN spr_id =  95 THEN problemcode_bez_kurz ELSE NULL END) AS problemcode_bez_kurz_ro   --rumänisch
   , MAX(CASE WHEN spr_id =  18 THEN problemcode_bez_kurz ELSE NULL END) AS problemcode_bez_kurz_bg   --bulgarisch
   , MAX(CASE WHEN spr_id =  22 THEN problemcode_bez_lang ELSE NULL END) AS problemcode_bez_lang      --standard=deutsch
   , MAX(CASE WHEN spr_id =  22 THEN problemcode_bez_lang ELSE NULL END) AS problemcode_bez_lang_de   --deutsch
   , MAX(CASE WHEN spr_id = 124 THEN problemcode_bez_lang ELSE NULL END) AS problemcode_bez_lang_cz   --tschechisch
   , MAX(CASE WHEN spr_id =  90 THEN problemcode_bez_lang ELSE NULL END) AS problemcode_bez_lang_pl   --polnisch
   , MAX(CASE WHEN spr_id = 108 THEN problemcode_bez_lang ELSE NULL END) AS problemcode_bez_lang_sk   --slowakisch
   , MAX(CASE WHEN spr_id =  65 THEN problemcode_bez_lang ELSE NULL END) AS problemcode_bez_lang_hr   --kroatisch
   , MAX(CASE WHEN spr_id =  95 THEN problemcode_bez_lang ELSE NULL END) AS problemcode_bez_lang_ro   --rumänisch
   , MAX(CASE WHEN spr_id =  18 THEN problemcode_bez_lang ELSE NULL END) AS problemcode_bez_lang_bg   --bulgarisch
   FROM dbp_view.v_problemcode_spr_zu
   GROUP BY
   mandant_id
   ,problemcode_id;