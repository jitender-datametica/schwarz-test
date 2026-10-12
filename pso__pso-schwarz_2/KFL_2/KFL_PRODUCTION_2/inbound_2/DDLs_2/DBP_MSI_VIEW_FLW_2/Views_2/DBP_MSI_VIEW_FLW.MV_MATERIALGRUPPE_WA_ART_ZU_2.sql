CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_MATERIALGRUPPE_WA_ART_ZU_2
-- 23.01.2013 twie: Filterung auf Mandant_2 und Werk, weil Tabelle in_art_wup_status_2 fuer Projekt SAKO erweitert
-- 19.08.2014 TWIE: Umstellung von Industrie auf eigene FLW Tabellen
(
mandant_id
,in_art_id
,werk_id
,materialgruppe_id
)
AS

   SELECT
   prd_stufe1.mandant_id, prd_stufe1.flw_art_id AS in_art_id, v01.werk_id,
   CASE
   WHEN prd_stufe1.art_col_auspr ='FFERT'
   AND prd_stufe2.art_col_auspr='01'
   AND v01.beschaffungsart_id = 'E' THEN 1
   WHEN prd_stufe1.art_col_auspr ='FFERT'
   AND prd_stufe2.art_col_auspr='02'
   AND v01.beschaffungsart_id = 'E' THEN 2
   WHEN prd_stufe1.art_col_auspr ='FFERT'
   AND prd_stufe2.art_col_auspr='03'
   AND v01.beschaffungsart_id = 'E' THEN 3
   WHEN prd_stufe1.art_col_auspr ='FFERT'
   AND v01.beschaffungsart_id = 'F' THEN 4
   END as materialgruppe_id

   FROM
   (
   SELECT
   art_col_auspr,
   mandant_id,
   flw_art_id
   FROM dbp_view.v_flw_art_col_zu_2
   WHERE flw_art_col_id =1 ) prd_stufe1
   INNER JOIN

   (
   SELECT
   art_col_auspr,
   mandant_id,
   flw_art_id
   FROM dbp_view.v_flw_art_col_zu_2
   WHERE flw_art_col_id =2 ) prd_stufe2
   ON prd_stufe1.mandant_id = prd_stufe2.mandant_id
   AND
   prd_stufe1.flw_art_id = prd_stufe2.flw_art_id
   INNER JOIN dbp_view.v_flw_art_wup_status_2 v01
   ON v01.mandant_id = prd_stufe2.mandant_id
   AND v01.flw_art_id = prd_stufe2.flw_art_id

   JOIN dbp_view.v_flw_werk_2 v02
   ON v01.werk_id = v02.werk_id
   AND v01.mandant_id = v02.mandant_id

   WHERE  materialgruppe_id IS NOT NULL
   AND v01.mandant_id in (1,2)
   AND v02.flw_fg = 1;