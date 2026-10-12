CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_IN_ART_2
-- AL 20.11.2011  produktgruppe_id hinzugefuegt
-- 26.10.2011 system_id entfernt
-- 22.10.2012 Filter auf mandant_id in (1,2)
-- 24.09.2013 twie: Erweitert um alle Retail Fleischartikel, die es nicht im Industrie gibt
--=============================================================
-- ACHTUNG bei aenderungen: diese View wird von anderen MV-Views benutzt
--=============================================================
-- 21.10.2013 twie: art_id mit ausgeben fuer Join mit anderen Views
-- 04.12.2013 twie: Retail Zusatzinfos ausgeben: wg_art_fg, posten_id, loesch_id, gewart_id, muki_block_vk_id,
--                                                                           bio_fg, discount_id, mhd_zeitraum
-- 19.08.2014 twie: Umstellung von Industrie auf eigene FLW Tabellen
--                               Den alten Namen in_art_id fuer MSI ausgeben, da dort nicht umbenannt werden kann
--                               Zusaetzlich den neuen Namen flw_art_id fuer Join innerhalb von anderen Views
-- 23.02.2015 twie: 7 neue Retailkennzeichen aufgenommen
-- 21.05.2015 twie: flw_art_id -1 als Dummy_2 fuer Auftragsmaterial, da dies in mv_l_in_auftrag_pps_2 bei Trennprozessauftraegen auch -1 ist
-- 25.09.2015 twie: tierwohl_kz dazu (setzt sich aus Land_2, Produ.hierarchie und bio_fg zusammen)
-- 04.05.2016 twie: SPEC0006968  loesch_id <> 'L' entfernt
-- 11.08.2016 twie: SPEC0007420 weitere loesch_id aus Industriesystem als loesch_id_ind um sie von der bisherigen loesch_id aus Retail zu unterscheiden
-- 07.06.2017 Erweiterung um artikelart_id REWO INC1168112, RITM0372799
--18.09.2018 naku:  WG Umstellung und Anpassungen: Alte wg_id durch neue ersetzt
--17.01.2019 naku: SPEC0048952 WG Erfassartikel  (Wegen Zusammenfuehrung der Artikeln aus Industrie und Retail, gab es ueberschneidungen der Ids welche zu doppelte Anzeige fuerhrte. Geloest wurde durch der Erhohung der WG-Erfassartikel um10000000 da dieser Zahlen Bereich noch nicht benutzt wird.)
-- 04.03.2019 srom, AP0020745, SPEC0047687 Anpassung Artikelart-ID ZHAW
-- 13.05.2019 pjan, AP0043250, SPEC0054321 Anpassung Artikelart-ID ZFLV
-- 28.11.2019 twie: SPEC0059224 Umstellung Ermittlungslogik des tierwohl_kz auf neues Feld tierwohl_kz

