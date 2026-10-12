CREATE OR REPLACE VIEW idq_production_cross_platform_coms.v_is_infor_2 (timeadded_is_infor_view) AS SELECT MIN(min_insert
  ) AS timeadded
FROM (SELECT MIN(td_insert) AS min_insert
   FROM idq_production_kfl_zsm.eina_2
   UNION ALL
   SELECT MIN(td_insert) AS min_insert
   FROM idq_production_kfl_zsm.eine_2
   UNION ALL
   SELECT MIN(td_insert) AS min_insert
   FROM idq_production_kfl_zsm.makt_2
   UNION ALL
   SELECT MIN(td_insert) AS min_insert
   FROM idq_production_kfl_zsm.mara_2
   UNION ALL
   SELECT MIN(td_insert) AS min_insert
   FROM idq_production_kfl_zsm.marm_2
   UNION ALL
   SELECT MIN(td_insert) AS min_insert
   FROM idq_production_kfl_zsm.mast_2
   UNION ALL
   SELECT MIN(td_insert) AS min_insert
   FROM idq_production_kfl_zsm.maw1_2
   UNION ALL
   SELECT MIN(td_insert) AS min_insert
   FROM idq_production_kfl_zsm.mean_2
   UNION ALL
   SELECT MIN(td_insert) AS min_insert
   FROM idq_production_kfl_zsm.mlan_2
   UNION ALL
   SELECT MIN(td_insert) AS min_insert
   FROM idq_production_kfl_zsm.stko_2
   UNION ALL
   SELECT MIN(td_insert) AS min_insert
   FROM idq_production_kfl_zsm.stpo_2
   UNION ALL
   SELECT MIN(td_insert) AS min_insert
   FROM idq_production_kfl_zsm.t023_2
   UNION ALL
   SELECT MIN(td_insert) AS min_insert
   FROM idq_production_kfl_zsm.t023t_2
   UNION ALL
   SELECT MIN(td_insert) AS min_insert
   FROM idq_production_kfl_zsm.t179_2
   UNION ALL
   SELECT MIN(td_insert) AS min_insert
   FROM idq_production_kfl_zsm.t179t_2
   UNION ALL
   SELECT MIN(td_insert) AS min_insert
   FROM idq_production_kfl_zsm.zsm_country_ar_2) AS t15;