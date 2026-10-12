CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_itm_statisticgroup_new AS SELECT T1.statisticgroup_id,
 T1.statisticgroup_desc,
 T1.language_id,
  CASE
  WHEN T1.statisticgroup_id IN (1)
  THEN 1
  WHEN T1.statisticgroup_id IN (3, 4)
  THEN 2
  WHEN T1.statisticgroup_id IN (6)
  THEN 3
  WHEN T1.statisticgroup_id IN (10, 11)
  THEN 4
  ELSE 5
  END AS stdgroup_id
FROM ldl_p_lew_core_ac.v_wawi_itm_statisticgroup AS T1
 INNER JOIN ldl_p_lew_mart_msi.v_ref_user_language AS T2 ON LOWER(SESSION_USER()) = LOWER(T2.db_user) AND T1.language_id
    = T2.language_id
WHERE CURRENT_DATE BETWEEN T1.dat_rec_start AND T1.dat_rec_end
GROUP BY T1.statisticgroup_id,
 T1.statisticgroup_desc,
 T1.language_id,
 stdgroup_id;