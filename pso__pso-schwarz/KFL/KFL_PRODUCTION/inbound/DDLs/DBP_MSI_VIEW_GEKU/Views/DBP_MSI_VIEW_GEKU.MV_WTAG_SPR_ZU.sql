CREATE OR REPLACE VIEW DBP_MSI_VIEW_GEKU.MV_WTAG_SPR_ZU
(
    wtag_id
   ,wtag_bez
   ,wtag_bez_cz
   ,wtag_bez_pl
   ,wtag_bez_sk
   ,wtag_bez_hr
   ,wtag_bez_ro
   ,wtag_bez_bg
)
AS
-- 18.10.2021 twie: SPEC0129990	neues Attribut Wochentag

   SELECT
    v01.wtag_id
   ,MAX(CASE WHEN v01.spr_id =  22 THEN v01.wtag_bez ELSE NULL END) AS wtag_bez   
   ,MAX(CASE WHEN v01.spr_id = 124 THEN v01.wtag_bez ELSE NULL END) AS wtag_bez_cz
   ,MAX(CASE WHEN v01.spr_id =  90 THEN v01.wtag_bez ELSE NULL END) AS wtag_bez_pl
   ,MAX(CASE WHEN v01.spr_id = 108 THEN v01.wtag_bez ELSE NULL END) AS wtag_bez_sk
   ,MAX(CASE WHEN v01.spr_id =  65 THEN v01.wtag_bez ELSE NULL END) AS wtag_bez_hr
   ,MAX(CASE WHEN v01.spr_id =  95 THEN v01.wtag_bez ELSE NULL END) AS wtag_bez_ro
   ,MAX(CASE WHEN v01.spr_id =  18 THEN v01.wtag_bez ELSE NULL END) AS wtag_bez_bg

   FROM dbp_view.v_wtag_spr_zu v01

   GROUP BY v01.wtag_id;