CREATE OR REPLACE VIEW idq_production_cross_platform_coms.v_is_infor (timeadded_is_infor_view) AS SELECT MIN(min_insert
  ) AS timeadded
FROM (SELECT MIN(td_insert) AS min_insert
   FROM idq_production_kfl_zsm.eina
   UNION ALL
   SELECT MIN(td_insert) AS min_insert
   FROM idq_production_kfl_zsm.eine
   UNION ALL
   SELECT MIN(td_insert) AS min_insert
   FROM idq_production_kfl_zsm.makt
   UNION ALL
   SELECT MIN(td_insert) AS min_insert
   FROM idq_production_kfl_zsm.mara
   UNION ALL
   SELECT MIN(td_insert) AS min_insert
   FROM idq_production_kfl_zsm.marm
   UNION ALL
   SELECT MIN(td_insert) AS min_insert
   FROM idq_production_kfl_zsm.mast
   UNION ALL
   SELECT MIN(td_insert) AS min_insert
   FROM idq_production_kfl_zsm.maw1
   UNION ALL
   SELECT MIN(td_insert) AS min_insert
   FROM idq_production_kfl_zsm.mean
   UNION ALL
   SELECT MIN(td_insert) AS min_insert
   FROM idq_production_kfl_zsm.mlan
   UNION ALL
   SELECT MIN(td_insert) AS min_insert
   FROM idq_production_kfl_zsm.stko
   UNION ALL
   SELECT MIN(td_insert) AS min_insert
   FROM idq_production_kfl_zsm.stpo
   UNION ALL
   SELECT MIN(td_insert) AS min_insert
   FROM idq_production_kfl_zsm.t023
   UNION ALL
   SELECT MIN(td_insert) AS min_insert
   FROM idq_production_kfl_zsm.t023t
   UNION ALL
   SELECT MIN(td_insert) AS min_insert
   FROM idq_production_kfl_zsm.t179
   UNION ALL
   SELECT MIN(td_insert) AS min_insert
   FROM idq_production_kfl_zsm.t179t
   UNION ALL
   SELECT MIN(td_insert) AS min_insert
   FROM idq_production_kfl_zsm.zsm_country_ar) AS t15;