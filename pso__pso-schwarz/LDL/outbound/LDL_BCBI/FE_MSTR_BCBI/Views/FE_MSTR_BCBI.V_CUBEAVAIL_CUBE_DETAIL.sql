CREATE OR REPLACE VIEW ldl_bcbi_fe_mstr_bcbi.v_cubeavail_cube_detail AS SELECT t3.day0 AS day,
 t3.week,
 t3.week_name,
 t3.week_id,
 t3.month,
 t3.month_name,
 t3.month_id,
 t3.year,
 t3.bus_year,
 t3.zone,
 t3.cube_id,
 t3.cube_name,
 t3.expected_cube_cubes,
 t3.amount_subcube_vta,
 t3.amount_subcube_vvta,
 t3.amount_subcube_nvta,
 t3.endtime_last_cube,
 t3.cube_status
FROM (SELECT EXPT.day AS day0,
   DET.week,
   DET.week_name,
   DET.week_id,
   DET.month,
   DET.month_name,
   DET.month_id,
   DET.year,
   DET.bus_year,
   DET.zone,
   EXPT.cube_id,
   EXPT.cube_name,
   EXPT.amount_expected_subcubes AS expected_cube_cubes,
   COUNT(CASE
     WHEN DET.subcube_status = 'VTA'
     THEN 1
     ELSE NULL
     END) AS amount_subcube_vta,
   COUNT(CASE
     WHEN DET.subcube_status = 'VVTA'
     THEN 1
     ELSE NULL
     END) AS amount_subcube_vvta,
   COUNT(CASE
     WHEN DET.subcube_status = 'NVTA'
     THEN 1
     ELSE NULL
     END) AS amount_subcube_nvta,
   MAX(DET.endtime_last_cube) AS endtime_last_cube,
    CASE
    WHEN COUNT(CASE
         WHEN DET.subcube_status = 'NVTA'
         THEN 1
         ELSE NULL
         END) > 0 OR DET.zone = 'EU' AND CURRENT_TIME > TIME(TIME '13:30:00') AND COUNT(CASE
            WHEN DET.subcube_status = 'VTA'
            THEN 1
            ELSE NULL
            END) + COUNT(CASE
            WHEN DET.subcube_status = 'VVTA'
            THEN 1
            ELSE NULL
            END) + COUNT(CASE
           WHEN DET.subcube_status = 'NVTA'
           THEN 1
           ELSE NULL
           END) < EXPT.amount_expected_subcubes OR DET.zone = 'US' AND CURRENT_TIME > TIME(TIME '18:00:00') AND COUNT(CASE
           WHEN DET.subcube_status = 'VTA'
           THEN 1
           ELSE NULL
           END) + COUNT(CASE
           WHEN DET.subcube_status = 'VVTA'
           THEN 1
           ELSE NULL
           END) + COUNT(CASE
          WHEN DET.subcube_status = 'NVTA'
          THEN 1
          ELSE NULL
          END) < EXPT.amount_expected_subcubes
    THEN 'NVTA'
    WHEN COUNT(CASE
       WHEN DET.subcube_status = 'VVTA'
       THEN 1
       ELSE NULL
       END) > 0
    THEN 'VVTA'
    WHEN COUNT(CASE
       WHEN DET.subcube_status = 'VTA'
       THEN 1
       ELSE NULL
       END) = EXPT.amount_expected_subcubes
    THEN 'VTA'
    WHEN DET.zone = 'EU' AND CURRENT_TIME > TIME(TIME '07:30:00') AND COUNT(CASE
         WHEN DET.subcube_status = 'VTA'
         THEN 1
         ELSE NULL
         END) < EXPT.amount_expected_subcubes OR DET.zone = 'US' AND CURRENT_TIME > TIME(TIME '13:00:00') AND COUNT(CASE
         WHEN DET.subcube_status = 'VTA'
         THEN 1
         ELSE NULL
         END) < EXPT.amount_expected_subcubes
    THEN 'NVTA'
    ELSE ' '
    END AS cube_status,
   EXPT.day
  FROM ldl_bcbi_fe_mstr_bcbi.v_cubeavail_subcube_detail AS DET
   LEFT JOIN (SELECT day,
     cube_id,
     cube_name,
     COUNT(DISTINCT subcube_id) AS amount_expected_subcubes
    FROM ldl_bcbi_fe_mstr_bcbi.v_cubeavail_expected
    GROUP BY day,
     cube_id,
     cube_name) AS EXPT ON DET.cube_id = EXPT.cube_id AND DET.day = EXPT.day
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
   EXPT.cube_id,
   EXPT.cube_name,
   expected_cube_cubes
  ORDER BY EXPT.day NULLS LAST,
   DET.week NULLS LAST) AS t3;