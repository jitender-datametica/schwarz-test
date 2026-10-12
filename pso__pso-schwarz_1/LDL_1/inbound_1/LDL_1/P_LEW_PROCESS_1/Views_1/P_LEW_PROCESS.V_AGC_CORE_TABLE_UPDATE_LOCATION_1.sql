CREATE OR REPLACE VIEW P_LEW_PROCESS.V_AGC_CORE_TABLE_UPDATE_LOCATION_1
(
 core_table_name
,client_id
,dwh_cal_dt
,loc_sid
,recalc_fg
,create_timestamp
,dwh_load_id
)
AS
   SELECT
    core_table_name,
   client_id,
   dwh_cal_dt,
   loc_sid,
   recalc_fg,
   create_timestamp,
   dwh_load_id
   FROM p_lew_process.t_agc_core_table_update_location_1
;