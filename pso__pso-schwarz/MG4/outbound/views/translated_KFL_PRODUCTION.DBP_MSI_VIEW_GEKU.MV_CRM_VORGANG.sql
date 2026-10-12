CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku.mv_crm_vorgang (crm_vorgang_id, ticketnummer, vorgangnummer,
ticket_text, dat_start, dat_ende, dat_aenderung, wup_id, nb_id, mandant_id, crm_prozess_id, crm_emotion_id,
crm_eigenmarke_id, crm_eingangskanal_id, etiketten_text, crm_prioritaet_id, crm_schaedlingsart_id, crm_status_id,
foto_fg, fremdkoerper_fg, standardloesung_fg, art_id, gtin_id, charge, gp_art_id, crm_magicword_id, dat_best_before,
zek_id, gp_id, subassortment, apollo, crm_brand_id, ebene_3_id, sec_kz, dat_start_processing, dat_end_processing,
bearbeitungszeit_sek, bearbeitungszeit_tage, verweildauer_sek, erstloesung_kunde_flag, erstloesung_kunde_std,
erstloesung_kunde_min, erstloesung_intern_std, bearbeitungszeit_abteilungssicht_sek) AS SELECT v01.crm_vorgang_id,
 v01.ticketnummer,
 v01.vorgangnummer,
 v01.ticket_text,
 DATE(v01.dat_start) AS dat_start,
 DATE(v01.dat_ende) AS dat_ende,
 v01.dat_aenderung,
 v03.aktuell_wup_id AS wup_id,
 v01.nb_id,
 v01.mandant_id,
 v01.crm_prozess_id,
 v01.crm_emotion_id,
 v01.crm_eigenmarke_id,
 v01.crm_eingangskanal_id,
 v01.etiketten_text,
 v01.crm_prioritaet_id,
 v01.crm_schaedlingsart_id,
 v01.crm_status_id,
 v01.foto_fg,
 v01.fremdkoerper_fg,
 v01.standardloesung_fg,
 v01.art_id,
 v01.gtin_id,
 v01.charge,
 v01.gp_art_id,
 v01.crm_magicword_id,
 v01.dat_best_before,
 v01.zek_id,
 v01.gp_id,
 v01.subassortment,
 v01.apollo,
 v01.crm_brand_id,
 v02.ebene_3_id,
 3 AS sec_kz,
 DATE(v01.dat_start_processing) AS dat_start_processing,
 DATE(v01.dat_end_processing) AS dat_end_processing,
  CASE
  WHEN v01.dat_ende <> CAST('9999-12-31 00:00:00' AS DATETIME)
  THEN DATETIME_DIFF(v01.dat_ende, v01.dat_start, SECOND)
  ELSE NULL
  END AS bearbeitungszeit_sek,
  CASE
  WHEN v01.dat_ende <> CAST('9999-12-31 00:00:00' AS DATETIME)
  THEN DATETIME_DIFF(v01.dat_ende, v01.dat_start, DAY)
  ELSE DATETIME_DIFF(CAST(CURRENT_DATE AS DATETIME), v01.dat_start, DAY)
  END AS bearbeitungszeit_tage,
  CASE
  WHEN v01.dat_start_processing <> CAST('1900-01-01 00:00:00' AS DATETIME)
  THEN DATETIME_DIFF(v01.dat_start_processing, v01.dat_start, SECOND)
  ELSE NULL
  END AS verweildauer_sek,
  CASE
  WHEN CAST(v01.dat_start AS DATE) = DATE(v01.dat_end_processing)
  THEN 1
  ELSE 0
  END AS erstloesung_kunde_flag,
 DATETIME_DIFF(v01.dat_ende, v01.dat_start, HOUR) AS erstloesung_kunde_std,
 DATETIME_DIFF(v01.dat_ende, v01.dat_start, MINUTE) AS erstloesung_kunde_min,
 DATETIME_DIFF(v01.dat_ende, v01.dat_start_processing, HOUR) AS erstloesung_intern_std,
  CASE
  WHEN v01.dat_ende <> CAST('9999-12-31 00:00:00' AS DATETIME)
  THEN DATETIME_DIFF(v01.dat_ende, v01.dat_start_processing, SECOND)
  ELSE NULL
  END AS bearbeitungszeit_abteilungssicht_sek
FROM kfl_production_dbp_view.v_crm_vorgang AS v01
 INNER JOIN kfl_production_dbp_view.v_crm_l_themenbaum_lv2 AS v02 ON v01.crm_themenbaum_lv2_id = v02.crm_themenbaum_lv2_id
  
 INNER JOIN kfl_production_dbp_view.v_wup AS v03 ON v01.wup_id = v03.wup_id AND v01.mandant_id = v03.mandant_id;