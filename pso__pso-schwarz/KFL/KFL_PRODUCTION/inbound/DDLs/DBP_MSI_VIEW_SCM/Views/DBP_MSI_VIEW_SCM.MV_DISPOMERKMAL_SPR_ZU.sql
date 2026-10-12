CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_DISPOMERKMAL_SPR_ZU as
   SELECT
   v01.mandant_id, v01.dispomerkmal, MAX(CASE WHEN spr_id =  22 THEN v01.dispomerkmal_bez END) AS dispomerkmal_bez      --standard=deutsch
   , MAX(CASE WHEN spr_id =  22 THEN v01.dispomerkmal_bez ELSE NULL END)   AS dispomerkmal_bez_de   --deutsch
   , COALESCE(MAX(CASE WHEN spr_id = 124 THEN v01.dispomerkmal_bez ELSE NULL END),dispomerkmal_bez_de) AS dispomerkmal_bez_cz   --tschechisch
   ,  COALESCE(MAX(CASE WHEN spr_id =  90 THEN v01.dispomerkmal_bez ELSE NULL END), dispomerkmal_bez_de) AS dispomerkmal_bez_pl   --polnisch
   ,  COALESCE(MAX(CASE WHEN spr_id = 108 THEN v01.dispomerkmal_bez ELSE NULL END), dispomerkmal_bez_de) AS dispomerkmal_bez_sk   --slowakisch
   ,  COALESCE(MAX(CASE WHEN spr_id =  65 THEN v01.dispomerkmal_bez ELSE NULL END), dispomerkmal_bez_de) AS dispomerkmal_bez_hr   --kroatisch
   ,  COALESCE(MAX(CASE WHEN spr_id =  95 THEN v01.dispomerkmal_bez ELSE NULL END), dispomerkmal_bez_de) AS dispomerkmal_bez_ro   --rumÃýnisch
   ,  COALESCE(MAX(CASE WHEN spr_id =  18 THEN v01.dispomerkmal_bez ELSE NULL END), dispomerkmal_bez_de) AS dispomerkmal_bez_bg   --bulgarisch
   FROM dbp_view.v_dispomerkmal_spr_zu v01
   group by
   v01.mandant_id
   , v01.dispomerkmal;