CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_IN_ART_SPR_ZU
   -- 26.10.2011 system_id entfernt
-- 22.10.2012 Filter auf mandant_id in (1,2)
-- 24.09.2013 twie: Erweitert um alle Retail Fleischartikel, die es nicht im Industrie gibt
-- 19.08.2014 TWIE: Umstellung von Industrie auf eigene FLW Tabellen
-- 21.05.2015 twie: flw_art_id -1 als Dummy fuer Auftragsmaterial, da dies in mv_l_in_auftrag_pps bei Trennprozessauftraegen auch -1 ist
-- 07.06.2017 Erweiterung um artikelart_id REWO INC1168112, RITM0372799
--18.09.2018 naku:  WG Umstellung und Anpassungen: Alte wg_id durch neue ersetzt
-- 18.01.2019 naku: SPEC0048952 WG Erfassartikel  (Wegen Zusammenfuehrung der Artikeln aus Industrie und Retail, gab es ueberschneidungen der Ids welche zu doppelte Anzeige fuerhrte. Geloest wurde durch der Erhohung der WG-Erfassartikel um10000000 da dieser Zahlen Bereich noch nicht benutzt wird.)
-- 04.03.2019 srom, AP0020745, SPEC0047687 Anpassung Artikelart-ID ZHAW
-- 13.05.2019 pjan, AP0043250, SPEC0054321 Anpassung Artikelart-ID ZFLV
   AS
   SELECT v01.mandant_id
   , v01.in_art_id
   , v01.spr_id
   , v01.art_bez
   FROM DBP_MSI_VIEW_FLW.tbl_MV_L_IN_ART_SPR_ZU v01
   JOIN dbp_msi.akt_msi_user_spr_zu v03
   ON v01.spr_id = v03.spr_id;