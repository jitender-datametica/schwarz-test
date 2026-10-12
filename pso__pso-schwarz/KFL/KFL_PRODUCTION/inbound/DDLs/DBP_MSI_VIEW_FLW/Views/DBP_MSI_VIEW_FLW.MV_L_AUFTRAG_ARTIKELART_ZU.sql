CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_AUFTRAG_ARTIKELART_ZU
-- 26.10.2011 system_id entfernt
-- 22.10.2012 Filter auf mandant_id in (1,2)
-- 19.08.2014 TWIE: Umstellung von Industrie auf eigene FLW Tabellen
-- 21.06.2017 twie: RITM0372799 Erweiterung um artikelart_id REWO
-- 04.03.2019 srom, AP0020745, SPEC0047687 Anpassung Artikelart-ID ZHAW
-- 13.05.2019 pjan, AP0043250, SPEC0054321 Anpassung Artikelart-ID ZFLV

(
mandant_id
--  ,system_id
,auftrag_id
,in_art_id
,artikelart_id
)
AS
   SELECT
   v01.mandant_id, v01.auftrag_id, v01.flw_art_id AS in_art_id, v02.artikelart_id
   FROM dbp_view.v_flw_auftrag_pps v01
   INNER JOIN dbp_view.v_flw_art v02
   ON v01.mandant_id = v02.mandant_id
   AND v01.flw_art_id = v02.flw_art_id

   WHERE v02.artikelart_id IN
   ('ZKMN', 'HALB', 'ZERL', 'ZFER', 'ROH', 'VERP', 'FERT', 'HAWA', 'ZDIE','REWO','ZHAW','ZFLV')
   AND v01.mandant_id IN (1,2);