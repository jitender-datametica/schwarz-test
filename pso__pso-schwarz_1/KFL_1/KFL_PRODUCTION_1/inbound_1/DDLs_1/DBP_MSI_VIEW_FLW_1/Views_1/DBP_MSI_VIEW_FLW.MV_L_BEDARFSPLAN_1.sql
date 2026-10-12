CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_BEDARFSPLAN_1
-- MR
-- 22.10.2012 Filter auf mandant_id in (1,2)
-- 19.08.2014 TWIE: Umstellung von Industrie auf eigene FLW Tabellen
-- 21.06.2017 twie: RITM0372799 Erweiterung um artikelart_id REWO
-- 04.03.2019 srom, AP0020745, SPEC0047687 Anpassung Artikelart-ID ZHAW
-- 13.05.2019 pjan, AP0043250, SPEC0054321 Anpassung Artikelart-ID ZFLV

(
mandant_id
,bedarfsplan_id
)
AS
   SELECT
   DISTINCT
   v01.mandant_id, CASE WHEN v01.bedarfsplan_id = '' THEN 'System generated' ELSE TRIM(v01.bedarfsplan_id) END

   FROM dbp_view.v_flw_art_1 v01

   WHERE v01.artikelart_id IN ('ZKMN','HALB','ZERL', 'ZFER', 'ROH', 'VERP', 'FERT', 'HAWA','ZDIE','REWO','ZHAW','ZFLV')
   AND v01.mandant_id IN (1,2);