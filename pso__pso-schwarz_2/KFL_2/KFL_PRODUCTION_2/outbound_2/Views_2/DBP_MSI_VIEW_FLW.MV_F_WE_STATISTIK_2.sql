CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_f_we_statistik_2 (mandant_id, beleg_kondition_id,
beleg_kondition_pos_id, beleg_konditionsart_id, werk_id, dat_buch, in_art_id, in_art_nr, artikelart_id, lagerort_id,
in_lief_id, lager_bewart_id, nettogew, menge_lagerbew_bme, basismenge_einh_id, dme_einh_id, menge_dme,
betrag_beleg_kondition, betrag_beleg_kondition_kg, ekn_gesamt, wrg_id) AS SELECT V01.mandant_id,
 V01.beleg_kondition_id,
 V01.beleg_kondition_pos_id,
 V01.beleg_konditionsart_id,
 V01.werk_id,
 V01.dat_buch,
 V01.in_art_id,
 V01.in_art_nr,
 V01.artikelart_id,
 V01.lagerort_id,
 V01.in_lief_id,
 V01.lager_bewart_id,
 V01.nettogew,
 V01.menge_lagerbew_bme,
 V01.basismenge_einh_id,
 V01.dme_einh_id,
 V01.menge_dme,
 CAST(CASE
    WHEN V01.wrg_id_09 <> V01.default_wrg AND V200.wrg_typ_id = 0
    THEN V01.betrag_beleg_kondition
    WHEN V01.wrg_id_09 <> V01.default_wrg AND V200.wrg_typ_id = 1
    THEN V01.betrag_beleg_kondition / V500.umrechnungskurs
    WHEN V01.wrg_id_09 = V01.default_wrg AND V200.wrg_typ_id = 0
    THEN V01.betrag_beleg_kondition * V500.umrechnungskurs
    WHEN V01.wrg_id_09 = V01.default_wrg AND V200.wrg_typ_id = 1
    THEN V01.betrag_beleg_kondition
    ELSE NULL
    END / COALESCE(CASE
     WHEN V01.kondition_preis_einh_id = 0
     THEN NULL
     ELSE V01.kondition_preis_einh_id
     END, 1) AS NUMERIC) AS betrag_beleg_kondition,
 CAST(CASE
    WHEN V01.basismenge_einh_id = 'KG'
    THEN V01.betrag_beleg_kondition
    WHEN V01.basismenge_einh_id = 'ST'
    THEN CAST(V01.betrag_beleg_kondition / V01.umrech_faktor AS NUMERIC)
    ELSE NULL
    END / COALESCE(CASE
     WHEN V01.kondition_preis_einh_id = 0
     THEN NULL
     ELSE V01.kondition_preis_einh_id
     END, 1) AS NUMERIC) AS betrag_beleg_kondition_kg,
 CAST(CASE
   WHEN V01.preis_steuer_kz = 'V' AND V01.wrg_id_02 <> V01.default_wrg AND V200.wrg_typ_id = 0
   THEN COALESCE(V01.betrag_lagerbew, 0)
   WHEN V01.preis_steuer_kz = 'V' AND V01.wrg_id_02 <> V01.default_wrg AND V200.wrg_typ_id = 1
   THEN COALESCE(V01.betrag_lagerbew, 0) / V600.umrechnungskurs
   WHEN V01.preis_steuer_kz = 'V' AND V01.wrg_id_02 = V01.default_wrg AND V200.wrg_typ_id = 0
   THEN COALESCE(V01.betrag_lagerbew, 0) * V600.umrechnungskurs
   WHEN V01.preis_steuer_kz = 'V' AND V01.wrg_id_02 = V01.default_wrg AND V200.wrg_typ_id = 1
   THEN COALESCE(V01.betrag_lagerbew, 0)
   WHEN V01.preis_steuer_kz = 'S' AND V01.wrg_id_02 <> V01.default_wrg AND V200.wrg_typ_id = 0
   THEN COALESCE(V01.betrag_lagerbew_altnv, 0)
   WHEN V01.preis_steuer_kz = 'S' AND V01.wrg_id_02 <> V01.default_wrg AND V200.wrg_typ_id = 1
   THEN COALESCE(V01.betrag_lagerbew_altnv, 0) / V600.umrechnungskurs
   WHEN V01.preis_steuer_kz = 'S' AND V01.wrg_id_02 = V01.default_wrg AND V200.wrg_typ_id = 0
   THEN COALESCE(V01.betrag_lagerbew_altnv, 0) * V600.umrechnungskurs
   WHEN V01.preis_steuer_kz = 'S' AND V01.wrg_id_02 = V01.default_wrg AND V200.wrg_typ_id = 1
   THEN COALESCE(V01.betrag_lagerbew_altnv, 0)
   ELSE NULL
   END AS NUMERIC) AS ekn_gesamt,
 V400.wrg_id
FROM kfl_production_dbp_msi_view_flw.tbl_mv_f_we_statistik_2 AS V01
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_wrg_typ_zu_2 AS V200 ON TRUE
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_kurstyp_zu_2 AS V300 ON TRUE
 INNER JOIN kfl_production_dbp_view.v_mandant_wrg_typ_zu_2 AS V400 ON V01.mandant_id = V400.mandant_id AND V200.wrg_typ_id
    = V400.wrg_typ_id
 LEFT JOIN kfl_production_dbp_view.v_kurs_2 AS V500 ON V300.kurstyp_id = V500.kurstyp_id AND V01.wrg_id_09 = V500.von_wrg_id
      AND V500.nach_wrg_id = 'EUR' AND V01.dat_buch BETWEEN V500.dat_von AND V500.dat_bis
 INNER JOIN kfl_production_dbp_view.v_kurs_2 AS V600 ON V300.kurstyp_id = V600.kurstyp_id AND V01.wrg_id_02 = V600.von_wrg_id
      AND V600.nach_wrg_id = 'EUR' AND V01.dat_buch BETWEEN V600.dat_von AND V600.dat_bis;