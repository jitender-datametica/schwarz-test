CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.TBL_MV_F_IN_LAGERBEW_DET_2
AS
-- 26.10.2011 system_id entfernt
-- 22.10.2012 Filter auf mandant_id in (1,2)
-- 14.03.2013 twieder: Join zu mv_f_in_besch_best_det_2 zur Ermittlung nettopreis (für DB-Rechnung IWV)
-- 17.04.2013 twieder: Umrechnung Nettopreis von BME in KG
-- 22.07.2013 twieder: Bew.art_2 531 und 532 hinzu
-- 19.08.2014 TWIE: Umstellung von Industrie auf eigene FLW Tabellen
-- 21.06.2017 twie: RITM0372799 Erweiterung um artikelart_id REWO
-- 10.07.2017 twie: SPEC0025417 lager_bewart_id Y29 + Y30 ergänzt, Filterung auf CHAR statt INT
-- 04.03.2019 srom, AP0020745, SPEC0047687 Anpassung Artikelart-ID ZHAW
-- 13.05.2019 pjan, AP0043250, SPEC0054321 Anpassung Artikelart-ID ZFLV
-- 17.03.2022 twie: SPEC0133190 menge_basis und komponentenmenge aus Stückliste ergänzt um Sollmenge zu ermitteln
-- 11.04.2022 twie: SPEC0133190 Filterung bei stueckliste_det_2 ergänzt

