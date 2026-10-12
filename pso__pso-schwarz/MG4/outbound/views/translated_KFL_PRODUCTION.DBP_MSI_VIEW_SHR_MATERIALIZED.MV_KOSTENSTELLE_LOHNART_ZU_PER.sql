-- 21.11.2022, AP0025890, SPEC0072496, Erweiterung von neuen Spalten
 -- Erstellt von HMue2308 am 06.09.2017

-- Umgeändert von HMue2308 am 21.09.2017 - Feld: Stunden_Lohnart in Anzahl_Lohnart umgeändert

-- AP0019874, SPEC0025176
 CREATE OR REPLACE VIEW dbp_msi_view_shr_materialized.mv_kostenstelle_lohnart_zu_per (mandant_id
, krk_id, kostenstelle_id, lohnart_id, kjmo, anzahl_lohnart, wrg_id, betrag_lohnart, zeitart_id, abrechnung_in_periode,
abrechnung_fuer_periode, zahlung_dat, kostenstelle_von_id, kostenstelle_nach_id, abrechnungstyp_fuer_periode,
anzahl_zeitart) AS SELECT mandant_id,
 krk_id,
 kostenstelle_id,
 lohnart_id,
 kjmo,
  CASE
  WHEN zeitart_id = '-1' AND lohnart_id IS NOT NULL
  THEN anzahl_lohnart
  ELSE NULL
  END AS anzahl_lohnart,
 wrg_id,
  CASE
  WHEN zeitart_id = '-1' AND lohnart_id IS NOT NULL
  THEN betrag_lohnart
  ELSE NULL
  END AS betrag_lohnart,
 zeitart_id,
 abrechnung_in_periode,
 abrechnung_fuer_periode,
 zahlung_dat,
 kostenstelle_von_id,
 kostenstelle_nach_id,
 abrechnungstyp_fuer_periode,
  CASE
  WHEN zeitart_id IS NOT NULL AND lohnart_id = '-1'
  THEN anzahl_lohnart
  ELSE NULL
  END AS anzahl_zeitart
FROM kfl_production_dbp_view.v_kostenstelle_lohnart_zu_per AS v01;