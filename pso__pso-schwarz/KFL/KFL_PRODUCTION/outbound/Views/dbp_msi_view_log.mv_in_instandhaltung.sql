CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_in_instandhaltung (auftrag_id, mandant_id,
instandhaltung_leistungsart_id, in_kunde_id, qual_meldung_id, wart_plan_id, wart_plan_abruf_id, wart_plan_pos_id,
dat_bezug, auftrag_aus_wartung, wartung_fg, ausfall_fg, auftragstyp_id) AS SELECT V01.auftrag_id,
 V01.mandant_id,
 V01.instandhaltung_leistungsart_id,
 V01.in_kunde_id,
 V01.qual_meldung_id,
 V01.wart_plan_id,
 V01.wart_plan_abruf_id,
 V01.wart_plan_pos_id,
 V01.dat_bezug,
  CASE
  WHEN V01.wart_plan_id IS NULL
  THEN 'nein'
  ELSE 'ja'
  END AS auftrag_aus_wartung,
  CASE
  WHEN V01.wart_plan_id > 0
  THEN 1
  ELSE 0
  END AS wartung_fg,
  CASE
  WHEN V02.ausfall_fg = 1
  THEN 1
  ELSE 0
  END AS ausfall_fg,
  CASE
  WHEN CASE
     WHEN V01.wart_plan_id > 0
     THEN 1
     ELSE 0
     END = 0 AND V02.ausfall_fg = 0
  THEN '0 '
  WHEN CASE
     WHEN V01.wart_plan_id > 0
     THEN 1
     ELSE 0
     END = 1 AND V02.ausfall_fg = 0
  THEN '1 '
  WHEN CASE
     WHEN V01.wart_plan_id > 0
     THEN 1
     ELSE 0
     END = 0 AND V02.ausfall_fg = 1
  THEN '2 '
  WHEN CASE
     WHEN V01.wart_plan_id > 0
     THEN 1
     ELSE 0
     END = 1 AND V02.ausfall_fg = 1
  THEN '3 '
  ELSE '-1'
  END AS auftragstyp_id
FROM kfl_production_dbp_view.v_in_instandhaltung AS V01
 LEFT JOIN kfl_production_dbp_data.in_qual_instand AS V02 ON V01.qual_meldung_id = V02.qual_meldung_id AND V01.mandant_id
    = V02.mandant_id;