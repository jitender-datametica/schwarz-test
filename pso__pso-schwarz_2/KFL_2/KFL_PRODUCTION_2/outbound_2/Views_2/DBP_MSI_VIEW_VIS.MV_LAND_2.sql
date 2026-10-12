CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_land_2 AS SELECT CAST(CASE
   WHEN mandant_id = 1
   THEN mandant_sort_id + 1
   ELSE mandant_sort_id + 2
   END AS BIGNUMERIC) AS land_sort_id,
 CAST(mandant_id AS BIGNUMERIC) AS land_id,
 CAST(mandant_bez AS STRING) AS land_bez,
 CAST(CASE
   WHEN mandant_id = 2
   THEN 'Tschechien'
   WHEN mandant_id = 7
   THEN 'Rumänien'
   ELSE mandant_bez
   END AS STRING) AS land_neu_bez
FROM kfl_production_dbp_view.v_mandant_2
UNION ALL
SELECT CAST(mandant_id AS BIGNUMERIC) AS dm__operand0,
 - 1,
 'INT',
 'INT'
FROM kfl_production_dbp_view.v_mandant_2
WHERE mandant_id = 1
UNION ALL
SELECT CAST(mandant_id AS BIGNUMERIC) AS dm__operand0,
 - 2 AS dm__operand1,
 'Ausland' AS dm__operand2,
 'Ausland' AS dm__operand3
FROM kfl_production_dbp_view.v_mandant_2
WHERE mandant_id = 3;