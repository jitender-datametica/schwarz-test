CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw_materialized.mv_f_kondit_det (mandant_id, kondition_id,
konditionsart_id, in_art_id, dat_bis, dat_von, dat, betrag_kondition, betrag_kondition_bme, flag_landeswrg, wrg_id,
preisliste_typ_id, in_vw_id, art_id) AS SELECT V01.mandant_id,
 V01.kondition_id,
 V01.konditionsart_id,
 V01.in_art_id,
 V01.dat_bis,
 V01.dat_von,
 V01.dat,
 CAST(CASE
   WHEN V01.wrg_id_org <> V01.default_wrg AND V200.wrg_typ_id = 0
   THEN COALESCE(V01.betrag_kondition, 0)
   WHEN V01.wrg_id_org <> V01.default_wrg AND V200.wrg_typ_id = 1
   THEN COALESCE(V01.betrag_kondition, 0) / V500.umrechnungskurs
   WHEN V01.wrg_id_org = V01.default_wrg AND V200.wrg_typ_id = 0
   THEN COALESCE(V01.betrag_kondition, 0) * V500.umrechnungskurs
   WHEN V01.wrg_id_org = V01.default_wrg AND V200.wrg_typ_id = 1
   THEN COALESCE(V01.betrag_kondition, 0)
   ELSE NULL
   END AS NUMERIC) AS betrag_kondition_konzwrg,
 CAST(CAST(CASE
     WHEN V01.wrg_id_org <> V01.default_wrg AND V200.wrg_typ_id = 0
     THEN COALESCE(V01.betrag_kondition, 0)
     WHEN V01.wrg_id_org <> V01.default_wrg AND V200.wrg_typ_id = 1
     THEN COALESCE(V01.betrag_kondition, 0) / V500.umrechnungskurs
     WHEN V01.wrg_id_org = V01.default_wrg AND V200.wrg_typ_id = 0
     THEN COALESCE(V01.betrag_kondition, 0) * V500.umrechnungskurs
     WHEN V01.wrg_id_org = V01.default_wrg AND V200.wrg_typ_id = 1
     THEN COALESCE(V01.betrag_kondition, 0)
     ELSE NULL
     END AS NUMERIC) * CAST(V01.umrech_faktor AS FLOAT64) AS FLOAT64) AS betrag_kondition_konzwrg_bme,
  CASE
  WHEN V01.wrg_id_org = V01.default_wrg
  THEN 1
  ELSE 0
  END AS flag_landeswrg,
 V400.wrg_id,
 V01.preisliste_typ_id,
 V01.in_vw_id,
 V01.art_id
FROM kfl_production_dbp_msi_view_flw_materialized.tbl_mv_f_kondit_det AS V01
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_wrg_typ_zu AS V200 ON TRUE
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_kurstyp_zu AS V300 ON TRUE
 INNER JOIN kfl_production_dbp_view.v_mandant_wrg_typ_zu AS V400 ON V01.mandant_id = V400.mandant_id AND V200.wrg_typ_id
    = V400.wrg_typ_id
 LEFT JOIN kfl_production_dbp_view.v_kurs AS V500 ON V300.kurstyp_id = V500.kurstyp_id AND V01.wrg_id_org = V500.von_wrg_id
      AND V500.nach_wrg_id = 'EUR' AND V01.dat_von BETWEEN V500.dat_von AND V500.dat_bis;