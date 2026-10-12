CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_fipo_antwort_2 AS SELECT V01.fipo_antwort_id,
 V01.fipo_bericht_id,
 V01.fipo_pruefpunkt_id,
 4 AS kmr_quelle_id,
 V02.fipo_pruefpunkt_nr,
 V01.fipo_antwort_bwz,
 V01.fipo_antwort_text,
  CASE
  WHEN V02.fipo_pruefpunkt_typ = 'NUMERISCH_OHNE_DEZIMALSTELLEN' OR V02.fipo_pruefpunkt_typ = 'OK_NOTOK_MIT_GANZZAHL'
  THEN ROUND(CAST(V01.fipo_antwort_num AS BIGNUMERIC), 0)
  ELSE NULL
  END AS fipo_antwort_num,
  CASE
  WHEN V02.fipo_pruefpunkt_typ = 'NUMERISCH_MIT_DEZIMALSTELLEN'
  THEN V01.fipo_antwort_num
  ELSE NULL
  END AS fipo_antwort_num_nk,
 V02.fipo_bereich_id,
 V02.fipo_kriterium_id
FROM kfl_production_dbp_view.v_fipo_antwort_2 AS V01
 INNER JOIN kfl_production_dbp_view.v_fipo_pruefpunkt_2 AS V02 ON V01.fipo_pruefpunkt_id = V02.fipo_pruefpunkt_id;