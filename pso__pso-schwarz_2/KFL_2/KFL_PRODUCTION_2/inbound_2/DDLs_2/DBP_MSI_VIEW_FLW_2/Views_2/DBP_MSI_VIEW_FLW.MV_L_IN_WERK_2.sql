CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_IN_WERK_2
-- 26.10.2011 system_id entfernt
-- 23.01.2013 twie: neues Werk Bad Heiligenstadt
-- 21.08.2014 TWIE: Umstellung von Industrie auf eigene FLW Tabellen
-- 14.09.2017 twie: SPEC0026009: Breiten- und Laengengrad aus wup_2 Tabelle
-- 13.05.2019 pjan: AP0043250, SPEC0054321 including werk_nr 6911

(
werk_id
,mandant_id
,werk_nr
,werk_name
,laengengrad
,breitengrad
)
AS
   SELECT
   v01.werk_id, v01.mandant_id, v01.werk_nr, v01.werk_name, v02.laengengrad, v02.breitengrad
   FROM dbp_view.v_flw_werk_2 v01
   LEFT OUTER JOIN dbp_view.v_wup_2 v02
   ON v01.werk_nr = v02.wup_id
   AND v01.mandant_id = v02.mandant_id

   WHERE v01.werk_nr IN ('6912','6916','6921','9800','6922','6911');