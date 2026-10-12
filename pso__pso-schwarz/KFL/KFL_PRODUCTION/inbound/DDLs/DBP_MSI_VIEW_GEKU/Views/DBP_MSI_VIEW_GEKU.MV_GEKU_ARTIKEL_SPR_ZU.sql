CREATE OR REPLACE VIEW DBP_MSI_VIEW_GEKU.MV_GEKU_ARTIKEL_SPR_ZU
(
geku_artikel_uid
,geku_artikel_bez
,geku_artikel_bez_cz
,geku_artikel_bez_pl
,geku_artikel_bez_sk
,geku_artikel_bez_hr
,geku_artikel_bez_ro
,geku_artikel_bez_bg
)
AS
-- 08.02.2017 twie: SPEC0019359 Umstellung spaltenbasiert

   SELECT

   v01.geku_artikel_uid
   , MAX(CASE WHEN v01.spr_id =   22 THEN v01.geku_artikel_bez ELSE NULL END)  AS geku_artikel_bez   --standard=deutsch
   , MAX(CASE WHEN v01.spr_id = 124 THEN v01.geku_artikel_bez ELSE NULL END)  AS geku_artikel_bez_cz
   , MAX(CASE WHEN v01.spr_id =   90 THEN v01.geku_artikel_bez ELSE NULL END)  AS geku_artikel_bez_pl
   , MAX(CASE WHEN v01.spr_id = 108 THEN v01.geku_artikel_bez ELSE NULL END)  AS geku_artikel_bez_sk
   , MAX(CASE WHEN v01.spr_id =   65 THEN v01.geku_artikel_bez ELSE NULL END)  AS geku_artikel_bez_hr
   , MAX(CASE WHEN v01.spr_id =   95 THEN v01.geku_artikel_bez ELSE NULL END)  AS geku_artikel_bez_ro
   , MAX(CASE WHEN v01.spr_id =   18 THEN v01.geku_artikel_bez ELSE NULL END)  AS geku_artikel_bez_bg

   FROM dbp_view.v_geku_artikel_spr_zu v01

   GROUP BY v01.geku_artikel_uid;