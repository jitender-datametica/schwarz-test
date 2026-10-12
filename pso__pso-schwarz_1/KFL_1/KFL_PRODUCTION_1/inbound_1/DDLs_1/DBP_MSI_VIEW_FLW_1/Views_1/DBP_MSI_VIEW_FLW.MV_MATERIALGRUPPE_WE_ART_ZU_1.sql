CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_MATERIALGRUPPE_WE_ART_ZU_1
-- 19.08.2014 TWIE: Umstellung von Industrie auf eigene FLW Tabellen
(
mandant_id
,in_art_id
,materialgruppe_id
)
AS

   SELECT
   prd_stufe1.mandant_id, prd_stufe1.flw_art_id AS in_art_id,
   CASE
   WHEN prd_stufe1.art_col_auspr ='FZERL'
   AND prd_stufe2.art_col_auspr='01' THEN 1
   WHEN prd_stufe1.art_col_auspr ='FZERL'
   AND prd_stufe2.art_col_auspr='02' THEN 2
   WHEN prd_stufe1.art_col_auspr ='FZERL'
   AND prd_stufe2.art_col_auspr='03' THEN 3
   WHEN prd_stufe1.art_col_auspr ='FFERT' THEN 4
   END as materialgruppe_id

   FROM
   (
   SELECT
   art_col_auspr,
   mandant_id,
   flw_art_id
   FROM dbp_view.v_flw_art_col_zu_1
   WHERE flw_art_col_id =1 ) prd_stufe1
   INNER JOIN

   (
   SELECT
   art_col_auspr,
   mandant_id,
   flw_art_id
   FROM dbp_view.v_flw_art_col_zu_1
   WHERE flw_art_col_id =2 ) prd_stufe2
   ON prd_stufe1.mandant_id = prd_stufe2.mandant_id
   AND
   prd_stufe1.flw_art_id = prd_stufe2.flw_art_id

   WHERE materialgruppe_id IS NOT NULL;