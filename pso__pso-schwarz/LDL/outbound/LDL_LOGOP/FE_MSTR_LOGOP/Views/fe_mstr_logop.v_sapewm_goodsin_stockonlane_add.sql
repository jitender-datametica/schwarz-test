/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB view			|	v_sapewm_goodsin_stockonlane_add
Description		|	SAP EWM Goods In - view with additional columns 
====================================================================================================
*/


CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_sapewm_goodsin_stockonlane_add (client_id
OPTIONS(description='Client id (PK)'), lidl_ctry OPTIONS(description='Country code (PK)'), wh_id
OPTIONS(description='Warehouse ID'), wh_task_nr OPTIONS(description='Warehouse Task (PK)'), wh_task_item
OPTIONS(description='Warehouse Task Item (PK)'), wh_task_stat
OPTIONS(description='Warehouse Task Status - Technical name: TOSTAT - Component Type: /SCWM/DE_TOSTAT'), wh_proc_type
OPTIONS(description='Warehouse Process Type - Technical name: PROCTY - Component Type: /SCWM/DE_PROCTY'), wh_proc_cat
OPTIONS(description='Warehouse Process Category - Technical name: TRART - Component Type: /SCWM/LVS_TRART'), doc_nr
OPTIONS(description='Document - Technical name: DOCNO - Component Type: /SCWM/SP_DOCNO_INT'), doc_cat
OPTIONS(description='Document Category for Document-Related Stocks - Technical name: QDOCCAT - Component Type: /SCWM/DE_UI_QDOCCAT'),
prod_nr OPTIONS(description='Product - Technical name: MATNR - Component Type: /SCWM/DE_MATNR'), prod_desc
OPTIONS(description='Product Short Description - Technical name: MAKTX - Component Type: /SCWM/DE_UI_MAKTX'), conf_dt
OPTIONS(description='Confirmation Date - Technical name: CONFIRMED_DATE - Component Type: /SCWM/DE_CONFIRMED_DATE'),
conf_tm
OPTIONS(description='Confirmation Time - Technical name: CONFIRMED_TIME - Component Type: /SCWM/DE_CONFIRMED_TIME'),
conf_ts OPTIONS(description='Confirmation timestamp'), conf_hr OPTIONS(description='Confirmation hour'), hu_fg
OPTIONS(description='Handling Unit Warehouse Task - Technical name: FLGHUTO - Component Type: /SCWM/FLGHUTO'),
src_strg_bin OPTIONS(description='Source Storage Bin - Technical name: VLPLA - Component Type: /SCWM/LTAP_VLPLA'),
src_hu OPTIONS(description='Source Handling Unit - Technical name: VLENR - Component Type: /SCWM/LTAP_VLENR'),
src_strg_type OPTIONS(description='Source Storage Type - Technical name: VLTYP - Component Type: /SCWM/LTAP_VLTYP'),
src_rsrc
OPTIONS(description='Source Resource (Means of Transport or User) - Technical name: SRSRC - Component Type: /SCWM/DE_SRSRC'),
dest_strg_bin OPTIONS(description='Destination Storage Bin - Technical name: NLPLA - Component Type: /SCWM/LTAP_NLPLA'),
dest_hu OPTIONS(description='Destination Handling Unit - Technical name: NLENR - Component Type: /SCWM/LTAP_NLENR'),
owner OPTIONS(description='Owner - Technical name: OWNER - Component Type: /SCWM/DE_OWNER'), dest_strg_type
OPTIONS(description='Destination Storage Type - Technical name: NLTYP - Component Type: /SCWM/LTAP_NLTYP'), dest_rsrc
OPTIONS(description='Destination Resource (Means of Transport or User) - Technical name: DRSRC - Component Type: /SCWM/DE_DRSRC'),
gr_dt OPTIONS(description='Goods Receipt Date - Technical name: GRDATE - Component Type: /SCWM/DE_GR_DATE'), gr_proc_tm
OPTIONS(description='Goods Receipt Processing Time - Technical name: GRTIME - Component Type: /SCWM/DE_GR_TIME'),
dwh_created OPTIONS(description='Record created at'), dwh_updated OPTIONS(description='Record updated at'), receipt_fg
OPTIONS(description='Receipt flag for counted pallets'), putaway_fg
OPTIONS(description='Putaway flag for picked up palltes')) AS WITH WHTREC AS (SELECT client_id,
   lidl_country AS lidl_ctry,
   ROUND(CAST(LTRIM(REGEXP_EXTRACT(wh_nr, '\\d+'), '0') AS NUMERIC), 0) AS wh_id,
   wh_task_nr,
   wh_task_item,
   wh_task_stat,
   wh_process_type AS wh_proc_type,
   wh_process_cat AS wh_proc_cat,
   doc_nr,
   doc_cat,
   product_nr AS prod_nr,
   prod_desc,
   confirmed_dt AS conf_dt,
   confirmed_tm AS conf_tm,
   DATETIME(confirmed_dt, confirmed_tm) AS conf_ts,
   TIME_TRUNC(confirmed_tm, HOUR) AS conf_hr,
   hu_flg AS hu_fg,
   src_strg_bin,
   src_hu,
   src_strg_type,
   src_rsrc,
   dest_strg_bin,
   dest_hu,
   IF(client_id = 10 AND ROUND(SAFE_CAST(LTRIM(REGEXP_EXTRACT(wh_nr, '\\d+'), '0') as NUMERIC), 0) = 7, owner_id,
    'Not Applicable') AS owner,
   dest_strg_type,
   dest_rsrc,
   goods_recpt_dt AS gr_dt,
   goods_recpt_procs_tm AS gr_proc_tm,
   dwh_created,
   dwh_updated
  FROM ldl_logop_data.t_logop_sapewm_warehousetask
  WHERE CAST(wh_process_cat AS FLOAT64) = 5
   AND wh_task_stat = 'C'
   AND doc_nr IS NOT NULL
   AND dest_hu IS NOT NULL), WHTREV AS (SELECT client_id,
   lidl_country AS lidl_ctry,
   ROUND(CAST(LTRIM(REGEXP_EXTRACT(wh_nr, '\\d+'), '0') AS NUMERIC), 0) AS wh_id,
   wh_task_stat,
   wh_process_cat AS wh_proc_cat,
   doc_cat,
   doc_nr,
   confirmed_dt AS conf_dt,
   src_hu,
   confirmed_tm AS conf_tm
  FROM ldl_logop_data.t_logop_sapewm_warehousetask
  WHERE CAST(wh_process_cat AS FLOAT64) = 6
   AND wh_task_stat = 'C'
   AND doc_cat = 'PDI'
   AND doc_nr IS NOT NULL
   AND src_hu IS NOT NULL), RECEIPTS AS (SELECT r.client_id,
   r.lidl_ctry,
   r.wh_id,
   r.wh_task_nr,
   r.wh_task_item,
   r.wh_task_stat,
   r.wh_proc_type,
   r.wh_proc_cat,
   r.doc_nr,
   r.doc_cat,
   r.prod_nr,
   r.prod_desc,
   r.conf_dt,
   r.conf_tm,
   r.conf_ts,
   r.conf_hr,
   r.hu_fg,
   r.src_strg_bin,
   r.src_hu,
   r.src_strg_type,
   r.src_rsrc,
   r.dest_strg_bin,
   r.dest_hu,
   r.owner,
   r.dest_strg_type,
   r.dest_rsrc,
   r.gr_dt,
   r.gr_proc_tm,
   r.dwh_created,
   r.dwh_updated
  FROM WHTREC AS r
   LEFT JOIN WHTREV AS rev ON r.client_id = rev.client_id AND r.wh_id = rev.wh_id AND r.dest_hu = rev.src_hu AND r.conf_dt
       <= rev.conf_dt AND r.conf_tm <= rev.conf_tm
  WHERE rev.conf_dt IS NULL
   AND r.dest_strg_type <> '9996'
  QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(r.client_id AS STRING), CAST(r.wh_id AS STRING), r.conf_dt, r.dest_hu
      ORDER BY r.conf_tm IS NULL DESC, r.conf_tm DESC)) = 1), PUTAWAYS AS (SELECT client_id,
   lidl_country AS lidl_ctry,
   ROUND(CAST(LTRIM(REGEXP_EXTRACT(wh_nr, '\\d+'), '0') AS NUMERIC), 0) AS wh_id,
   wh_task_nr,
   wh_task_item,
   wh_task_stat,
   wh_process_type AS wh_proc_type,
   wh_process_cat AS wh_proc_cat,
   doc_nr,
   doc_cat,
   product_nr AS prod_nr,
   prod_desc,
   confirmed_dt AS conf_dt,
   confirmed_tm AS conf_tm,
   DATETIME(confirmed_dt, confirmed_tm) AS conf_ts,
   TIME_TRUNC(confirmed_tm, HOUR) AS conf_hr,
   hu_flg AS hu_fg,
   src_strg_bin,
   src_hu,
   src_strg_type,
   src_rsrc,
   dest_strg_bin,
   dest_hu,
   IF(client_id = 10 AND ROUND(SAFE_CAST(LTRIM(REGEXP_EXTRACT(wh_nr, '\\d+'), '0') as NUMERIC), 0) = 7, owner_id,
    'Not Applicable') AS owner,
   dest_strg_type,
   dest_rsrc,
   goods_recpt_dt AS gr_dt,
   goods_recpt_procs_tm AS gr_proc_tm,
   dwh_created,
   dwh_updated
  FROM ldl_logop_data.t_logop_sapewm_warehousetask
  WHERE wh_task_stat = 'C'
   AND (CAST(wh_process_cat AS FLOAT64) = 1 OR CAST(wh_process_cat AS FLOAT64) = 3 AND wh_process_type IN ('3050',
        '9999'))
   AND IFNULL(doc_cat, '') <> 'PDO'
   AND LEFT(src_strg_type, 1) IN ('9', 'D', 'W')
   AND LEFT(IFNULL(dest_strg_type, ''), 1) <> 'W'
   AND dest_hu IS NOT NULL
  QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(client_id AS STRING), CAST(ROUND(ROUND(CAST(LTRIM(REGEXP_EXTRACT(wh_nr, '\\d+'), '0') AS NUMERIC)
           , 0), 0) AS STRING), confirmed_dt, src_hu ORDER BY confirmed_tm IS NULL DESC, confirmed_tm DESC)) = 1) (SELECT
   *
  FROM (SELECT client_id,
      lidl_ctry,
      wh_id,
      wh_task_nr,
      wh_task_item,
      wh_task_stat,
      wh_proc_type,
      wh_proc_cat,
      doc_nr,
      doc_cat,
      prod_nr,
      prod_desc,
      conf_dt,
      conf_tm,
      conf_ts,
      conf_hr,
      hu_fg,
      src_strg_bin,
      src_hu,
      src_strg_type,
      src_rsrc,
      dest_strg_bin,
      dest_hu,
      owner,
      dest_strg_type,
      dest_rsrc,
      gr_dt,
      gr_proc_tm,
      dwh_created,
      dwh_updated,
      1 AS receipt_fg,
      0 AS putaway_fg
     FROM RECEIPTS
     UNION ALL
     SELECT t19.client_id,
      t19.lidl_ctry,
      t19.wh_id,
      t19.wh_task_nr,
      t19.wh_task_item,
      t19.wh_task_stat,
      t19.wh_proc_type,
      t19.wh_proc_cat,
      t19.doc_nr,
      t19.doc_cat,
      t19.prod_nr,
      t19.prod_desc,
      t19.conf_dt,
      t19.conf_tm,
      t19.conf_ts,
      t19.conf_hr,
      t19.hu_fg,
      t19.src_strg_bin,
      t19.src_hu,
      t19.src_strg_type,
      t19.src_rsrc,
      t19.dest_strg_bin,
      t19.dest_hu,
      t19.owner,
      t15.dest_strg_type,
      t19.dest_rsrc,
      t19.gr_dt,
      t19.gr_proc_tm,
      t19.dwh_created,
      t19.dwh_updated,
      0 AS receipt_fg,
      1 AS putaway_fg
     FROM RECEIPTS AS t15
      INNER JOIN PUTAWAYS AS t19 ON t15.client_id = t19.client_id AND t15.wh_id = t19.wh_id AND t15.dest_hu = t19.src_hu
            AND IFNULL(t15.prod_nr, t19.prod_nr) = IFNULL(t19.prod_nr, t15.prod_nr) AND t15.gr_dt = t19.gr_dt AND t15.conf_ts
         <= t19.conf_ts
     QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(t19.client_id AS STRING), CAST(t19.wh_id AS STRING), t19.src_hu, t19
           .prod_nr, t19.gr_dt ORDER BY t19.conf_dt IS NULL, t19.conf_dt, t19.conf_tm IS NULL, t19.conf_tm)) = 1));