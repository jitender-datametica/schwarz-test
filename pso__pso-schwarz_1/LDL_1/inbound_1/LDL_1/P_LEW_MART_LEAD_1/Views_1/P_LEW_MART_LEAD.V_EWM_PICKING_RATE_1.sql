create or replace view LDL_PRODUCTION.P_LEW_MART_LEAD.V_EWM_PICKING_RATE_1(
	CLIENT_ID,
	WH_LOC_SID,
	WH_ID,
	WORK_PACKAGE_SID,
	WH_TASK_NR,
	WH_SUB_TASK_NR,
	WH_TASK_CONFIRM_DT,
	CY_MONTH,
	CY_WEEK,
	WH_TASK_GRP_NR,
	WORK_PACKAGE_GRP_NR,
	WORK_PACKAGE_NR,
	PICKED_CASE_QTY,
	PALLET_TYPE_FACTOR,
	WH_WORK_GRP_DESCR,
	PICK_AREA_NR,
	PICK_AREA_DESCR,
	PICK_MAIN_AREA_NR,
	PICK_MAIN_AREA_DESCR,
	DEST_HANDLING_UNIT_NR,
	HANDLING_UNIT_TYPE_CD,
	GRP_WHO_FIRST,
	GRP_HU_FIRST,
	GRP_WHO_LAST,
	PICK_START_TMSP,
	PICK_END_TMSP,
	WORK_TIME_SEC,
	SUM_BREAK_SEC,
	PICK_PALLET_QTY,
	THM_1,
	THM_2,
	THM_3,
	THM_4,
	THM_5,
	THM_ELSE,
	THM_BB,
	THM_BD,
	THM_COHU,
	THM_DTOT,
	THM_EPOS,
	THM_ES,
	THM_GMA,
	THM_HG,
	THM_HS,
	THM_IP,
	THM_QG,
	THM_QP,
	THM_SG,
	THM_SP,
	THM_TB,
	THM_TOTE
) as
WITH  
tsk AS( 
SELECT 
    work_package_sid
   ,client_id
   ,wh_loc_sid
   ,wh_task_confirm_dt
   ,wh_task_grp_nr
   ,dest_handling_unit_nr
   ,pick_case_qty
   ,wh_task_confirm_tmsp
   ,wh_task_start_tmsp
   ,wh_task_nr
   ,wh_sub_task_nr  
FROM p_lew_core.t_warehouse_pick_item_task_1  
WHERE wh_task_status_cd='C' 
AND wh_task_activity_type_cd='PICK')
,hu AS( 
SELECT DISTINCT 
     p_lew_core.t_warehouse_pick_handling_unit_task.pick_handling_unit_task_nr
    ,p_lew_core.t_warehouse_pick_handling_unit_task.pick_handling_unit_sub_task_nr
    ,p_lew_core.t_warehouse_pick_handling_unit_task.work_package_sid
    ,p_lew_core.t_warehouse_pick_handling_unit_task.client_id
    ,p_lew_core.t_warehouse_pick_handling_unit_task.wh_loc_sid
    ,p_lew_core.t_warehouse_pick_handling_unit_task.wh_task_confirm_tmsp
    ,p_lew_core.t_warehouse_pick_handling_unit_task.wh_task_grp_nr
    ,p_lew_core.t_warehouse_pick_handling_unit_task.dest_handling_unit_nr
    ,p_lew_core.t_warehouse_pick_handling_unit_task.handling_unit_type_cd
    ,p_lew_core.t_ref_pallet_type.pallet_type_factor
    ,p_lew_core.t_ref_pallet_type.pallet_type_cd
    ,ROW_NUMBER() OVER (PARTITION BY p_lew_core.t_warehouse_pick_handling_unit_task.work_package_sid
    ,p_lew_core.t_warehouse_pick_handling_unit_task.client_id
    ,p_lew_core.t_warehouse_pick_handling_unit_task.wh_loc_sid
    ,p_lew_core.t_warehouse_pick_handling_unit_task.wh_task_grp_nr
    ,p_lew_core.t_warehouse_pick_handling_unit_task.dest_handling_unit_nr 
     ORDER BY p_lew_core.t_warehouse_pick_handling_unit_task.wh_task_confirm_tmsp DESC NULLS LAST
     ,p_lew_core.t_warehouse_pick_handling_unit_task.pick_handling_unit_task_nr DESC
     ,p_lew_core.t_warehouse_pick_handling_unit_task.pick_handling_unit_sub_task_nr DESC) AS grp_hu_tsk_last  
FROM p_lew_core.t_warehouse_pick_handling_unit_task_1 
LEFT OUTER JOIN p_lew_core.t_ref_handling_unit_type_1
ON p_lew_core.t_warehouse_pick_handling_unit_task.client_id=p_lew_core.t_ref_handling_unit_type.client_id 
AND p_lew_core.t_warehouse_pick_handling_unit_task.handling_unit_type_cd=p_lew_core.t_ref_handling_unit_type.handling_unit_type_cd 
LEFT OUTER JOIN p_lew_core.t_ref_pallet_type_1 
ON p_lew_core.t_ref_handling_unit_type.pallet_type_cd=p_lew_core.t_ref_pallet_type.pallet_type_cd)
,who AS( 
SELECT 
     work_package_sid
    ,client_id
    ,wh_loc_sid
    ,work_package_grp_nr
    ,work_package_nr 
    ,work_package_start_tmsp
    ,work_package_confirm_tmsp 
FROM p_lew_core.t_warehouse_work_package_1)
,brk AS(
SELECT 
    work_package_sid
    ,client_id
    ,wh_loc_sid
    ,SUM(DATEDIFF(SECOND,work_break_start_tmsp,work_break_end_tmsp)) AS work_break_time 
FROM p_lew_core.t_warehouse_work_break_1 
GROUP BY 
    work_package_sid
   ,client_id
   ,wh_loc_sid)