SELECT
   v01.lagerbew_beleg_id AS lagerbew_beleg_id,
   v02.lagerbew_beleg_pos_id AS lagerbew_beleg_pos_id,
   v01.mandant_id AS mandant_id,
   v01.kj AS kj,
   v02.werk_id AS werk_id,
   v01.dat_buch AS dat_buch,
   v02.flw_art_id AS in_art_id,
   v07.flw_art_nr AS in_art_nr,
   v07.artikelart_id AS artikelart_id,
   v02.lager_bewart_id AS lager_bewart_id,
   v02.auto_id AS auto_id,
   v02.flw_lief_id AS in_lief_id,
   v02.charge_id AS charge_id,
   v02.soll_haben_kz AS soll_haben_kz,
   v02.empfaenger_id AS empfaenger_id,
   -- v400.wrg_id AS wrg_id,
   v02.wrg_id AS wrg_id,
   V100.DEFAULT_WRG AS DEFAULT_WRG,
   V02.BETRAG_LAGERBEW,
   v02.betrag_lagerbew_altnv,
   CASE
      -- Ausweisung Positiv
      WHEN v02.lager_bewart_id IN (
         '101',
         '501',
         '521',
         '202',
         '162',
         '262',
         '552',
         '602',
         '644',
         '912',
         '531',
         'Y30'
      ) THEN 1 
      -- Ausweisung Negativ
      WHEN v02.lager_bewart_id IN (
         '102',
         '502',
         '522',
         '201',
         '161',
         '261',
         '551',
         '601',
         '643',
         '911',
         '532',
         'Y29'
      ) THEN -1 
      -- Ausweisung Position 1 Negativ, Position 2 Positiv
      WHEN v02.lager_bewart_id IN ('309', '311')
      AND soll_haben_kz = 'H' THEN -1
      WHEN v02.lager_bewart_id IN ('309', '311')
      AND soll_haben_kz = 'S' THEN 1 
      -- Ausweisung Position 1 Positiv, Position 2 Negativ
      WHEN v02.lager_bewart_id IN ('310', '312')
      AND soll_haben_kz = 'H' THEN -1
      WHEN v02.lager_bewart_id IN ('310', '312')
      AND soll_haben_kz = 'S' THEN 1
   END AS vorzeichen,
   v02.menge_lagerbew_bme * vorzeichen AS menge_lagerbew_bme,
   v02.menge_bstmg * vorzeichen AS menge_bstmg,
   v02.best_menge_einh_id AS best_menge_einh_id,
   CASE
      WHEN v07.basismenge_einh_id = 'KG' THEN CAST(
         v02.menge_lagerbew_bme * vorzeichen * v06.umrech_faktor AS DECIMAL(18, 6)
      )
      WHEN v07.basismenge_einh_id = 'ST' THEN v02.menge_lagerbew_bme * vorzeichen
   END AS menge_st,
   -- Umrechnung ST > KG
   CASE
      WHEN v07.basismenge_einh_id = 'KG' THEN menge_lagerbew_bme * vorzeichen
      WHEN v07.basismenge_einh_id = 'ST' THEN CAST(
         v02.menge_lagerbew_bme * vorzeichen * v06.umrech_faktor AS DECIMAL(18, 6)
      )
   END AS menge_kg_tmp,
   --TRUNC(CASE WHEN ekn = 0 THEN null ELSE ekn END / CASE WHEN menge_kg_tmp = 0 THEN null ELSE menge_kg_tmp END) AS ekn_kg,
   v02.erfsngs_menge_einh_id,
   v02.menge_erf * vorzeichen AS menge_erf,
   -- Umrechnung AME
   CAST(menge_kg_tmp AS DECIMAL(18, 3)) * CAST(v09.umrech_faktor AS DECIMAL (18, 3)) AS menge_lagerbew_ame,
   v09.umrech_faktor,
   v08.dme_einh_id,
   v02.lagerort_id,
   v02.kostenstelle_id,
   v02.auftrag_id,
   v02.best_beleg_id,
   v02.best_beleg_pos_id,
   v02.menge_bestellpreis * vorzeichen AS menge_bestellpreis,
   v05.preis_steuer_kz,
   v10.pjwo,
   CAST(
      (v11.nettopreis / v12.umrech_faktor) AS DECIMAL(18, 6)
   ) AS nettopreis,
   v14.menge_basis,
   v14.komponentenmenge
   
   FROM dbp_view.v_flw_lagerbew_2 v01

   JOIN dbp_view.v_flw_lagerbew_det_2 v02
   ON v01.mandant_id = v02.mandant_id
   AND v01.lagerbew_beleg_id = v02.lagerbew_beleg_id
   AND v01.kj = v02.kj 
   
   -- Ermittlung der default Waehrung
   JOIN dbp_view.v_mandant_2 v100 
   ON v01.mandant_id = v100.mandant_id 
   
   -- 09.08.2011 twieder: v04 und v05 dazugejoint für preis_steuer_kz
   -- Ermittlung der Zuordnung werk_id zu wup_id, zur Aufloesung fuer bewertungskreis_id aus in_art_bewertungkreis_per
   JOIN dbp_view.v_flw_werk_2 v04 
   ON v02.werk_id = v04.werk_id
   AND v02.mandant_id = v04.mandant_id

   -- Ermittlung Standardpreis oder GLD aus MBEW
   LEFT OUTER JOIN dbp_view.v_flw_art_bewertungskreis_per_2 v05 
   ON v01.mandant_id = v05.mandant_id
   AND v02.flw_art_id = v05.flw_art_id
   AND v01.dat_buch BETWEEN v05.dat_von AND v05.dat_bis
   AND v04.werk_nr = v05.bewertungskreis_id 
   
   -- Einschraenkgung auf bestimmte Materialarten ueber artikelart_id IN ('ZKMN','HALB','ZERL', 'ZFER', 'ROH', 'VERP', 'FERT', 'HAWA','ZDIE','REWO','ZFLV')
   JOIN dbp_view.v_flw_art_2 v07
   ON v01.mandant_id = v07.mandant_id
   AND v02.flw_art_id = v07.flw_art_id

   -- Umrechnung BME(ST/KG)
   LEFT OUTER JOIN dbp_view.v_flw_art_umrech_faktor_per_2 v06 
   ON v02.flw_art_id = v06.flw_art_id
   AND v02.mandant_id = v06.mandant_id
   AND (
      CASE
         WHEN v07.basismenge_einh_id = 'ST' THEN 'KG'
         WHEN v07.basismenge_einh_id = 'KG' THEN 'ST'
      END
   ) = v06.altnv_menge_einh_id

   JOIN dbp_view.v_flw_art_wup_status_2 v08 
   ON v02.mandant_id = v08.mandant_id
   AND v02.werk_id = v08.werk_id
   AND v02.flw_art_id = v08.flw_art_id

   -- Umrechnung AME
   LEFT OUTER JOIN dbp_view.v_flw_art_umrech_faktor_per_2 v09 
   ON v08.flw_art_id = v09.flw_art_id
   AND v08.mandant_id = v09.mandant_id
   AND v08.dme_einh_id = v09.altnv_menge_einh_id 
   
   -- Produktionswoche zu dat_beleg aus flw_lagerbew_2 ermitteln (10.08.2011 twieder)
   JOIN (
      SELECT
         v001.dat,
         v001.pjwo
      FROM
         dbp_view.v_tag_2 v001
      GROUP BY
         1,
         2
   ) v10 ON v10.dat = v01.dat_beleg

   -- Ermittlung nettopreis aus der in_besch_best_det_2
   LEFT OUTER JOIN dbp_msi_view_flw.mv_f_in_besch_best_det_2 v11 
   ON v02.mandant_id = v11.mandant_id
   AND v02.best_beleg_id = v11.best_beleg_id
   AND v02.best_beleg_pos_id = v11.best_beleg_pos_id

   -- Umrechnung von BME in KG (für nettopreis)
   LEFT OUTER JOIN dbp_view.v_flw_art_umrech_faktor_per_2 v12 
   ON v02.flw_art_id = v12.flw_art_id
   AND v02.mandant_id = v12.mandant_id
   AND v12.altnv_menge_einh_id = 'KG'

   --über den Auftrag das Auftragsmaterial ermitteln für nächsten Step
   LEFT OUTER JOIN dbp_view.v_flw_auftrag_pps_2 v13
   ON v02.auftrag_id = v13.auftrag_id
   AND v02.mandant_id = v13.mandant_id

   --menge_basis und komponentenmenge aus der Stückliste ermitteln (mit diesen kann aus Istmenge die Sollmenge errechnet werden)
   --dazu mit Werk und Auftragsmaterial (output) in die STKO_2 und menge_basis ermitteln
   --über den Tabellenschlüssel (stueckliste_id, stueckliste_typ_id) in die STPO_2 und die komponentenmenge ermitteln
   --diese wiederum auf die Inputmaterialien aufteilen
   LEFT OUTER JOIN
   (
   SELECT
     v01.mandant_id
   , v01.werk_id
   , v01.flw_art_id AS flw_art_id_out	--Auftragsmaterial
   , v02.flw_art_id AS flw_art_id_in	--dafür benötige Inputmaterialien
   , v01.menge_basis
   , v02.komponentenmenge

   -- MAST_2/STKO_2
   FROM dbp_view.v_flw_stueckliste_2 v01
   -- STPO_2
   JOIN dbp_view.v_flw_stueckliste_det_2 v02
   ON v01.mandant_id = v02.mandant_id
   AND v01.stueckliste_id = v02.stueckliste_id
   AND v01.stueckliste_typ_id = v02.stueckliste_typ_id

   WHERE v02.stueckliste_typ_id <> 'X'
   AND v02.komponentenmenge <> 0.001
   ) v14
   ON v02.mandant_id = v14.mandant_id
   AND v02.werk_id = v14.werk_id
   AND v02.flw_art_id = v14.flw_art_id_in
   AND v13.flw_art_id = v14.flw_art_id_out
  

   WHERE v07.artikelart_id IN (
      'ZKMN',
      'HALB',
      'ZERL',
      'ZFER',
      'ROH',
      'VERP',
      'FERT',
      'HAWA',
      'ZDIE',
      'REWO',
      'ZHAW',
      'ZFLV'
   )
   AND v01.mandant_id IN (1, 2)
;