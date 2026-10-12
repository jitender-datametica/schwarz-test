/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB view			|	v_alma_lane_use_add_2
Description		|	ALMA Lane Use - view with additional data
====================================================================================================
*/

CREATE OR REPLACE VIEW fe_mstr_logop.v_alma_lane_use_add_2 (
	client_id COMMENT 'Id of a country_2 (PK)',
	wh_id COMMENT 'Warehouse number (PK)',
	lane_id COMMENT 'Id of a lane (PK)',
	gate_id COMMENT 'Id of a gate',
	label COMMENT 'Label of a lane',
	lane_blocked COMMENT 'Checks if a lane is blocked',
	gr_allocation COMMENT 'Checks whats the current capacity of a lane',
	gr_capacity COMMENT 'Checks maximum capacity of a lane',
	lane_update COMMENT 'Latest update date and time of a lane (based on PK Update_TMSP)',
	update_hour COMMENT 'Update hour of the lane',
	gi_blocked_fg COMMENT 'Checks if lane is blocked by GI',
	dwh_valid_from COMMENT 'Date of insertion to DWH',
	dwh_valid_to COMMENT '9999-12-30 means currently active, else when it stopped being active',
	active_fg COMMENT 'Checks whether the lane is active now or if it shows past data',
	area_id COMMENT 'Id of aread type',
	lane_update_to COMMENT 'End of update for a lane',
    lane_update_to_hr COMMENT 'Hour of update end',
    lane_update_to_day COMMENT 'Day of update end',
    dwh_updated COMMENT 'DWH updated',
	hr_h COMMENT 'Hours passed for a lane across rows.',
	blocked_time_period COMMENT 'Time of block for each hour.'
) COMMENT='Second edition ADD VIEW of Necessary columns for 1-4-5 ALMA KPIs'
AS
WITH cte_lane_add AS (
    SELECT 
        al.client_id
        ,al.wh_id
        ,al.lane_id
        ,al.gate_id
        ,al.label
        ,IFF(al.allocation_state_id IN (3,4,5,6), 1, 0) AS lane_blocked
        ,alt.gr_allocation
        ,al.gr_capacity
        ,al.update_tmsp AS lane_update
        ,HOUR(al.update_tmsp) AS update_hour
        ,IFF(alop.store IS NOT NULL, 1, 0) AS gi_blocked_fg
        ,al.dwh_valid_from
        ,al.dwh_valid_to
        ,IFF(CURRENT_DATE BETWEEN al.dwh_valid_from AND al.dwh_valid_to, 1, 0) AS active_fg
        ,g.area_id
        ,IFF(CURRENT_DATE BETWEEN al.dwh_valid_from AND al.dwh_valid_to, CURRENT_TIMESTAMP, al.dwh_valid_to) AS lane_update_to
        ,HOUR(lane_update_to) AS lane_update_to_hr
        ,DAY(lane_update_to) AS lane_update_to_day
        ,al.dwh_updated
    FROM fe_mstr_logop.v_alma_lanes_2 AS al
        LEFT JOIN fe_mstr_logop.v_alma_lane_tasks_2 AS alt 
            ON al.lane_id = alt.lane_id 
                AND al.client_id = alt.client_id 
                AND al.wh_id = alt.wh_id 
                AND al.update_tmsp = alt.update_tmsp
        LEFT JOIN fe_mstr_logop.v_alma_leftoverpallets_2 alop 
            ON al.lane_id = alop.lane_id 
                AND al.client_id = alop.client_id 
                AND al.wh_id = alop.wh_id
        LEFT JOIN fe_mstr_logop.v_alma_gates_2 g 
            ON al.gate_id = g.gate_id 
                AND al.client_id = g.client_id 
                AND al.wh_id = g.wh_id 
                AND al.update_tmsp = g.update_tmsp
    WHERE al.client_id = 4
        AND al.allocation_state_id <> 2
    )
SELECT 
    l.client_id
    , l.wh_id
    , l.lane_id
    , l.gate_id
    , l.label
    , l.lane_blocked
    , l.gr_allocation
    , l.gr_capacity
    , l.lane_update
    , l.update_hour
    , l.gi_blocked_fg
    , l.dwh_valid_from
    , l.dwh_valid_to
    , l.active_fg
    , l.area_id
    , l.lane_update_to
    , l.lane_update_to_hr
    , l.lane_update_to_day
    , l.dwh_updated
    , h.hr_h
    ,CASE 
        WHEN l.update_hour = h.hr_h AND l.lane_update_to_hr <> h.hr_h 
            THEN TIMESTAMPDIFF(MINUTE, lane_update, TIME_SLICE(lane_update, 1, 'HOUR', 'END')) -- calculates remaining minutes until the next full hour
        WHEN l.update_hour <> h.hr_h AND l.lane_update_to_hr <> h.hr_h 
            THEN 60
        WHEN l.update_hour <> h.hr_h AND l.lane_update_to_hr = h.hr_h 
            THEN TIMESTAMPDIFF(MINUTE, TIME_FROM_PARTS(hr_h, 0, 0), TO_TIME(lane_update_to)) --
        ELSE MINUTE(CURRENT_TIME)
        END AS blocked_time_period
FROM cte_lane_add l
INNER JOIN fe_mstr_logop.v_ref_time_hour_2 h 
    ON CASE 
        WHEN l.lane_update_to_hr >= l.update_hour AND active_fg = 1 
            THEN h.hr_h >= l.update_hour AND h.hr_h <= l.lane_update_to_hr
        WHEN l.lane_update_to_hr = 0 AND DAY(CURRENT_DATE) = l.lane_update_to_day 
            THEN h.hr_h <= HOUR(dwh_updated) AND h.hr_h >= l.update_hour
        WHEN l.lane_update_to_hr = 0 AND DATEDIFF(DAY, l.dwh_valid_to, CURRENT_DATE) = 1 
            THEN h.hr_h >= 0 AND h.hr_h <= HOUR(l.dwh_updated)
        WHEN l.lane_update_to_hr = l.update_hour AND l.lane_update_to_day = DATE_PART(DAY, l.lane_update) 
            THEN h.hr_h = l.update_hour
        WHEN l.lane_update_to_hr = l.update_hour AND DATE_PART(DAY,l.lane_update_to) != DATE_PART(DAY, l.lane_update) 
            THEN h.hr_h >= 0 AND h.hr_h <= l.lane_update_to_hr
        WHEN l.lane_update_to_hr <= l.update_hour 
            THEN h.hr_h >= 0 AND h.hr_h <= l.lane_update_to_hr 
        END
;
