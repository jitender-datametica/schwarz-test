
CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_alma_lane_use_add (client_id
OPTIONS(description='Id of a country (PK)'), wh_id OPTIONS(description='Warehouse number (PK)'), lane_id
OPTIONS(description='Id of a lane (PK)'), gate_id OPTIONS(description='Id of a gate'), label
OPTIONS(description='Label of a lane'), lane_blocked OPTIONS(description='Checks if a lane is blocked'), gr_allocation
OPTIONS(description='Checks whats the current capacity of a lane'), gr_capacity
OPTIONS(description='Checks maximum capacity of a lane'), lane_update
OPTIONS(description='Latest update date and time of a lane (based on PK Update_TMSP)'), update_hour
OPTIONS(description='Update hour of the lane'), gi_blocked_fg OPTIONS(description='Checks if lane is blocked by GI'),
dwh_valid_from OPTIONS(description='Date of insertion to DWH'), dwh_valid_to
OPTIONS(description='9999-12-30 means currently active, else when it stopped being active'), active_fg
OPTIONS(description='Checks whether the lane is active now or if it shows past data'), area_id
OPTIONS(description='Id of aread type'), lane_update_to OPTIONS(description='End of update for a lane'),
lane_update_to_hr OPTIONS(description='Hour of update end'), lane_update_to_day OPTIONS(description='Day of update end'),
dwh_updated OPTIONS(description='DWH updated'), hr_h OPTIONS(description='Hours passed for a lane across rows.'),
blocked_time_period OPTIONS(description='Time of block for each hour.'))
OPTIONS(DESCRIPTION = `SECOND EDITION ADD VIEW OF NECESSARY COLUMNS FOR 1-4-5 ALMA KPIS`) AS WITH CTE_LANE_ADD AS (SELECT
   AL.client_id,
   AL.wh_id,
   AL.lane_id,
   AL.gate_id,
   AL.label,
   IF(AL.allocation_state_id IN (3, 4, 5, 6), 1, 0) AS lane_blocked,
   ALT.gr_allocation,
   AL.gr_capacity,
   AL.update_tmsp AS lane_update,
   EXTRACT(HOUR FROM AL.update_tmsp) AS update_hour,
   IF(ALOP.store IS NOT NULL, 1, 0) AS gi_blocked_fg,
   AL.dwh_valid_from,
   AL.dwh_valid_to,
   IF(CURRENT_DATE BETWEEN AL.dwh_valid_from AND AL.dwh_valid_to, 1, 0) AS active_fg,
   G.area_id,
   IF(CURRENT_DATE BETWEEN AL.dwh_valid_from AND AL.dwh_valid_to, SAFE_CAST(CURRENT_TIMESTAMP() as DATE), AL.dwh_valid_to
    ) AS lane_update_to,
   EXTRACT(HOUR FROM CAST(IF(CURRENT_DATE BETWEEN AL.dwh_valid_from AND AL.dwh_valid_to, SAFE_CAST(CURRENT_TIMESTAMP() as DATE), AL.dwh_valid_to) AS DATETIME)
    ) AS lane_update_to_hr,
   EXTRACT(DAY FROM IF(CURRENT_DATE BETWEEN AL.dwh_valid_from AND AL.dwh_valid_to, SAFE_CAST(CURRENT_TIMESTAMP() as DATE
      ), AL.dwh_valid_to)) AS lane_update_to_day,
   AL.dwh_updated
  FROM ldl_logop_fe_mstr_logop.v_alma_lanes AS AL
   LEFT JOIN ldl_logop_fe_mstr_logop.v_alma_lane_tasks AS ALT ON AL.lane_id = ALT.lane_id AND AL.client_id = ALT.client_id
        AND AL.wh_id = ALT.wh_id AND AL.update_tmsp = ALT.update_tmsp
   LEFT JOIN ldl_logop_fe_mstr_logop.v_alma_leftoverpallets AS ALOP ON AL.lane_id = ALOP.lane_id AND AL.client_id = ALOP
      .client_id AND AL.wh_id = ALOP.wh_id
   LEFT JOIN ldl_logop_fe_mstr_logop.v_alma_gates AS G ON AL.gate_id = G.gate_id AND AL.client_id = G.client_id AND AL.wh_id
       = G.wh_id AND AL.update_tmsp = G.update_tmsp
  WHERE AL.client_id = 4
   AND AL.allocation_state_id <> 2) (SELECT l.client_id,
   l.wh_id,
   l.lane_id,
   l.gate_id,
   l.label,
   l.lane_blocked,
   l.gr_allocation,
   l.gr_capacity,
   l.lane_update,
   l.update_hour,
   l.gi_blocked_fg,
   l.dwh_valid_from,
   l.dwh_valid_to,
   l.active_fg,
   l.area_id,
   l.lane_update_to,
   l.lane_update_to_hr,
   l.lane_update_to_day,
   l.dwh_updated,
   H.hr_h,
    CASE
    WHEN l.update_hour = H.hr_h AND l.lane_update_to_hr <> H.hr_h
    THEN TIMESTAMP_DIFF(TIMESTAMP_ADD(TIMESTAMP_TRUNC(l.lane_update, HOUR), INTERVAL 1 HOUR), l.lane_update, MINUTE)
    WHEN l.update_hour <> H.hr_h AND l.lane_update_to_hr <> H.hr_h
    THEN 60
    WHEN l.update_hour <> H.hr_h AND l.lane_update_to_hr = H.hr_h
    THEN TIME_DIFF(TIME(l.lane_update_to), TIME_ADD(TIME_ADD(TIME_ADD(TIME_ADD(TIME '00:00:00', INTERVAL 0 MICROSECOND)
        ,INTERVAL 0 SECOND), INTERVAL 0 MINUTE), INTERVAL H.hr_h HOUR), MINUTE)
    ELSE CAST(EXTRACT(MINUTE FROM CURRENT_TIME) AS INTEGER)
    END AS blocked_time_period
  FROM CTE_LANE_ADD AS l
   INNER JOIN ldl_logop_fe_mstr_logop.v_ref_time_hour AS H ON l.lane_update_to_hr >= l.update_hour AND l.active_fg = 1
          AND l.update_hour <= H.hr_h AND l.lane_update_to_hr >= H.hr_h OR l.lane_update_to_hr = 0 AND EXTRACT(DAY FROM
             CURRENT_DATE) = l.lane_update_to_day AND H.hr_h <= EXTRACT(HOUR FROM l.dwh_updated) AND l.update_hour <= H
          .hr_h OR l.lane_update_to_hr = 0 AND DATE_DIFF(CURRENT_DATE, l.dwh_valid_to, DAY) = 1 AND H.hr_h >= 0 AND H.hr_h
          <= EXTRACT(HOUR FROM l.dwh_updated) OR l.lane_update_to_hr = l.update_hour AND l.lane_update_to_day = EXTRACT(DAY
          FROM l.lane_update) AND l.update_hour = H.hr_h OR l.lane_update_to_hr = l.update_hour AND EXTRACT(DAY FROM l.lane_update_to
          ) <> EXTRACT(DAY FROM l.lane_update) AND H.hr_h >= 0 AND l.lane_update_to_hr >= H.hr_h OR l.lane_update_to_hr
       <= l.update_hour AND H.hr_h >= 0 AND l.lane_update_to_hr >= H.hr_h);


