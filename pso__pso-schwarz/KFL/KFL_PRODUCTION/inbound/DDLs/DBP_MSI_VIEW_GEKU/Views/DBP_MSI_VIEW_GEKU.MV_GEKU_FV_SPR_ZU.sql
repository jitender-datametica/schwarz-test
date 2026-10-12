CREATE OR REPLACE VIEW DBP_MSI_VIEW_GEKU.MV_GEKU_FV_SPR_ZU
(
fv_fg
,fv_bez
,fv_bez_cz
,fv_bez_pl
,fv_bez_sk
,fv_bez_hr
,fv_bez_ro
,fv_bez_bg
)
AS
-- 27.02.2017 twie: SPEC0019359 Umstellung spaltenbasiert

   SELECT

   v01.fv_fg
   , MAX(CASE WHEN v01.spr_id =  22 THEN v01.fv_bez ELSE NULL END) AS fv_bez   --standard=deutsch
   , MAX(CASE WHEN v01.spr_id = 124 THEN v01.fv_bez ELSE NULL END) AS fv_bez_cz
   , MAX(CASE WHEN v01.spr_id =  90 THEN v01.fv_bez ELSE NULL END) AS fv_bez_pl
   , MAX(CASE WHEN v01.spr_id = 108 THEN v01.fv_bez ELSE NULL END) AS fv_bez_sk
   , MAX(CASE WHEN v01.spr_id =  65 THEN v01.fv_bez ELSE NULL END) AS fv_bez_hr
   , MAX(CASE WHEN v01.spr_id =  95 THEN v01.fv_bez ELSE NULL END) AS fv_bez_ro
   , MAX(CASE WHEN v01.spr_id =  18 THEN v01.fv_bez ELSE NULL END) AS fv_bez_bg

   FROM dbp_view.v_geku_fv_spr_zu v01

   GROUP BY v01.fv_fg;