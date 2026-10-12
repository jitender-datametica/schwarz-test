CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_shr.mv_l_shr_ma_funktion_1 (mandant_id, shr_ma_funktion_id,
shr_ma_funktion_id_2, shr_ma_funktion_id_gesamt, shr_ma_funktion_id_f_ebene, shr_ma_funktion_id_funktion,
ma_funktion_bez) AS SELECT v01.mandant_id,
 v01.shr_ma_funktion_id,
  CASE
  WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
  THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
  ELSE '99'
  END AS shr_ma_funktion_id_2,
  CASE
  WHEN CAST(CASE
     WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
     THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
     ELSE '99'
     END AS INTEGER) IN (11, 12, 13, 14, 15, 16, 21, 22)
  THEN 'Ges'
  ELSE NULL
  END AS shr_ma_funktion_id_gesamt,
  CASE
  WHEN CAST(CASE
     WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
     THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
     ELSE '99'
     END AS INTEGER) IN (14, 15, 16, 21, 22)
  THEN 'FE'
  ELSE NULL
  END AS shr_ma_funktion_id_f_ebene,
  CASE
  WHEN CAST(CASE
     WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
     THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
     ELSE '99'
     END AS INTEGER) IN (11)
  THEN 'MA'
  WHEN CAST(CASE
     WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
     THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
     ELSE '99'
     END AS INTEGER) IN (12)
  THEN 'MA'
  WHEN CAST(CASE
     WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
     THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
     ELSE '99'
     END AS INTEGER) IN (13)
  THEN 'MA'
  WHEN CAST(CASE
     WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
     THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
     ELSE '99'
     END AS INTEGER) IN (14)
  THEN 'Erstkraft'
  WHEN CAST(CASE
     WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
     THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
     ELSE '99'
     END AS INTEGER) IN (15)
  THEN 'PSB'
  WHEN CAST(CASE
     WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
     THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
     ELSE '99'
     END AS INTEGER) IN (16)
  THEN 'TL'
  WHEN CAST(CASE
     WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
     THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
     ELSE '99'
     END AS INTEGER) IN (21)
  THEN 'WBL_1'
  WHEN CAST(CASE
     WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
     THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
     ELSE '99'
     END AS INTEGER) IN (22)
  THEN 'HL_1'
  ELSE 'nicht zugeordnet'
  END AS shr_ma_funktion_id_funktion,
 v02.ma_funktion_bez
FROM kfl_production_dbp_view.v_l_shr_ma_funktion_1 AS v01
 LEFT JOIN kfl_production_dbp_view.v_ma_funktion_spr_zu_1 AS v02 ON v01.mandant_id = v02.mandant_id AND v01.shr_ma_funktion_id
     = v02.ma_funktion_id AND v02.spr_id = 22;