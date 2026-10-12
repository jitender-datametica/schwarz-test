CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_l_lagerplatz (lagerplatz_id, lagernummer_id, mandant_id,
lagertyp_id, wup_id, nb_id, lagerbereich_id, dat_bis, dat_von, einlager_sperr_fg, auslager_sperr_fg, anzahl_quant,
komm_bereich, gang_id, brand_abschnitt_id, lagerplatz_typ_id, lagerplatz_gewicht_max, lagerplatz_ebene, sperrgrund_id)
AS SELECT lagerplatz_id,
 lagernummer_id,
 mandant_id,
 lagertyp_id,
 wup_id,
 nb_id,
 lagerbereich_id,
 dat_bis,
 dat_von,
 einlager_sperr_fg,
 auslager_sperr_fg,
 anzahl_quant,
  CASE
  WHEN TRIM(COALESCE(komm_bereich, '')) <> ''
  THEN komm_bereich
  ELSE 'kein Kommbereich'
  END AS komm_bereich,
  CASE
  WHEN SUBSTR(lagerplatz_id, 4, 1) = '-'
  THEN LEFT(lagerplatz_id, 3)
  ELSE 'kein Gang'
  END AS gang_id,
 SUBSTR(CAST(COALESCE(brand_abschnitt_id, '-1') AS STRING), 1, 2) AS brand_abschnitt_id,
 lagerplatz_typ_id,
 lagerplatz_gewicht_max,
 lagerplatz_ebene,
 sperrgrund_id
FROM kfl_production_dbp_view.v_l_lagerplatz
WHERE EXTRACT(YEAR FROM dat_bis) >= EXTRACT(YEAR FROM CURRENT_TIMESTAMP()) - 2;