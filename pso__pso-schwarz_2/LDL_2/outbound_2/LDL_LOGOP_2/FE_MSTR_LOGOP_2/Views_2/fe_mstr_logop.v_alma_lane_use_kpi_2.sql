/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB view			|	v_alma_lane_use_kpi_2
Description		|	ALMA Lane Use - view with final KPIs for FE
====================================================================================================
*/


CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_alma_lane_use_kpi_2 (client_id
OPTIONS(description='Id of a country_2 (PK)'), wh_id OPTIONS(description='Warehouse number (PK)'), lane_id
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
OPTIONS(DESCRIPTION = `SECOND EDITION KPI VIEW OF CECESSARY COLUMNS FOR 1-4-5 ALMA KPIS`) AS SELECT *
FROM ldl_logop_fe_mstr_logop.v_alma_lane_use_add_2;