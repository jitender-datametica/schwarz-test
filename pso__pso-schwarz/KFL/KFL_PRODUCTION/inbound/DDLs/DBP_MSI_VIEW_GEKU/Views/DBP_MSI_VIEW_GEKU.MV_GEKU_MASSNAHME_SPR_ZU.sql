CREATE OR REPLACE VIEW DBP_MSI_VIEW_GEKU.MV_GEKU_MASSNAHME_SPR_ZU
(
geku_massnahme_uid
,geku_massnahme_bez
,geku_massnahme_bez_cz
,geku_massnahme_bez_pl
,geku_massnahme_bez_sk
,geku_massnahme_bez_hr
,geku_massnahme_bez_ro
,geku_massnahme_bez_bg
)
AS
-- 27.02.2017 twie: SPEC0019359 Umstellung spaltenbasiert

   SELECT

   v01.geku_massnahme_uid
   , MAX(CASE WHEN v01.spr_id =   22 THEN v01.geku_massnahme_bez ELSE NULL END)  AS geku_massnahme_bez   --standard=deutsch
   , MAX(CASE WHEN v01.spr_id = 124 THEN v01.geku_massnahme_bez ELSE NULL END)  AS geku_massnahme_bez_cz
   , MAX(CASE WHEN v01.spr_id =   90 THEN v01.geku_massnahme_bez ELSE NULL END)  AS geku_massnahme_bez_pl
   , MAX(CASE WHEN v01.spr_id = 108 THEN v01.geku_massnahme_bez ELSE NULL END)  AS geku_massnahme_bez_sk
   , MAX(CASE WHEN v01.spr_id =   65 THEN v01.geku_massnahme_bez ELSE NULL END)  AS geku_massnahme_bez_hr
   , MAX(CASE WHEN v01.spr_id =   95 THEN v01.geku_massnahme_bez ELSE NULL END)  AS geku_massnahme_bez_ro
   , MAX(CASE WHEN v01.spr_id =   18 THEN v01.geku_massnahme_bez ELSE NULL END)  AS geku_massnahme_bez_bg

   FROM dbp_view.v_geku_massnahme_spr_zu v01

   GROUP BY v01.geku_massnahme_uid;