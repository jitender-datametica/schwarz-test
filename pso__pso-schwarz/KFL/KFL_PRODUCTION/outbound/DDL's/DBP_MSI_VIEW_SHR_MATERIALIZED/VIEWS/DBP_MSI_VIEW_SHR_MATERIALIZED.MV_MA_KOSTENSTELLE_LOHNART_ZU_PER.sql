CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_shr_materialized.mv_ma_kostenstelle_lohnart_zu_per (mandant_id,
krk_id, kostenstelle_id, mitarbeiter_id, lohnart_id, kjmo, anzahl_lohnart, zeitart_id, abrechnung_in_periode,
abrechnung_fuer_periode, zahlung_dat, kostenstelle_von_id, kostenstelle_nach_id, abrechnungstyp_fuer_periode,
anzahl_zeitart, austrittsdatum) AS SELECT V01.mandant_id,
 V01.krk_id,
 V01.kostenstelle_id,
 V01.mitarbeiter_id,
 V01.lohnart_id,
 V01.kjmo,
  CASE
  WHEN V01.zeitart_id = '-1' AND V01.lohnart_id IS NOT NULL
  THEN V01.anzahl_lohnart
  ELSE NULL
  END AS anzahl_lohnart,
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
  END AS anzahl_zeitart,
 COALESCE(DATE_SUB(v02.dat_von, INTERVAL 1 DAY), DATE('9999-12-31')) AS austrittsdatum
FROM kfl_production_dbp_view.v_ma_kostenstelle_lohnart_zu_per AS V01
 LEFT JOIN (SELECT mandant_id,
   mitarbeiter_id,
   kjmo,
   MIN(dat_von) AS dat_von
  FROM kfl_production_dbp_view.v_ma_hr_massnahme_zu_per AS V0
  WHERE hr_massnahme_id = '04'
  GROUP BY mandant_id,
   mitarbeiter_id,
   kjmo) AS v02 ON V01.mitarbeiter_id = v02.mitarbeiter_id AND V01.mandant_id = v02.mandant_id AND V01.kjmo = v02.kjmo;