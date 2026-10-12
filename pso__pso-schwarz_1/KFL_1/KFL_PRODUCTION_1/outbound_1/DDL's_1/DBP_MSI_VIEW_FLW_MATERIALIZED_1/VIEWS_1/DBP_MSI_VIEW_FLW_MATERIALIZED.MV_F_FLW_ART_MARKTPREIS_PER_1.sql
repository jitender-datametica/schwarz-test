CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw_materialized.mv_f_flw_art_marktpreis_per_1 (mandant_id, in_art_id,
werk_id, flw_version_id, bruttopreis, menge, nicht_relevant_fg, wrg_id, pjwo, pjwo_vw) AS SELECT V01.mandant_id,
 V01.in_art_id,
 V01.werk_id,
 V01.flw_version_id,
  CASE
  WHEN V01.wrg_id <> V01.default_wrg AND V200.wrg_typ_id = 0
  THEN V01.bruttopreis
  WHEN V01.wrg_id <> V01.default_wrg AND V200.wrg_typ_id = 1
  THEN V01.bruttopreis / V500.umrechnungskurs
  WHEN V01.wrg_id = V01.default_wrg AND V200.wrg_typ_id = 0
  THEN V01.bruttopreis * V500.umrechnungskurs
  WHEN V01.wrg_id = V01.default_wrg AND V200.wrg_typ_id = 1
  THEN V01.bruttopreis
  ELSE NULL
  END AS bruttopreis,
 V01.menge,
 V01.nicht_relevant_fg,
 V400.wrg_id,
 V01.pjwo,
 V01.pjwo_vw
FROM kfl_production_dbp_msi_view_flw_materialized.tbl_mv_f_flw_art_marktpreis_per_1 AS V01
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_wrg_typ_zu_1 AS V200 ON TRUE
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_kurstyp_zu_1 AS V300 ON TRUE
 INNER JOIN kfl_production_dbp_view.v_mandant_wrg_typ_zu_1 AS V400 ON V01.mandant_id = V400.mandant_id AND V200.wrg_typ_id
    = V400.wrg_typ_id
 INNER JOIN kfl_production_dbp_view.v_kurs_1 AS V500 ON V300.kurstyp_id = V500.kurstyp_id AND V01.wrg_id = V500.von_wrg_id
      AND V500.nach_wrg_id = 'EUR' AND V01.dat_aenderung BETWEEN V500.dat_von AND V500.dat_bis
GROUP BY V01.mandant_id,
 V01.in_art_id,
 V01.werk_id,
 V01.flw_version_id,
 bruttopreis,
 V01.menge,
 V01.nicht_relevant_fg,
 V400.wrg_id,
 V01.pjwo,
 V01.pjwo_vw;