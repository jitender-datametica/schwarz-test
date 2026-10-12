/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB view			|	v_sapewm_forklift_exception_add
Description		|	SAP EWM Forklift Exception - view with additional columns 
====================================================================================================
*/


CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_sapewm_forklift_exception_add (client_id
OPTIONS(description='Client id (PK)'), wh_id OPTIONS(description='Warehouse ID (PK)'), wh_task_nr
OPTIONS(description='Warehouse Task (PK)'), conf_dt
OPTIONS(description='Confirmation Date - Technical name: CONFIRMED_DATE - Component Type: /SCWM/DE_CONFIRMED_DATE'),
conf_tm
OPTIONS(description='Confirmation Time - Technical name: CONFIRMED_TIME - Component Type: /SCWM/DE_CONFIRMED_TIME'),
src_hu OPTIONS(description='Source Handling Unit - Technical name: VLENR - Component Type: /SCWM/LTAP_VLENR'),
movement_type OPTIONS(description='Movement type'), rsrc_type OPTIONS(description='Resource type'), wh_area
OPTIONS(description='Warehouse area'), exc_cd
OPTIONS(description='Exception Code - Technical name: EXCCODE - Component Type: /SCWM/DE_EXCCODE'), except_fg
OPTIONS(description='Flag to indicate if the exception occurred'), dwh_created OPTIONS(description='Record created at'),
dwh_updated OPTIONS(description='Record updated at'))
OPTIONS(DESCRIPTION = `SAP EWM FORKLIFT REPORT EXCEPTION HANDLING - VIEW WITH ADDITIONAL COLUMNS (BASED ON V_SAPEWM_FORKLIFT_PRODUCTIVITY_ADD, V_SAPEWM_WHTASK AND MV_REF_QUEUE)`)
AS WITH EXCEPTIONS_BASE AS (SELECT T.client_id,
   T.wh_id,
   T.wh_task_nr,
   T.wh_task_item,
   T.conf_by,
   T.conf_dt,
   T.conf_tm,
   T.queue,
   T.exc_cd,
   T.src_rsrc,
   T.src_hu,
   T.dest_strg_bin,
   T.dest_strg_bin_orig,
   T.act_area,
   T.dest_rsrc,
   Q.wh_area,
   Q.movement_type,
   COALESCE(T.dest_rsrc, T.src_rsrc) AS rsrc,
    CASE
    WHEN LEFT(COALESCE(T.dest_rsrc, T.src_rsrc), 1) = '1'
    THEN 'FAMO'
    WHEN LEFT(COALESCE(T.dest_rsrc, T.src_rsrc), 1) = '2'
    THEN 'FORK'
    WHEN LEFT(COALESCE(T.dest_rsrc, T.src_rsrc), 1) = '3'
    THEN 'FAMO'
    WHEN LEFT(COALESCE(T.dest_rsrc, T.src_rsrc), 1) = ''
    THEN 'No Resource'
    ELSE 'Unknown'
    END AS rsrc_type,
   T.dwh_created,
   T.dwh_updated,
   DATETIME(T.conf_dt, T.conf_tm) AS exception_ts
  FROM ldl_logop_fe_mstr_logop.v_sapewm_whtask AS T
   INNER JOIN ldl_logop_data.t_ref_queue AS Q ON T.queue = Q.queue
  WHERE T.wh_task_stat IN ('C', 'A')
   AND (NOT STARTS_WITH(IFNULL(T.queue, 'dummy'), 'OUT') OR STARTS_WITH(IFNULL(T.queue, 'dummy'), 'OUT') AND T.src_hu
      IS NOT NULL)
   AND (T.src_rsrc IS NOT NULL OR T.dest_rsrc IS NOT NULL)
   AND T.act_type IN ('INTL', 'PICK', 'PTWY', 'REPL')
   AND (T.exc_cd = 'CHBD' AND T.dest_strg_bin <> T.dest_strg_bin_orig AND T.dest_rsrc IS NULL AND T.dest_strg_bin_orig
        NOT LIKE '9998%' OR T.exc_cd <> 'CHBD' OR T.dest_strg_bin_orig IS NULL)
   AND (T.exc_cd = 'MBNO' AND T.dest_strg_bin NOT LIKE '9998%' OR T.exc_cd <> 'MBNO')
   AND T.exc_cd <> 'MLOC') (SELECT client_id,
   wh_id,
   wh_task_nr,
   conf_dt,
   conf_tm,
   src_hu,
   movement_type,
   rsrc_type,
   wh_area,
   exc_cd,
    CASE
    WHEN exc_cd IS NOT NULL
    THEN 1
    ELSE 0
    END AS except_fg,
   dwh_created,
   dwh_updated
  FROM EXCEPTIONS_BASE);