CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw_materialized.mv_f_soll_ist_halb (werk_nr, werk_name, mandant_id,
auftrag_id, halb_in_art_id, halb_in_art_nr, in_art_id, typ, basismenge_einh_id, in_art_nr, artikelart_id, werk_id,
dat_start, menge_lagerbew_bme, bewertungspreis_me, input_menge_ist, input_menge_soll, bewertungspreis_kg, menge_kg) AS
SELECT V01.werk_nr,
 V01.werk_name,
 V01.mandant_id,
 V01.auftrag_id,
 V01.halb_in_art_id,
 V01.halb_in_art_nr,
 V01.in_art_id,
 V01.typ,
 V01.basismenge_einh_id,
 V01.in_art_nr,
 V01.artikelart_id,
 V01.werk_id,
 V01.dat_start,
 V01.menge_lagerbew_bme,
 CAST(CASE
   WHEN V01.preis_steuer_kz = 'V' AND V01.wrg_id <> V01.default_wrg AND V200.wrg_typ_id = 0
   THEN COALESCE(V01.gld / V01.preis_faktor, 0)
   WHEN V01.preis_steuer_kz = 'V' AND V01.wrg_id <> V01.default_wrg AND V200.wrg_typ_id = 1
   THEN COALESCE(V01.gld / V01.preis_faktor, 0) / V500.umrechnungskurs
   WHEN V01.preis_steuer_kz = 'V' AND V01.wrg_id = V01.default_wrg AND V200.wrg_typ_id = 0
   THEN COALESCE(V01.gld / V01.preis_faktor, 0) * V500.umrechnungskurs
   WHEN V01.preis_steuer_kz = 'V' AND V01.wrg_id = V01.default_wrg AND V200.wrg_typ_id = 1
   THEN COALESCE(V01.gld / V01.preis_faktor, 0)
   WHEN V01.preis_steuer_kz = 'S' AND V01.wrg_id <> V01.default_wrg AND V200.wrg_typ_id = 0
   THEN COALESCE(V01.standard_preis / V01.preis_faktor, 0)
   WHEN V01.preis_steuer_kz = 'S' AND V01.wrg_id <> V01.default_wrg AND V200.wrg_typ_id = 1
   THEN COALESCE(V01.standard_preis / V01.preis_faktor, 0) / V500.umrechnungskurs
   WHEN V01.preis_steuer_kz = 'S' AND V01.wrg_id = V01.default_wrg AND V200.wrg_typ_id = 0
   THEN COALESCE(V01.standard_preis / V01.preis_faktor, 0) * V500.umrechnungskurs
   WHEN V01.preis_steuer_kz = 'S' AND V01.wrg_id = V01.default_wrg AND V200.wrg_typ_id = 1
   THEN COALESCE(V01.standard_preis / V01.preis_faktor, 0)
   ELSE NULL
   END AS NUMERIC) AS bewertungspreis_me,
 V01.input_menge_ist,
 V01.input_menge_soll,
  CASE
  WHEN V01.basismenge_einh_id = 'ST'
  THEN CAST(CAST(CASE
      WHEN V01.preis_steuer_kz = 'V' AND V01.wrg_id <> V01.default_wrg AND V200.wrg_typ_id = 0
      THEN COALESCE(V01.gld / V01.preis_faktor, 0)
      WHEN V01.preis_steuer_kz = 'V' AND V01.wrg_id <> V01.default_wrg AND V200.wrg_typ_id = 1
      THEN COALESCE(V01.gld / V01.preis_faktor, 0) / V500.umrechnungskurs
      WHEN V01.preis_steuer_kz = 'V' AND V01.wrg_id = V01.default_wrg AND V200.wrg_typ_id = 0
      THEN COALESCE(V01.gld / V01.preis_faktor, 0) * V500.umrechnungskurs
      WHEN V01.preis_steuer_kz = 'V' AND V01.wrg_id = V01.default_wrg AND V200.wrg_typ_id = 1
      THEN COALESCE(V01.gld / V01.preis_faktor, 0)
      WHEN V01.preis_steuer_kz = 'S' AND V01.wrg_id <> V01.default_wrg AND V200.wrg_typ_id = 0
      THEN COALESCE(V01.standard_preis / V01.preis_faktor, 0)
      WHEN V01.preis_steuer_kz = 'S' AND V01.wrg_id <> V01.default_wrg AND V200.wrg_typ_id = 1
      THEN COALESCE(V01.standard_preis / V01.preis_faktor, 0) / V500.umrechnungskurs
      WHEN V01.preis_steuer_kz = 'S' AND V01.wrg_id = V01.default_wrg AND V200.wrg_typ_id = 0
      THEN COALESCE(V01.standard_preis / V01.preis_faktor, 0) * V500.umrechnungskurs
      WHEN V01.preis_steuer_kz = 'S' AND V01.wrg_id = V01.default_wrg AND V200.wrg_typ_id = 1
      THEN COALESCE(V01.standard_preis / V01.preis_faktor, 0)
      ELSE NULL
      END AS NUMERIC) / V01.umrech_faktor AS NUMERIC)
  ELSE CAST(CASE
    WHEN V01.preis_steuer_kz = 'V' AND V01.wrg_id <> V01.default_wrg AND V200.wrg_typ_id = 0
    THEN COALESCE(V01.gld / V01.preis_faktor, 0)
    WHEN V01.preis_steuer_kz = 'V' AND V01.wrg_id <> V01.default_wrg AND V200.wrg_typ_id = 1
    THEN COALESCE(V01.gld / V01.preis_faktor, 0) / V500.umrechnungskurs
    WHEN V01.preis_steuer_kz = 'V' AND V01.wrg_id = V01.default_wrg AND V200.wrg_typ_id = 0
    THEN COALESCE(V01.gld / V01.preis_faktor, 0) * V500.umrechnungskurs
    WHEN V01.preis_steuer_kz = 'V' AND V01.wrg_id = V01.default_wrg AND V200.wrg_typ_id = 1
    THEN COALESCE(V01.gld / V01.preis_faktor, 0)
    WHEN V01.preis_steuer_kz = 'S' AND V01.wrg_id <> V01.default_wrg AND V200.wrg_typ_id = 0
    THEN COALESCE(V01.standard_preis / V01.preis_faktor, 0)
    WHEN V01.preis_steuer_kz = 'S' AND V01.wrg_id <> V01.default_wrg AND V200.wrg_typ_id = 1
    THEN COALESCE(V01.standard_preis / V01.preis_faktor, 0) / V500.umrechnungskurs
    WHEN V01.preis_steuer_kz = 'S' AND V01.wrg_id = V01.default_wrg AND V200.wrg_typ_id = 0
    THEN COALESCE(V01.standard_preis / V01.preis_faktor, 0) * V500.umrechnungskurs
    WHEN V01.preis_steuer_kz = 'S' AND V01.wrg_id = V01.default_wrg AND V200.wrg_typ_id = 1
    THEN COALESCE(V01.standard_preis / V01.preis_faktor, 0)
    ELSE NULL
    END AS NUMERIC)
  END AS bewertungspreis_kg,
  CASE
  WHEN V01.basismenge_einh_id = 'ST'
  THEN ROUND(CAST(V01.menge_lagerbew_bme * V01.umrech_faktor AS NUMERIC), 6)
  ELSE NULL
  END AS menge_kg
FROM kfl_production_dbp_msi_view_flw_materialized.tbl_mv_f_soll_ist_halb AS V01
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_wrg_typ_zu AS V200 ON TRUE
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_kurstyp_zu AS V300 ON TRUE
 INNER JOIN kfl_production_dbp_view.v_mandant_wrg_typ_zu AS V400 ON V01.mandant_id = V400.mandant_id AND V200.wrg_typ_id
    = V400.wrg_typ_id
 INNER JOIN kfl_production_dbp_view.v_kurs AS V500 ON V300.kurstyp_id = V500.kurstyp_id AND V01.wrg_id = V500.von_wrg_id
      AND V500.nach_wrg_id = 'EUR' AND V01.dat_start BETWEEN V500.dat_von AND V500.dat_bis;