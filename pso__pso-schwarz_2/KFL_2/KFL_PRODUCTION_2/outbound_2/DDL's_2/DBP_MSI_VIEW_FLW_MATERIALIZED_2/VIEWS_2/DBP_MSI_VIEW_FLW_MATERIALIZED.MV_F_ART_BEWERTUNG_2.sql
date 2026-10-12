CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw_materialized.mv_f_art_bewertung_2 (mandant_id, werk_id, werk_nr,
werk_name, bewertungskreis_id, in_art_id, preis_steuer_kz, gld, standard_preis, preis_faktor, dat_von, dat_bis,
umrech_faktor, artikelwert_bme, artikelwert_kg, wrg_id, dat) AS SELECT V01.mandant_id,
 V01.werk_id,
 V01.werk_nr,
 V01.werk_name,
 V01.bewertungskreis_id,
 V01.in_art_id,
 V01.preis_steuer_kz,
 V01.gld,
 V01.standard_preis,
 V01.preis_faktor,
 V01.dat_von,
 V01.dat_bis,
 V01.umrech_faktor,
  CASE
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
  END AS artikelwert_bme,
  CASE
  WHEN V01.basismenge_einh_id = 'KG'
  THEN CASE
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
   END
  WHEN V01.basismenge_einh_id = 'ST'
  THEN CASE
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
    END / V01.umrech_faktor
  ELSE NULL
  END AS artikelwert_kg,
 V400.wrg_id,
 V01.dat
FROM kfl_production_dbp_msi_view_flw_materialized.tbl_mv_f_art_bewertung_2 AS V01
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_wrg_typ_zu_2 AS V200 ON TRUE
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_kurstyp_zu_2 AS V300 ON TRUE
 INNER JOIN kfl_production_dbp_view.v_mandant_wrg_typ_zu_2 AS V400 ON V01.mandant_id = V400.mandant_id AND V200.wrg_typ_id
    = V400.wrg_typ_id
 LEFT JOIN kfl_production_dbp_view.v_kurs_2 AS V500 ON V300.kurstyp_id = V500.kurstyp_id AND V400.wrg_id = V500.von_wrg_id
     AND V01.dat BETWEEN V500.dat_von AND V500.dat_bis
WHERE V500.nach_wrg_id = 'EUR'
 AND V01.mandant_id IN (1, 2);