,lkp AS( 
SELECT 
    p_lew_core.t_ref_work_group.wh_work_grp_nr
    ,p_lew_core.t_ref_work_group.wh_work_grp_descr
    ,p_lew_core.t_ref_uniform_pick_area.pick_area_nr
    ,p_lew_core.t_ref_uniform_pick_area.pick_area_descr
    ,p_lew_core.t_ref_pick_main_area.pick_main_area_nr
    ,p_lew_core.t_ref_pick_main_area.pick_main_area_descr 
FROM p_lew_core.t_ref_work_group_1  
INNER JOIN p_lew_core.t_ref_uniform_pick_area_1 
ON p_lew_core.t_ref_work_group.pick_area_nr= p_lew_core.t_ref_uniform_pick_area.pick_area_nr 
INNER JOIN p_lew_core.t_ref_pick_main_area_1 
ON p_lew_core.t_ref_uniform_pick_area.pick_main_area_nr= p_lew_core.t_ref_pick_main_area.pick_main_area_nr) 
SELECT  
     tsk.client_id
    ,tsk.wh_loc_sid
    ,wh.src_wh_id AS wh_id
    ,tsk.work_package_sid
    ,tsk.wh_task_nr
    ,tsk.wh_sub_task_nr
    ,tsk.wh_task_confirm_dt
    ,CAST(CONCAT(SUBSTRING(tsk.wh_task_confirm_dt,1,4),SUBSTRING(tsk.wh_task_confirm_dt,6,2)) AS INTEGER) AS cy_month
	,CAST(IFF(LENGTH(WEEK(tsk.wh_task_confirm_dt)) = 2, CONCAT(YEAR(tsk.wh_task_confirm_dt),WEEK(tsk.wh_task_confirm_dt)),CONCAT(YEAR(tsk.wh_task_confirm_dt),'0',WEEK(tsk.wh_task_confirm_dt))) AS INTEGER) AS cy_week
    ,tsk.wh_task_grp_nr
    ,who.work_package_grp_nr
    ,who.work_package_nr
    ,tsk.pick_case_qty
    ,hu.pallet_type_factor
    ,lkp.wh_work_grp_descr
    ,lkp.pick_area_nr
    ,lkp.pick_area_descr
    ,lkp.pick_main_area_nr
    ,lkp.pick_main_area_descr
    ,tsk.dest_handling_unit_nr
    ,hu.handling_unit_type_cd
    ,ROW_NUMBER() OVER (PARTITION BY tsk.client_id, tsk.wh_loc_sid, tsk.work_package_sid, tsk.wh_task_confirm_dt, tsk.wh_task_grp_nr 
     ORDER BY tsk.wh_task_confirm_tmsp ASC, tsk.wh_task_nr ASC, tsk.wh_sub_task_nr ASC) AS grp_who_first
    ,ROW_NUMBER() OVER (PARTITION BY tsk.client_id, tsk.wh_loc_sid, tsk.work_package_sid, tsk.wh_task_confirm_dt, tsk.wh_task_grp_nr, tsk.dest_handling_unit_nr 
     ORDER BY tsk.wh_task_confirm_tmsp ASC, tsk.wh_task_nr ASC, tsk.wh_sub_task_nr ASC) AS grp_hu_first
    ,ROW_NUMBER() OVER (PARTITION BY tsk.client_id, tsk.wh_loc_sid, tsk.work_package_sid, tsk.wh_task_confirm_dt, tsk.wh_task_grp_nr 
     ORDER BY tsk.wh_task_confirm_tmsp DESC, tsk.wh_task_nr DESC, tsk.wh_sub_task_nr DESC) AS grp_who_last
    ,CASE  
        WHEN grp_who_first = 1 AND tsk.wh_task_grp_nr NOT IN  ('WHO_CANCEL', 'WHO_SPLIT')  
        THEN IFNULL(who.work_package_start_tmsp,tsk.wh_task_start_tmsp)  
        WHEN tsk.wh_task_grp_nr IN ('WHO_CANCEL', 'WHO_SPLIT') AND grp_who_first = 1  
        THEN tsk.wh_task_start_tmsp 
     ELSE LAG(tsk.wh_task_confirm_tmsp) OVER (PARTITION BY tsk.client_id, tsk.wh_loc_sid, tsk.work_package_sid 
          ORDER BY tsk.wh_task_confirm_tmsp ASC, tsk.wh_task_nr ASC, tsk.wh_sub_task_nr ASC)  
     END AS pick_start_tmsp
     ,IFF(grp_who_last = 1 AND tsk.wh_task_grp_nr NOT IN ('WHO_CANCEL', 'WHO_SPLIT')
     ,IFNULL(IFNULL(who.work_package_confirm_tmsp, hu.wh_task_confirm_tmsp),tsk.wh_task_confirm_tmsp)
     ,tsk.wh_task_confirm_tmsp) AS pick_end_tmsp
     ,DATEDIFF(SECOND, pick_start_tmsp, pick_end_tmsp) AS work_time_sec
     ,IFF(grp_who_last = 1, brk.work_break_time, NULL) AS sum_break_sec
     ,IFF(grp_hu_first=1,hu.pallet_type_factor,0) AS pick_pallet_qty
     ,IFF(grp_hu_first=1 AND hu.PALLET_TYPE_CD IN ('AE','E','EP','EPAL','ZE') AND hu.pallet_type_factor <> 0,1,0) AS THM_1 
     ,IFF(grp_hu_first=1 AND hu.PALLET_TYPE_CD IN ('DD','DPAL') AND hu.pallet_type_factor <> 0,1,0) AS THM_2
     ,IFF(grp_hu_first=1 AND hu.PALLET_TYPE_CD IN ('CPOS','FR') AND hu.pallet_type_factor <> 0 ,1,0) AS THM_3
     ,IFF(grp_hu_first=1 AND hu.PALLET_TYPE_CD IN ('BX') AND hu.pallet_type_factor <> 0,1,0) AS THM_4
     ,IFF(grp_hu_first=1 AND hu.PALLET_TYPE_CD IN ('MT') AND hu.pallet_type_factor <> 0,1,0) AS THM_5
     ,IFF(grp_hu_first=1 AND hu.PALLET_TYPE_CD NOT IN ('AE','E','EP','EPAL','ZE','DD','DPAL','CPOS','FR','BX','MT') AND hu.pallet_type_factor <> 0 ,1,0) AS THM_else
     ,IFF(grp_hu_first=1 AND hu.PALLET_TYPE_CD IN ('BB') AND hu.pallet_type_factor <> 0,1,0) AS THM_BB
     ,IFF(grp_hu_first=1 AND hu.PALLET_TYPE_CD IN ('BD') AND hu.pallet_type_factor <> 0,1,0) AS THM_BD
     ,IFF(grp_hu_first=1 AND hu.PALLET_TYPE_CD IN ('COHU') AND hu.pallet_type_factor <> 0,1,0) AS THM_COHU
     ,IFF(grp_hu_first=1 AND hu.PALLET_TYPE_CD IN ('DTOT') AND hu.pallet_type_factor <> 0,1,0) AS THM_DTOT
     ,IFF(grp_hu_first=1 AND hu.PALLET_TYPE_CD IN ('EPOS') AND hu.pallet_type_factor <> 0,1,0) AS THM_EPOS
     ,IFF(grp_hu_first=1 AND hu.PALLET_TYPE_CD IN ('ES') AND hu.pallet_type_factor <> 0,1,0) AS THM_ES
     ,IFF(grp_hu_first=1 AND hu.PALLET_TYPE_CD IN ('GMA') AND hu.pallet_type_factor <> 0,1,0) AS THM_GMA
     ,IFF(grp_hu_first=1 AND hu.PALLET_TYPE_CD IN ('HG') AND hu.pallet_type_factor <> 0,1,0) AS THM_HG
     ,IFF(grp_hu_first=1 AND hu.PALLET_TYPE_CD IN ('HS') AND hu.pallet_type_factor <> 0,1,0) AS THM_HS
     ,IFF(grp_hu_first=1 AND hu.PALLET_TYPE_CD IN ('IP') AND hu.pallet_type_factor <> 0,1,0) AS THM_IP
     ,IFF(grp_hu_first=1 AND hu.PALLET_TYPE_CD IN ('QG') AND hu.pallet_type_factor <> 0,1,0) AS THM_QG
     ,IFF(grp_hu_first=1 AND hu.PALLET_TYPE_CD IN ('QP') AND hu.pallet_type_factor <> 0,1,0) AS THM_QP
     ,IFF(grp_hu_first=1 AND hu.PALLET_TYPE_CD IN ('SG') AND hu.pallet_type_factor <> 0,1,0) AS THM_SG
     ,IFF(grp_hu_first=1 AND hu.PALLET_TYPE_CD IN ('SP') AND hu.pallet_type_factor <> 0,1,0) AS THM_SP
     ,IFF(grp_hu_first=1 AND hu.PALLET_TYPE_CD IN ('TB') AND hu.pallet_type_factor <> 0,1,0) AS THM_TB
     ,IFF(grp_hu_first=1 AND hu.PALLET_TYPE_CD IN ('TOTE') AND hu.pallet_type_factor <> 0,1,0) AS THM_TOTE

