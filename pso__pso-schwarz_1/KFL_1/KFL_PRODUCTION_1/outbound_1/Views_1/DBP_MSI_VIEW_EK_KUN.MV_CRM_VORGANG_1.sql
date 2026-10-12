CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_kun.mv_crm_vorgang_1 (crm_vorgang_id, ticketnummer, vorgangnummer,
ticket_text, dat_start, dat_ende, dat_aenderung, wup_id, nb_id, mandant_id, crm_prozess_id, crm_emotion_id,
crm_eigenmarke_id, crm_eingangskanal_id, etiketten_text, crm_prioritaet_id, crm_schaedlingsart_id, crm_status_id,
foto_fg, fremdkoerper_fg, standardloesung_fg, art_id, gtin_id, charge, gp_art_id, crm_magicword_id, dat_best_before,
zek_id, gp_id, subassortment, apollo, crm_brand_id, ebene_3_id, sec_kz, dat_start_processing, dat_end_processing,
bearbeitungszeit_sek, bearbeitungszeit_tage, verweildauer_sek, erstloesung_kunde_flag, erstloesung_kunde_std,
erstloesung_kunde_min, erstloesung_intern_std, bearbeitungszeit_abteilungssicht_sek, dauer_fb_bearbeitungszeit,
dauer_gesamt_bearbeitungszeit) AS SELECT V01.crm_vorgang_id,
 V01.ticketnummer,
 V01.vorgangnummer,
 V01.ticket_text,
 DATE(V01.dat_start) AS dat_start,
 DATE(V01.dat_ende) AS dat_ende,
 V01.dat_aenderung,
 V03.aktuell_wup_id AS wup_id,
 V01.nb_id,
 V01.mandant_id,
 V01.crm_prozess_id,
 V01.crm_emotion_id,
 V01.crm_eigenmarke_id,
 V01.crm_eingangskanal_id,
 V01.etiketten_text,
 V01.crm_prioritaet_id,
 V01.crm_schaedlingsart_id,
 V01.crm_status_id,
 V01.foto_fg,
 V01.fremdkoerper_fg,
 V01.standardloesung_fg,
 V01.art_id,
 V01.gtin_id,
 V01.charge,
 V01.gp_art_id,
 V01.crm_magicword_id,
 V01.dat_best_before,
 V01.zek_id,
 V01.gp_id,
 V01.subassortment,
 V01.apollo,
 V01.crm_brand_id,
 V02.ebene_3_id,
 3 AS sec_kz,
 DATE(V01.dat_start_processing) AS dat_start_processing,
 DATE(V01.dat_end_processing) AS dat_end_processing,
  CASE
  WHEN V01.dat_ende <> CAST('9999-12-31 00:00:00' AS DATETIME)
  THEN DATETIME_DIFF(V01.dat_ende, V01.dat_start, SECOND)
  ELSE NULL
  END AS bearbeitungszeit_sek,
  CASE
  WHEN V01.dat_ende <> CAST('9999-12-31 00:00:00' AS DATETIME)
  THEN DATETIME_DIFF(V01.dat_ende, V01.dat_start, DAY)
  ELSE DATETIME_DIFF(CAST(CURRENT_DATE AS DATETIME), V01.dat_start, DAY)
  END AS bearbeitungszeit_tage,
  CASE
  WHEN V01.dat_start_processing <> CAST('1900-01-01 00:00:00' AS DATETIME)
  THEN DATETIME_DIFF(V01.dat_start_processing, V01.dat_start, SECOND)
  ELSE NULL
  END AS verweildauer_sek,
  CASE
  WHEN CAST(V01.dat_start AS DATE) = DATE(V01.dat_end_processing)
  THEN 1
  ELSE 0
  END AS erstloesung_kunde_flag,
 DATETIME_DIFF(V01.dat_ende, V01.dat_start, HOUR) AS erstloesung_kunde_std,
 DATETIME_DIFF(V01.dat_ende, V01.dat_start, MINUTE) AS erstloesung_kunde_min,
 DATETIME_DIFF(V01.dat_ende, V01.dat_start_processing, HOUR) AS erstloesung_intern_std,
  CASE
  WHEN V01.dat_ende <> CAST('9999-12-31 00:00:00' AS DATETIME)
  THEN DATETIME_DIFF(V01.dat_ende, V01.dat_start_processing, SECOND)
  ELSE NULL
  END AS bearbeitungszeit_abteilungssicht_sek,
 V01.dauer_fb_bearbeitungszeit,
 V01.dauer_gesamt_bearbeitungszeit
FROM kfl_production_dbp_data.crm_vorgang_1 AS V01
 INNER JOIN kfl_production_dbp_data.crm_l_themenbaum_lv2_1 AS V02 ON V01.crm_themenbaum_lv2_id = V02.crm_themenbaum_lv2_id
  
 INNER JOIN kfl_production_dbp_data.wup_1 AS V03 ON V01.wup_id = V03.wup_id AND V01.mandant_id = V03.mandant_id;