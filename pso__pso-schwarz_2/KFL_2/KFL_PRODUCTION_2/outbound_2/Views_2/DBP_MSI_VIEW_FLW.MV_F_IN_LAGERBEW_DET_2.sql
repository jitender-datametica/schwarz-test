-- 13.05.2019 pjan, AP0043250, SPEC0054321 Anpassung Artikelart-ID ZFLV

-- 17.03.2022 twie: SPEC0133190 menge_basis und komponentenmenge aus Stückliste ergänzt um Sollmenge zu ermitteln

-- 19.08.2014 TWIE: Umstellung von Industrie auf eigene FLW Tabellen
 -- 26.10.2011 system_id entfernt

-- 17.04.2013 twieder: Umrechnung Nettopreis von BME in KG
 -- 22.10.2012 Filter auf mandant_id in (1,2)

-- 14.03.2013 twieder: CROSS JOIN zu mv_f_in_besch_best_det_2 zur Ermittlung nettopreis (für DB-Rechnung IWV)

-- 21.06.2017 twie: RITM0372799 Erweiterung um artikelart_id REWO
 -- 22.07.2013 twieder: Bew.art_2 531 und 532 hinzu

-- 04.03.2019 srom, AP0020745, SPEC0047687 Anpassung Artikelart-ID ZHAW

-- 10.07.2017 twie: SPEC0025417 lager_bewart_id Y29 + Y30 ergänzt, Filterung auf STRING statt INTEGER

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_f_in_lagerbew_det_2 AS
-- Landesbeleg in Euro wird in Euro angezeigt
 -- Landesbeleg in Landeswaehrung wird in Euro angezeigt

-- Landesbeleg in Euro wird in Euro angezeigt
 -- Landesbeleg in Landeswaehrung wird in Euro angezeigt

-- Ermittlung der eingestellter Währung
 -- Ermittlung ob Tageskurs / Kaufland Kurs_2

-- Aufloesung eingestellte Waehrung nach Kurstyp(0 = Euro,1 = Landeswaehrung)
 SELECT V01.lagerbew_beleg_id,
 V01.lagerbew_beleg_pos_id,
 V01.mandant_id,
 V01.kj,
 V01.werk_id,
 V01.dat_buch,
 V01.in_art_id,
 V01.in_art_nr,
 V01.artikelart_id,
 V01.lager_bewart_id,
 V01.auto_id,
 V01.in_lief_id,
 V01.charge_id,
 V01.soll_haben_kz,
 V01.empfaenger_id,
 V01.menge_lagerbew_bme,
 V01.menge_bstmg,
 V01.best_menge_einh_id,
 V01.menge_st,
 V01.menge_kg_tmp AS menge_kg,
 V01.erfsngs_menge_einh_id,
 V01.menge_erf,
 V01.menge_lagerbew_ame,
 V01.umrech_faktor,
 V01.dme_einh_id,
 V01.lagerort_id,
 V01.kostenstelle_id,
 V01.auftrag_id,
 V01.best_beleg_id,
 V01.best_beleg_pos_id,
 V01.menge_bestellpreis,
 V01.preis_steuer_kz,
 V01.pjwo,
 V01.nettopreis,
 V400.wrg_id,
  CASE
  WHEN V01.wrg_id <> V01.default_wrg AND V200.wrg_typ_id = 0 -- 0 = Euro

  THEN V01.betrag_lagerbew * V01.vorzeichen -- Landesbeleg in Euro wird in Landeswaehrung angezeigt

  WHEN V01.wrg_id <> V01.default_wrg AND V200.wrg_typ_id = 1 -- 1 = Landeswaehrung

  THEN V01.betrag_lagerbew * V01.vorzeichen / V500.umrechnungskurs
  WHEN V01.wrg_id = V01.default_wrg AND V200.wrg_typ_id = 0 -- 0 = Euro

  THEN V01.betrag_lagerbew * V01.vorzeichen * V500.umrechnungskurs
   -- Landesbeleg in Landeswaehrung wird in Landeswaehrung angezeigt

  WHEN V01.wrg_id = V01.default_wrg AND V200.wrg_typ_id = 1 -- 1 = Landeswaehrung

  THEN V01.betrag_lagerbew * V01.vorzeichen
  ELSE NULL
  END AS betrag_lagerbew,
  CASE
  WHEN V01.wrg_id <> V01.default_wrg AND V200.wrg_typ_id = 0 -- 0 = Euro

  THEN V01.betrag_lagerbew_altnv * V01.vorzeichen -- Landesbeleg in Euro wird in Landeswaehrung angezeigt

  WHEN V01.wrg_id <> V01.default_wrg AND V200.wrg_typ_id = 1 -- 1 = Landeswaehrung

  THEN V01.betrag_lagerbew_altnv * V01.vorzeichen / V500.umrechnungskurs
  WHEN V01.wrg_id = V01.default_wrg AND V200.wrg_typ_id = 0 -- 0 = Euro

  THEN V01.betrag_lagerbew_altnv * V01.vorzeichen * V500.umrechnungskurs
   -- Landesbeleg in Landeswaehrung wird in Landeswaehrung angezeigt

  WHEN V01.wrg_id = V01.default_wrg AND V200.wrg_typ_id = 1 -- 1 = Landeswaehrung

  THEN V01.betrag_lagerbew_altnv * V01.vorzeichen
  ELSE NULL
  END AS betrag_lagerbew_altnv,
   CASE
   WHEN V01.betrag_lagerbew = 0
   THEN NULL
   ELSE V01.betrag_lagerbew
   END / CASE
   WHEN V01.menge_kg_tmp = 0
   THEN NULL
   ELSE V01.menge_kg_tmp
   END AS ekn_kg,
 V01.menge_basis,
 V01.komponentenmenge
FROM kfl_production_dbp_msi_view_flw.tbl_mv_f_in_lagerbew_det_2 AS V01
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_wrg_typ_zu_2 AS V200 ON TRUE
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_kurstyp_zu_2 AS V300 ON TRUE
 INNER JOIN kfl_production_dbp_view.v_mandant_wrg_typ_zu_2 AS V400 ON V01.mandant_id = V400.mandant_id AND V200.wrg_typ_id
    = V400.wrg_typ_id -- Umrechnung Standardkurs, Tageskurs

 INNER JOIN kfl_production_dbp_view.v_kurs_2 AS V500 ON V300.kurstyp_id = V500.kurstyp_id AND V01.wrg_id = V500.von_wrg_id
      AND V500.nach_wrg_id = 'EUR' AND V01.dat_buch BETWEEN V500.dat_von AND V500.dat_bis;