CREATE OR REPLACE VIEW ugs_aris_production_fe_mstr_aris.v_fact_world (dwh_tenant_cd, country_org_sid, country_org_name,
number_processes_int, number_processes, number_processes_cur, number_processes_updt, number_processes_abw,
number_processes_unv, number_processes_erg, rollout_dur_day_sum, rollout_dur_day_cnt) AS SELECT dwh_tenant_cd,
 country_org_sid,
  CASE
  WHEN country_org_name = 'Lidl Asia'
  THEN 'Hong Kong'
  ELSE country_org_name
  END AS country_org_name,
 COUNT(CASE
   WHEN country_org_nr = 'INTEGER ' AND dwh_src_file_name = 'Lidl-Prozesse lesen MSTR'
   THEN 1
   ELSE NULL
   END) AS number_processes_int,
 COUNT(CASE
   WHEN country_org_nr IS NOT NULL
   THEN 1
   ELSE NULL
   END) AS number_processes,
 COUNT(CASE
   WHEN process_upd_status_cd = 'CUR'
   THEN 1
   ELSE NULL
   END) AS number_processes_cur,
 COUNT(CASE
   WHEN process_upd_status_cd = 'UPDT'
   THEN 1
   ELSE NULL
   END) AS number_processes_updt,
 COUNT(CASE
   WHEN process_change_lvl_cd = 'Abw'
   THEN 1
   ELSE NULL
   END) AS number_processes_abw,
 COUNT(CASE
   WHEN process_change_lvl_cd = 'Unv'
   THEN 1
   ELSE NULL
   END) AS number_processes_unv,
 COUNT(CASE
   WHEN process_change_lvl_cd = 'Erg'
   THEN 1
   ELSE NULL
   END) AS number_processes_erg,
 SUM(CASE
   WHEN CAST(process_rollout_status_cd AS FLOAT64) = 0 AND approval_dt BETWEEN IF(DATE_ADD(LAST_DAY(CURRENT_DATE, MONTH
         ), INTERVAL 1 DAY) = LAST_DAY(DATE_ADD(LAST_DAY(CURRENT_DATE, MONTH), INTERVAL 1 DAY)), LAST_DAY(DATE_ADD(DATE_ADD(LAST_DAY(CURRENT_DATE
          , MONTH), INTERVAL 1 DAY), INTERVAL - 2 MONTH)), DATE_ADD(DATE_ADD(LAST_DAY(CURRENT_DATE, MONTH), INTERVAL 1
        DAY), INTERVAL - 2 MONTH)) AND (IF(LAST_DAY(CURRENT_DATE, MONTH) = LAST_DAY(LAST_DAY(CURRENT_DATE, MONTH)),
       LAST_DAY(DATE_ADD(LAST_DAY(CURRENT_DATE, MONTH), INTERVAL - 1 MONTH)), DATE_ADD(LAST_DAY(CURRENT_DATE, MONTH),
        INTERVAL - 1 MONTH)))
   THEN rollout_dur_day_cnt
   ELSE 0
   END) AS rollout_dur_day_sum,
 COUNT(CASE
   WHEN CAST(process_rollout_status_cd AS FLOAT64) = 0 AND approval_dt BETWEEN IF(DATE_ADD(LAST_DAY(CURRENT_DATE, MONTH
         ), INTERVAL 1 DAY) = LAST_DAY(DATE_ADD(LAST_DAY(CURRENT_DATE, MONTH), INTERVAL 1 DAY)), LAST_DAY(DATE_ADD(DATE_ADD(LAST_DAY(CURRENT_DATE
          , MONTH), INTERVAL 1 DAY), INTERVAL - 2 MONTH)), DATE_ADD(DATE_ADD(LAST_DAY(CURRENT_DATE, MONTH), INTERVAL 1
        DAY), INTERVAL - 2 MONTH)) AND (IF(LAST_DAY(CURRENT_DATE, MONTH) = LAST_DAY(LAST_DAY(CURRENT_DATE, MONTH)),
       LAST_DAY(DATE_ADD(LAST_DAY(CURRENT_DATE, MONTH), INTERVAL - 1 MONTH)), DATE_ADD(LAST_DAY(CURRENT_DATE, MONTH),
        INTERVAL - 1 MONTH)))
   THEN rollout_dur_day_cnt
   ELSE NULL
   END) AS rollout_dur_day_cnt
FROM ugs_aris_production_fe_mstr_aris.v_dim_process
WHERE dwh_tenant_cd = 'L'
 AND process_sid > 0
 AND NOT country_specific_process_fg
GROUP BY dwh_tenant_cd,
 country_org_sid,
 country_org_name;