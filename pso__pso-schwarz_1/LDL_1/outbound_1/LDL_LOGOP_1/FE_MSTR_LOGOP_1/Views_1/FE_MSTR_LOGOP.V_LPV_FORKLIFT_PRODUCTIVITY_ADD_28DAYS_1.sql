CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_lpv_forklift_productivity_add_28days_1 (client_id
OPTIONS(description='Client id - calculated based on the country_1 code (PK)'), wh_id
OPTIONS(description='Warehouse number (datastore_data:lagernummer). Foreign key: Referencing LPV.LAGER.LAGERNR'), op_id
OPTIONS(description='Surrogate key (PK)'), op_dt OPTIONS(description='Operation date from timestamp'), op_tm
OPTIONS(description='Operation time from timestamp'), op_type OPTIONS(description='Operation type'), user_id
OPTIONS(description='User ID of the executing user. Foreign key: Referencing LPV.PERSONAL.PERSNR'), comp_id
OPTIONS(description='Computer that initiated the goods movement. Foreign key: References LPV.RECHNER.RECHNERID'),
src_pallet_nr
OPTIONS(description='Number of the pallet on which the stock is located. Foreign key: References LPV.LHM.LHMNR'),
pallet_type OPTIONS(description='This column identifies if a pallet is Doppelt Quer or Einfachtief type'), src_area_nr
OPTIONS(description='Source area. Foreign key: Referencing LPV.BEREICH.NR'), tgt_area_nr
OPTIONS(description='Target area. Foreign key: Referencing LPV.BEREICH.NR'), dwh_created
OPTIONS(description='Record created at'), dwh_updated OPTIONS(description='Record updated at'), mvmt_fg
OPTIONS(description='Flag for classification if the operation is a relevant movement'), cons_src_area_nr
OPTIONS(description='Consolidated source area number'), mvmt_type_nr OPTIONS(description='Movement type for FE lookup'),
op_dt_prev OPTIONS(description='Operation date of previous warehouse task'), op_tm_prev
OPTIONS(description='Operation time of previous warehouse task'), prev_op_tm_diff_sec
OPTIONS(description='Time in seconds between last and current operation'), emp_wrk_shift_start_fg
OPTIONS(description='Flag for first operation of a working shift of an employee_1'), work_tm_sec
OPTIONS(description='Recorded working time in seconds'), work_tm_sec_net
OPTIONS(description='Net working time in seconds without pauses and with standard time'), count_pallet_mvmt
OPTIONS(description='Amount of pallet movements'), number_of_pallet_mvmt
OPTIONS(description='Number of pallet movements')) AS WITH CONSOLIDATEDOPERATIONS AS (SELECT client_id,
   wh_id,
   operation_id AS op_id,
   DATE(operation_tmsp) AS op_dt,
   TIME(operation_tmsp) AS op_tm,
   operation_type AS op_type,
   user_id,
   computer_id AS comp_id,
   src_pallet_nr,
   src_area_nr,
   tgt_area_nr,
   dwh_created,
   dwh_updated,
    CASE
    WHEN operation_type = 'NU' AND TIME_DIFF(LAG(TIME(operation_tmsp)) OVER (PARTITION BY CAST(client_id AS STRING), CAST(wh_id AS STRING)
          , user_id, computer_id, src_pallet_nr, DATE(operation_tmsp) ORDER BY DATE(operation_tmsp) IS NULL, DATE(operation_tmsp
           ), TIME(operation_tmsp) IS NULL, TIME(operation_tmsp), operation_id IS NULL, operation_id), TIME(operation_tmsp
        ), SECOND) <= 5
    THEN 0
    WHEN tgt_area_nr BETWEEN 8000 AND 8999 AND tgt_area_nr = (LEAD(src_area_nr) OVER (PARTITION BY CAST(client_id AS STRING)
          , CAST(wh_id AS STRING), computer_id, user_id, src_pallet_nr, CAST(operation_id AS STRING), DATE(operation_tmsp
           ) ORDER BY DATE(operation_tmsp) IS NULL, DATE(operation_tmsp), TIME(operation_tmsp) IS NULL, TIME(operation_tmsp
           ), operation_id IS NULL, operation_id))
    THEN 0
    ELSE 1
    END AS mvmt_fg,
   IF(CASE
         WHEN operation_type = 'NU' AND TIME_DIFF(LAG(TIME(operation_tmsp)) OVER (PARTITION BY CAST(client_id AS STRING)
               , CAST(wh_id AS STRING), user_id, computer_id, src_pallet_nr, DATE(operation_tmsp) ORDER BY DATE(operation_tmsp
                ) IS NULL, DATE(operation_tmsp), TIME(operation_tmsp) IS NULL, TIME(operation_tmsp), operation_id
               IS NULL, operation_id), TIME(operation_tmsp), SECOND) <= 5
         THEN 0
         WHEN tgt_area_nr BETWEEN 8000 AND 8999 AND tgt_area_nr = (LEAD(src_area_nr) OVER (PARTITION BY CAST(client_id AS STRING)
               , CAST(wh_id AS STRING), computer_id, user_id, src_pallet_nr, CAST(operation_id AS STRING), DATE(operation_tmsp
                ) ORDER BY DATE(operation_tmsp) IS NULL, DATE(operation_tmsp), TIME(operation_tmsp) IS NULL, TIME(operation_tmsp
                ), operation_id IS NULL, operation_id))
         THEN 0
         ELSE 1
         END = 1 AND src_area_nr BETWEEN 8000 AND 8999 AND src_area_nr = (LAG(tgt_area_nr) OVER (PARTITION BY CAST(client_id AS STRING)
           , CAST(wh_id AS STRING), src_pallet_nr, DATE(operation_tmsp) ORDER BY DATE(operation_tmsp) IS NULL, DATE(operation_tmsp
            ), TIME(operation_tmsp) IS NULL, TIME(operation_tmsp), operation_id IS NULL, operation_id)) AND tgt_area_nr
      <> 0, LAG(src_area_nr) OVER (PARTITION BY CAST(client_id AS STRING), CAST(wh_id AS STRING), src_pallet_nr, DATE(operation_tmsp
        ) ORDER BY DATE(operation_tmsp) IS NULL, DATE(operation_tmsp), TIME(operation_tmsp) IS NULL, TIME(operation_tmsp
        ), operation_id IS NULL, operation_id), IF(CASE
           WHEN operation_type = 'NU' AND TIME_DIFF(LAG(TIME(operation_tmsp)) OVER (PARTITION BY CAST(client_id AS STRING)
                 , CAST(wh_id AS STRING), user_id, computer_id, src_pallet_nr, DATE(operation_tmsp) ORDER BY DATE(operation_tmsp
                  ) IS NULL, DATE(operation_tmsp), TIME(operation_tmsp) IS NULL, TIME(operation_tmsp), operation_id
                 IS NULL, operation_id), TIME(operation_tmsp), SECOND) <= 5
           THEN 0
           WHEN tgt_area_nr BETWEEN 8000 AND 8999 AND tgt_area_nr = (LEAD(src_area_nr) OVER (PARTITION BY CAST(client_id AS STRING)
                 , CAST(wh_id AS STRING), computer_id, user_id, src_pallet_nr, CAST(operation_id AS STRING), DATE(operation_tmsp
                  ) ORDER BY DATE(operation_tmsp) IS NULL, DATE(operation_tmsp), TIME(operation_tmsp) IS NULL, TIME(operation_tmsp
                  ), operation_id IS NULL, operation_id))
           THEN 0
           ELSE 1
           END = 1 AND src_area_nr BETWEEN 8000 AND 8999 AND src_area_nr = (LAG(tgt_area_nr) OVER (PARTITION BY CAST(client_id AS STRING)
             , CAST(wh_id AS STRING), user_id, computer_id, src_pallet_nr, DATE(operation_tmsp) ORDER BY DATE(operation_tmsp
              ) IS NULL, DATE(operation_tmsp), TIME(operation_tmsp) IS NULL, TIME(operation_tmsp), operation_id IS NULL
             , operation_id)) AND tgt_area_nr = 0 AND (FIRST_VALUE(tgt_area_nr) OVER (PARTITION BY CAST(client_id AS STRING)
           , CAST(wh_id AS STRING), user_id, computer_id, src_pallet_nr, DATE(operation_tmsp) ORDER BY DATE(operation_tmsp
            ) IS NULL, DATE(operation_tmsp), TIME(operation_tmsp) IS NULL, TIME(operation_tmsp), operation_id IS NULL,
           operation_id RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) NOT IN (ROUND(CAST('700' AS BIGNUMERIC)
         , 0), ROUND(CAST('701' AS BIGNUMERIC), 0)), FIRST_VALUE(src_area_nr) OVER (PARTITION BY CAST(client_id AS STRING)
        , CAST(wh_id AS STRING), user_id, computer_id, src_pallet_nr, DATE(operation_tmsp) ORDER BY DATE(operation_tmsp
         ) IS NULL, DATE(operation_tmsp), TIME(operation_tmsp) IS NULL, TIME(operation_tmsp), operation_id IS NULL,
        operation_id RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING), IF(CASE
          WHEN operation_type = 'NU' AND TIME_DIFF(LAG(TIME(operation_tmsp)) OVER (PARTITION BY CAST(client_id AS STRING)
                , CAST(wh_id AS STRING), user_id, computer_id, src_pallet_nr, DATE(operation_tmsp) ORDER BY DATE(operation_tmsp
                 ) IS NULL, DATE(operation_tmsp), TIME(operation_tmsp) IS NULL, TIME(operation_tmsp), operation_id
                IS NULL, operation_id), TIME(operation_tmsp), SECOND) <= 5
          THEN 0
          WHEN tgt_area_nr BETWEEN 8000 AND 8999 AND tgt_area_nr = (LEAD(src_area_nr) OVER (PARTITION BY CAST(client_id AS STRING)
                , CAST(wh_id AS STRING), computer_id, user_id, src_pallet_nr, CAST(operation_id AS STRING), DATE(operation_tmsp
                 ) ORDER BY DATE(operation_tmsp) IS NULL, DATE(operation_tmsp), TIME(operation_tmsp) IS NULL, TIME(operation_tmsp
                 ), operation_id IS NULL, operation_id))
          THEN 0
          ELSE 1
          END = 1 AND src_area_nr BETWEEN 8000 AND 8999 AND (FIRST_VALUE(tgt_area_nr) OVER (PARTITION BY CAST(client_id AS STRING)
            , CAST(wh_id AS STRING), user_id, computer_id, src_pallet_nr, DATE(operation_tmsp) ORDER BY DATE(operation_tmsp
             ) IS NULL, DATE(operation_tmsp), TIME(operation_tmsp) IS NULL, TIME(operation_tmsp), operation_id IS NULL,
            operation_id RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) = 700, FIRST_VALUE(tgt_area_nr)
      OVER (PARTITION BY CAST(client_id AS STRING), CAST(wh_id AS STRING), user_id, computer_id, src_pallet_nr, DATE(operation_tmsp
          ) ORDER BY DATE(operation_tmsp) IS NULL, DATE(operation_tmsp), TIME(operation_tmsp) IS NULL, TIME(operation_tmsp
          ), operation_id IS NULL, operation_id RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING), IF(CASE
            WHEN operation_type = 'NU' AND TIME_DIFF(LAG(TIME(operation_tmsp)) OVER (PARTITION BY CAST(client_id AS STRING)
                  , CAST(wh_id AS STRING), user_id, computer_id, src_pallet_nr, DATE(operation_tmsp) ORDER BY DATE(operation_tmsp
                   ) IS NULL, DATE(operation_tmsp), TIME(operation_tmsp) IS NULL, TIME(operation_tmsp), operation_id
                  IS NULL, operation_id), TIME(operation_tmsp), SECOND) <= 5
            THEN 0
            WHEN tgt_area_nr BETWEEN 8000 AND 8999 AND tgt_area_nr = (LEAD(src_area_nr) OVER (PARTITION BY CAST(client_id AS STRING)
                  , CAST(wh_id AS STRING), computer_id, user_id, src_pallet_nr, CAST(operation_id AS STRING), DATE(operation_tmsp
                   ) ORDER BY DATE(operation_tmsp) IS NULL, DATE(operation_tmsp), TIME(operation_tmsp) IS NULL, TIME(operation_tmsp
                   ), operation_id IS NULL, operation_id))
            THEN 0
            ELSE 1
            END = 1 AND src_area_nr BETWEEN 8000 AND 8999 AND (FIRST_VALUE(tgt_area_nr) OVER (PARTITION BY CAST(client_id AS STRING)
              , CAST(wh_id AS STRING), user_id, computer_id, src_pallet_nr, DATE(operation_tmsp) ORDER BY DATE(operation_tmsp
               ) IS NULL, DATE(operation_tmsp), TIME(operation_tmsp) IS NULL, TIME(operation_tmsp), operation_id IS NULL
              , operation_id RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) = 701 AND tgt_area_nr = 0,
       FIRST_VALUE(tgt_area_nr) OVER (PARTITION BY CAST(client_id AS STRING), CAST(wh_id AS STRING), user_id,
          computer_id, src_pallet_nr, DATE(operation_tmsp) ORDER BY DATE(operation_tmsp) IS NULL, DATE(operation_tmsp),
          TIME(operation_tmsp) IS NULL, TIME(operation_tmsp), operation_id IS NULL, operation_id RANGE BETWEEN
        UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING), IF(CASE
            WHEN operation_type = 'NU' AND TIME_DIFF(LAG(TIME(operation_tmsp)) OVER (PARTITION BY CAST(client_id AS STRING)
                  , CAST(wh_id AS STRING), user_id, computer_id, src_pallet_nr, DATE(operation_tmsp) ORDER BY DATE(operation_tmsp
                   ) IS NULL, DATE(operation_tmsp), TIME(operation_tmsp) IS NULL, TIME(operation_tmsp), operation_id
                  IS NULL, operation_id), TIME(operation_tmsp), SECOND) <= 5
            THEN 0
            WHEN tgt_area_nr BETWEEN 8000 AND 8999 AND tgt_area_nr = (LEAD(src_area_nr) OVER (PARTITION BY CAST(client_id AS STRING)
                  , CAST(wh_id AS STRING), computer_id, user_id, src_pallet_nr, CAST(operation_id AS STRING), DATE(operation_tmsp
                   ) ORDER BY DATE(operation_tmsp) IS NULL, DATE(operation_tmsp), TIME(operation_tmsp) IS NULL, TIME(operation_tmsp
                   ), operation_id IS NULL, operation_id))
            THEN 0
            ELSE 1
            END = 1 AND src_area_nr BETWEEN 8000 AND 8999 AND (FIRST_VALUE(src_area_nr) OVER (PARTITION BY CAST(client_id AS STRING)
              , CAST(wh_id AS STRING), user_id, computer_id, src_pallet_nr, DATE(operation_tmsp) ORDER BY DATE(operation_tmsp
               ) IS NULL, DATE(operation_tmsp), TIME(operation_tmsp) IS NULL, TIME(operation_tmsp), operation_id IS NULL
              , operation_id RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) = 702, FIRST_VALUE(src_area_nr
         ) OVER (PARTITION BY CAST(client_id AS STRING), CAST(wh_id AS STRING), user_id, computer_id, src_pallet_nr,
           DATE(operation_tmsp) ORDER BY DATE(operation_tmsp) IS NULL, DATE(operation_tmsp), TIME(operation_tmsp)
           IS NULL, TIME(operation_tmsp), operation_id IS NULL, operation_id RANGE BETWEEN UNBOUNDED PRECEDING AND
         UNBOUNDED FOLLOWING), src_area_nr))))) AS cons_src_area_nr
  FROM ldl_logop_data.t_lpv_tabakt_1
  WHERE STARTS_WITH(computer_id, 'TERMINAL_')
   AND CURRENT_DATE BETWEEN dwh_valid_from AND dwh_valid_to
   AND DATE(operation_tmsp) BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 40 DAY) AND (CURRENT_DATE)
   AND NOT deleted_fg), DOPPELT_QUER_PALETTEN AS (SELECT client_id,
   wh_id,
   operation_tmsp,
   operation_type,
   src_pallet_nr
  FROM ldl_logop_data.t_lpv_tabakt_1
  WHERE operation_type = 'VE'
   AND CURRENT_DATE BETWEEN dwh_valid_from AND dwh_valid_to
   AND DATE(operation_tmsp) BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 40 DAY) AND (CURRENT_DATE)
   AND NOT deleted_fg) (SELECT con.client_id,
   con.wh_id,
   con.op_id,
   con.op_dt,
   con.op_tm,
   con.op_type,
   IF(con.client_id = 27, NULL, con.user_id),
   con.comp_id,
   con.src_pallet_nr,
   IF(dq.src_pallet_nr = con.src_pallet_nr, 'Doppelt Quer', 'Einfachtief') AS pallet_type,
   con.src_area_nr,
   con.tgt_area_nr,
   con.dwh_created,
   con.dwh_updated,
   con.mvmt_fg,
   con.cons_src_area_nr,
    CASE
    WHEN (con.cons_src_area_nr BETWEEN 1000 AND 1999 OR con.cons_src_area_nr BETWEEN 8000 AND 8999) AND con.tgt_area_nr
      BETWEEN 700 AND 899
    THEN 1
    WHEN (con.cons_src_area_nr BETWEEN 1000 AND 1999 OR con.cons_src_area_nr BETWEEN 8000 AND 8999) AND con.tgt_area_nr
      IN (0, 1, 2, 3, 4, 5, 6, 7)
    THEN 3
    WHEN (con.cons_src_area_nr BETWEEN 700 AND 899 OR con.cons_src_area_nr BETWEEN 8000 AND 8999) AND con.tgt_area_nr
      BETWEEN 700 AND 899
    THEN 4
    WHEN (con.cons_src_area_nr BETWEEN 700 AND 899 OR con.cons_src_area_nr BETWEEN 8000 AND 8999) AND con.tgt_area_nr =
      0
    THEN 2
    ELSE NULL
    END AS mvmt_type_nr,
   LAG(con.op_dt) OVER (PARTITION BY CAST(con.client_id AS STRING), CAST(con.wh_id AS STRING), con.user_id ORDER BY con
      .op_dt IS NULL, con.op_dt, con.op_tm IS NULL, con.op_tm, con.op_id IS NULL, con.op_id) AS op_dt_prev,
   LAG(con.op_tm) OVER (PARTITION BY CAST(con.client_id AS STRING), CAST(con.wh_id AS STRING), con.user_id ORDER BY con
      .op_dt IS NULL, con.op_dt, con.op_tm IS NULL, con.op_tm, con.op_id IS NULL, con.op_id) AS op_tm_prev,
    TIMESTAMP_DIFF(CAST(con.op_dt AS DATETIME), CAST(LAG(con.op_dt) OVER (PARTITION BY CAST(con.client_id AS STRING), CAST(con.wh_id AS STRING)
         , con.user_id ORDER BY con.op_dt IS NULL, con.op_dt, con.op_tm IS NULL, con.op_tm, con.op_id IS NULL, con.op_id
         ) AS DATETIME), SECOND) + TIME_DIFF(con.op_tm, LAG(con.op_tm) OVER (PARTITION BY CAST(con.client_id AS STRING)
        , CAST(con.wh_id AS STRING), con.user_id ORDER BY con.op_dt IS NULL, con.op_dt, con.op_tm IS NULL, con.op_tm,
        con.op_id IS NULL, con.op_id), SECOND) AS prev_op_tm_diff_sec,
   IF((LAG(con.op_dt) OVER (PARTITION BY CAST(con.client_id AS STRING), CAST(con.wh_id AS STRING), con.user_id ORDER BY
         con.op_dt IS NULL, con.op_dt, con.op_tm IS NULL, con.op_tm, con.op_id IS NULL, con.op_id)) IS NULL OR
       TIMESTAMP_DIFF(SAFE_CAST(con.op_dt as DATETIME), SAFE_CAST((LAG(con.op_dt) OVER (PARTITION BY CAST(con.client_id AS STRING)
             , CAST(con.wh_id AS STRING), con.user_id ORDER BY con.op_dt IS NULL, con.op_dt, con.op_tm IS NULL, con.op_tm
             , con.op_id IS NULL, con.op_id)) as DATETIME), SECOND) + TIME_DIFF(con.op_tm, LAG(con.op_tm) OVER (PARTITION BY CAST(con.client_id AS STRING)
           , CAST(con.wh_id AS STRING), con.user_id ORDER BY con.op_dt IS NULL, con.op_dt, con.op_tm IS NULL, con.op_tm
           , con.op_id IS NULL, con.op_id), SECOND) > 28800, 1, 0) AS emp_wrk_shift_start_fg,
   IF(IF((LAG(con.op_dt) OVER (PARTITION BY CAST(con.client_id AS STRING), CAST(con.wh_id AS STRING), con.user_id
         ORDER BY con.op_dt IS NULL, con.op_dt, con.op_tm IS NULL, con.op_tm, con.op_id IS NULL, con.op_id)) IS NULL OR
         TIMESTAMP_DIFF(SAFE_CAST(con.op_dt as DATETIME), SAFE_CAST((LAG(con.op_dt) OVER (PARTITION BY CAST(con.client_id AS STRING)
               , CAST(con.wh_id AS STRING), con.user_id ORDER BY con.op_dt IS NULL, con.op_dt, con.op_tm IS NULL, con.op_tm
               , con.op_id IS NULL, con.op_id)) as DATETIME), SECOND) + TIME_DIFF(con.op_tm, LAG(con.op_tm) OVER (PARTITION BY CAST(con.client_id AS STRING)
             , CAST(con.wh_id AS STRING), con.user_id ORDER BY con.op_dt IS NULL, con.op_dt, con.op_tm IS NULL, con.op_tm
             , con.op_id IS NULL, con.op_id), SECOND) > 28800, 1, 0) <> 1, TIMESTAMP_DIFF(SAFE_CAST(con.op_dt as DATETIME)
      ,SAFE_CAST((LAG(con.op_dt) OVER (PARTITION BY CAST(con.client_id AS STRING), CAST(con.wh_id AS STRING), con.user_id
           ORDER BY con.op_dt IS NULL, con.op_dt, con.op_tm IS NULL, con.op_tm, con.op_id IS NULL, con.op_id)) as DATETIME)
      ,SECOND) + TIME_DIFF(con.op_tm, LAG(con.op_tm) OVER (PARTITION BY CAST(con.client_id AS STRING), CAST(con.wh_id AS STRING)
         , con.user_id ORDER BY con.op_dt IS NULL, con.op_dt, con.op_tm IS NULL, con.op_tm, con.op_id IS NULL, con.op_id
         ), SECOND), NULL) AS work_tm_sec,
   IF(IF((LAG(con.op_dt) OVER (PARTITION BY CAST(con.client_id AS STRING), CAST(con.wh_id AS STRING), con.user_id
          ORDER BY con.op_dt IS NULL, con.op_dt, con.op_tm IS NULL, con.op_tm, con.op_id IS NULL, con.op_id)) IS NULL OR
          TIMESTAMP_DIFF(SAFE_CAST(con.op_dt as DATETIME), SAFE_CAST((LAG(con.op_dt) OVER (PARTITION BY CAST(con.client_id AS STRING)
                , CAST(con.wh_id AS STRING), con.user_id ORDER BY con.op_dt IS NULL, con.op_dt, con.op_tm IS NULL, con.op_tm
                , con.op_id IS NULL, con.op_id)) as DATETIME), SECOND) + TIME_DIFF(con.op_tm, LAG(con.op_tm) OVER (PARTITION BY CAST(con.client_id AS STRING)
              , CAST(con.wh_id AS STRING), con.user_id ORDER BY con.op_dt IS NULL, con.op_dt, con.op_tm IS NULL, con.op_tm
              , con.op_id IS NULL, con.op_id), SECOND) > 28800, 1, 0) = 1 OR IF(IF((LAG(con.op_dt) OVER (PARTITION BY CAST(con.client_id AS STRING)
              , CAST(con.wh_id AS STRING), con.user_id ORDER BY con.op_dt IS NULL, con.op_dt, con.op_tm IS NULL, con.op_tm
              , con.op_id IS NULL, con.op_id)) IS NULL OR TIMESTAMP_DIFF(SAFE_CAST(con.op_dt as DATETIME), SAFE_CAST((LAG(con
                .op_dt) OVER (PARTITION BY CAST(con.client_id AS STRING), CAST(con.wh_id AS STRING), con.user_id
                ORDER BY con.op_dt IS NULL, con.op_dt, con.op_tm IS NULL, con.op_tm, con.op_id IS NULL, con.op_id)) as DATETIME)
             ,SECOND) + TIME_DIFF(con.op_tm, LAG(con.op_tm) OVER (PARTITION BY CAST(con.client_id AS STRING), CAST(con.wh_id AS STRING)
                , con.user_id ORDER BY con.op_dt IS NULL, con.op_dt, con.op_tm IS NULL, con.op_tm, con.op_id IS NULL,
                con.op_id), SECOND) > 28800, 1, 0) <> 1, TIMESTAMP_DIFF(SAFE_CAST(con.op_dt as DATETIME), SAFE_CAST((LAG(con
            .op_dt) OVER (PARTITION BY CAST(con.client_id AS STRING), CAST(con.wh_id AS STRING), con.user_id ORDER BY
              con.op_dt IS NULL, con.op_dt, con.op_tm IS NULL, con.op_tm, con.op_id IS NULL, con.op_id)) as DATETIME),
         SECOND) + TIME_DIFF(con.op_tm, LAG(con.op_tm) OVER (PARTITION BY CAST(con.client_id AS STRING), CAST(con.wh_id AS STRING)
            , con.user_id ORDER BY con.op_dt IS NULL, con.op_dt, con.op_tm IS NULL, con.op_tm, con.op_id IS NULL, con.op_id
            ), SECOND), NULL) > 900, 114, IF(IF((LAG(con.op_dt) OVER (PARTITION BY CAST(con.client_id AS STRING), CAST(con.wh_id AS STRING)
            , con.user_id ORDER BY con.op_dt IS NULL, con.op_dt, con.op_tm IS NULL, con.op_tm, con.op_id IS NULL, con.op_id
            )) IS NULL OR TIMESTAMP_DIFF(SAFE_CAST(con.op_dt as DATETIME), SAFE_CAST((LAG(con.op_dt) OVER (PARTITION BY CAST(con.client_id AS STRING)
                , CAST(con.wh_id AS STRING), con.user_id ORDER BY con.op_dt IS NULL, con.op_dt, con.op_tm IS NULL, con.op_tm
                , con.op_id IS NULL, con.op_id)) as DATETIME), SECOND) + TIME_DIFF(con.op_tm, LAG(con.op_tm) OVER (PARTITION BY CAST(con.client_id AS STRING)
              , CAST(con.wh_id AS STRING), con.user_id ORDER BY con.op_dt IS NULL, con.op_dt, con.op_tm IS NULL, con.op_tm
              , con.op_id IS NULL, con.op_id), SECOND) > 28800, 1, 0) <> 1, TIMESTAMP_DIFF(SAFE_CAST(con.op_dt as DATETIME)
       ,SAFE_CAST((LAG(con.op_dt) OVER (PARTITION BY CAST(con.client_id AS STRING), CAST(con.wh_id AS STRING), con.user_id
            ORDER BY con.op_dt IS NULL, con.op_dt, con.op_tm IS NULL, con.op_tm, con.op_id IS NULL, con.op_id)) as DATETIME)
       ,SECOND) + TIME_DIFF(con.op_tm, LAG(con.op_tm) OVER (PARTITION BY CAST(con.client_id AS STRING), CAST(con.wh_id AS STRING)
          , con.user_id ORDER BY con.op_dt IS NULL, con.op_dt, con.op_tm IS NULL, con.op_tm, con.op_id IS NULL, con.op_id
          ), SECOND), NULL)) AS work_tm_sec_net,
   IF((ROW_NUMBER() OVER (PARTITION BY CAST(con.client_id AS STRING), CAST(con.wh_id AS STRING), con.op_dt, con.src_pallet_nr
            ORDER BY con.src_pallet_nr IS NULL, con.src_pallet_nr)) > 1 AND con.op_type = 'VE' AND IF(dq.src_pallet_nr =
         con.src_pallet_nr, 'Doppelt Quer', 'Einfachtief') = 'Doppelt Quer' OR (ROW_NUMBER() OVER (PARTITION BY CAST(con.client_id AS STRING)
            , CAST(con.wh_id AS STRING), con.op_dt, con.src_pallet_nr, con.comp_id ORDER BY con.src_pallet_nr IS NULL,
            con.src_pallet_nr)) > 1 AND con.op_type IN ('EN', 'NU') AND IF(dq.src_pallet_nr = con.src_pallet_nr,
        'Doppelt Quer', 'Einfachtief') = 'Doppelt Quer', 0, IF(IF(dq.src_pallet_nr = con.src_pallet_nr, 'Doppelt Quer',
        'Einfachtief') = 'Doppelt Quer' AND con.op_type <> 'VE', 2, IF(IF(dq.src_pallet_nr = con.src_pallet_nr,
         'Doppelt Quer', 'Einfachtief') = 'Doppelt Quer' AND con.op_type = 'VE', 0, 1))) AS count_pallet_mvmt,
   IF((ROW_NUMBER() OVER (PARTITION BY CAST(con.client_id AS STRING), CAST(con.wh_id AS STRING), con.src_pallet_nr
          ORDER BY con.src_pallet_nr IS NULL, con.src_pallet_nr)) > 1 AND con.op_type = 'VE' AND IF(dq.src_pallet_nr =
         con.src_pallet_nr, 'Doppelt Quer', 'Einfachtief') = 'Doppelt Quer' OR (ROW_NUMBER() OVER (PARTITION BY CAST(con.client_id AS STRING)
            , CAST(con.wh_id AS STRING), con.op_dt, con.src_pallet_nr, con.comp_id ORDER BY con.src_pallet_nr IS NULL,
            con.src_pallet_nr)) > 1 AND con.op_type IN ('EN', 'NU') AND IF(dq.src_pallet_nr = con.src_pallet_nr,
        'Doppelt Quer', 'Einfachtief') = 'Doppelt Quer', 0, IF(IF(dq.src_pallet_nr = con.src_pallet_nr, 'Doppelt Quer',
        'Einfachtief') = 'Doppelt Quer' AND con.op_type <> 'VE', 2, IF(IF(dq.src_pallet_nr = con.src_pallet_nr,
         'Doppelt Quer', 'Einfachtief') = 'Doppelt Quer' AND con.op_type = 'VE', 0, 1))) AS number_of_pallet_mvmt
  FROM CONSOLIDATEDOPERATIONS AS con
   LEFT JOIN DOPPELT_QUER_PALETTEN AS dq ON con.client_id = dq.client_id AND con.wh_id = dq.wh_id AND con.src_pallet_nr
     = dq.src_pallet_nr
  WHERE con.mvmt_fg = 1
   AND con.op_type NOT IN ('HE')
   AND CASE
    WHEN (con.cons_src_area_nr BETWEEN 1000 AND 1999 OR con.cons_src_area_nr BETWEEN 8000 AND 8999) AND con.tgt_area_nr
      BETWEEN 700 AND 899
    THEN 1
    WHEN (con.cons_src_area_nr BETWEEN 1000 AND 1999 OR con.cons_src_area_nr BETWEEN 8000 AND 8999) AND con.tgt_area_nr
      IN (0, 1, 2, 3, 4, 5, 6, 7)
    THEN 3
    WHEN (con.cons_src_area_nr BETWEEN 700 AND 899 OR con.cons_src_area_nr BETWEEN 8000 AND 8999) AND con.tgt_area_nr
      BETWEEN 700 AND 899
    THEN 4
    WHEN (con.cons_src_area_nr BETWEEN 700 AND 899 OR con.cons_src_area_nr BETWEEN 8000 AND 8999) AND con.tgt_area_nr =
      0
    THEN 2
    ELSE NULL
    END IS NOT NULL);