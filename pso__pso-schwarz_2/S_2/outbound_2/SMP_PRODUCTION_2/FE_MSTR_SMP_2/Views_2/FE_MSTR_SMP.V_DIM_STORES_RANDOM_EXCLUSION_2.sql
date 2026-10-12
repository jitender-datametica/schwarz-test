CREATE OR REPLACE VIEW smp_production_fe_mstr_smp.v_dim_stores_random_exclusion_2 AS WITH STORES_WITH_RANK AS (SELECT
   division_id,
   country_id,
   store_id,
   store_nr,
   ROW_NUMBER() OVER (PARTITION BY country_id, division_id ORDER BY CAST((RAND() - 0.5) * POWER(10, 18) AS INTEGER)
      NULLS LAST) AS rand,
   COUNT(*) OVER (PARTITION BY country_id, division_id RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS
   cnt_store
  FROM smp_production_fe_mstr_smp.v_dim_store_2
  GROUP BY division_id,
   country_id,
   store_id,
   store_nr), STORES_TO_EXCLUDE AS (SELECT division_id,
   country_id,
   store_id,
   store_nr,
   rand,
   cnt_store,
   CAST(ROUND(CEIL(0.3 * cnt_store)) AS INTEGER) AS exclude_cnt
  FROM STORES_WITH_RANK
  WHERE rand > CAST(ROUND(CEIL(0.3 * cnt_store)) AS INTEGER)) (SELECT country_id,
   division_id,
   store_id,
   store_nr
  FROM STORES_TO_EXCLUDE);