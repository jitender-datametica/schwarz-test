CREATE OR REPLACE VIEW ldl_bcbi_fe_mstr_bcbi.v_cubeavail_subcube_detail_1 AS SELECT EXPT.day,
 DET.week,
 DET.week_name,
 DET.week_id,
 DET.month,
 DET.month_name,
 DET.month_id,
 DET.year,
 DET.bus_year,
 DET.zone,
 DET.project_id,
 DET.project_name,
 DET.cube_id,
 DET.cube_name,
 EXPT.subcube_id,
 EXPT.subcube_name,
 DET.first_solution_id,
 DET.first_solution_name,
 DET.sec_solution_id,
 DET.sec_solution_name,
 EXPT.amount_expected_server AS expected_subcube_cubes,
 COUNT(CASE
   WHEN DET.vta_status = 'VTA'
   THEN 1
   ELSE NULL
   END) AS amount_iserver_vta,
 COUNT(CASE
   WHEN DET.vta_status = 'VVTA'
   THEN 1
   ELSE NULL
   END) AS amount_iserver_vvta,
 COUNT(CASE
   WHEN DET.vta_status = 'NVTA'
   THEN 1
   ELSE NULL
   END) AS amount_iserver_nvta,
 MAX(DET.end_time) AS endtime_last_cube,
 COUNT(CASE
   WHEN DET.error_id = 1
   THEN 1
   ELSE NULL
   END) AS amount_errors,
  CASE
  WHEN COUNT(CASE
       WHEN DET.vta_status = 'NVTA'
       THEN 1
       ELSE NULL
       END) > 0 OR DET.zone = 'EU' AND CURRENT_TIME > TIME(TIME '13:30:00') AND COUNT(CASE
          WHEN DET.vta_status = 'VTA'
          THEN 1
          ELSE NULL
          END) + COUNT(CASE
          WHEN DET.vta_status = 'VVTA'
          THEN 1
          ELSE NULL
          END) + COUNT(CASE
         WHEN DET.vta_status = 'NVTA'
         THEN 1
         ELSE NULL
         END) < EXPT.amount_expected_server OR DET.zone = 'US' AND CURRENT_TIME > TIME(TIME '18:00:00') AND COUNT(CASE
         WHEN DET.vta_status = 'VTA'
         THEN 1
         ELSE NULL
         END) + COUNT(CASE
         WHEN DET.vta_status = 'VVTA'
         THEN 1
         ELSE NULL
         END) + COUNT(CASE
        WHEN DET.vta_status = 'NVTA'
        THEN 1
        ELSE NULL
        END) < EXPT.amount_expected_server
  THEN 'NVTA'
  WHEN COUNT(CASE
     WHEN DET.vta_status = 'VVTA'
     THEN 1
     ELSE NULL
     END) > 0
  THEN 'VVTA'
  WHEN COUNT(CASE
     WHEN DET.vta_status = 'VTA'
     THEN 1
     ELSE NULL
     END) = EXPT.amount_expected_server
  THEN 'VTA'
  WHEN DET.zone = 'EU' AND CURRENT_TIME > TIME(TIME '07:30:00') AND COUNT(CASE
       WHEN DET.vta_status = 'VTA'
       THEN 1
       ELSE NULL
       END) < EXPT.amount_expected_server OR DET.zone = 'US' AND CURRENT_TIME > TIME(TIME '13:00:00') AND COUNT(CASE
       WHEN DET.vta_status = 'VTA'
       THEN 1
       ELSE NULL
       END) < EXPT.amount_expected_server
  THEN 'NVTA'
  ELSE ' '
  END AS subcube_status
FROM ldl_bcbi_fe_mstr_bcbi.v_cubeavail_server_detail_1 AS DET
 RIGHT JOIN (SELECT day,
   subcube_id,
   subcube_name,
   COUNT(DISTINCT iserver_id) AS amount_expected_server
  FROM ldl_bcbi_fe_mstr_bcbi.v_cubeavail_expected_1
  GROUP BY day,
   subcube_id,
   subcube_name) AS EXPT ON DET.subcube_id = EXPT.subcube_id AND DET.day = EXPT.day
GROUP BY EXPT.day,
 DET.week,
 DET.week_name,
 DET.week_id,
 DET.month,
 DET.month_name,
 DET.month_id,
 DET.year,
 DET.bus_year,
 DET.zone,
 DET.project_id,
 DET.project_name,
 DET.cube_id,
 DET.cube_name,
 EXPT.subcube_id,
 EXPT.subcube_name,
 DET.first_solution_id,
 DET.first_solution_name,
 DET.sec_solution_id,
 DET.sec_solution_name,
 expected_subcube_cubes;