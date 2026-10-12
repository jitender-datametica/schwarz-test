/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB view			|	v_alma_lane_use_kpi_1
Description		|	ALMA Lane Use - view with final KPIs for FE
====================================================================================================
*/

CREATE OR REPLACE VIEW fe_mstr_logop.v_alma_lane_use_kpi_1 (
    client_id COMMENT 'Id of a country_1 (PK)'
    , wh_id COMMENT 'Warehouse number (PK)'
    , lane_id COMMENT 'Id of a lane (PK)'
    , gate_id COMMENT 'Id of a gate'
    , label COMMENT 'Label of a lane'
    , lane_blocked COMMENT 'Checks if a lane is blocked'
    , gr_allocation COMMENT 'Checks whats the current capacity of a lane'
    , gr_capacity COMMENT 'Checks maximum capacity of a lane'
    , lane_update COMMENT 'Latest update date and time of a lane (based on PK Update_TMSP)'
    , update_hour COMMENT 'Update hour of the lane'
    , gi_blocked_fg COMMENT 'Checks if lane is blocked by GI'
    , dwh_valid_from COMMENT 'Date of insertion to DWH'
    , dwh_valid_to COMMENT '9999-12-30 means currently active, else when it stopped being active'
    , active_fg COMMENT 'Checks whether the lane is active now or if it shows past data'
    , area_id COMMENT 'Id of aread type'
    , lane_update_to COMMENT 'End of update for a lane'
    , lane_update_to_hr COMMENT 'Hour of update end'
    , lane_update_to_day COMMENT 'Day of update end'
    , dwh_updated COMMENT 'DWH updated'
    , hr_h COMMENT 'Hours passed for a lane across rows.'
    , blocked_time_period COMMENT 'Time of block for each hour.'
) COMMENT='Second edition KPI VIEW of cecessary columns for 1-4-5 ALMA KPIs'
 AS
SELECT 
	client_id
    , wh_id
    , lane_id
    , gate_id
    , label
    , lane_blocked
    , gr_allocation
    , gr_capacity
    , lane_update
    , update_hour
    , gi_blocked_fg
    , dwh_valid_from
    , dwh_valid_to
    , active_fg
    , area_id
    , lane_update_to
    , lane_update_to_hr
    , lane_update_to_day
    , dwh_updated
    , hr_h
    , blocked_time_period
FROM fe_mstr_logop.v_alma_lane_use_add_1;
