CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.mv_dispomerkmal_spr_zu_prompt
AS
SELECT
  v01.dispomerkmal
, MAX(CASE WHEN v01.spr_id = 22 THEN v01.dispomerkmal_bez END) AS dispomerkmal_bez      --standard=deutsch
, MAX(CASE WHEN v01.spr_id = 22 THEN v01.dispomerkmal_bez ELSE NULL END) AS dispomerkmal_bez_de   --deutsch
, COALESCE(MAX(CASE WHEN v01.spr_id = 124 THEN v01.dispomerkmal_bez ELSE NULL END), dispomerkmal_bez_de) AS dispomerkmal_bez_cz   --tschechisch
, COALESCE(MAX(CASE WHEN v01.spr_id = 108 THEN v01.dispomerkmal_bez ELSE NULL END), dispomerkmal_bez_de) AS dispomerkmal_bez_sk   --slowakisch
, COALESCE(MAX(CASE WHEN v01.spr_id =  65 THEN v01.dispomerkmal_bez ELSE NULL END), dispomerkmal_bez_de) AS dispomerkmal_bez_hr   --kroatisch
, COALESCE(MAX(CASE WHEN v01.spr_id =  90 THEN v01.dispomerkmal_bez ELSE NULL END), dispomerkmal_bez_de) AS dispomerkmal_bez_pl   --polnisch
, COALESCE(MAX(CASE WHEN v01.spr_id =  95 THEN v01.dispomerkmal_bez ELSE NULL END), dispomerkmal_bez_de) AS dispomerkmal_bez_ro   --rumänisch
, COALESCE(MAX(CASE WHEN v01.spr_id =  18 THEN v01.dispomerkmal_bez ELSE NULL END), dispomerkmal_bez_de) AS dispomerkmal_bez_bg   --bulgarisch 
FROM DBP_VIEW.v_dispomerkmal_spr_zu v01
JOIN DBP_VIEW.v_mandant_spr_zu v02 
  ON v01.mandant_id = v02.mandant_id
 AND v01.spr_id = v02.spr_id
GROUP BY v01.dispomerkmal;