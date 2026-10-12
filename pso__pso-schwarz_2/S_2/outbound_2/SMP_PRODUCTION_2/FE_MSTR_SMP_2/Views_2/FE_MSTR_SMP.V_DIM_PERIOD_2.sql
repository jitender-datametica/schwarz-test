CREATE OR REPLACE VIEW smp_production_fe_mstr_smp.v_dim_period_2 AS WITH P AS (SELECT 'TEST_2' AS period
   UNION ALL
   SELECT 'PRE' AS period
   UNION ALL
   SELECT 'POST' AS period), PP AS (SELECT 'TEST_2' AS period_detail
   UNION ALL
   SELECT 'PRE' AS period_detail
   UNION ALL
   SELECT 'POST_1' AS period_detail
   UNION ALL
   SELECT 'POST_2' AS period_detail) (SELECT t1.period,
   t4.period_detail
  FROM P AS t1_2
   INNER JOIN PP AS t4 ON t4.period_detail LIKE '%' || t1.period || '%');