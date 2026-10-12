/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB view			|	v_sapewm_forklift_exception_add_1
Description		|	SAP EWM Forklift Exception - view with additional columns 
====================================================================================================
*/

CREATE OR REPLACE VIEW fe_mstr_logop.v_sapewm_forklift_exception_add_1(
	client_id COMMENT 'Client id (PK)',
	wh_id COMMENT 'Warehouse ID (PK)',
	wh_task_nr COMMENT 'Warehouse Task (PK)',
	conf_dt COMMENT 'Confirmation Date - Technical name: CONFIRMED_DATE - Component Type: /SCWM/DE_CONFIRMED_DATE',
	conf_tm COMMENT 'Confirmation Time - Technical name: CONFIRMED_TIME - Component Type: /SCWM/DE_CONFIRMED_TIME',
	src_hu COMMENT 'Source Handling Unit_1 - Technical name: VLENR - Component Type: /SCWM/LTAP_VLENR',
	movement_type COMMENT 'Movement type',
	rsrc_type COMMENT 'Resource type',
	wh_area COMMENT 'Warehouse area',
	exc_cd COMMENT 'Exception Code - Technical name: EXCCODE - Component Type: /SCWM/DE_EXCCODE',
	except_fg COMMENT 'Flag to indicate if the exception occurred',
	dwh_created COMMENT 'Record created at',
	dwh_updated COMMENT 'Record updated at'
) COMMENT='SAP EWM forklift report exception handling - view with additional columns (based on v_sapewm_forklift_productivity_add_1, v_sapewm_whtask_1 and mv_ref_queue_1)'
 AS 
 WITH exceptions_base AS (
	SELECT
        t.client_id
        , t.wh_id
        , t.wh_task_nr
        , t.wh_task_item
        , t.conf_by
        , t.conf_dt
        , t.conf_tm
        , t.QUEUE
        , t.exc_cd
        , t.src_rsrc
        , t.src_hu
        , t.dest_strg_bin
        , t.dest_strg_bin_orig
        , t.act_area
        , t.dest_rsrc
        , q.wh_area
        , q.movement_type
        ,COALESCE(t.dest_rsrc, t.src_rsrc) AS rsrc
        ,DECODE(LEFT(rsrc, 1), '1', 'FAMO', '2', 'FORK', '3', 'FAMO', '', 'No Resource', 'Unknown') AS rsrc_type
        --,LEFT(t.hu_type, 2) AS HU_TYPE_EPE
        --,DECODE(LEFT(t.hu_type, 2), 'EP', TO_NUMBER(1,10,5), 'DD', TO_NUMBER(0.5,10,5), 'QP', TO_NUMBER(0.25,10,5), TO_NUMBER(0,10,5)) as hu_size
        , t.dwh_created
    	, t.dwh_updated
        , TIMESTAMPFROMPARTS(t.conf_dt, t.conf_tm) AS exception_ts
    FROM fe_mstr_logop.v_sapewm_whtask_1 t -- Primary key (client_id, wh_id, wh_task_nr, wh_task_item)
        JOIN "DATA".T_REF_QUEUE_1 q -- Primary key (queue) but this columns is already covered in the PK of mv_sapewm_whtask_1
            ON t.QUEUE = q.QUEUE
    WHERE t.wh_task_stat IN ('C','A') -- A canceled, C confirmed
        AND (NOT STARTSWITH(IFNULL(t.QUEUE, 'dummy_1'), 'OUT') OR (STARTSWITH(IFNULL(t.QUEUE, 'dummy_1'), 'OUT') AND t.src_hu IS NOT NULL))
        AND (t.src_rsrc IS NOT NULL OR t.dest_rsrc IS NOT NULL)
        AND t.act_type IN ('INTL', 'PICK', 'PTWY', 'REPL') -- internal movement, picking, put away, replenishment
        -- The new logic to identify real CHBD errors only 
      AND ((t.exc_cd = 'CHBD' AND t.dest_strg_bin <> t.dest_strg_bin_orig AND NOT t.dest_strg_bin_orig LIKE '9998%' AND t.dest_rsrc IS NULL) 
       OR
           (t.exc_cd IS NOT NULL AND t.exc_cd != 'CHBD')
       OR 
            t.dest_strg_bin_orig IS NULL) -- to take into count dest_strg_bin_orig with NULL
       AND ((t.exc_cd = 'MBNO' AND NOT t.dest_strg_bin LIKE '9998%') -- Destination Bin is not 9998% 
        OR
           (t.exc_cd IS NOT NULL AND t.exc_cd != 'MBNO')) -- Source Resource is not empty
       AND  t.exc_cd <> 'MLOC'
 )
 SELECT
 	 client_id
    , wh_id
    , wh_task_nr
    , conf_dt
    , conf_tm
    , src_hu
    , movement_type
    , rsrc_type
    , wh_area
    , exc_cd
    , CASE WHEN exc_cd IS NOT NULL THEN 1 ELSE 0 END AS except_fg
    , dwh_created
    , dwh_updated
 FROM  exceptions_base;