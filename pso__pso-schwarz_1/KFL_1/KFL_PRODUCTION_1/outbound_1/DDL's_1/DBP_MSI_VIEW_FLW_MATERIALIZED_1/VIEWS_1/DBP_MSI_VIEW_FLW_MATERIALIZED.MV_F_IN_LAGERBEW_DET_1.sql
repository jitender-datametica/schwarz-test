CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw_materialized.mv_f_in_lagerbew_det_1 (lagerbew_beleg_id,
lagerbew_beleg_pos_id, mandant_id, kj, werk_id, dat_buch, in_art_id, in_art_nr, artikelart_id, lager_bewart_id, auto_id
, in_lief_id, charge_id, soll_haben_kz, empfaenger_id, menge_lagerbew_bme, menge_bstmg, best_menge_einh_id, menge_st,
menge_kg, erfsngs_menge_einh_id, menge_erf, menge_lagerbew_ame, umrech_faktor, dme_einh_id, lagerort_id, kostenstelle_id
, auftrag_id, best_beleg_id, best_beleg_pos_id, menge_bestellpreis, preis_steuer_kz, pjwo, nettopreis, wrg_id,
betrag_lagerbew, betrag_lagerbew_altnv, ekn_kg, menge_basis, komponentenmenge) AS SELECT V01.lagerbew_beleg_id,
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
  WHEN V01.wrg_id <> V01.default_wrg AND V200.wrg_typ_id = 0
  THEN V01.betrag_lagerbew * V01.vorzeichen
  WHEN V01.wrg_id <> V01.default_wrg AND V200.wrg_typ_id = 1
  THEN V01.betrag_lagerbew * V01.vorzeichen / V500.umrechnungskurs
  WHEN V01.wrg_id = V01.default_wrg AND V200.wrg_typ_id = 0
  THEN V01.betrag_lagerbew * V01.vorzeichen * V500.umrechnungskurs
  WHEN V01.wrg_id = V01.default_wrg AND V200.wrg_typ_id = 1
  THEN V01.betrag_lagerbew * V01.vorzeichen
  ELSE NULL
  END AS betrag_lagerbew,
  CASE
  WHEN V01.wrg_id <> V01.default_wrg AND V200.wrg_typ_id = 0
  THEN V01.betrag_lagerbew_altnv * V01.vorzeichen
  WHEN V01.wrg_id <> V01.default_wrg AND V200.wrg_typ_id = 1
  THEN V01.betrag_lagerbew_altnv * V01.vorzeichen / V500.umrechnungskurs
  WHEN V01.wrg_id = V01.default_wrg AND V200.wrg_typ_id = 0
  THEN V01.betrag_lagerbew_altnv * V01.vorzeichen * V500.umrechnungskurs
  WHEN V01.wrg_id = V01.default_wrg AND V200.wrg_typ_id = 1
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
FROM kfl_production_dbp_msi_view_flw_materialized.tbl_mv_f_in_lagerbew_det_1 AS V01
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_wrg_typ_zu_1 AS V200 ON TRUE
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_kurstyp_zu_1 AS V300 ON TRUE
 INNER JOIN kfl_production_dbp_view.v_mandant_wrg_typ_zu_1 AS V400 ON V01.mandant_id = V400.mandant_id AND V200.wrg_typ_id
    = V400.wrg_typ_id
 INNER JOIN kfl_production_dbp_view.v_kurs_1 AS V500 ON V300.kurstyp_id = V500.kurstyp_id AND V01.wrg_id = V500.von_wrg_id
      AND V500.nach_wrg_id = 'EUR' AND V01.dat_buch BETWEEN V500.dat_von AND V500.dat_bis;