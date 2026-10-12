CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_lagerplatz_ewm_tag (mandant_id, lagernummer_id, lagerplatz_id
, lagertyp_id, lagerbereich_id, lagerplatztyp_id, lagerplatz_zugriffstyp_id, lagerplatz_aufteilung_id,
lagerplatz_position, auslagerung_sperr_fg, einlagerung_sperr_fg, inventur_block_fg, aufgeteilt_fg, anz_hu, anz_hu_max,
gewicht_max, gew_einh_id, gewicht, volumen_netto, volumen_max, vol_einh_id, kapa_max, kapa_frei, leer_fg, voll_fg,
dat_erste_einlagerung, datzeit_letzte_bewegung, lageraufgabe_id_letzte_bew, brandabschnitt_id, datzeit_aenderung,
haupt_lagerplatz_id, loc_guid, handling_unit_guid, gang_id, saeule_id, ebene_id, x_koordinate, y_koordinate,
z_koordinate, lagernereich_lgst_id, feldtyp_id, regaltyp_id, wa_lane_kapa, we_lane_kapa, kapa_erh_fg, dat, tiefe_max,
tiefe_max_fg, anz_lagerplaetze_gesamt, anz_lagerplaetze_belegt) AS SELECT mandant_id,
 lagernummer_id,
 lagerplatz_id,
 lagertyp_id,
 lagerbereich_id,
 lagerplatztyp_id,
 lagerplatz_zugriffstyp_id,
 lagerplatz_aufteilung_id,
 lagerplatz_position,
 auslagerung_sperr_fg,
 einlagerung_sperr_fg,
 inventur_block_fg,
 aufgeteilt_fg,
 anz_hu,
 anz_hu_max,
 gewicht_max,
 gew_einh_id,
 gewicht,
 volumen_netto,
 volumen_max,
 vol_einh_id,
 kapa_max,
 kapa_frei,
 leer_fg,
 voll_fg,
 dat_erste_einlagerung,
 datzeit_letzte_bewegung,
 lageraufgabe_id_letzte_bew,
 brandabschnitt_id,
 datzeit_aenderung,
 haupt_lagerplatz_id,
 loc_guid,
 handling_unit_guid,
 gang_id,
 saeule_id,
 ebene_id,
 x_koordinate,
 y_koordinate,
 z_koordinate,
 lagernereich_lgst_id,
 feldtyp_id,
 regaltyp_id,
 wa_lane_kapa,
 we_lane_kapa,
 kapa_erh_fg,
 dat,
 tiefe_max,
  CASE
  WHEN COALESCE(tiefe_max, 1) >= 2
  THEN tiefe_max
  ELSE 1
  END AS tiefe_max_fg,
  CASE
  WHEN RIGHT(lagertyp_id, 3) = 'RLP' AND (lagerplatz_position IS NULL OR haupt_lagerplatz_id IS NULL)
  THEN ROUND(CAST(RIGHT(lagerplatztyp_id, 1) AS BIGNUMERIC), 0)
  WHEN RIGHT(lagertyp_id, 3) = 'RLP'
  THEN 0
  WHEN CASE
    WHEN COALESCE(tiefe_max, 1) >= 2
    THEN tiefe_max
    ELSE 1
    END = 2
  THEN 2
  ELSE 1
  END AS anz_lagerplaetze_gesamt,
  CASE
  WHEN RIGHT(lagertyp_id, 3) = 'RLP' AND (lagerplatz_position IS NULL OR haupt_lagerplatz_id IS NULL)
  THEN CAST(CASE
    WHEN CAST(RIGHT(lagerplatztyp_id, 1) AS FLOAT64) = 2 AND anz_hu_max = 0 AND anz_hu = 0
    THEN 0
    WHEN CAST(RIGHT(lagerplatztyp_id, 1) AS FLOAT64) = 2 AND anz_hu_max = 1 AND anz_hu = 1
    THEN 2
    WHEN CAST(RIGHT(lagerplatztyp_id, 1) AS FLOAT64) = 2 AND anz_hu_max = 2 AND anz_hu = 2
    THEN 2
    WHEN CAST(RIGHT(lagerplatztyp_id, 1) AS FLOAT64) = 2 AND anz_hu_max = 2 AND anz_hu = 1
    THEN 1
    WHEN CAST(RIGHT(lagerplatztyp_id, 1) AS FLOAT64) = 4 AND anz_hu_max = 0 AND anz_hu = 0
    THEN 0
    WHEN CAST(RIGHT(lagerplatztyp_id, 1) AS FLOAT64) = 4 AND anz_hu_max = 2 AND anz_hu = 2
    THEN 4
    WHEN CAST(RIGHT(lagerplatztyp_id, 1) AS FLOAT64) = 4 AND anz_hu_max = 2 AND anz_hu = 1
    THEN 2
    WHEN CAST(RIGHT(lagerplatztyp_id, 1) AS FLOAT64) = 4 AND anz_hu_max = 4 AND anz_hu = 1
    THEN 1
    WHEN CAST(RIGHT(lagerplatztyp_id, 1) AS FLOAT64) = 4 AND anz_hu_max = 4 AND anz_hu = 2
    THEN 2
    WHEN CAST(RIGHT(lagerplatztyp_id, 1) AS FLOAT64) = 4 AND anz_hu_max = 4 AND anz_hu = 3
    THEN 3
    WHEN CAST(RIGHT(lagerplatztyp_id, 1) AS FLOAT64) = 4 AND anz_hu_max = 4 AND anz_hu = 4
    THEN 4
    ELSE NULL
    END AS BIGNUMERIC)
  WHEN RIGHT(lagertyp_id, 3) = 'RLP'
  THEN 0
  ELSE CASE
    WHEN lagertyp_id LIKE '%G%' AND leer_fg = 0
    THEN 1
    ELSE 0
    END + CASE
    WHEN leer_fg = 0
    THEN anz_hu
    ELSE 0
    END
  END AS anz_lagerplaetze_belegt
FROM kfl_production_dbp_view.v_lagerplatz_ewm_tag AS V01
WHERE RIGHT(lagertyp_id, 3) <> 'RLP'
 OR lagerplatz_id NOT LIKE '%/%';