CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_MATERIALGRUPPE_1
-- 23.01.2013 twie: Filterung auf Mandant_1 und Werk, weil Tabelle in_art_wup_status_1 fuer Projekt SAKO erweitert
-- 19.08.2014 TWIE: Umstellung von Industrie auf eigene FLW Tabellen

(
mandant_id
,in_art_id
,werk_id
,materialgruppe_id
)
AS

   SELECT
   v01.mandant_id, v01.flw_art_id AS in_art_id, v01.werk_id,
   CASE WHEN v02.art_col_auspr = '01' THEN 1
   WHEN v02.art_col_auspr = '02' THEN 2
   WHEN v02.art_col_auspr = '03' THEN 3
   END as materialgruppe_id

   FROM dbp_view.v_flw_art_wup_status_1 v01
   INNER JOIN dbp_view.v_flw_art_col_zu_1 v02
   ON
   v01.mandant_id = v02.mandant_id
   AND v01.flw_art_id = v02.flw_art_id
   AND v02.flw_art_col_id = 2

   JOIN dbp_view.v_flw_werk_1 v03
   ON v01.werk_id = v03.werk_id
   AND v01.mandant_id = v03.mandant_id

   WHERE
   materialgruppe_id IS NOT NULL
   and v01.mandant_id in (1,2)
   AND v03.flw_fg = 1

   UNION
   ALL
   SELECT
   v01.mandant_id, v01.flw_art_id AS in_art_id, v01.werk_id, 4 AS materialgruppe_id
   FROM dbp_view.v_flw_art_wup_status_1 v01
   INNER JOIN dbp_view.v_flw_art_col_zu_1 v02
   ON
   v01.mandant_id = v02.mandant_id
   AND v01.flw_art_id = v02.flw_art_id
   AND v02.flw_art_col_id = 1
   AND v02.art_col_auspr = 'FFERT'
   AND v01.beschaffungsart_id = 'F'

   JOIN dbp_view.v_flw_werk_1 v03
   ON v01.werk_id = v03.werk_id
   AND v01.mandant_id = v03.mandant_id

   WHERE v01.mandant_id in (1,2)
   AND v03.flw_fg = 1;