CREATE OR REPLACE VIEW idq_production_cross_platform_coms.v_is_infor_kfl_pmr_1 (timeadded_is_infor_view) AS SELECT MIN(min_insert
  ) AS timeadded
FROM (SELECT MIN(td_insert) AS min_insert
   FROM idq_production_kfl_pmr.dmf_ofr_1
   UNION ALL
   SELECT MIN(td_insert) AS min_insert
   FROM idq_production_kfl_pmr.dmf_ofr_exp_sts_1
   UNION ALL
   SELECT MIN(td_insert) AS min_insert
   FROM idq_production_kfl_pmr.dmf_ofr_ext_xr_1
   UNION ALL
   SELECT MIN(td_insert) AS min_insert
   FROM idq_production_kfl_pmr.dmf_ofr_trm_prd_1
   UNION ALL
   SELECT MIN(td_insert) AS min_insert
   FROM idq_production_kfl_pmr.dmf_prod_1
   UNION ALL
   SELECT MIN(td_insert) AS min_insert
   FROM idq_production_kfl_pmr.dmf_prod_ext_xr_1
   UNION ALL
   SELECT MIN(td_insert) AS min_insert
   FROM idq_production_kfl_pmr.dmf_prodt_1) AS t6;