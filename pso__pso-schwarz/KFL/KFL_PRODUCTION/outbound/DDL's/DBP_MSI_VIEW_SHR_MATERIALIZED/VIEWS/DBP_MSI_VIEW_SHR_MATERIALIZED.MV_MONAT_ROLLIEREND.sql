CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_shr_materialized.mv_monat_rollierend (kjmo, kjmo_roll) AS
-- generating 12 months back
 -- joining rollierend months with base month
 SELECT t5.kjmo0 AS kjmo,
 t5.kjmo_12
FROM (SELECT DISTINCT T1.kjmo AS kjmo0,
     EXTRACT(YEAR FROM DATE_ADD(PARSE_DATE('%Y%m', CAST(T1.kjmo AS STRING)), INTERVAL -1 * OFFSETS.c_offset MONTH)) *
     100 + EXTRACT(MONTH FROM DATE_ADD(PARSE_DATE('%Y%m', CAST(T1.kjmo AS STRING)), INTERVAL -1 * OFFSETS.c_offset MONTH)
     ) AS kjmo_12,
   T1.kjmo
  FROM kfl_production_dbp_msi_view_shr_materialized.mv_monat AS T1
   INNER JOIN (SELECT (ROW_NUMBER() OVER (ORDER BY 1 IS NULL, 1)) - 1 AS c_offset
    FROM UNNEST(GENERATE_ARRAY(0, 11)) AS SEQ) AS OFFSETS ON TRUE
  ORDER BY T1.kjmo DESC NULLS FIRST) AS t5;