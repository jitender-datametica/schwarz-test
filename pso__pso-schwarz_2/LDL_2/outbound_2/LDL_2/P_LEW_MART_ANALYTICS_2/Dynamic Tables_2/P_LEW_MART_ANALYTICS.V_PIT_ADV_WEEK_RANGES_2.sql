CREATE OR REPLACE MATERIALIZED VIEW ldl_p_lew_mart_analytics.v_pit_adv_week_ranges_2
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90,max_staleness = INTERVAL 90 MINUTE,allow_non_incremental_definition = true
) AS
SELECT AWK.client_id,
 1 AS range_id,
 CAST(100 + AWK.client_id AS BIGNUMERIC) AS range_sid,
 rng.range_seq,
   'Letzte ' || CAST(- 1 * rng.range_seq AS STRING) || ' Werbewochen' AS range_desc,
 AWK.adv_week_seq
FROM ldl_p_lew_mart_analytics.v_pit_adv_week_2 AS AWK
 INNER JOIN (SELECT client_id,
   MIN(adv_week_seq) AS range_seq
  FROM ldl_p_lew_mart_analytics.v_pit_adv_week_2
  GROUP BY client_id) AS rng ON AWK.client_id = rng.client_id
UNION ALL
SELECT client_id,
 2 AS range_id,
 CAST(2 * 100 + client_id AS BIGNUMERIC) AS range_sid,
 - 104 AS range_seq,
 'Letzte 104 Werbewochen' AS range_desc,
 adv_week_seq
FROM ldl_p_lew_mart_analytics.v_pit_adv_week_2
WHERE adv_week_seq BETWEEN - 104 AND 0
UNION ALL
SELECT client_id,
 3 AS range_id,
 CAST(3 * 100 + client_id AS BIGNUMERIC) AS range_sid,
 - 52 AS range_seq,
 'Letzte 52 Werbewochen' AS range_desc,
 adv_week_seq
FROM ldl_p_lew_mart_analytics.v_pit_adv_week_2
WHERE adv_week_seq BETWEEN - 52 AND 0
UNION ALL
SELECT client_id,
 4 AS range_id,
 CAST(4 * 100 + client_id AS BIGNUMERIC) AS range_sid,
 - 36 AS range_seq,
 'Letzte 36 Werbewochen' AS range_desc,
 adv_week_seq
FROM ldl_p_lew_mart_analytics.v_pit_adv_week_2
WHERE adv_week_seq BETWEEN - 36 AND 0
UNION ALL
SELECT client_id,
 5 AS range_id,
 CAST(5 * 100 + client_id AS BIGNUMERIC) AS range_sid,
 - 24 AS range_seq,
 'Letzte 24 Werbewochen' AS range_desc,
 adv_week_seq
FROM ldl_p_lew_mart_analytics.v_pit_adv_week_2
WHERE adv_week_seq BETWEEN - 24 AND 0
UNION ALL
SELECT client_id,
 6 AS range_id,
 CAST(6 * 100 + client_id AS BIGNUMERIC) AS range_sid,
 - 12 AS range_seq,
 'Letzte 12 Werbewochen' AS range_desc,
 adv_week_seq
FROM ldl_p_lew_mart_analytics.v_pit_adv_week_2
WHERE adv_week_seq BETWEEN - 12 AND 0
UNION ALL
SELECT client_id,
 7 AS range_id,
 CAST(7 * 100 + client_id AS BIGNUMERIC) AS range_sid,
 - 4 AS range_seq,
 'Letzte 4 Werbewochen' AS range_desc,
 adv_week_seq
FROM ldl_p_lew_mart_analytics.v_pit_adv_week_2
WHERE adv_week_seq BETWEEN - 4 AND 0;
