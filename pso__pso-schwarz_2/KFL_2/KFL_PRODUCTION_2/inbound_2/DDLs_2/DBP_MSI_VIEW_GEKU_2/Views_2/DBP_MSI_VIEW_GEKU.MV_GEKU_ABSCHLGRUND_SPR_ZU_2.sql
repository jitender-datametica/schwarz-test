CREATE OR REPLACE VIEW DBP_MSI_VIEW_GEKU.MV_GEKU_ABSCHLGRUND_SPR_ZU_2
(
abschlussgrund_id
,abschlussgrund_bez
,abschlussgrund_bez_cz
,abschlussgrund_bez_pl
,abschlussgrund_bez_sk
,abschlussgrund_bez_hr
,abschlussgrund_bez_ro
,abschlussgrund_bez_bg
)
AS
-- 08.02.2017 twie: SPEC0019359 Umstellung spaltenbasiert

   SELECT

   v01.abschlussgrund_id
   , MAX(CASE WHEN v01.spr_id =   22 THEN v01.abschlussgrund_bez ELSE NULL END)  AS abschlussgrund_bez   --standard=deutsch
   , MAX(CASE WHEN v01.spr_id = 124 THEN v01.abschlussgrund_bez ELSE NULL END)  AS abschlussgrund_bez_cz
   , MAX(CASE WHEN v01.spr_id =   90 THEN v01.abschlussgrund_bez ELSE NULL END)  AS abschlussgrund_bez_pl
   , MAX(CASE WHEN v01.spr_id = 108 THEN v01.abschlussgrund_bez ELSE NULL END)  AS abschlussgrund_bez_sk
   , MAX(CASE WHEN v01.spr_id =   65 THEN v01.abschlussgrund_bez ELSE NULL END)  AS abschlussgrund_bez_hr
   , MAX(CASE WHEN v01.spr_id =   95 THEN v01.abschlussgrund_bez ELSE NULL END)  AS abschlussgrund_bez_ro
   , MAX(CASE WHEN v01.spr_id =   18 THEN v01.abschlussgrund_bez ELSE NULL END)  AS abschlussgrund_bez_bg

   FROM dbp_view.v_geku_abschlussgrund_spr_zu_2 v01

   GROUP BY v01.abschlussgrund_id;