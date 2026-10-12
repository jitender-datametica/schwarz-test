CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_MATERIALGRUPPE_DB_ZU
AS
   SELECT

   v01.mandant_id, v01.flw_art_id AS in_art_id, v01.werk_id, CASE
   -- Fleisch
   WHEN beschaffungsart_id='E' AND v02.art_col_auspr = 'FFERT'  AND v03.art_col_auspr in ('01', '02', '03', '04') THEN 1
   -- Wurst
   WHEN beschaffungsart_id='E' AND v02.art_col_auspr = 'FFERT'  AND v03.art_col_auspr in ('05') THEN 2
   -- HAWA
   WHEN beschaffungsart_id='F' AND v02.art_col_auspr = 'FFERT'  THEN 3
   -- Produktion
   WHEN v02.art_col_auspr = 'FZERL' THEN 4
   -- Sonstige , nicht zugeordnet
   ELSE  5
   END   materialgruppe_db_id

   FROM dbp_view.v_flw_art_wup_status v01
   INNER JOIN dbp_view.v_flw_art_col_zu v02
   ON v01.mandant_id = v02.mandant_id
   AND v01.flw_art_id = v02.flw_art_id
   AND v02.flw_art_col_id = 1
   INNER JOIN dbp_view.v_flw_art_col_zu v03
   ON
   v01.mandant_id = v03.mandant_id
   AND v01.flw_art_id = v03.flw_art_id
   AND v03.flw_art_col_id = 3


   JOIN dbp_view.v_flw_werk v04
   ON v01.werk_id = v04.werk_id
   AND v01.mandant_id = v04.mandant_id

   WHERE v01.mandant_id in (1,2)
   AND v04.flw_fg = 1;