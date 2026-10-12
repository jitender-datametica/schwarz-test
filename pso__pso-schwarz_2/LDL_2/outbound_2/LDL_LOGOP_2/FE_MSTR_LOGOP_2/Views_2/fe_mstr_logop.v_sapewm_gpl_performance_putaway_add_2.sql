/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB table/view	|	v_sapewm_gpl_performance_putaway_add_2
Description		|	SAP EWM Gruppenleiter Dahsboard Putaway - view with additional columns
====================================================================================================
*/


CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_sapewm_gpl_performance_putaway_add_2 (client_id
OPTIONS(description='Client id (PK)'), lidl_ctry OPTIONS(description='Country_2 code (PK)'), wh_id
OPTIONS(description='Warehouse ID'), wh_task_nr OPTIONS(description='Warehouse Task (PK)'), wh_task_item
OPTIONS(description='Warehouse Task Item_2 (PK)'), wh_task_stat
OPTIONS(description='Warehouse Task Status_2 - Technical name: TOSTAT - Component Type: /SCWM/DE_TOSTAT'), wh_proc_type
OPTIONS(description='Warehouse Process Type - Technical name: PROCTY - Component Type: /SCWM/DE_PROCTY'), wh_proc_cat
OPTIONS(description='Warehouse Process Category - Technical name: TRART - Component Type: /SCWM/LVS_TRART'), doc_nr
OPTIONS(description='Document - Technical name: DOCNO - Component Type: /SCWM/SP_DOCNO_INT'), doc_cat
OPTIONS(description='Document Category for Document-Related Stocks - Technical name: QDOCCAT - Component Type: /SCWM/DE_UI_QDOCCAT'),
prod_nr OPTIONS(description='Product - Technical name: MATNR - Component Type: /SCWM/DE_MATNR'), prod_desc
OPTIONS(description='Product Short Description - Technical name: MAKTX - Component Type: /SCWM/DE_UI_MAKTX'), conf_dt
OPTIONS(description='Confirmation Date - Technical name: CONFIRMED_DATE - Component Type: /SCWM/DE_CONFIRMED_DATE'),
conf_tm
OPTIONS(description='Confirmation Time - Technical name: CONFIRMED_TIME - Component Type: /SCWM/DE_CONFIRMED_TIME'),
curr_tm OPTIONS(description='Matches the current hour'), conf_ts OPTIONS(description='Confirmation timestamp'), conf_hr
OPTIONS(description='Confirmation hour'), hu_fg
OPTIONS(description='Handling Unit_2 Warehouse Task - Technical name: FLGHUTO - Component Type: /SCWM/FLGHUTO'),
src_strg_bin OPTIONS(description='Source Storage Bin - Technical name: VLPLA - Component Type: /SCWM/LTAP_VLPLA'),
src_hu OPTIONS(description='Source Handling Unit_2 - Technical name: VLENR - Component Type: /SCWM/LTAP_VLENR'), hu_type
OPTIONS(description='Type of HU'), hu_size OPTIONS(description='EP value of HU'), rsrc_type
OPTIONS(description='Type of resource'), queue OPTIONS(description='Queue'), src_strg_type
OPTIONS(description='Source Storage Type - Technical name: VLTYP - Component Type: /SCWM/LTAP_VLTYP'), src_rsrc
OPTIONS(description='Source Resource (Means of Transport or User) - Technical name: SRSRC - Component Type: /SCWM/DE_SRSRC'),
dest_strg_bin OPTIONS(description='Destination Storage Bin - Technical name: NLPLA - Component Type: /SCWM/LTAP_NLPLA'),
dest_hu OPTIONS(description='Destination Handling Unit_2 - Technical name: NLENR - Component Type: /SCWM/LTAP_NLENR'),
owner OPTIONS(description='Owner - Technical name: OWNER - Component Type: /SCWM/DE_OWNER'), dest_strg_type
OPTIONS(description='Destination Storage Type - Technical name: NLTYP - Component Type: /SCWM/LTAP_NLTYP'), dest_rsrc
OPTIONS(description='Destination Resource (Means of Transport or User) - Technical name: DRSRC - Component Type: /SCWM/DE_DRSRC'),
gr_dt OPTIONS(description='Goods Receipt Date - Technical name: GRDATE - Component Type: /SCWM/DE_GR_DATE'), gr_proc_tm
OPTIONS(description='Goods Receipt Processing Time - Technical name: GRTIME - Component Type: /SCWM/DE_GR_TIME'),
dwh_created OPTIONS(description='Record created at'), dwh_updated OPTIONS(description='Record updated at'), receipt_fg
OPTIONS(description='Receipt flag for counted pallets'), putaway_fg
OPTIONS(description='Putaway flag for picked up palltes'), tm_on_lane_sec
OPTIONS(description='Time of pallets on lane between receipt and putaway in seconds for average and median time'),
cum_pallets_counted
OPTIONS(description='Amount of pallets in receipts cumulated per group of client, warehouse, day, hour and destination storage type'),
cum_pallets_pickedup
OPTIONS(description='Amount of pallets in putaways cumulated per group of client, warehouse, day, hour and destination storage type'),
cum_pallets_on_lane
OPTIONS(description='Amount of pallets on lane cumulated per group of client, warehouse, day, hour and destination storage type'),
open_ptwy OPTIONS(description='Open_ptwy KPI (placeholder)'), open_ptwy_per_hour
OPTIONS(description='Open_ptwy KPI per Hour (placeholder)'), nums
OPTIONS(description='Amount of hours since the start of the day (placeholder)'), time_on_lane_m_h
OPTIONS(description='Average time of lane per minute (based on this day, placeholder)'))
OPTIONS(DESCRIPTION = `SAP EWM PERFORMANCE PUTAWAY VIEW (BASED ON V_SAPEWM_WHTASK_2)`) AS WITH WHTREC AS (SELECT client_id
   ,
   lidl_country AS lidl_ctry,
   wh_id,
   tanum AS wh_task_nr,
   tapos AS wh_task_item,
   tostat AS wh_task_stat,
   procty AS wh_proc_type,
   trart AS wh_proc_cat,
   docno AS doc_nr,
   qdoccat AS doc_cat,
   matnr AS prod_nr,
   maktx AS prod_desc,
   confirmed_date AS conf_dt,
   confirmed_time AS conf_tm,
   DATETIME(confirmed_date, confirmed_time) AS conf_ts,
   TIME_TRUNC(confirmed_time, HOUR) AS conf_hr,
   flghuto AS hu_fg,
   vlpla AS src_strg_bin,
   vlenr AS src_hu,
   zz_settype AS hu_type,
    CASE
    WHEN LEFT(zz_settype, 2) = 'EP'
    THEN 1
    WHEN LEFT(zz_settype, 2) = 'DD'
    THEN 0.5
    WHEN LEFT(zz_settype, 2) = 'QP'
    THEN 0.25
    WHEN LEFT(zz_settype, 2) = 'IP'
    THEN 1
    WHEN LEFT(zz_settype, 2) = 'AE'
    THEN 1
    WHEN LEFT(zz_settype, 2) = 'SG'
    THEN 1
    WHEN LEFT(zz_settype, 2) = 'HG'
    THEN 0.5
    WHEN LEFT(zz_settype, 2) = 'QG'
    THEN 0.25
    ELSE 0
    END AS hu_size,
   drsrc AS dest_rsrc,
   srsrc AS src_rsrc,
   COALESCE(drsrc, srsrc) AS rsrc,
    CASE
    WHEN LEFT(COALESCE(drsrc, srsrc), 1) = '1'
    THEN 'FAMO'
    WHEN LEFT(COALESCE(drsrc, srsrc), 1) = '2'
    THEN 'FORK'
    WHEN LEFT(COALESCE(drsrc, srsrc), 1) = '3'
    THEN 'FAMO'
    WHEN LEFT(COALESCE(drsrc, srsrc), 1) = ''
    THEN 'No Resource'
    ELSE 'Unknown'
    END AS rsrc_type,
   queue,
   vltyp AS src_strg_type,
   nlpla AS dest_strg_bin,
   nlenr AS dest_hu,
   IF(client_id = 10 AND wh_id = 7, owner, 'Not Applicable') AS owner,
   nltyp AS dest_strg_type,
   grdate AS gr_dt,
   grtime AS gr_proc_tm,
   dwh_created,
   dwh_updated
  FROM ldl_logop_data.t_sapewm_warehousetask_2
  WHERE CAST(trart AS FLOAT64) = 5
   AND tostat = 'C'
   AND confirmed_date >= CAST(CAST(DATETIME_ADD(CAST(CURRENT_TIMESTAMP() AS DATETIME), INTERVAL - 1 MONTH) AS
      TIMESTAMP) AS DATE)
   AND docno IS NOT NULL
   AND nlenr IS NOT NULL), WHTREV AS (SELECT client_id,
   lidl_country AS lidl_ctry,
   wh_id,
   tostat AS wh_task_stat,
   trart AS wh_proc_cat,
   qdoccat AS doc_cat,
   docno AS doc_nr,
   confirmed_date AS conf_dt,
   vlenr AS src_hu,
   zz_settype AS hu_type,
    CASE
    WHEN LEFT(zz_settype, 2) = 'EP'
    THEN 1
    WHEN LEFT(zz_settype, 2) = 'DD'
    THEN 0.5
    WHEN LEFT(zz_settype, 2) = 'QP'
    THEN 0.25
    WHEN LEFT(zz_settype, 2) = 'IP'
    THEN 1
    WHEN LEFT(zz_settype, 2) = 'AE'
    THEN 1
    WHEN LEFT(zz_settype, 2) = 'SG'
    THEN 1
    WHEN LEFT(zz_settype, 2) = 'HG'
    THEN 0.5
    WHEN LEFT(zz_settype, 2) = 'QG'
    THEN 0.25
    ELSE 0
    END AS hu_size,
   drsrc AS dest_rsrc,
   srsrc AS src_rsrc,
   COALESCE(drsrc, srsrc) AS rsrc,
    CASE
    WHEN LEFT(COALESCE(drsrc, srsrc), 1) = '1'
    THEN 'FAMO'
    WHEN LEFT(COALESCE(drsrc, srsrc), 1) = '2'
    THEN 'FORK'
    WHEN LEFT(COALESCE(drsrc, srsrc), 1) = '3'
    THEN 'FAMO'
    WHEN LEFT(COALESCE(drsrc, srsrc), 1) = ''
    THEN 'No Resource'
    ELSE 'Unknown'
    END AS rsrc_type,
   queue,
   confirmed_time AS conf_tm
  FROM ldl_logop_data.t_sapewm_warehousetask_2
  WHERE CAST(trart AS FLOAT64) = 6
   AND tostat = 'C'
   AND qdoccat = 'PDI'
   AND confirmed_date >= CAST(CAST(DATETIME_ADD(CAST(CURRENT_TIMESTAMP() AS DATETIME), INTERVAL - 1 MONTH) AS
      TIMESTAMP) AS DATE)
   AND docno IS NOT NULL
   AND vlenr IS NOT NULL), RECEIPTS AS (SELECT r.client_id,
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
   r.hu_type,
   r.hu_size,
   r.rsrc,
   r.rsrc_type,
   r.queue,
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
   wh_id,
   tanum AS wh_task_nr,
   tapos AS wh_task_item,
   tostat AS wh_task_stat,
   procty AS wh_proc_type,
   trart AS wh_proc_cat,
   docno AS doc_nr,
   qdoccat AS doc_cat,
   matnr AS prod_nr,
   maktx AS prod_desc,
   confirmed_date AS conf_dt,
   confirmed_time AS conf_tm,
   DATETIME(confirmed_date, confirmed_time) AS conf_ts,
   TIME_TRUNC(confirmed_time, HOUR) AS conf_hr,
   flghuto AS hu_fg,
   vlpla AS src_strg_bin,
   vlenr AS src_hu,
   zz_settype AS hu_type,
    CASE
    WHEN LEFT(zz_settype, 2) = 'EP'
    THEN 1
    WHEN LEFT(zz_settype, 2) = 'DD'
    THEN 0.5
    WHEN LEFT(zz_settype, 2) = 'QP'
    THEN 0.25
    WHEN LEFT(zz_settype, 2) = 'IP'
    THEN 1
    WHEN LEFT(zz_settype, 2) = 'AE'
    THEN 1
    WHEN LEFT(zz_settype, 2) = 'SG'
    THEN 1
    WHEN LEFT(zz_settype, 2) = 'HG'
    THEN 0.5
    WHEN LEFT(zz_settype, 2) = 'QG'
    THEN 0.25
    ELSE 0
    END AS hu_size,
   drsrc AS dest_rsrc,
   srsrc AS src_rsrc,
   COALESCE(drsrc, srsrc) AS rsrc,
    CASE
    WHEN LEFT(COALESCE(drsrc, srsrc), 1) = '1'
    THEN 'FAMO'
    WHEN LEFT(COALESCE(drsrc, srsrc), 1) = '2'
    THEN 'FORK'
    WHEN LEFT(COALESCE(drsrc, srsrc), 1) = '3'
    THEN 'FAMO'
    WHEN LEFT(COALESCE(drsrc, srsrc), 1) = ''
    THEN 'No Resource'
    ELSE 'Unknown'
    END AS rsrc_type,
   queue,
   vltyp AS src_strg_type,
   nlpla AS dest_strg_bin,
   nlenr AS dest_hu,
   IF(client_id = 10 AND wh_id = 7, owner, 'Not Applicable') AS owner,
   nltyp AS dest_strg_type,
   grdate AS gr_dt,
   grtime AS gr_proc_tm,
   dwh_created,
   dwh_updated
  FROM ldl_logop_data.t_sapewm_warehousetask_2
  WHERE tostat = 'C'
   AND (CAST(trart AS FLOAT64) = 1 OR CAST(trart AS FLOAT64) = 3 AND procty IN ('3050', '9999'))
   AND IFNULL(qdoccat, '') <> 'PDO'
   AND LEFT(vltyp, 1) IN ('9', 'D', 'W')
   AND LEFT(IFNULL(nltyp, ''), 1) <> 'W'
   AND confirmed_date >= CAST(CAST(DATETIME_ADD(CAST(CURRENT_TIMESTAMP() AS DATETIME), INTERVAL - 1 MONTH) AS
      TIMESTAMP) AS DATE)
   AND nlenr IS NOT NULL
  QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(client_id AS STRING), CAST(wh_id AS STRING), confirmed_date, vlenr
      ORDER BY confirmed_time IS NULL DESC, confirmed_time DESC)) = 1), CONS AS (SELECT client_id,
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
    hu_type,
    hu_size,
    rsrc,
    rsrc_type,
    queue,
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
    t19.hu_type,
    t19.hu_size,
    t19.rsrc,
    t19.rsrc_type,
    t19.queue,
    t19.src_strg_type,
    t19.src_rsrc,
    t19.dest_strg_bin,
    t19.dest_hu,
    t19.owner,
    t19.dest_strg_type,
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
   QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(t19.client_id AS STRING), CAST(t19.wh_id AS STRING), t19.src_hu, t19.prod_nr
         , t19.gr_dt ORDER BY t19.conf_dt IS NULL, t19.conf_dt, t19.conf_tm IS NULL, t19.conf_tm)) = 1), CTE_PROP AS (SELECT
   client_id,
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
   hu_type,
   hu_size,
   rsrc_type,
   queue,
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
   receipt_fg,
   putaway_fg,
   IF(putaway_fg = 1, TIME_DIFF(LAST_VALUE(conf_tm) OVER (PARTITION BY CAST(client_id AS STRING), CAST(wh_id AS STRING)
        , conf_dt, dest_hu ORDER BY conf_tm IS NULL, conf_tm RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
     , FIRST_VALUE(conf_tm) OVER (PARTITION BY CAST(client_id AS STRING), CAST(wh_id AS STRING), conf_dt, dest_hu
      ORDER BY conf_tm IS NULL, conf_tm RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING), SECOND), NULL) AS
   tm_on_lane_sec,
   IF((RANK() OVER (PARTITION BY CAST(client_id AS STRING), CAST(wh_id AS STRING), conf_dt, conf_hr, dest_strg_type
       ORDER BY conf_tm IS NULL DESC, conf_tm DESC, gr_proc_tm IS NULL DESC, gr_proc_tm DESC, wh_task_nr IS NULL,
         wh_task_nr)) = 1, SUM(receipt_fg) OVER (PARTITION BY CAST(client_id AS STRING), CAST(wh_id AS STRING), conf_dt
       , dest_strg_type ORDER BY conf_tm IS NULL, conf_tm ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW), NULL) AS
   cum_pallets_counted,
   IF((RANK() OVER (PARTITION BY CAST(client_id AS STRING), CAST(wh_id AS STRING), conf_dt, conf_hr, dest_strg_type
       ORDER BY conf_tm IS NULL DESC, conf_tm DESC, gr_proc_tm IS NULL DESC, gr_proc_tm DESC, wh_task_nr IS NULL,
         wh_task_nr)) = 1, SUM(putaway_fg) OVER (PARTITION BY CAST(client_id AS STRING), CAST(wh_id AS STRING), conf_dt
       , dest_strg_type ORDER BY conf_tm IS NULL, conf_tm, gr_proc_tm IS NULL, gr_proc_tm ROWS BETWEEN
     UNBOUNDED PRECEDING AND CURRENT ROW), NULL) AS cum_pallets_pickedup,
    IF((RANK() OVER (PARTITION BY CAST(client_id AS STRING), CAST(wh_id AS STRING), conf_dt, conf_hr, dest_strg_type
        ORDER BY conf_tm IS NULL DESC, conf_tm DESC, gr_proc_tm IS NULL DESC, gr_proc_tm DESC, wh_task_nr IS NULL,
          wh_task_nr)) = 1, SUM(receipt_fg) OVER (PARTITION BY CAST(client_id AS STRING), CAST(wh_id AS STRING), conf_dt
        , dest_strg_type ORDER BY conf_tm IS NULL, conf_tm ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW), NULL) - IF((RANK()
       OVER (PARTITION BY CAST(client_id AS STRING), CAST(wh_id AS STRING), conf_dt, conf_hr, dest_strg_type ORDER BY
          conf_tm IS NULL DESC, conf_tm DESC, gr_proc_tm IS NULL DESC, gr_proc_tm DESC, wh_task_nr IS NULL, wh_task_nr)
       ) = 1, SUM(putaway_fg) OVER (PARTITION BY CAST(client_id AS STRING), CAST(wh_id AS STRING), conf_dt,
        dest_strg_type ORDER BY conf_tm IS NULL, conf_tm, gr_proc_tm IS NULL, gr_proc_tm ROWS BETWEEN
      UNBOUNDED PRECEDING AND CURRENT ROW), NULL) AS cum_pallets_on_lane,
     (SUM(receipt_fg) OVER (PARTITION BY CAST(client_id AS STRING), CAST(wh_id AS STRING) ORDER BY conf_hr IS NULL,
        conf_hr RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)) - (SUM(putaway_fg) OVER (PARTITION BY CAST(client_id AS STRING)
        , CAST(wh_id AS STRING) ORDER BY conf_hr IS NULL, conf_hr RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)) AS
   open_ptwy,
   EXTRACT(HOUR FROM CURRENT_TIMESTAMP()) AS nums
  FROM CONS) (SELECT client_id,
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
   IF(SUBSTR(SUBSTR(SAFE_CAST(conf_tm as STRING), 1, 8), 2, 1) = SUBSTR(SUBSTR(SAFE_CAST(EXTRACT(HOUR FROM
         CURRENT_TIMESTAMP()) as STRING), 1, 19), 1, 1), 0, 1) AS curr_tm,
   conf_ts,
   conf_hr,
   hu_fg,
   src_strg_bin,
   src_hu,
   hu_type,
   hu_size,
   rsrc_type,
    CASE
    WHEN queue IN ('INB_AMB', 'INB_BULK', 'INB_NF', 'INB1_AMB', 'INB1_CHAMB', 'INB1_PROMO', 'INB2_AMB', 'INB2_CHAMB',
      'INB2_NF', 'INB2_PROMO', 'INB3_AMB')
    THEN 'Ambient'
    WHEN queue IN ('INB_CHL', 'INB_CHLBK', 'INB_MILK', 'INB1_CHL', 'INB2_CHL')
    THEN 'Chiller'
    WHEN queue IN ('INB_F+V', 'INB1_F+V', 'INB1_PRD', 'INB3_F+V')
    THEN 'Fruit and Veg'
    WHEN queue IN ('INB_FRZ', 'INB_FRZBK', 'INB1_FRZ', 'INB2_FRZ')
    THEN 'Freezer'
    WHEN queue IN ('INB_MPF', 'INB1_MPF', 'INB3_MPF')
    THEN 'Meat,Poultry & Fish'
    ELSE NULL
    END AS queue,
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
   receipt_fg,
   putaway_fg,
   tm_on_lane_sec,
   cum_pallets_counted,
   cum_pallets_pickedup,
   cum_pallets_on_lane,
   open_ptwy,
    open_ptwy / nums AS open_ptwy_per_hour,
   nums,
      (SUM(tm_on_lane_sec) OVER (RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) / 60 / nums AS
   time_on_lane_m_h
  FROM CTE_PROP AS t25);