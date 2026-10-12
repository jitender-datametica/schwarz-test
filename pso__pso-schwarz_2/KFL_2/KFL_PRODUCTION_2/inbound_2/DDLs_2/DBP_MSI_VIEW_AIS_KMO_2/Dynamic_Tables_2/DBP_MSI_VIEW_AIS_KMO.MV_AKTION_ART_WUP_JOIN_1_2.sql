CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_AIS_KMO.MV_AKTION_ART_WUP_JOIN_1_2
-- Projekt 597, gesperrte Aktionen werden herausgefiltert lt. Anforderung --
-- 130830 - kkai VK_2-Preis raus
-- SPEC0014769 Ausbau sap_aktion_id; sschuecke 25.10.2016
-- INC0893448 Erweiterung um Filter dat_preisaktiviert <> 101 / sschuecke 12.04.2019
(
aktion_id
, mandant_id
, dat_von
, dat_bis
, dat
, vk_aktion_brutto
, art_id
, wup_id
, nb_id
, aktionsart_id
, preisaktivierung
, aktion_thema_id
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_KMO
AS
   SELECT
   v01.aktion_id,
   v01.mandant_id,
   v01.dat_von,
   v01.dat_bis,
   v03.dat,
   v02.vk_aktion_brutto,
   v02.art_id,
   v02.wup_id,
   v02.nb_id,
   v01.aktionsart_id,
   CASE   WHEN v01.preisaktiviert_fg = 1 THEN 'X' ELSE ' '
  END AS preisaktivierung,
   v02.aktion_thema_id

  FROM dbp_view.v_aktion_2 v01

   JOIN dbp_view.v_aktion_art_wup_zu_2 v02
   ON v02.aktion_id = v01.aktion_id
   AND v02.mandant_id = v01.mandant_id

   JOIN dbp_view.v_tag_2 v03
   ON v03.dat BETWEEN v01.dat_von AND v01.dat_bis

   WHERE v02.grund_sperrung IS NULL
   AND v01.mandant_id <> 1
   AND v03.akt_kj BETWEEN -3 AND 0
   -- Filtern von Ýnicht durchgeführten/falschen Aktionen --
   AND dat_preisaktiviert <> '1900-01-01';