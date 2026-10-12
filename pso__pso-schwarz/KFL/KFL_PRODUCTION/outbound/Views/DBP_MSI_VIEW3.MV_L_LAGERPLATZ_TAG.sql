CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_l_lagerplatz_tag (lagerplatz_id, lagernummer_id, mandant_id,
lagertyp_id, wup_id, nb_id, lagerbereich_id, einlager_sperr_fg, auslager_sperr_fg, anzahl_quant, komm_bereich,
brand_abschnitt_id, lagerplatz_typ_id, lagerplatz_gewicht_max, dat) AS SELECT V01.lagerplatz_id,
 V01.lagernummer_id,
 V01.mandant_id,
 V01.lagertyp_id,
 V01.wup_id,
 V01.nb_id,
 V01.lagerbereich_id,
 V01.einlager_sperr_fg,
 V01.auslager_sperr_fg,
 V01.anzahl_quant,
  CASE
  WHEN TRIM(COALESCE(V01.komm_bereich, '')) <> ''
  THEN V01.komm_bereich
  ELSE 'kein Kommbereich'
  END AS komm_bereich,
 SUBSTR(CAST(COALESCE(V01.brand_abschnitt_id, '-1') AS STRING), 1, 2) AS brand_abschnitt_id,
 V01.lagerplatz_typ_id,
 V01.lagerplatz_gewicht_max,
 V02.dat
FROM kfl_production_dbp_view.v_l_lagerplatz AS V01
 INNER JOIN kfl_production_dbp_view.v_tag AS V02 ON V02.dat BETWEEN V01.dat_von AND V01.dat_bis
WHERE V02.dat >= DATE '2014-01-01';