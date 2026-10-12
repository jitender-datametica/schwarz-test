-- 15.10.2013 twie: neu erstellt fuer CZ Abschriften_1
 -- loeschen

-- 23.10.2013 twie: reine Retailartikel ohne Industriependant mit Retailumrechnungsfaktor umrechnen

-- 20.08.2014 TWIE: Umstellung von Industrie auf eigene FLW Tabellen

-- 28.05.2014 twie: betrag_vk in netto statt brutto ausgeben, sowie menge_lagerbew_bme

-- 21.10.2013 twie: CROSS JOIN auf in_art_1 jetzt auf MV-VIEW, damit auch reine Retailartikel mitkommen

-- Vorzeichen umdrehen bei Storno Bewegungsart?

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_f_lagerbew_det_1 (lagerbew_beleg_id, lagerbew_beleg_pos_id,
mandant_id, kj, wup_id, nb_id, in_kunde_id, dat_buch, art_id, in_art_id, lager_bewart_id, betrag_vk_netto,
betrag_vk_brutto, menge_lagerbew_bme, menge_lagerbew_kg, wrg_id) AS -- Landesbeleg in Euro wird in Euro angezeigt

-- Landesbeleg in Landeswaehrung wird in Euro angezeigt
 -- zu loeschen nach P3/2014, inkl. v06

-- Aufloesung eingestellte Waehrung nach Kurstyp(0 = Euro,1 = Landeswaehrung)
 SELECT V01.lagerbew_beleg_id,
 V01.lagerbew_beleg_pos_id,
 V01.mandant_id,
 V01.kj,
 V01.wup_id,
 V01.nb_id,
 V01.in_kunde_id,
 V01.dat_buch,
 V01.art_id,
 V01.in_art_id,
 V01.lager_bewart_id,
  CASE
  WHEN V01.wrg_id <> V01.default_wrg AND V200.wrg_typ_id = 0 -- 0 = Euro

  THEN V01.betrag_vk_netto -- Landesbeleg in Euro wird in Landeswaehrung angezeigt

  WHEN V01.wrg_id <> V01.default_wrg AND V200.wrg_typ_id = 1 -- 1 = Landeswaehrung

  THEN V01.betrag_vk_netto / V500.umrechnungskurs
  WHEN V01.wrg_id = V01.default_wrg AND V200.wrg_typ_id = 0 -- 0 = Euro

  THEN V01.betrag_vk_netto * V500.umrechnungskurs -- Landesbeleg in Landeswaehrung wird in Landeswaehrung angezeigt

  WHEN V01.wrg_id = V01.default_wrg AND V200.wrg_typ_id = 1 -- 1 = Landeswaehrung

  THEN V01.betrag_vk_netto
  ELSE NULL
  END AS betrag_vk_netto,
  V01.betrag_vk_netto * (V01.mwst / 100 + 1) AS betrag_vk_brutto,
 V01.menge_lagerbew_bme,
 V01.menge_lagerbew_kg,
 V400.wrg_id
FROM kfl_production_dbp_msi_view_flw.tbl_mv_f_lagerbew_det_1 AS V01
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_wrg_typ_zu_1 AS V200 ON TRUE
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_kurstyp_zu_1 AS V300 ON TRUE
 INNER JOIN kfl_production_dbp_view.v_mandant_wrg_typ_zu_1 AS V400 ON V01.mandant_id = V400.mandant_id AND V200.wrg_typ_id
    = V400.wrg_typ_id -- Umrechnung Standardkurs, Tageskurs

 INNER JOIN kfl_production_dbp_view.v_kurs_1 AS V500 ON V300.kurstyp_id = V500.kurstyp_id AND V01.wrg_id = V500.von_wrg_id
      AND V500.nach_wrg_id = 'EUR' AND V01.dat_buch BETWEEN V500.dat_von AND V500.dat_bis;