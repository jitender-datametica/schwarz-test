CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_shr_materialized.mv_kostenstelle_lohnart_zu_per (mandant_id, krk_id,
kostenstelle_id, lohnart_id, kjmo, anzahl_lohnart, wrg_id, betrag_lohnart, zeitart_id, abrechnung_in_periode,
abrechnung_fuer_periode, zahlung_dat, kostenstelle_von_id, kostenstelle_nach_id, abrechnungstyp_fuer_periode,
anzahl_zeitart) AS SELECT V01.mandant_id,
 V01.krk_id,
 V01.kostenstelle_id,
 V01.lohnart_id,
 V01.kjmo,
  CASE
  WHEN V01.zeitart_id = '-1' AND V01.lohnart_id IS NOT NULL
  THEN V01.anzahl_lohnart
  ELSE NULL
  END AS anzahl_lohnart,
 V400.wrg_id,
  CASE
  WHEN V01.zeitart_id = '-1' AND V100.wrg_typ_id = 1 AND V01.lohnart_id IS NOT NULL
  THEN V01.betrag_lohnart
  WHEN V01.zeitart_id = '-1' AND V100.wrg_typ_id = 0 AND V01.lohnart_id IS NOT NULL
  THEN V01.betrag_lohnart * V300.umrechnungskurs
  ELSE NULL
  END AS betrag_lohnart,
 V01.zeitart_id,
 V01.abrechnung_in_periode,
 V01.abrechnung_fuer_periode,
 V01.zahlung_dat,
 V01.kostenstelle_von_id,
 V01.kostenstelle_nach_id,
 V01.abrechnungstyp_fuer_periode,
  CASE
  WHEN V01.zeitart_id IS NOT NULL AND V01.lohnart_id = '-1'
  THEN V01.anzahl_lohnart
  ELSE NULL
  END AS anzahl_zeitart
FROM kfl_production_dbp_view.v_kostenstelle_lohnart_zu_per AS V01
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_wrg_typ_zu AS V100 ON TRUE
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_kurstyp_zu AS V200 ON TRUE
 INNER JOIN kfl_production_dbp_view.v_kurs AS V300 ON V01.wrg_id = V300.von_wrg_id AND CURRENT_DATE BETWEEN V300.dat_von
     AND V300.dat_bis AND V200.kurstyp_id = V300.kurstyp_id AND V300.nach_wrg_id = 'EUR'
 INNER JOIN kfl_production_dbp_view.v_mandant_wrg_typ_zu AS V400 ON V01.mandant_id = V400.mandant_id AND V100.wrg_typ_id
    = V400.wrg_typ_id;