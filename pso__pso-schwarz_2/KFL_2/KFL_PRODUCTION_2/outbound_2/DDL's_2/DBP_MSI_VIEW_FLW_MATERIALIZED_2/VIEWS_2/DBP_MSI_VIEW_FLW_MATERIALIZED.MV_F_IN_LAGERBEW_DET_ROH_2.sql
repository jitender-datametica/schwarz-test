CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw_materialized.mv_f_in_lagerbew_det_roh_2 (mandant_id, werk_id,
dat_buch, wrg_id_org, wrg_id, best_beleg_id, in_art_id, wa_intern) AS SELECT V01.mandant_id,
 V01.werk_id,
 V01.dat_buch,
 V01.wrg_id_org,
 V01.wrg_id,
 V01.best_beleg_id,
 V01.in_art_id,
 CAST(CASE
   WHEN V01.preis_steuer_kz = 'V' AND V01.wrg_id_org <> V01.default_wrg AND V200.wrg_typ_id = 0
   THEN COALESCE(V01.betrag_lagerbew, 0)
   WHEN V01.preis_steuer_kz = 'V' AND V01.wrg_id_org <> V01.default_wrg AND V200.wrg_typ_id = 1
   THEN COALESCE(V01.betrag_lagerbew, 0) / V500.umrechnungskurs
   WHEN V01.preis_steuer_kz = 'V' AND V01.wrg_id_org = V01.default_wrg AND V200.wrg_typ_id = 0
   THEN COALESCE(V01.betrag_lagerbew, 0) * V500.umrechnungskurs
   WHEN V01.preis_steuer_kz = 'V' AND V01.wrg_id_org = V01.default_wrg AND V200.wrg_typ_id = 1
   THEN COALESCE(V01.betrag_lagerbew, 0)
   WHEN V01.preis_steuer_kz = 'S' AND V01.wrg_id_org <> V01.default_wrg AND V200.wrg_typ_id = 0
   THEN COALESCE(V01.betrag_lagerbew_altnv, 0)
   WHEN V01.preis_steuer_kz = 'S' AND V01.wrg_id_org <> V01.default_wrg AND V200.wrg_typ_id = 1
   THEN COALESCE(V01.betrag_lagerbew_altnv, 0) / V500.umrechnungskurs
   WHEN V01.preis_steuer_kz = 'S' AND V01.wrg_id_org = V01.default_wrg AND V200.wrg_typ_id = 0
   THEN COALESCE(V01.betrag_lagerbew_altnv, 0) * V500.umrechnungskurs
   WHEN V01.preis_steuer_kz = 'S' AND V01.wrg_id_org = V01.default_wrg AND V200.wrg_typ_id = 1
   THEN COALESCE(V01.betrag_lagerbew_altnv, 0)
   ELSE NULL
   END AS NUMERIC) AS wa_intern
FROM kfl_production_dbp_msi_view_flw_materialized.tbl_mv_f_in_lagerbew_det_roh_2 AS V01
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_wrg_typ_zu_2 AS V200 ON TRUE
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_kurstyp_zu_2 AS V300 ON TRUE
 INNER JOIN kfl_production_dbp_view.v_mandant_wrg_typ_zu_2 AS V400 ON V01.mandant_id = V400.mandant_id AND V200.wrg_typ_id
    = V400.wrg_typ_id
 INNER JOIN kfl_production_dbp_view.v_kurs_2 AS V500 ON V300.kurstyp_id = V500.kurstyp_id AND V01.wrg_id = V500.von_wrg_id
      AND V500.nach_wrg_id = 'EUR' AND V01.dat_buch BETWEEN V500.dat_von AND V500.dat_bis;