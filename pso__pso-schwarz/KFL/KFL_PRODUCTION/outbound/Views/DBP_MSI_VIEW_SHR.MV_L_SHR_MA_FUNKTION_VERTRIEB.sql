CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_shr.mv_l_shr_ma_funktion_vertrieb AS SELECT V01.mandant_id,
  CASE
  WHEN SUBSTR(V01.shr_ma_funktion_id, 3, 1) = '-'
  THEN SUBSTR(V01.shr_ma_funktion_id, 1, 2)
  ELSE '99'
  END AS shr_ma_funktion_id_2,
 MAX(CASE
   WHEN CAST(CASE
      WHEN SUBSTR(V01.shr_ma_funktion_id, 3, 1) = '-'
      THEN SUBSTR(V01.shr_ma_funktion_id, 1, 2)
      ELSE '99'
      END AS INTEGER) IN (11)
   THEN 'MA'
   WHEN CAST(CASE
      WHEN SUBSTR(V01.shr_ma_funktion_id, 3, 1) = '-'
      THEN SUBSTR(V01.shr_ma_funktion_id, 1, 2)
      ELSE '99'
      END AS INTEGER) IN (12)
   THEN 'MA'
   WHEN CAST(CASE
      WHEN SUBSTR(V01.shr_ma_funktion_id, 3, 1) = '-'
      THEN SUBSTR(V01.shr_ma_funktion_id, 1, 2)
      ELSE '99'
      END AS INTEGER) IN (13)
   THEN 'MA'
   WHEN CAST(CASE
      WHEN SUBSTR(V01.shr_ma_funktion_id, 3, 1) = '-'
      THEN SUBSTR(V01.shr_ma_funktion_id, 1, 2)
      ELSE '99'
      END AS INTEGER) IN (14)
   THEN 'Erstkraft'
   WHEN CAST(CASE
      WHEN SUBSTR(V01.shr_ma_funktion_id, 3, 1) = '-'
      THEN SUBSTR(V01.shr_ma_funktion_id, 1, 2)
      ELSE '99'
      END AS INTEGER) IN (15)
   THEN 'PSB'
   WHEN CAST(CASE
      WHEN SUBSTR(V01.shr_ma_funktion_id, 3, 1) = '-'
      THEN SUBSTR(V01.shr_ma_funktion_id, 1, 2)
      ELSE '99'
      END AS INTEGER) IN (16)
   THEN 'TL'
   WHEN CAST(CASE
      WHEN SUBSTR(V01.shr_ma_funktion_id, 3, 1) = '-'
      THEN SUBSTR(V01.shr_ma_funktion_id, 1, 2)
      ELSE '99'
      END AS INTEGER) IN (21)
   THEN 'WBL'
   WHEN CAST(CASE
      WHEN SUBSTR(V01.shr_ma_funktion_id, 3, 1) = '-'
      THEN SUBSTR(V01.shr_ma_funktion_id, 1, 2)
      ELSE '99'
      END AS INTEGER) IN (22)
   THEN 'HL'
   ELSE 'nicht zugeordnet'
   END) AS shr_ma_funktion_id_funktion
FROM kfl_production_dbp_view.v_l_shr_ma_funktion AS V01
 LEFT JOIN kfl_production_dbp_view.v_ma_funktion_spr_zu AS V02 ON V01.mandant_id = V02.mandant_id AND V01.shr_ma_funktion_id
     = V02.ma_funktion_id AND V02.spr_id = 22
GROUP BY V01.mandant_id,
 shr_ma_funktion_id_2;