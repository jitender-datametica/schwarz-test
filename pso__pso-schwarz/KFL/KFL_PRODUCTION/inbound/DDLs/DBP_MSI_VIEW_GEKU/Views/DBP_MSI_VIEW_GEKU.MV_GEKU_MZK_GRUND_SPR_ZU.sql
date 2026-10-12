CREATE OR REPLACE VIEW DBP_MSI_VIEW_GEKU.MV_GEKU_MZK_GRUND_SPR_ZU
(
geku_mzk_grund_uid
,geku_mzk_grund_bez
,geku_mzk_grund_bez_cz
,geku_mzk_grund_bez_pl
,geku_mzk_grund_bez_sk
,geku_mzk_grund_bez_hr
,geku_mzk_grund_bez_ro
,geku_mzk_grund_bez_bg
)
AS
-- 27.02.2017 twie: SPEC0019359 Umstellung spaltenbasiert

   SELECT

   v01.geku_mzk_grund_uid
   , MAX(CASE WHEN v01.spr_id =   22 THEN v01.geku_mzk_grund_bez ELSE NULL END)  AS geku_mzk_grund_bez   --standard=deutsch
   , MAX(CASE WHEN v01.spr_id = 124 THEN v01.geku_mzk_grund_bez ELSE NULL END)  AS geku_mzk_grund_bez_cz
   , MAX(CASE WHEN v01.spr_id =   90 THEN v01.geku_mzk_grund_bez ELSE NULL END)  AS geku_mzk_grund_bez_pl
   , MAX(CASE WHEN v01.spr_id = 108 THEN v01.geku_mzk_grund_bez ELSE NULL END)  AS geku_mzk_grund_bez_sk
   , MAX(CASE WHEN v01.spr_id =   65 THEN v01.geku_mzk_grund_bez ELSE NULL END)  AS geku_mzk_grund_bez_hr
   , MAX(CASE WHEN v01.spr_id =   95 THEN v01.geku_mzk_grund_bez ELSE NULL END)  AS geku_mzk_grund_bez_ro
   , MAX(CASE WHEN v01.spr_id =   18 THEN v01.geku_mzk_grund_bez ELSE NULL END)  AS geku_mzk_grund_bez_bg

   FROM dbp_view.v_geku_mzk_grund_spr_zu v01

   GROUP BY v01.geku_mzk_grund_uid;