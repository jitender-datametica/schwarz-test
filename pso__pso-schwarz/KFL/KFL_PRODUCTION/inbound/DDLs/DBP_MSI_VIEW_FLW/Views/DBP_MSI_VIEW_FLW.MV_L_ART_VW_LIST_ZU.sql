CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_ART_VW_LIST_ZU
-- 30.11.2011 MR Performance art_id Verbindung
-- 26.10.2011 system_id entfernt
-- 19.08.2014 TWIE: Umstellung von Industrie auf eigene FLW Tabellen
(
in_art_id
,  in_art_nr
,  vw_id
,  mandant_id
,  list_durchg_fg
--,  system_id

)

AS
   SELECT
  v03.flw_art_id AS in_art_id,  v03.flw_art_nr AS in_art_nr,  v01.vw_id,  v01.mandant_id,  MAX(v01.list_durchg_fg)
   --,  v03.system_id

   FROM
   dbp_view.v_sternchen_logik AS v01
   INNER JOIN dbp_view.v_art v02
   ON v01.art_id = v02.art_id
   AND v01.mandant_id = v02.mandant_id
   INNER JOIN dbp_view.v_flw_art v03     -- MARA

   ON v03.art_id =v02.art_id
   AND v03.mandant_id = v02.mandant_id

   WHERE v01.mandant_id = 1
   AND CURRENT_DATE BETWEEN v01.dat_von AND v01.dat_bis
   AND v02.dat_bis='9999-12-31'
   GROUP BY 1,2,3,4;