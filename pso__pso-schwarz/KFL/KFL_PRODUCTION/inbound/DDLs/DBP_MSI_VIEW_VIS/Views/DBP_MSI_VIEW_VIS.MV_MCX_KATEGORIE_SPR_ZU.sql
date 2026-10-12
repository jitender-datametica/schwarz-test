CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_MCX_KATEGORIE_SPR_ZU
-- 20180502 twie: SPEC0037245 Neuanlage Sprachview Kategorie in Maritz
--                           Kategorie wird in DWH generiert, existiert nicht im Quellsystem Maritz
(
kat_id
,kat_bez
,kat_bez_cz
,kat_bez_pl
,kat_bez_sk
,kat_bez_hr
,kat_bez_ro
,kat_bez_bg
)
AS
   SELECT

   kat_id, MAX(CASE WHEN spr_id =   22 THEN kat_bez ELSE NULL END)  AS kat_bez   --standard=deutsch
   , MAX(CASE WHEN spr_id = 124 THEN kat_bez ELSE NULL END)  AS kat_bez_cz, MAX(CASE WHEN spr_id =   90 THEN kat_bez ELSE NULL END)  AS kat_bez_pl, MAX(CASE WHEN spr_id = 108 THEN kat_bez ELSE NULL END)  AS kat_bez_sk, MAX(CASE WHEN spr_id =   65 THEN kat_bez ELSE NULL END)  AS kat_bez_hr, MAX(CASE WHEN spr_id =   95 THEN kat_bez ELSE NULL END)  AS kat_bez_ro, MAX(CASE WHEN spr_id =   18 THEN kat_bez ELSE NULL END)  AS kat_bez_bg

   FROM dbp_view.v_mcx_kategorie_spr_zu

   GROUP BY kat_id
   ;