create or replace view DBP_MSI_VIEW_IOS_MATERIALIZED.MV_T_FACT_IOT_STOERMELDUNGEN_1(
	MANDANT_ID,
	WUP_ID,
	DEVICE_ID,
	FAULT_NR,
	CAL_DT,
	MEASUREMENT_TMSP,
	ALARM_PRIORITY_CD,
	ERROR_MESSAGE,
	VALUE_CYCLING,
	DEVICE_TYPE_ID,
	ERROR_SOURCE,
	ACTIVE_FG,
	ACTIVE_FG_BEZ
) as
SELECT  
    v01.mandant_id
    ,COALESCE(v02.aktuell_wup_id, v01.wup_id) AS wup_id 
    ,v01.device_id
	,v01.fault_nr
	,v01.cal_dt
	,v01.measurement_tmsp
	,v01.alarm_priority_cd
	,v01.error_message
	,v01.value_cycling
	,v01.device_type_id
	,v01.error_source
	,v01.active_fg
    ,CASE WHEN v01.active_fg = 1 THEN 'Start'
    WHEN v01.active_fg = 0 THEN 'Ende'
    ELSE ''
    END AS active_fg_bez
FROM  DBP_VIEW.V_T_FACT_IOT_ERRORMESSAGES_1 v01
LEFT JOIN dbp_view.v_wup_1 v02 
   ON v01.wup_id = v02.wup_id AND 
   v01.mandant_id = v02.mandant_id;