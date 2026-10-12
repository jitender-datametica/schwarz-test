CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_geku_vtg_quote_1 (verteilgebiet_uid, kjwo, verteil_quote,
last_1_kjwo, last_1_quote, last_2_kjwo, last_2_quote, last_3_kjwo, last_3_quote) AS SELECT verteilgebiet_uid,
 kjwo,
 verteil_quote,
 MAX(last_1_kjwo) OVER (PARTITION BY verteilgebiet_uid RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS
 last_1_kjwo,
 MAX(last_1_quote) OVER (PARTITION BY verteilgebiet_uid RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS
 last_1_quote,
 MAX(last_2_kjwo) OVER (PARTITION BY verteilgebiet_uid RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS
 last_2_kjwo,
 MAX(last_2_quote) OVER (PARTITION BY verteilgebiet_uid RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS
 last_2_quote,
 MAX(last_3_kjwo) OVER (PARTITION BY verteilgebiet_uid RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS
 last_3_kjwo,
 MAX(last_3_quote) OVER (PARTITION BY verteilgebiet_uid RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS
 last_3_quote
FROM (SELECT verteilgebiet_uid,
   kjwo,
   verteil_quote,
   RANK() OVER (PARTITION BY CASE
       WHEN verteil_quote IS NOT NULL
       THEN verteilgebiet_uid
       ELSE NULL
       END ORDER BY kjwo IS NULL, kjwo) AS rank_kjwo,
   ROUND(CAST(CASE
      WHEN (RANK() OVER (PARTITION BY CASE
             WHEN verteil_quote IS NOT NULL
             THEN verteilgebiet_uid
             ELSE NULL
             END ORDER BY kjwo IS NULL, kjwo)) = 1 AND verteil_quote IS NOT NULL
      THEN TRIM(SUBSTR(CAST(MOD(CAST(kjwo AS BIGNUMERIC), 100) AS STRING), 1, 10)) || TRIM(SUBSTR(CAST((kjwo - 200000) / 100 AS STRING), 1, 20))
      ELSE NULL
      END AS BIGNUMERIC), 0) AS last_1_kjwo,
    CASE
    WHEN (RANK() OVER (PARTITION BY CASE
           WHEN verteil_quote IS NOT NULL
           THEN verteilgebiet_uid
           ELSE NULL
           END ORDER BY kjwo IS NULL, kjwo)) = 1 AND verteil_quote IS NOT NULL
    THEN verteil_quote
    ELSE NULL
    END AS last_1_quote,
   ROUND(CAST(CASE
      WHEN (RANK() OVER (PARTITION BY CASE
             WHEN verteil_quote IS NOT NULL
             THEN verteilgebiet_uid
             ELSE NULL
             END ORDER BY kjwo IS NULL, kjwo)) = 2 AND verteil_quote IS NOT NULL
      THEN TRIM(SUBSTR(CAST(MOD(CAST(kjwo AS BIGNUMERIC), 100) AS STRING), 1, 10)) || TRIM(SUBSTR(CAST((kjwo - 200000) / 100 AS STRING)
         , 1, 20))
      ELSE NULL
      END AS BIGNUMERIC), 0) AS last_2_kjwo,
    CASE
    WHEN (RANK() OVER (PARTITION BY CASE
           WHEN verteil_quote IS NOT NULL
           THEN verteilgebiet_uid
           ELSE NULL
           END ORDER BY kjwo IS NULL, kjwo)) = 2 AND verteil_quote IS NOT NULL
    THEN verteil_quote
    ELSE NULL
    END AS last_2_quote,
   ROUND(CAST(CASE
      WHEN (RANK() OVER (PARTITION BY CASE
             WHEN verteil_quote IS NOT NULL
             THEN verteilgebiet_uid
             ELSE NULL
             END ORDER BY kjwo IS NULL, kjwo)) = 3 AND verteil_quote IS NOT NULL
      THEN TRIM(SUBSTR(CAST(MOD(CAST(kjwo AS BIGNUMERIC), 100) AS STRING), 1, 10)) || TRIM(SUBSTR(CAST((kjwo - 200000) / 100 AS STRING)
         , 1, 20))
      ELSE NULL
      END AS BIGNUMERIC), 0) AS last_3_kjwo,
    CASE
    WHEN (RANK() OVER (PARTITION BY CASE
           WHEN verteil_quote IS NOT NULL
           THEN verteilgebiet_uid
           ELSE NULL
           END ORDER BY kjwo IS NULL, kjwo)) = 3 AND verteil_quote IS NOT NULL
    THEN verteil_quote
    ELSE NULL
    END AS last_3_quote
  FROM kfl_production_dbp_msi_view_vis.ts_geku_verteilgebiet_quote_1 AS V01) AS v011;