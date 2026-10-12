CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_ivs_mietvertrag_per AS SELECT MV.mandant_id,
 MV.mietvertrag_id,
 MV.mietvertrag_nr,
 MV.dat_von,
 MV.dat_bis,
 MV.dat_vertrag_beginn,
 COALESCE(SUBSTR(CAST(MV.dat_vertrag_ende AS STRING), 1, 20), '9999-12-31') AS dat_vertrag_ende,
 MV.vertragart_id,
 MV.vertrag_status_fg,
 MV.konzessionaer_id,
 MV.vermieter_id,
  CASE
  WHEN MV.dat_vertrag_ende BETWEEN CURRENT_DATE AND DATE '9999-12-01'
  THEN DATE_DIFF(MV.dat_vertrag_ende, CURRENT_DATE, DAY) / 30
  ELSE 0
  END AS laufzeit_ende,
  CASE
  WHEN MV.dat_vertrag_beginn BETWEEN DATE '2031-01-01' AND (CURRENT_DATE)
  THEN DATE_DIFF(CURRENT_DATE, MV.dat_vertrag_beginn, DAY) / 30
  ELSE 0
  END AS laufzeit_beginn,
 COALESCE(SUBSTR(CAST(MV.dat_kuendbar_zum AS STRING), 1, 20), '9999-12-31') AS dat_kuendbar_zum,
 MV.dat_kuendigung,
 COALESCE(MV.kuendigung_frist, 0) AS kuendigung_frist,
 COALESCE(MV.kuend_frist_bez, '') AS kuend_frist_bez,
  MV.betrag_kaution * KURS.kurs AS kaution,
  MV.nebenkosten_betrag * KURS.kurs AS nebenkosten_betrag,
  MV.nebenkosten_abschlag * KURS.kurs AS nebenkosten_abschlag,
 MV.sonderregelung_fg,
 MV.mietindex_prozent,
 MV.dat_mietindex,
 MV.mietauftrag_id,
 MV.mietvertrag_option,
 MV.mietvertrag_option AS option_bez,
 MV.debitor_miete_id,
 MV.debitor_werbung_id,
 KURS.wrg_id
FROM kfl_production_dbp_view.v_ivs_mietvertrag_per AS MV
 INNER JOIN kfl_production_dbp_msi_view_vis.mv_ivs_mandant_wrg_kurs_zu_per AS KURS ON MV.mandant_id = KURS.mandant_id
WHERE MV.dat_bis = DATE '9999-12-31'
UNION ALL
SELECT mandant_id,
 '0' AS mietvertrag_id,
 '0' AS mietvertrag_nr,
 CAST('101' AS DATE) AS dat_von,
 CAST('9999-12-31' AS DATE) AS dat_bis,
 CAST('101' AS DATE) AS dat_vertrag_beginn,
 '9999-12-31' AS dat_vertrag_ende,
 SUBSTR('000', 1, 3) AS vertragart_id,
 SUBSTR('0', 1, 1) AS vertrag_status_fg,
 '0' AS konzessionaer_id,
  mandant_id * - 1 AS vermieter_id,
 0 AS laufzeit_ende,
 0 AS laufzeit_beginn,
 '80991231' AS dat_kuendbar_zum,
 CAST('80991231' AS DATE) AS dat_kuendigung,
 0 AS kuendigung_frist,
 '' AS kuend_frist_bez,
 0 AS betrag_kaution,
 0 AS nebenkosten_betrag,
 0 AS nebenkosten_abschlag,
 0 AS sonderregelung_fg,
 0 AS mietindex_prozent,
 CAST('101' AS DATE) AS dat_mietindex,
 0 AS mietauftrag_id,
 '' AS mietvertrag_option,
 '' AS option_bez,
 0 AS debitor_miete_id,
 0 AS debitor_werbung_id,
 wrg_id
FROM kfl_production_dbp_msi_view_vis.mv_ivs_mandant_wrg_kurs_zu_per AS MWT;