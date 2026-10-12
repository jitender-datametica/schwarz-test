CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_WWC.MV_MSEG_ARTBEW_DE_1
-- AP0002977, srom0404 29.08.2016 Der neue Bericht soll Absatzzahlen und Warenbewegungen kombinieren.
-- eigene View für Bericht 1.01.04 Materialbelege mit Abverkauf, Die Daten von mseg bzw. artbew_1 sollen im Bericht untereinander stehen
-- INC4242193; prescherad, 19.10.2022, Anpnassen zweites Union auf Union All
(
mandant_id
,WERKS
,nb_id
,BUDAT
,art_id
,LIFNR
,BWART
,MENGE
,DMBTR
,VK_brutto
,VK_netto
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_WWC 
AS
   SELECT dt1.mandant_id, dt1.WERKS, dt1.nb_id, dt1.BUDAT, dt1.art_id, dt1.LIFNR, dt1.BWART, dt1.MENGE, dt1.DMBTR, dt1.VK_brutto, dt1.VK_netto
   FROM
   ( --dt1
   -- teilw explizit auf DECIMAL(18,4), damit die artbew_1 Werte keine Genauigkeit verlieren
   SELECT v01.mandant_id, v01.wup_id              AS WERKS, v01.nb_id, v01.dat_buch            AS BUDAT, v01.art_id, v01.gp_id               AS LIFNR, v01.lager_bewart_id     AS BWART, v01.menge_lagerbew_bme  AS MENGE, CAST(v01.betrag_lagerbew  AS DECIMAL(18,4))    AS DMBTR, CAST(CASE WHEN v01.betrag_verkauf_ist <> 0.0 AND v01.betrag_verkauf_ist <> v01.betrag_verkauf THEN v01.betrag_verkauf_ist ELSE v01.betrag_verkauf END AS DECIMAL(18,4)) AS VK_brutto, CASE WHEN v01.betrag_verkauf_ist <> 0.0 AND v01.betrag_verkauf_ist <> v01.betrag_verkauf THEN
   --steht fr a11.EXVKW_nt
   CASE WHEN v01.betrag_verkauf_ist = v01.betrag_verkauf THEN v01.betrag_vk_netto ELSE v01.betrag_verkauf_ist_netto END
   ELSE v01.betrag_vk_netto
   END AS VK_netto
   FROM dbp_view.v_lagerbew_det_1 v01
   WHERE v01.mandant_id = 1

   UNION

   -- Das dazugehörige Delta kommt morgens nach der Hauptverarbeitung
   -- teilw explizit auf DECIMAL(18,4), damit die artbew_1 Werte keine Genauigkeit verlieren
   SELECT v02.mandant_id, v02.wup_id              AS WERKS, v02.nb_id, v02.dat_buch            AS BUDAT, v02.art_id, v02.gp_id               AS LIFNR, v02.lager_bewart_id     AS BWART, v02.menge_lagerbew_bme  AS MENGE, CAST(v02.betrag_lagerbew  AS DECIMAL(18,4))    AS DMBTR, CAST(CASE WHEN v02.betrag_verkauf_ist <> 0.0 AND v02.betrag_verkauf_ist <> v02.betrag_verkauf THEN v02.betrag_verkauf_ist ELSE v02.betrag_verkauf END AS DECIMAL(18,4)) AS VK_brutto, CASE WHEN v02.betrag_verkauf_ist <> 0.0 AND v02.betrag_verkauf_ist <> v02.betrag_verkauf THEN
   --steht fr a11.EXVKW_nt
   CASE WHEN v02.betrag_verkauf_ist = v02.betrag_verkauf THEN v02.betrag_vk_netto ELSE v02.betrag_verkauf_ist_netto END
   ELSE v02.betrag_vk_netto
   END AS VK_netto
   FROM dbp_view.v_lagerbew_det_delta_1 v02
   WHERE v02.mandant_id = 1

   UNION ALL

   -- die Umsatzzahlen werden unter die Bewegungsdaten gestellt
   -- Feedback Fr. Einenkel (Mail 06.09.16)
   -- Bitte drehen Sie bei den aus AIS gezogenen Metrik-Werten immer das Vorzeichen um,
   -- so dass Abverkäufe immer bereits mit - dargestellt werden bzw. Rücknahmen von Kunden mit +.
   SELECT v03.mandant_id, v03.wup_id      AS WERKS, v03.nb_id, v03.dat, v03.art_id, -1               AS LIFNR  -- lt. AP0002977 vorbelegt
   , '251'            AS BWART  -- lt. AP0002977 vorbelegt
   , v03.menge * (-1) AS menge                                       -- auf MSEG.MENGE mappen
   , v03.ek_netto_bnk * (-1) AS ek_netto_bnk                         -- auf MSEG.DMBTR mappen
   , (v03.umsatz_netto + v03.umsatz_mwst_betrag) * (-1) AS vk_brutto -- auf VK_1 Brutto mappen
   , v03.umsatz_netto * (-1) AS umsatz_netto                         -- auf VK_1 Netto mappen
   FROM dbp_view.v_artbew_1 v03
   WHERE v03.mandant_id = 1

   ) dt1;