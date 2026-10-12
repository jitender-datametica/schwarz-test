CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ios.mv_l_bvv_leistung AS SELECT bvv_leist_id,
 psp_end_nr,
 psp_end_nr AS bvv_gewerk_id,
  CASE
  WHEN bvv_leist_id BETWEEN 7 AND 11
  THEN 7
  WHEN bvv_leist_id BETWEEN 12 AND 17
  THEN 12
  WHEN bvv_leist_id = 993 OR bvv_leist_id BETWEEN 18 AND 85 OR bvv_leist_id BETWEEN 300 AND 399
  THEN 18
  WHEN bvv_leist_id = 994 OR bvv_leist_id BETWEEN 87 AND 123 OR bvv_leist_id BETWEEN 400 AND 499
  THEN 87
  WHEN bvv_leist_id = 995 OR bvv_leist_id BETWEEN 125 AND 158 OR bvv_leist_id BETWEEN 500 AND 699
  THEN 158
  WHEN bvv_leist_id = 996 OR bvv_leist_id BETWEEN 159 AND 162 OR bvv_leist_id BETWEEN 700 AND 799
  THEN 159
  WHEN bvv_leist_id = 997 OR bvv_leist_id BETWEEN 163 AND 165 OR bvv_leist_id BETWEEN 800 AND 990
  THEN 163
  WHEN bvv_leist_id IN (3, 991) OR bvv_leist_id BETWEEN 166 AND 199
  THEN 3
  WHEN bvv_leist_id IN (5, 992) OR bvv_leist_id BETWEEN 200 AND 299
  THEN 5
  ELSE bvv_leist_id
  END AS bvv_u_gewerk_id,
  CASE
  WHEN bvv_leist_id IN (991, 992) OR bvv_leist_id BETWEEN 1 AND 5 OR bvv_leist_id BETWEEN 166 AND 299
  THEN 1
  WHEN bvv_leist_id IN (993, 994) OR bvv_leist_id BETWEEN 7 AND 123 OR bvv_leist_id BETWEEN 300 AND 499
  THEN 7
  WHEN bvv_leist_id IN (995, 996, 997) OR bvv_leist_id BETWEEN 125 AND 165 OR bvv_leist_id BETWEEN 500 AND 990
  THEN 125
  ELSE bvv_leist_id
  END AS bvv_immo_mob_id,
  CASE
  WHEN bvv_leist_id BETWEEN 7 AND 17
  THEN 1
  WHEN bvv_leist_id = 993 OR bvv_leist_id BETWEEN 18 AND 85 OR bvv_leist_id BETWEEN 300 AND 399
  THEN 2
  WHEN bvv_leist_id = 994 OR bvv_leist_id BETWEEN 87 AND 123 OR bvv_leist_id BETWEEN 400 AND 499
  THEN 3
  WHEN bvv_leist_id = 995 OR bvv_leist_id BETWEEN 125 AND 158 OR bvv_leist_id BETWEEN 500 AND 699
  THEN 4
  WHEN bvv_leist_id IN (5, 992) OR bvv_leist_id BETWEEN 200 AND 299
  THEN 5
  WHEN bvv_leist_id = 991 OR bvv_leist_id BETWEEN 1 AND 3 OR bvv_leist_id BETWEEN 166 AND 199
  THEN 6
  WHEN bvv_leist_id = 996 OR bvv_leist_id BETWEEN 159 AND 162 OR bvv_leist_id BETWEEN 700 AND 799
  THEN 7
  WHEN bvv_leist_id = 997 OR bvv_leist_id BETWEEN 163 AND 165 OR bvv_leist_id BETWEEN 800 AND 999
  THEN 8
  ELSE bvv_leist_id
  END AS bvv_u_gewerk_summe_id
FROM kfl_production_dbp_view.v_l_bvv_leistung;