-- LOOKUP Berichtskurs pro Mandant_1
 -- Anreicherung Kurs_1-Texte
 -- 2010KW17 Review

CREATE OR REPLACE VIEW public.mv_kurs_1 (mandant_id, kurstyp_id, von_wrg_id, nach_wrg_id, dat_von, dat_bis,
umrechnungskurs, kurs_1, kurs_bez) AS SELECT v02.mandant_id,
 v01.kurstyp_id,
 v01.von_wrg_id,
 v01.nach_wrg_id,
 v01.dat_von,
 v01.dat_bis,
 v01.umrechnungskurs,
  1 / IF(ROUND(CAST(v01.umrechnungskurs AS NUMERIC), 2) = 0, NULL, ROUND(CAST(v01.umrechnungskurs AS NUMERIC), 2)) AS
 kurs_1,
  CASE
  WHEN 1 / IF(ROUND(CAST(v01.umrechnungskurs AS NUMERIC), 2) = 0, NULL, ROUND(CAST(v01.umrechnungskurs AS NUMERIC), 2))
   > 1
  THEN '1 ' || v01.nach_wrg_id || ' = ' || TRIM(SUBSTR(CAST(1 / IF(ROUND(CAST(v01.umrechnungskurs AS NUMERIC), 2) = 0,
          NULL, ROUND(CAST(v01.umrechnungskurs AS NUMERIC), 2)) AS STRING), 1, 20)) || ' ' || v01.von_wrg_id
  ELSE ''
  END AS kurs_bez
FROM kfl_production_dbp_view.v_kurs_1 AS v01
 INNER JOIN kfl_production_dbp_view.v_mandant_1 AS v02 ON v01.von_wrg_id = v02.default_wrg
WHERE v01.kurstyp_id = 3
 AND v01.dat_bis = DATE '9999-12-31';