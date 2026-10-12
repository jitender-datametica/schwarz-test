CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_sapewm_wareneingang_add (client_id
OPTIONS(description='Client id (PK)'), lidl_ctry OPTIONS(description='Country code'), wh_id
OPTIONS(description='Warehouse ID (PK)'), wh_task_nr OPTIONS(description='Warehouse Task (PK)'), wh_proc_cat
OPTIONS(description='Warehouse Process Category - Technical name: TRART - Component Type: /SCWM/LVS_TRART'), doc_nr
OPTIONS(description='Document - Technical name: DOCNO - Component Type: /SCWM/SP_DOCNO_INT'), doc_cat
OPTIONS(description='Document Category for Document-Related Stocks - Technical name: QDOCCAT - Component Type: /SCWM/DE_UI_QDOCCAT'),
prod_nr OPTIONS(description='Product - Technical name: MATNR - Component Type: /SCWM/DE_MATNR'), prod_desc
OPTIONS(description='Product Short Description - Technical name: MAKTX - Component Type: /SCWM/DE_UI_MAKTX'), conf_dt
OPTIONS(description='Confirmation Date - Technical name: CONFIRMED_DATE - Component Type: /SCWM/DE_CONFIRMED_DATE'),
conf_tm
OPTIONS(description='Confirmation Time - Technical name: CONFIRMED_TIME - Component Type: /SCWM/DE_CONFIRMED_TIME'),
conf_ts OPTIONS(description='Confirmation timestamp'), conf_hr OPTIONS(description='Confirmation hour'), confirmed_by
OPTIONS(description='Confirmed by - Technical name: CONFIRMED_BY - Component Type: /SCWM/DE_CONFIRMEDBY'), src_hu
OPTIONS(description='Source Handling Unit - Technical name: VLENR - Component Type: /SCWM/LTAP_VLENR'), src_strg_type
OPTIONS(description='Source Storage Type - Technical name: VLTYP - Component Type: /SCWM/LTAP_VLTYP'), dest_hu
OPTIONS(description='Destination Handling Unit - Technical name: NLENR - Component Type: /SCWM/LTAP_NLENR'),
dest_strg_type
OPTIONS(description='Destination Storage Type - Technical name: NLTYP - Component Type: /SCWM/LTAP_NLTYP'), dwh_created
OPTIONS(description='Record created at'), dwh_updated OPTIONS(description='Record updated at'), act_qty_dest_buom
OPTIONS(description='Destination Actual Quantity in Stockkeeping Unit - Technical name: NISTM - Component Type: /SCWM/DE_UI_NISTM'),
auom
OPTIONS(description='Alternative Unit of Measure for Stockkeeping Unit - Technical name: ALTME - Component Type: /SCWM/DE_AUNIT'),
act_dest_qnty_auom
OPTIONS(description='Actual Destination Quantity in Alternative Unit - Technical name: NISTA - Component Type: /SCWM/DE_UI_NISTA'),
receipt_fg OPTIONS(description='Receipt flag for counted pallets')) AS WITH WHTREC AS (SELECT client_id,
   lidl_country AS lidl_ctry,
   wh_id,
   tanum AS wh_task_nr,
   trart AS wh_proc_cat,
   docno AS doc_nr,
   doccat AS doc_cat,
   matnr AS prod_nr,
   maktx AS prod_desc,
   confirmed_date AS conf_dt,
   confirmed_time AS conf_tm,
   DATETIME(confirmed_date, confirmed_time) AS conf_ts,
   TIME_TRUNC(confirmed_time, HOUR) AS conf_hr,
   confirmed_by,
   vlenr AS src_hu,
   vltyp AS src_strg_type,
   nlenr AS dest_hu,
   nltyp AS dest_strg_type,
   dwh_created,
   dwh_updated,
   nistm AS act_qty_dest_buom,
   altme AS auom,
   nista AS act_dest_qnty_auom
  FROM ldl_logop_data.t_sapewm_warehousetask
  WHERE CAST(trart AS FLOAT64) = 5
   AND tostat = 'C'
   AND nltyp <> '9996'
   AND docno IS NOT NULL
   AND nlenr IS NOT NULL), WHTREV AS (SELECT client_id,
   lidl_country AS lidl_ctry,
   wh_id,
   tanum AS wh_task_nr,
   trart AS wh_proc_cat,
   docno AS doc_nr,
   doccat AS doc_cat,
   matnr AS prod_nr,
   maktx AS prod_desc,
   confirmed_date AS conf_dt,
   confirmed_time AS conf_tm,
   DATETIME(confirmed_date, confirmed_time) AS conf_ts,
   TIME_TRUNC(confirmed_time, HOUR) AS conf_hr,
   confirmed_by,
   vlenr AS src_hu,
   vltyp AS src_strg_type,
   nlenr AS dest_hu,
   nltyp AS dest_strg_type,
   dwh_created,
   dwh_updated,
   nistm AS act_qty_dest_buom,
   altme AS auom,
   nista AS act_dest_qnty_auom
  FROM ldl_logop_data.t_sapewm_warehousetask
  WHERE CAST(trart AS FLOAT64) = 6
   AND tostat = 'C'
   AND doccat = 'PDI'
   AND docno IS NOT NULL
   AND vlenr IS NOT NULL), RECEIPTS AS (SELECT r.client_id,
   r.lidl_ctry,
   r.wh_id,
   r.wh_task_nr,
   r.wh_proc_cat,
   r.doc_nr,
   r.doc_cat,
   r.prod_nr,
   r.prod_desc,
   r.conf_dt,
   r.conf_tm,
   r.conf_ts,
   r.conf_hr,
   r.confirmed_by,
   r.src_hu,
   r.src_strg_type,
   r.dest_hu,
   r.dest_strg_type,
   r.dwh_created,
   r.dwh_updated,
   r.act_qty_dest_buom,
   r.auom,
   r.act_dest_qnty_auom
  FROM WHTREC AS r
   LEFT JOIN WHTREV AS rev ON r.client_id = rev.client_id AND r.wh_id = rev.wh_id AND r.dest_hu = rev.src_hu AND r.conf_dt
       <= rev.conf_dt AND r.conf_tm <= rev.conf_tm
  WHERE rev.conf_dt IS NULL
   AND r.dest_strg_type <> '9996'
  QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(r.client_id AS STRING), CAST(r.wh_id AS STRING), r.conf_dt, r.dest_hu
      ORDER BY r.conf_tm IS NULL DESC, r.conf_tm DESC)) = 1) (SELECT client_id,
   lidl_ctry,
   wh_id,
   wh_task_nr,
   wh_proc_cat,
   doc_nr,
   doc_cat,
   prod_nr,
   prod_desc,
   conf_dt,
   conf_tm,
   conf_ts,
   conf_hr,
   confirmed_by,
   src_hu,
   src_strg_type,
   dest_hu,
   dest_strg_type,
   dwh_created,
   dwh_updated,
   act_qty_dest_buom,
   auom,
   act_dest_qnty_auom,
   1 AS receipt_fg
  FROM RECEIPTS AS rc);