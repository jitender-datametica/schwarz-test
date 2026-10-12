CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_lagerplatz_ewm_stunde_1 (lagerplatz_id, lagernummer_id,
mandant_id, lagertyp_id, lagerbereich_id, einlagerung_sperr_fg, auslagerung_sperr_fg, gang_id, saeule_id, ebene_id,
brandabschnitt_id, lagerplatztyp_id, kapa_max, gewicht_max, leer_fg, dat_zeit, dat, stunde, wa_lane_kapa, anz_hu,
tiefe_max, tiefe_max_fg, anz_lagerplaetze_gesamt, anz_lagerplaetze_belegt) AS SELECT V01.lagerplatz_id,
 V01.lagernummer_id,
 V01.mandant_id,
 V01.lagertyp_id,
 V01.lagerbereich_id,
 V01.einlagerung_sperr_fg,
 V01.auslagerung_sperr_fg,
 V01.gang_id,
 V01.saeule_id,
 V01.ebene_id,
 SUBSTR(CAST(COALESCE(V01.brandabschnitt_id, '-1') AS STRING), 1, 2) AS brandabschnitt_id,
 V01.lagerplatztyp_id,
 V01.kapa_max,
 V01.gewicht_max,
 V01.leer_fg,
 V02.dat_zeit,
 V02.dat,
 V02.stunde,
 V01.wa_lane_kapa,
 V01.anz_hu,
 V01.tiefe_max,
  CASE
  WHEN COALESCE(V01.tiefe_max, 1) >= 2
  THEN V01.tiefe_max
  ELSE 1
  END AS tiefe_max_fg,
  CASE
  WHEN RIGHT(V01.lagertyp_id, 3) = 'RLP' AND (V01.lagerplatz_position IS NULL OR V01.haupt_lagerplatz_id IS NULL)
  THEN ROUND(CAST(RIGHT(V01.lagerplatztyp_id, 1) AS BIGNUMERIC), 0)
  WHEN RIGHT(V01.lagertyp_id, 3) = 'RLP'
  THEN 0
  WHEN CASE
    WHEN COALESCE(V01.tiefe_max, 1) >= 2
    THEN V01.tiefe_max
    ELSE 1
    END = 2
  THEN 2
  ELSE 1
  END AS anz_lagerplaetze_gesamt,
  CASE
  WHEN RIGHT(V01.lagertyp_id, 3) = 'RLP' AND (V01.lagerplatz_position IS NULL OR V01.haupt_lagerplatz_id IS NULL)
  THEN CAST(CASE
    WHEN CAST(RIGHT(V01.lagerplatztyp_id, 1) AS FLOAT64) = 2 AND V01.anz_hu_max = 0 AND V01.anz_hu = 0
    THEN 0
    WHEN CAST(RIGHT(V01.lagerplatztyp_id, 1) AS FLOAT64) = 2 AND V01.anz_hu_max = 1 AND V01.anz_hu = 1
    THEN 2
    WHEN CAST(RIGHT(V01.lagerplatztyp_id, 1) AS FLOAT64) = 2 AND V01.anz_hu_max = 2 AND V01.anz_hu = 2
    THEN 2
    WHEN CAST(RIGHT(V01.lagerplatztyp_id, 1) AS FLOAT64) = 2 AND V01.anz_hu_max = 2 AND V01.anz_hu = 1
    THEN 1
    WHEN CAST(RIGHT(V01.lagerplatztyp_id, 1) AS FLOAT64) = 4 AND V01.anz_hu_max = 0 AND V01.anz_hu = 0
    THEN 0
    WHEN CAST(RIGHT(V01.lagerplatztyp_id, 1) AS FLOAT64) = 4 AND V01.anz_hu_max = 2 AND V01.anz_hu = 2
    THEN 4
    WHEN CAST(RIGHT(V01.lagerplatztyp_id, 1) AS FLOAT64) = 4 AND V01.anz_hu_max = 2 AND V01.anz_hu = 1
    THEN 2
    WHEN CAST(RIGHT(V01.lagerplatztyp_id, 1) AS FLOAT64) = 4 AND V01.anz_hu_max = 4 AND V01.anz_hu = 1
    THEN 1
    WHEN CAST(RIGHT(V01.lagerplatztyp_id, 1) AS FLOAT64) = 4 AND V01.anz_hu_max = 4 AND V01.anz_hu = 2
    THEN 2
    WHEN CAST(RIGHT(V01.lagerplatztyp_id, 1) AS FLOAT64) = 4 AND V01.anz_hu_max = 4 AND V01.anz_hu = 3
    THEN 3
    WHEN CAST(RIGHT(V01.lagerplatztyp_id, 1) AS FLOAT64) = 4 AND V01.anz_hu_max = 4 AND V01.anz_hu = 4
    THEN 4
    ELSE NULL
    END AS BIGNUMERIC)
  WHEN RIGHT(V01.lagertyp_id, 3) = 'RLP'
  THEN 0
  ELSE CASE
    WHEN V01.lagertyp_id LIKE '%G%' AND V01.leer_fg = 0
    THEN 1
    ELSE 0
    END + CASE
    WHEN V01.leer_fg = 0
    THEN V01.anz_hu
    ELSE 0
    END
  END AS anz_lagerplaetze_belegt
FROM kfl_production_dbp_view.v_lagerplatz_ewm_per_1 AS V01
 INNER JOIN kfl_production_dbp_view.v_tag_stunde_1 AS V02 ON V02.dat_zeit BETWEEN V01.datzeit_von AND V01.datzeit_bis;