FROM tsk 
INNER JOIN p_lew_bil.t_warehouse_1 wh
ON tsk.client_id = wh.client_id
AND tsk.wh_loc_sid = wh.loc_sid_wh
AND CURRENT_DATE BETWEEN wh.dwh_valid_from AND wh.dwh_valid_to
AND wh.active_fg = TRUE
INNER JOIN who 
ON tsk.client_id=who.client_id 
AND tsk.wh_loc_sid=who.wh_loc_sid 
AND tsk.work_package_sid=who.work_package_sid 
LEFT OUTER JOIN hu 
ON tsk.client_id=hu.client_id 
AND tsk.wh_loc_sid=hu.wh_loc_sid 
AND tsk.work_package_sid=hu.work_package_sid 
AND tsk.wh_task_grp_nr=hu.wh_task_grp_nr 
AND tsk.dest_handling_unit_nr= hu.dest_handling_unit_nr 
AND hu.grp_hu_tsk_last=1 
LEFT OUTER JOIN brk 
ON tsk.client_id=brk.client_id 
AND tsk.wh_loc_sid=brk.wh_loc_sid 
AND tsk.work_package_sid=brk.work_package_sid 
LEFT OUTER JOIN lkp 
ON tsk.wh_task_grp_nr =lkp.wh_work_grp_nr;
