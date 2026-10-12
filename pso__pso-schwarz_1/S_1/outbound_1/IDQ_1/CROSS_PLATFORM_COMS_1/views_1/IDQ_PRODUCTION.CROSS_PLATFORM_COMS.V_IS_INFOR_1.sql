CREATE OR REPLACE VIEW idq_production_cross_platform_coms.v_is_infor_1 (timeadded_is_infor_view) AS SELECT MIN(min_insert
  ) AS timeadded
FROM (SELECT MIN(td_insert) AS min_insert
   FROM idq_production_kfl_zsm.eina_1
   UNION ALL
   SELECT MIN(td_insert) AS min_insert
   FROM idq_production_kfl_zsm.eine_1
   UNION ALL
   SELECT MIN(td_insert) AS min_insert
   FROM idq_production_kfl_zsm.makt_1
   UNION ALL
   SELECT MIN(td_insert) AS min_insert
   FROM idq_production_kfl_zsm.mara_1
   UNION ALL
   SELECT MIN(td_insert) AS min_insert
   FROM idq_production_kfl_zsm.marm_1
   UNION ALL
   SELECT MIN(td_insert) AS min_insert
   FROM idq_production_kfl_zsm.mast_1
   UNION ALL
   SELECT MIN(td_insert) AS min_insert
   FROM idq_production_kfl_zsm.maw1_1
   UNION ALL
   SELECT MIN(td_insert) AS min_insert
   FROM idq_production_kfl_zsm.mean_1
   UNION ALL
   SELECT MIN(td_insert) AS min_insert
   FROM idq_production_kfl_zsm.mlan_1
   UNION ALL
   SELECT MIN(td_insert) AS min_insert
   FROM idq_production_kfl_zsm.stko_1
   UNION ALL
   SELECT MIN(td_insert) AS min_insert
   FROM idq_production_kfl_zsm.stpo_1
   UNION ALL
   SELECT MIN(td_insert) AS min_insert
   FROM idq_production_kfl_zsm.t023_1
   UNION ALL
   SELECT MIN(td_insert) AS min_insert
   FROM idq_production_kfl_zsm.t023t_1
   UNION ALL
   SELECT MIN(td_insert) AS min_insert
   FROM idq_production_kfl_zsm.t179_1
   UNION ALL
   SELECT MIN(td_insert) AS min_insert
   FROM idq_production_kfl_zsm.t179t_1
   UNION ALL
   SELECT MIN(td_insert) AS min_insert
   FROM idq_production_kfl_zsm.zsm_country_ar_1) AS t15;