(
mandant_id
--, system_id
, in_art_id
, flw_art_id
, in_art_nr
, art_id
, basismenge_einh_id
, prodhier_id
, artikelart_id
, vol
, vol_einh_id
, nettogew
, gew_einh_id
, best_menge_einh_id
, best_basismenge_einh_id
,bedarfsplan_id
, produktgruppe_id
, wg_art_fg
, posten_id
, loesch_id
, gewart_id
, muki_block_vk_id
, bio_fg
, discount_id
, mhd_zeitraum
, fw_saison_id
, fw_wk_system_id
, fw_wk_discount_id
, fw_wk_national_id
, fw_we_hammer_id
, fw_we_artikel_id
, fw_reserve_id
, ind_fg
, tierwohl_kz
, loesch_id_ind
, dat_von_loesch_id_ind
)
AS
   SELECT
   v01.mandant_id, v01.flw_art_id AS in_art_id, v01.flw_art_id, v01.flw_art_nr AS in_art_nr, v01.art_id, v01.basismenge_einh_id,  1 AS  prodhier_id, v01.artikelart_id, v01.vol, v01.vol_einh_id, v01.nettogew, v01.gew_einh_id, v01.best_menge_einh_id, CASE WHEN v01.best_menge_einh_id = '' THEN v01.basismenge_einh_id ELSE v01.best_menge_einh_id END AS best_basismenge_einh_id, CASE WHEN v01.bedarfsplan_id = '' THEN 'System generated' ELSE v01.bedarfsplan_id END AS bedarfsplan_id, v01.produktgruppe_id, COALESCE(v02.wg_art_fg, 0) AS wg_art_fg, COALESCE(
   CASE WHEN v02.mandant_id = 2 AND v02.posten_id = '' THEN '0' ELSE v02.posten_id END  --an Lookup anpassen
   ,CASE WHEN v02.mandant_id = 1 THEN '' ELSE '0' END --Dummywert je Land_2 wenn Artikel_2 nicht in Retailtabelle
   ) AS posten_id, COALESCE(v02.loesch_id, '')  AS loesch_id, COALESCE(v02.gewart_id, '')  AS gewart_id, COALESCE(v02.mutter_vk_id, v02.art_id, -1) AS muki_block_vk_id, COALESCE(v02.bio_fg, 0) AS bio_fg, COALESCE(v02.discount_id, 0) AS discount_id, COALESCE(v02.mhd_zeitraum, -1) AS mhd_zeitraum, COALESCE(v02.fw_saison_id, '') AS fw_saison_id, COALESCE(v02.fw_wk_system_id, '') AS fw_wk_system_id, COALESCE(v02.fw_wk_discount_id, '') AS fw_wk_discount_id, COALESCE(v02.fw_wk_national_id, '') AS fw_wk_national_id, COALESCE(v02.fw_we_hammer_id, '') AS fw_we_hammer_id, COALESCE(v02.fw_we_artikel_id, '') AS fw_we_artikel_id, COALESCE(v02.fw_reserve_id, '') AS fw_reserve_id, 1 AS ind_fg, v02.tierwohl_kz --soll 1:1 ausgegeben werden, auch mit NULL Werten
   , COALESCE(v01.loesch_id, '')  AS loesch_id_ind    --loesch_id aus Industrie
   , v01.dat_von_loesch_id AS  dat_von_loesch_id_ind

   FROM dbp_view.v_flw_art_2 v01
   LEFT OUTER JOIN dbp_view.v_art_2 v02
   ON v01.art_id  =v02.art_id
   AND v01.mandant_id = v02.mandant_id
   LEFT OUTER JOIN
   (
   SELECT
   mandant_id, flw_art_id, MAX(CASE WHEN flw_art_col_id=2 THEN art_col_auspr ELSE NULL END ) prodh_lvl_2 --01 = Schwein, 03 = Gemischt
   FROM dbp_view.v_flw_art_col_zu_2
   GROUP BY mandant_id,
   flw_art_id
   ) v03
   ON v01.mandant_id = v03.mandant_id
   AND v01.flw_art_id = v03.flw_art_id

   WHERE (v01.artikelart_id IN ('ZKMN','HALB','ZERL', 'ZFER', 'ROH', 'VERP', 'FERT', 'HAWA','ZDIE','REWO','ZHAW','ZFLV') OR v01.flw_art_id = -1)
   AND v01.mandant_id IN (1,2)

   UNION

   -- fehlende Fleischartikel aus Retail, die es nicht im Industrie gibt

   SELECT

   v01.mandant_id, CASE WHEN v01.art_id < 0 THEN (v01.art_id * -1 + 10000000) ELSE v01.art_id * -1 END AS in_art_id --da es keine in/flw_art_id gibt, eine_2 < 0 generieren
   , CASE WHEN v01.art_id < 0 THEN (v01.art_id * -1 + 10000000) ELSE v01.art_id * -1 END AS flw_art_id, CAST(v01.kl_art_id AS VARCHAR(20)) AS in_art_nr, v01.art_id, v01.basismenge_einh_id, 1 AS  prodhier_id, '' AS artikelart_id, CAST(0 AS DECIMAL (18,3)) AS vol, '' AS vol_einh_id, 0 AS nettogew, '' AS gew_einh_id, '' AS best_menge_einh_id, '' AS best_basismenge_einh_id, '' AS bedarfsplan_id, '' AS produktgruppe_id, v01.wg_art_fg, CASE WHEN v01.mandant_id = 2 AND v01.posten_id = '' THEN '0' ELSE v01.posten_id END AS posten_id  --an Lookup anpassen
   , v01.loesch_id, v01.gewart_id, COALESCE(v01.mutter_vk_id, v01.art_id) AS muki_block_vk_id, v01.bio_fg, v01.discount_id, v01.mhd_zeitraum, v01.fw_saison_id, v01.fw_wk_system_id, v01.fw_wk_discount_id, v01.fw_wk_national_id, v01.fw_we_hammer_id, v01.fw_we_artikel_id, v01.fw_reserve_id, 0 AS ind_fg, v01.tierwohl_kz --soll 1:1 ausgegeben werden, auch mit NULL Werten
   , '' AS loesch_id_ind, NULL AS dat_von_loesch_id_ind

   FROM dbp_view.v_art_2 v01
   LEFT OUTER JOIN dbp_view.v_flw_art_2 v02
   ON v01.art_id  =v02.art_id
   AND v01.mandant_id = v02.mandant_id
   INNER JOIN dbp_view.v_art_wg_zu_per_2 v03
   ON  v01.art_id = v03.art_id
   AND  v01.mandant_id = v03.mandant_id

   WHERE
   --v01.art_id >= 0  -- keine negative art_id
   --AND
   v01.mandant_id IN (1,2)

   -- eindeutigen Datensatz aus art_wg_zu_per_2 ermitteln
   AND v03.dat_bis='9999-12-31'
   AND v03.arthiertyp_id = 2

   -- nur FLW Artikel_2
   -- Naku  Alte wg_id (1, 2, 3, 5, 9, 10, 12, 13, 19) durch neue laut Mapping Tabelle in SPEC0034878 ersetzt

   AND v03.wg_id IN (003,122,128,134,135,136,137,138,139,141,142,144,145,146,147,158,159,184,186,232,233,234,235,236,237,238,239,331,242,243,244,245,246)

   AND v01.dat_bis = '9999-12-31'

   -- nur reine Retail Artikel_2
   AND v02.flw_art_id IS NULL;