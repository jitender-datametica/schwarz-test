CREATE OR REPLACE VIEW DBP_MSI_VIEW_GEKU.MV_GEKU_KUNDENFAKTOR_SPR_ZU_1
(
kundenfaktor_id
,kf_kommentar
,kf_kommentar_cz
,kf_kommentar_pl
,kf_kommentar_sk
,kf_kommentar_hr
,kf_kommentar_ro
,kf_kommentar_bg
,kf_bez
,kf_bez_cz
,kf_bez_pl
,kf_bez_sk
,kf_bez_hr
,kf_bez_ro
,kf_bez_bg
)
AS
-- 27.02.2017 twie: SPEC0019359 Umstellung spaltenbasiert

   SELECT

   kundenfaktor_id
   , MAX(CASE WHEN v01.spr_id =   22 THEN v01.kf_kommentar ELSE NULL END)  AS kf_kommentar   --standard=deutsch
   , MAX(CASE WHEN v01.spr_id = 124 THEN v01.kf_kommentar ELSE NULL END)  AS kf_kommentar_cz
   , MAX(CASE WHEN v01.spr_id =   90 THEN v01.kf_kommentar ELSE NULL END)  AS kf_kommentar_pl
   , MAX(CASE WHEN v01.spr_id = 108 THEN v01.kf_kommentar ELSE NULL END)  AS kf_kommentar_sk
   , MAX(CASE WHEN v01.spr_id =   65 THEN v01.kf_kommentar ELSE NULL END)  AS kf_kommentar_hr
   , MAX(CASE WHEN v01.spr_id =   95 THEN v01.kf_kommentar ELSE NULL END)  AS kf_kommentar_ro
   , MAX(CASE WHEN v01.spr_id =   18 THEN v01.kf_kommentar ELSE NULL END)  AS kf_kommentar_bg
   
   , MAX(CASE WHEN v01.spr_id =   22 THEN v01.kf_bez ELSE NULL END)  AS kf_bez --standard=deutsch
   , MAX(CASE WHEN v01.spr_id = 124 THEN v01.kf_bez ELSE NULL END)  AS kf_bez_cz
   , MAX(CASE WHEN v01.spr_id =   90 THEN v01.kf_bez ELSE NULL END)  AS kf_bez_pl
   , MAX(CASE WHEN v01.spr_id = 108 THEN v01.kf_bez ELSE NULL END)  AS kf_bez_sk
   , MAX(CASE WHEN v01.spr_id =   65 THEN v01.kf_bez ELSE NULL END)  AS kf_bez_hr
   , MAX(CASE WHEN v01.spr_id =   95 THEN v01.kf_bez ELSE NULL END)  AS kf_bez_ro
   , MAX(CASE WHEN v01.spr_id =   18 THEN v01.kf_bez ELSE NULL END)  AS kf_bez_bg

   FROM dbp_view.v_geku_kundenfaktor_spr_zu_1 v01

   GROUP BY v01.kundenfaktor_id;