CREATE OR REPLACE VIEW DBP_MSI_VIEW_IOS.MV_T_FACT_IOT_STOERMELDUNGEN_2
--20250122 alavih: Filialumgliederung 
(
    mandant_id
    ,wup_id
    ,device_id
	,fault_nr
	,cal_dt
	,measurement_tmsp
	,alarm_priority_cd
	,error_message
	,value_cycling
	,device_type_id
	,error_source
	,active_fg
	,active_fg_bez
) 
AS
SELECT  
    v01.mandant_id
    ,COALESCE(v02.aktuell_wup_id, v01.wup_id) AS wup_id --aktuelle WUP_2
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
FROM  DBP_VIEW.V_T_FACT_IOT_ERRORMESSAGES_2 v01
LEFT JOIN dbp_view.v_wup_2 v02 --aktuelle WUP_2
   ON v01.wup_id = v02.wup_id AND 
   v01.mandant_id = v02.mandant_id;