CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw_materialized.mv_f_in_pruef_los (mandant_id, best_beleg_id,
best_beleg_pos_id, dat_buch, prueflos_id, werk_id, in_art_id, in_lief_id, herkunft, pruefart_id, wrg_id, anz_stp_merkmal
, anz_wert_ergebnis, menge_lagerbew_kg, lbd_we_menge_kg, lbd_we_wert, lbd_we_wert_eur) AS SELECT V01.mandant_id,
 V01.best_beleg_id,
 V01.best_beleg_pos_id,
 V01.dat_buch,
 V01.prueflos_id,
 V01.werk_id,
 V01.in_art_id,
 V01.in_lief_id,
 V01.herkunft,
 V01.pruefart_id,
 V400.wrg_id,
 V01.anz_stp_merkmal,
 V01.anz_wert_ergebnis,
  CASE
  WHEN V01.basismenge_einh_id = 'KG'
  THEN V01.menge_lagerbew_bme * V01.vorzeichen
  WHEN V01.basismenge_einh_id = 'ST'
  THEN ROUND(CAST(V01.menge_lagerbew_bme * V01.vorzeichen * V01.umrech_faktor AS NUMERIC), 6)
  ELSE NULL
  END AS menge_lagerbew_kg,
  CASE
  WHEN V01.best_menge_einh_id = 'KG' OR V01.best_menge_einh_id <> 'KG' AND V01.altnv_menge_einh_id = 'KG'
  THEN CASE
   WHEN V01.basismenge_einh_id = 'KG'
   THEN V01.menge_lagerbew_bme * V01.vorzeichen
   WHEN V01.basismenge_einh_id = 'ST'
   THEN ROUND(CAST(V01.menge_lagerbew_bme * V01.vorzeichen * V01.umrech_faktor AS NUMERIC), 6)
   ELSE NULL
   END
  ELSE NULL
  END AS lbd_we_menge_kg,
  CASE
  WHEN V01.preis_steuer_kz = 'V'
  THEN CASE
   WHEN V01.wrg_id <> V01.default_wrg AND V200.wrg_typ_id = 0
   THEN V01.betrag_lagerbew * V01.vorzeichen
   WHEN V01.wrg_id <> V01.default_wrg AND V200.wrg_typ_id = 1
   THEN V01.betrag_lagerbew * V01.vorzeichen / V500.umrechnungskurs
   WHEN V01.wrg_id = V01.default_wrg AND V200.wrg_typ_id = 0
   THEN V01.betrag_lagerbew * V01.vorzeichen * V500.umrechnungskurs
   WHEN V01.wrg_id = V01.default_wrg AND V200.wrg_typ_id = 1
   THEN V01.betrag_lagerbew * V01.vorzeichen
   ELSE NULL
   END
  WHEN V01.preis_steuer_kz = 'S'
  THEN CASE
   WHEN V01.wrg_id <> V01.default_wrg AND V200.wrg_typ_id = 0
   THEN V01.betrag_lagerbew_altnv * V01.vorzeichen
   WHEN V01.wrg_id <> V01.default_wrg AND V200.wrg_typ_id = 1
   THEN V01.betrag_lagerbew_altnv * V01.vorzeichen / V500.umrechnungskurs
   WHEN V01.wrg_id = V01.default_wrg AND V200.wrg_typ_id = 0
   THEN V01.betrag_lagerbew_altnv * V01.vorzeichen * V500.umrechnungskurs
   WHEN V01.wrg_id = V01.default_wrg AND V200.wrg_typ_id = 1
   THEN V01.betrag_lagerbew_altnv * V01.vorzeichen
   ELSE NULL
   END
  ELSE NULL
  END AS lbd_we_wert,
  CASE
  WHEN V01.preis_steuer_kz = 'V'
  THEN CASE
   WHEN V01.wrg_id <> V01.default_wrg
   THEN V01.betrag_lagerbew * V01.vorzeichen
   WHEN V01.wrg_id = V01.default_wrg
   THEN V01.betrag_lagerbew * V01.vorzeichen * V500.umrechnungskurs
   ELSE NULL
   END
  WHEN V01.preis_steuer_kz = 'S'
  THEN CASE
   WHEN V01.wrg_id <> V01.default_wrg
   THEN V01.betrag_lagerbew_altnv * V01.vorzeichen
   WHEN V01.wrg_id = V01.default_wrg
   THEN V01.betrag_lagerbew_altnv * V01.vorzeichen * V500.umrechnungskurs
   ELSE NULL
   END
  ELSE NULL
  END AS lbd_we_wert_eur
FROM kfl_production_dbp_msi_view_flw_materialized.tbl_mv_f_in_pruef_los AS V01
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_wrg_typ_zu AS V200 ON TRUE
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_kurstyp_zu AS V300 ON TRUE
 INNER JOIN kfl_production_dbp_view.v_mandant_wrg_typ_zu AS V400 ON V01.mandant_id = V400.mandant_id AND V200.wrg_typ_id
    = V400.wrg_typ_id
 INNER JOIN kfl_production_dbp_view.v_kurs AS V500 ON V300.kurstyp_id = V500.kurstyp_id AND V01.wrg_id = V500.von_wrg_id
      AND V500.nach_wrg_id = 'EUR' AND V01.dat_buch BETWEEN V500.dat_von AND V500.dat_bis;