/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB view			|	v_lpv_forklift_productivity_add_2
Description		|	LPV Forklift - view with additional columns
====================================================================================================
*/

-- General information: One warehouse task usually contains more than one operations. So one pallet can be considered as a warehouse task and one movement can be considered as a single operation.   
-- FE_MSTR_LOGOP.V_LPV_FORKLIFT_PRODUCTIVITY_ADD_2 source

CREATE OR REPLACE VIEW FE_MSTR_LOGOP.V_LPV_FORKLIFT_PRODUCTIVITY_ADD_2(
   CLIENT_ID COMMENT 'Client id - calculated based on the country_2 code (PK)'
 , WH_ID COMMENT 'Warehouse number (datastore_data:lagernummer). Foreign key: Referencing LPV.LAGER.LAGERNR'
 , OP_ID COMMENT 'Surrogate key (PK)'
 , OP_DT COMMENT 'Operation date from timestamp'
 , OP_TM COMMENT 'Operation time from timestamp'
 , OP_TYPE COMMENT 'Operation type'
 , USER_ID COMMENT 'User ID of the executing user. Foreign key: Referencing LPV.PERSONAL.PERSNR'
 , COMP_ID COMMENT 'Computer that initiated the goods movement. Foreign key: References LPV.RECHNER.RECHNERID'
 , SRC_PALLET_NR COMMENT 'Number of the pallet on which the stock is located. Foreign key: References LPV.LHM.LHMNR'
 , PALLET_TYPE COMMENT 'This column identifies if a pallet is Doppelt Quer or Einfachtief type'
 , SRC_AREA_NR COMMENT 'Source area. Foreign key: Referencing LPV.BEREICH.NR'
 , TGT_AREA_NR COMMENT 'Target area. Foreign key: Referencing LPV.BEREICH.NR'
 , DWH_CREATED COMMENT 'Record created at'
 , DWH_UPDATED COMMENT 'Record updated at'
 , MVMT_FG COMMENT 'Flag for classification if the operation is a relevant movement'
 , CONS_SRC_AREA_NR COMMENT 'Consolidated source area number'
 , MVMT_TYPE_NR COMMENT 'Movement type for FE lookup'
 , OP_DT_PREV COMMENT 'Operation date of previous warehouse task'
 , OP_TM_PREV COMMENT 'Operation time of previous warehouse task'
 , PREV_OP_TM_DIFF_SEC COMMENT 'Time in seconds between last and current operation'
 , EMP_WRK_SHIFT_START_FG COMMENT 'Flag for first operation of a working shift of an employee_2'
 , WORK_TM_SEC COMMENT 'Recorded working time in seconds'
 , WORK_TM_SEC_NET COMMENT 'Net working time in seconds without pauses and with standard time'
 , COUNT_PALLET_MVMT COMMENT 'Amount of pallet movements'
 , NUMBER_OF_PALLET_MVMT COMMENT 'Number of pallet movements'
) AS
WITH 

