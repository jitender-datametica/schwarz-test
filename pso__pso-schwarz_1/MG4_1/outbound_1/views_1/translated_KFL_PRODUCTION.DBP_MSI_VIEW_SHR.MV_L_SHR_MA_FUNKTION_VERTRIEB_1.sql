CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_shr.mv_l_shr_ma_funktion_vertrieb_1 (mandant_id, shr_ma_funktion_id_2,
shr_ma_funktion_id_funktion) AS SELECT v01.mandant_id,
  CASE
  WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
  THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
  ELSE '99'
  END AS shr_ma_funktion_id_2,
 MAX(CASE
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
   END) AS shr_ma_funktion_id_funktion
FROM kfl_production_dbp_view.v_l_shr_ma_funktion_1 AS v01
 LEFT JOIN kfl_production_dbp_view.v_ma_funktion_spr_zu_1 AS v02 ON v01.mandant_id = v02.mandant_id AND v01.shr_ma_funktion_id
     = v02.ma_funktion_id AND v02.spr_id = 22
GROUP BY v01.mandant_id,
 shr_ma_funktion_id_2;