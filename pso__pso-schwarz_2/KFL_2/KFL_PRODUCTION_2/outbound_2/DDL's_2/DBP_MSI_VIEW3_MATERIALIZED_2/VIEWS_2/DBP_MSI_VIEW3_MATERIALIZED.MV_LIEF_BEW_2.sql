
-- 14.05.2018, AP0011752, srom0404 Anpassung Moldau, Filterung auf mandant_id <> 1 statt mandant_id IN (2,3,..)

-- 14.11.2019, AP0050464, nwag2310 Anpassung Moldau BEWART_2 643/644

-- 27.11.2019, AP0041558, nwag2310, added KJ in join (LIKP/LIPS)

-- 20220804; richternic, AP0132142, SPEC0154921, akt_msi_user_wrg_typ_zu_2 ersetzen durch neue View (Projektspezifische Waehrungsauswahl)

-- 09.02.2021, AP0078007, SPEC0101516, srom0404, lief_pal_typ_id auf STRING(2)

-- Incident WOL3467619, Ergänzung der Storno- und Korrekturbuchungen (BWA 302;312;602;642;648)

-- SUM
 -- Incident WOL3467619, Ergänzung der Storno- und Korrekturbuchungen (BWA 302;312;602;642;648)
 -- SUM

-- Das tbl Objekt ersetzt die bisherige Logik und materialisiert einen Join über mehrere Tabellen.
CREATE OR REPLACE TABLE FUNCTION kfl_production_dbp_msi_view3_materialized.mv_lief_bew_2 (USERID STRING) AS 
 SELECT mandant_id,
 wup_id,
 nb_id,
 dat_lief_soll_ AS dat_lief_soll,
 dat_buch,
 lief_beleg_id,
 kj,
 lagerbew_beleg_id,
 lager_bewart_id,
 wg_verkett_id,
 lief_pal_typ_id,
 versandstelle_id,
 werbeware_id,
 kunde_id_ AS kunde_id,
 mandant_id_kunde_ AS mandant_id_kunde,
 wrg_id,
 wrg_typ_id,
 SUM(menge_lief_ist_kolli) AS menge_lief_ist_kolli,
 SUM(anzahl_packstueck) AS anzahl_packstueck,
 SUM(betrag_lagerbew) AS betrag_lagerbew,
 SUM(betrag_vk_netto_vz) AS betrag_vk_netto_vz
FROM (SELECT V01.mandant_id,
   V01.wup_id,
   V01.nb_id,
   V01.dat_lief_soll_,
   V01.dat_buch,
   V01.lief_beleg_id,
   V01.kj,
   V01.lagerbew_beleg_id,
   V01.lager_bewart_id,
   V01.wg_verkett_id,
   CAST(V01.lief_pal_typ_id AS STRING) AS lief_pal_typ_id,
   V01.versandstelle_id,
   V01.werbeware_id,
   V01.kunde_id_,
   V01.mandant_id_kunde_,
   V01.wrg_id,
   V01.wrg_typ_id,
   SUM(V01.menge_lief_ist_kolli) AS menge_lief_ist_kolli,
   MIN(V01.anzahl_packstueck) AS anzahl_packstueck,
   SUM(CASE
      WHEN V01.wrg_typ_id = 0
      THEN V01.betrag_lagerbew * V01.umrechnungskurs * V09.ek_anzeige_fg
      ELSE V01.betrag_lagerbew * V09.ek_anzeige_fg
      END * CASE
      WHEN V01.lager_bewart_id IN ('301', '311', '601', '641', '643', '647', '302', '312', '602', '642', '644', '648')
       AND V01.v04_mandant_id <> 1
      THEN -1
      ELSE 1
      END) AS betrag_lagerbew,
   SUM(CASE
      WHEN V01.wrg_typ_id = 0
      THEN V01.betrag_vk_netto_vz * V01.umrechnungskurs
      ELSE V01.betrag_vk_netto_vz
      END * CASE
      WHEN V01.lager_bewart_id IN ('301', '311', '601', '641', '643', '647', '302', '312', '602', '642', '644', '648')
       AND V01.v04_mandant_id <> 1
      THEN -1
      ELSE 1
      END) AS betrag_vk_netto_vz
  FROM kfl_production_dbp_msi_view3_materialized.tbl_mv_lief_bew_2 AS V01
   INNER JOIN kfl_production_dbp_msi_view3_materialized.mv_akt_msi_user_prj_wrg_typ_zu_2(USERID) AS V10 ON V01.wrg_typ_id = V10.wrg_typ_id
    
   INNER JOIN kfl_production_dbp_msi.akt_msi_user_ek_anzeige_zu_2 AS V09 ON TRUE
  GROUP BY V01.lief_beleg_id,
   V01.lief_pal_typ_id,
   V01.versandstelle_id,
   V01.werbeware_id,
   V01.kunde_id_,
   V01.mandant_id_kunde_,
   V01.mandant_id,
   V01.wup_id,
   V01.nb_id,
   V01.dat_lief_soll_,
   V01.ref_lagerbew_beleg_id_num,
   V01.kj,
   V01.lagerbew_beleg_id,
   V01.dat_buch,
   V01.lager_bewart_id,
   V01.wg_verkett_id,
   V01.wrg_id,
   V01.wrg_typ_id) AS t01
GROUP BY mandant_id,
 wup_id,
 nb_id,
 dat_lief_soll_,
 dat_buch,
 lief_beleg_id,
 kj,
 lagerbew_beleg_id,
 lager_bewart_id,
 wg_verkett_id,
 lief_pal_typ_id,
 versandstelle_id,
 werbeware_id,
 kunde_id_,
 mandant_id_kunde_,
 wrg_id,
 wrg_typ_id;
