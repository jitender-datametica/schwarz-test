 CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.TBL_MV_F_FLW_ART_MARKTPREIS_PER
-- 26.10.2011 system_id entfernt
-- 22.03.2012 twie: nicht_relevant_fg hinzu
-- 21.05.2012 twie: geaenderte Logik Zeitselektion mit PJWO
-- 22.08.2014 TWIE: Umstellung von Industrie auf eigene FLW Tabellen
(
mandant_id
--, system_id
, in_art_id
, werk_id
, flw_version_id
, menge
, nicht_relevant_fg
, pjwo
, pjwo_vw
, default_wrg
, wrg_id
, bruttopreis
, dat_aenderung 
)
AS
   SELECT
   v01.mandant_id, 
   v01.flw_art_id AS in_art_id, 
   v01.werk_id, 
   v01.flw_version_id, 
   v01.menge, 
   v01.nicht_relevant_fg, 
   v02.pjwo, 
   v02.pjwo_vw,
   v100.default_wrg,
   v01.wrg_id,
   v01.bruttopreis,
   v01.dat_aenderung


   FROM dbp_view.v_flw_art_marktpreis_per v01

   JOIN
   (
   SELECT
   v001.dat, v001.pjwo, v001.wtag_id, v002.pjwo AS pjwo_vw
   FROM dbp_view.v_tag v001

   JOIN dbp_view.v_tag v002
   ON v001.dat - 7 = v002.dat
   AND v001.dat <= CURRENT_DATE + 7
   GROUP BY 1,2,3,4
   ) v02
   ON v02.dat = v01.dat_von  --Datensatz nur noch einer Woche zuordnen (in der dat_von liegt), dat_bis ist nicht mehr relevant
   AND v02.wtag_id = 6 --nur Datensaetze beruecksichtigen, die ab Samstag gueltig sind

   -- Ermittlung der default Waehrung

   JOIN
   dbp_view.v_mandant v100
   ON v01.mandant_id = v100.mandant_id   ;