consolidatedoperations AS (
		SELECT
		 client_id
		,wh_id 
		,operation_id AS op_id
		,TO_DATE(operation_tmsp) AS op_dt
		,TO_TIME(operation_tmsp) AS op_tm
		,operation_type AS op_type
		,user_id
		,computer_id AS comp_id 
		,src_pallet_nr 
		,src_area_nr
		,tgt_area_nr 
		,dwh_created
		,dwh_updated
		,CASE
			WHEN op_type = 'NU' 
				AND TIMEDIFF('sec',op_tm , LAG(op_tm) OVER (PARTITION BY client_id, wh_id, user_id, comp_id, src_pallet_nr, op_dt ORDER BY op_dt, op_tm, op_id)) <=5
				THEN 0 
			WHEN tgt_area_nr BETWEEN 8000 AND 8999
                AND tgt_area_nr = LEAD(src_area_nr) OVER (PARTITION BY client_id, wh_id, comp_id,user_id, src_pallet_nr, op_id, op_dt ORDER BY op_dt, op_tm, op_id)
                THEN 0 
			ELSE 1
			END AS mvmt_fg 
		,IFF(mvmt_fg = 1
			AND src_area_nr BETWEEN 8000 AND 8999
			AND src_area_nr = LAG(tgt_area_nr) OVER (PARTITION BY client_id, wh_id, src_pallet_nr, op_dt ORDER BY op_dt, op_tm, op_id) 
			AND tgt_area_nr <> 0,
			LAG(src_area_nr) OVER (PARTITION BY client_id, wh_id, src_pallet_nr, op_dt ORDER BY op_dt, op_tm, op_id)
		,IFF(mvmt_fg = 1
			AND src_area_nr BETWEEN 8000 AND 8999
			AND src_area_nr = LAG(tgt_area_nr) OVER (PARTITION BY client_id, wh_id, user_id, comp_id, src_pallet_nr, op_dt ORDER BY op_dt, op_tm, op_id) 
			AND tgt_area_nr = 0 AND FIRST_VALUE(tgt_area_nr) OVER (PARTITION BY client_id, wh_id, user_id, comp_id, src_pallet_nr, op_dt ORDER BY op_dt, op_tm, op_id) NOT IN ('700','701')
			,FIRST_VALUE(src_area_nr) OVER (PARTITION BY client_id, wh_id, user_id, comp_id, src_pallet_nr, op_dt ORDER BY op_dt, op_tm, op_id)
		,IFF(mvmt_fg = 1
			AND src_area_nr BETWEEN 8000 AND 8999
			AND FIRST_VALUE(tgt_area_nr) OVER (PARTITION BY client_id, wh_id, user_id, comp_id, src_pallet_nr, op_dt ORDER BY op_dt, op_tm, op_id) = 700
			,FIRST_VALUE(tgt_area_nr) OVER (PARTITION BY client_id, wh_id, user_id, comp_id, src_pallet_nr, op_dt ORDER BY op_dt, op_tm, op_id)
		,IFF(mvmt_fg = 1
			AND src_area_nr BETWEEN 8000 AND 8999
			AND FIRST_VALUE(tgt_area_nr) OVER (PARTITION BY client_id, wh_id, user_id, comp_id, src_pallet_nr, op_dt ORDER BY op_dt, op_tm, op_id) = 701
			AND tgt_area_nr = 0 
			,FIRST_VALUE(tgt_area_nr) OVER (PARTITION BY client_id, wh_id, user_id, comp_id, src_pallet_nr, op_dt ORDER BY op_dt, op_tm, op_id)
		,IFF(mvmt_fg = 1
			AND src_area_nr BETWEEN 8000 AND 8999
			AND FIRST_VALUE(src_area_nr) OVER (PARTITION BY client_id, wh_id, user_id, comp_id, src_pallet_nr, op_dt ORDER BY op_dt, op_tm, op_id) = 702
			,FIRST_VALUE(src_area_nr) OVER (PARTITION BY client_id, wh_id, user_id, comp_id, src_pallet_nr, op_dt ORDER BY op_dt, op_tm, op_id)
		,src_area_nr))))) AS cons_src_area_nr
	FROM "DATA".T_LPV_TABAKT_2 
	WHERE STARTSWITH(comp_id, 'TERMINAL_')
		AND CURRENT_DATE BETWEEN dwh_valid_from AND dwh_valid_to
		AND deleted_fg = FALSE
		AND TO_DATE(operation_tmsp) BETWEEN CURRENT_DATE-40 AND CURRENT_DATE
),
doppelt_quer_paletten AS (
	SELECT 
	client_id
   ,wh_id
   ,operation_tmsp 
   ,operation_type 
   ,src_pallet_nr
FROM "DATA".T_LPV_TABAKT_2 
WHERE operation_type = 'VE'
AND CURRENT_DATE BETWEEN dwh_valid_from AND dwh_valid_to
AND deleted_fg = FALSE
AND TO_DATE(operation_tmsp) BETWEEN CURRENT_DATE-40 AND CURRENT_DATE
)
SELECT 
	 con.client_id
	,con.wh_id
	,con.op_id
	,con.op_dt
	,con.op_tm
	,con.op_type
	,IFF(con.client_id = 27, NULL, con.user_id)
	,con.comp_id
	,con.src_pallet_nr
	,IFF(dq.src_pallet_nr = con.src_pallet_nr,'Doppelt Quer','Einfachtief') AS pallet_type 
	,con.src_area_nr
	,con.tgt_area_nr
	,con.dwh_created
	,con.dwh_updated
	,con.mvmt_fg
	,con.cons_src_area_nr
	,CASE
		WHEN (con.cons_src_area_nr BETWEEN 1000 AND 1999 OR con.cons_src_area_nr BETWEEN 8000 AND 8999)
			AND (con.tgt_area_nr BETWEEN 700 AND 899)
			THEN 1 
		WHEN (con.cons_src_area_nr BETWEEN 1000 AND 1999 OR con.cons_src_area_nr BETWEEN 8000 AND 8999)
			AND (con.tgt_area_nr IN ('0', '1','2','3','4','5','6', '7'))
			THEN 3 
		WHEN (con.cons_src_area_nr BETWEEN 700 AND 899 OR con.cons_src_area_nr BETWEEN 8000 AND 8999)
			AND (con.tgt_area_nr BETWEEN 700 AND 899)
			THEN 4 
		WHEN (con.cons_src_area_nr BETWEEN 700 AND 899 OR con.cons_src_area_nr BETWEEN 8000 AND 8999)
			AND (con.tgt_area_nr = 0)
			THEN 2 
		ELSE NULL
		END AS mvmt_type_nr 
	,LAG(con.op_dt) OVER (PARTITION BY con.client_id, con.wh_id, con.user_id ORDER BY con.op_dt, con.op_tm, con.op_id) AS op_dt_prev
	,LAG(con.op_tm) OVER (PARTITION BY con.client_id, con.wh_id, con.user_id ORDER BY con.op_dt, con.op_tm, con.op_id) AS op_tm_prev
	,TIMEDIFF(SECOND, op_dt_prev, con.op_dt) + TIMEDIFF(SECOND, op_tm_prev, con.op_tm) AS prev_op_tm_diff_sec
	,IFF(op_dt_prev IS NULL 
			OR prev_op_tm_diff_sec > 28800 
		, 1
		, 0) AS emp_wrk_shift_start_fg 
	,IFF(emp_wrk_shift_start_fg <> 1, prev_op_tm_diff_sec, NULL) AS work_tm_sec
	,IFF(emp_wrk_shift_start_fg = 1 OR work_tm_sec > 900, 114, work_tm_sec) AS work_tm_sec_net 
	
	,IFF(ROW_NUMBER() OVER (PARTITION BY con.client_id, con.wh_id, con.op_dt, con.src_pallet_nr ORDER BY con.src_pallet_nr)>1 AND OP_TYPE = 'VE' AND pallet_Type = 'Doppelt Quer' OR ROW_NUMBER() OVER (PARTITION BY con.client_id, con.wh_id, con.op_dt, con.src_pallet_nr, con.comp_id ORDER BY con.src_pallet_nr)>1 AND OP_TYPE IN ('EN','NU') AND pallet_Type = 'Doppelt Quer' ,0
	,IFF(pallet_type = 'Doppelt Quer' AND OP_TYPE <> 'VE',2, IFF(pallet_type = 'Doppelt Quer' AND OP_TYPE = 'VE',0,1))) AS count_pallet_mvmt 
	,IFF(ROW_NUMBER() OVER (PARTITION BY con.client_id, con.wh_id, con.src_pallet_nr ORDER BY con.src_pallet_nr)>1 AND OP_TYPE = 'VE' AND pallet_Type = 'Doppelt Quer' OR ROW_NUMBER() OVER (PARTITION BY con.client_id, con.wh_id, con.op_dt, con.src_pallet_nr, con.comp_id ORDER BY con.src_pallet_nr)>1 AND OP_TYPE IN ('EN','NU') AND pallet_Type = 'Doppelt Quer' ,0
	,IFF(pallet_type = 'Doppelt Quer' AND OP_TYPE <> 'VE',2, IFF(pallet_type = 'Doppelt Quer' AND OP_TYPE = 'VE',0,1))) AS number_of_pallet_mvmt 
FROM consolidatedoperations con
LEFT JOIN doppelt_quer_paletten dq
ON con.client_id = dq.client_id
AND con.wh_id = dq.wh_id
AND con.src_pallet_nr = dq.src_pallet_nr
WHERE con.mvmt_fg = 1 
AND mvmt_type_nr IS NOT NULL
AND con.op_type NOT IN ('HE');