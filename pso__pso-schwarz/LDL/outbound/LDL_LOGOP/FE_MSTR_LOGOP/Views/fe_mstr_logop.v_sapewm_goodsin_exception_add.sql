/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB view			|	v_sapewm_goodsin_exception_add
Description		|	SAP EWM Goods In - view with additional columns 
====================================================================================================
*/


CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_sapewm_goodsin_exception_add (client_id
OPTIONS(description='Client ID (PK)'), lidl_ctry OPTIONS(description='Country code'), wh_id
OPTIONS(description='Warehouse ID (PK)'), wh_task_nr OPTIONS(description='Warehouse task number (PK)'), wh_task_item
OPTIONS(description='Warehouse Task Item (PK)'), conf_dt OPTIONS(description='Confirmation date'), conf_tm
OPTIONS(description='Confirmation time'), wh_proc_cat OPTIONS(description='Warehouse process category'), wh_task_stat
OPTIONS(description='Warehouse Task Status'), prod_nr OPTIONS(description='Product number'), prod_desc
OPTIONS(description='Product short description'), doc_nr OPTIONS(description='Document number'), doc_cat
OPTIONS(description='Document category for document-related stocks'), src_hu OPTIONS(description='Source handling unit'),
src_strg_bin OPTIONS(description='Source storage bin'), src_strg_type OPTIONS(description='Source storage type'),
dest_hu OPTIONS(description='Destination handling unit'), dest_strg_bin OPTIONS(description='Destination storage bin'),
dest_strg_type OPTIONS(description='Destination storage type'), queue OPTIONS(description='Queue'), act_area
OPTIONS(description='Activity area'), act_type OPTIONS(description='Activity type'), exc_cd
OPTIONS(description='Exception code'), dwh_created OPTIONS(description='Record created at'), dwh_updated
OPTIONS(description='Record updated at'), receipt_fg OPTIONS(description='Flag for original receipt record'),
dest_strg_bin_clrg OPTIONS(description='Destination storage bin of clearing'), clrg_area
OPTIONS(description='Area of clearing'), rejected_area OPTIONS(description='Area of rejection'), clearing_cnt
OPTIONS(description='Clearing count'), reversal_cnt OPTIONS(description='Reversal count'), underdeliv_cnt
OPTIONS(description='Underdelivery if delivered quantity is smaller than ordered quantity'), clearing_amount
OPTIONS(description='Amount of clearing without underdelivery'))
OPTIONS(DESCRIPTION = `SAP EWM GOODS IN - VIEW WITH ADDITIONAL COLUMNS (PK CLIENT_ID, WH_ID, WH_TASK_NR, WH_TASK_ITEM)`)
AS WITH RECEIPTS AS (SELECT client_id,
   lidl_country AS lidl_ctry,
   ROUND(CAST(LTRIM(REGEXP_EXTRACT(wh_nr, '\\d+'), '0') AS NUMERIC), 0) AS wh_id,
   wh_task_nr,
   wh_task_item,
   confirmed_dt AS conf_dt,
   confirmed_tm AS conf_tm,
   wh_process_cat AS wh_proc_cat,
   wh_task_stat,
   product_nr AS prod_nr,
   prod_desc,
   doc_nr,
   doc_cat,
   src_hu,
   src_strg_bin,
   src_strg_type,
   dest_hu,
   dest_strg_bin,
   dest_strg_type,
   queue,
   activity_area AS act_area,
   activity_type AS act_type,
   exception_cd AS exc_cd,
   dwh_created,
   dwh_updated
  FROM ldl_logop_data.t_logop_sapewm_warehousetask
  WHERE wh_task_stat = 'C'
   AND CAST(wh_process_cat AS FLOAT64) = 5
   AND dest_hu IS NOT NULL
   AND doc_nr IS NOT NULL), CLEARINGS AS (SELECT client_id,
   ROUND(CAST(LTRIM(REGEXP_EXTRACT(wh_nr, '\\d+'), '0') AS NUMERIC), 0) AS wh_id,
   confirmed_dt AS conf_dt,
   confirmed_tm AS conf_tm,
   src_hu,
   dest_strg_bin,
   activity_area AS act_area,
    CASE
    WHEN activity_area = 'WCL1' OR STRPOS(dest_strg_bin, '9100') <> 0
    THEN 'Ambient'
    WHEN activity_area = 'WCL4' OR STRPOS(dest_strg_bin, '9400') <> 0
    THEN 'Fruit & Veg.'
    WHEN activity_area = 'WCL5' OR STRPOS(dest_strg_bin, '9500') <> 0
    THEN 'Chiller'
    WHEN activity_area = 'WCL7' OR STRPOS(dest_strg_bin, '9700') <> 0
    THEN 'TIKO'
    WHEN STRPOS(dest_strg_bin, '9800') <> 0
    THEN 'AHR'
    ELSE 'Unassigned'
    END AS clrg_area,
   COUNT(wh_task_nr) AS clearing_cnt
  FROM ldl_logop_data.t_logop_sapewm_warehousetask
  WHERE wh_task_stat IN ('A', 'C')
   AND (STARTS_WITH(dest_strg_type, 'W') OR dest_strg_bin = '9800')
   AND (queue IN ('INB_AHR', 'INB_AMB', 'INB_CHL', 'INB_FRZ', 'INB_F+V', 'INB1_AMB', 'INB1_CHL', 'INB1_FRZ', 'INB1_F+V'
        , 'INB3_F+V') AND activity_area = 'WPCO' OR queue IS NULL AND activity_area IN ('WCL1', 'WCL4', 'WCL5', 'WCL7')
    )
  GROUP BY client_id,
   wh_id,
   src_hu,
   conf_dt,
   conf_tm,
   dest_strg_bin,
   act_area), REVERSALS AS (SELECT client_id,
   ROUND(CAST(LTRIM(REGEXP_EXTRACT(wh_nr, '\\d+'), '0') AS NUMERIC), 0) AS wh_id,
   confirmed_dt AS conf_dt,
   confirmed_tm AS conf_tm,
   src_hu,
   COUNT(wh_task_nr) AS reversal_cnt,
   COUNTIF(exception_cd = 'Z009') AS underdeliv_cnt,
    CASE
    WHEN activity_area = 'WCL1' OR STRPOS(src_strg_bin, '9100') <> 0
    THEN 'Ambient'
    WHEN activity_area = 'WCL4' OR STRPOS(src_strg_bin, '9400') <> 0
    THEN 'Fruit & Veg.'
    WHEN activity_area = 'WCL5' OR STRPOS(src_strg_bin, '9500') <> 0
    THEN 'Chiller'
    WHEN activity_area = 'WCL7' OR STRPOS(src_strg_bin, '9700') <> 0
    THEN 'TIKO'
    WHEN STRPOS(src_strg_bin, '9800') <> 0
    THEN 'AHR'
    ELSE 'Unassigned'
    END AS rejected_area
  FROM ldl_logop_data.t_logop_sapewm_warehousetask
  WHERE CAST(wh_process_cat AS FLOAT64) = 6
   AND doc_cat = 'PDI'
   AND wh_task_stat = 'C'
   AND doc_nr IS NOT NULL
   AND src_hu IS NOT NULL
  GROUP BY client_id,
   wh_id,
   src_hu,
   conf_dt,
   conf_tm,
   activity_area,
   src_strg_bin) (SELECT r.client_id,
   r.lidl_ctry,
   r.wh_id,
   r.wh_task_nr,
   r.wh_task_item,
   r.conf_dt,
   r.conf_tm,
   r.wh_proc_cat,
   r.wh_task_stat,
   r.prod_nr,
   r.prod_desc,
   r.doc_nr,
   r.doc_cat,
   r.src_hu,
   r.src_strg_bin,
   r.src_strg_type,
   r.dest_hu,
   r.dest_strg_bin,
   r.dest_strg_type,
   r.queue,
   r.act_area,
   r.act_type,
   r.exc_cd,
   r.dwh_created,
   r.dwh_updated,
   IF((ROW_NUMBER() OVER (PARTITION BY CAST(r.client_id AS STRING), CAST(r.wh_id AS STRING), CAST(r.wh_task_nr AS STRING)
         , CAST(r.wh_task_item AS STRING) ORDER BY c.conf_dt IS NULL, c.conf_dt, c.conf_tm IS NULL, c.conf_tm)) = 1, 1,
    0) AS receipt_fg,
   c.dest_strg_bin AS dest_strg_bin_clrg,
   c.clrg_area,
   rv.rejected_area,
   IFNULL(c.clearing_cnt, 0) AS clearing_cnt,
   IF(IFNULL(rv.reversal_cnt, 0) <> 0 AND IF((ROW_NUMBER() OVER (PARTITION BY CAST(r.client_id AS STRING), CAST(r.wh_id AS STRING)
            , CAST(r.wh_task_nr AS STRING), CAST(r.wh_task_item AS STRING) ORDER BY c.conf_dt IS NULL, c.conf_dt, c.conf_tm
            IS NULL, c.conf_tm)) = 1, 1, 0) = 1, 1, 0) AS reversal_cnt,
   IFNULL(rv.underdeliv_cnt, 0) AS underdeliv_cnt,
   IF(c.clearing_cnt > 0 AND IF((ROW_NUMBER() OVER (PARTITION BY CAST(r.client_id AS STRING), CAST(r.wh_id AS STRING), CAST(r.wh_task_nr AS STRING)
            , CAST(r.wh_task_item AS STRING) ORDER BY c.conf_dt IS NULL, c.conf_dt, c.conf_tm IS NULL, c.conf_tm)) = 1,
       1, 0) = 1, c.clearing_cnt - IFNULL(rv.underdeliv_cnt, 0), 0) AS clearing_amount
  FROM RECEIPTS AS r
   LEFT JOIN CLEARINGS AS c ON r.client_id = c.client_id AND r.wh_id = c.wh_id AND r.dest_hu = c.src_hu AND r.conf_dt =
      c.conf_dt AND r.conf_tm <= c.conf_tm
   LEFT JOIN REVERSALS AS rv ON r.client_id = rv.client_id AND r.wh_id = rv.wh_id AND r.dest_hu = rv.src_hu AND r.conf_dt
       = rv.conf_dt AND r.conf_tm <= rv.conf_tm);