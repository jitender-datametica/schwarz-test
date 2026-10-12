CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_kurs AS SELECT V02.mandant_id,
 V01.kurstyp_id,
 V01.von_wrg_id,
 V01.nach_wrg_id,
 V01.dat_von,
 V01.dat_bis,
 V01.umrechnungskurs,
  1 / IF(ROUND(CAST(V01.umrechnungskurs AS NUMERIC), 2) = 0, NULL, ROUND(CAST(V01.umrechnungskurs AS NUMERIC), 2)) AS
 kurs,
  CASE
  WHEN 1 / IF(ROUND(CAST(V01.umrechnungskurs AS NUMERIC), 2) = 0, NULL, ROUND(CAST(V01.umrechnungskurs AS NUMERIC), 2))
   > 1
  THEN '1 ' || V01.nach_wrg_id || ' = ' || TRIM(SUBSTR(CAST(1 / IF(ROUND(CAST(V01.umrechnungskurs AS NUMERIC), 2) = 0,
          NULL, ROUND(CAST(V01.umrechnungskurs AS NUMERIC), 2)) AS STRING), 1, 20)) || ' ' || V01.von_wrg_id
  ELSE ''
  END AS kurs_bez
FROM kfl_production_dbp_view.v_kurs AS V01
 INNER JOIN kfl_production_dbp_view.v_mandant AS V02 ON V01.von_wrg_id = V02.default_wrg
WHERE V01.kurstyp_id = 3
 AND V01.dat_bis = DATE '9999-12-31';