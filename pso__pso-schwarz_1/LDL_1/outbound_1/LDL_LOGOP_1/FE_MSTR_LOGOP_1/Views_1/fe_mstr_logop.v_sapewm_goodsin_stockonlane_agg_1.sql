/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB view			|	v_sapewm_goodsin_stockonlane_agg_1
Description		|	SAP EWM Goods In - view with aggregations
====================================================================================================
*/


CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_sapewm_goodsin_stockonlane_agg_1 (client_id
OPTIONS(description='Client id (PK)'), lidl_ctry OPTIONS(description='Country_1 code'), wh_id
OPTIONS(description='Warehouse ID (PK)'), wh_task_nr OPTIONS(description='Warehouse Task (PK)'), wh_task_item
OPTIONS(description='Warehouse Task Item_1 (PK)'), wh_task_stat
OPTIONS(description='Warehouse Task Status_1 - Technical name: TOSTAT - Component Type: /SCWM/DE_TOSTAT'), wh_proc_type
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
OPTIONS(description='Handling Unit_1 Warehouse Task - Technical name: FLGHUTO - Component Type: /SCWM/FLGHUTO'),
src_strg_bin OPTIONS(description='Source Storage Bin - Technical name: VLPLA - Component Type: /SCWM/LTAP_VLPLA'),
src_hu OPTIONS(description='Source Handling Unit_1 - Technical name: VLENR - Component Type: /SCWM/LTAP_VLENR'),
src_strg_type OPTIONS(description='Source Storage Type - Technical name: VLTYP - Component Type: /SCWM/LTAP_VLTYP'),
src_rsrc
OPTIONS(description='Source Resource (Means of Transport or User) - Technical name: SRSRC - Component Type: /SCWM/DE_SRSRC'),
dest_strg_bin OPTIONS(description='Destination Storage Bin - Technical name: NLPLA - Component Type: /SCWM/LTAP_NLPLA'),
dest_hu OPTIONS(description='Destination Handling Unit_1 - Technical name: NLENR - Component Type: /SCWM/LTAP_NLENR'),
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
OPTIONS(description='Amount of pallets on lane cumulated per group of client, warehouse, day, hour and destination storage type'))
AS SELECT client_id,
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
 receipt_fg,
 putaway_fg,
 IF(putaway_fg = 1, TIME_DIFF(LAST_VALUE(conf_tm) OVER (PARTITION BY CAST(client_id AS STRING), CAST(wh_id AS STRING),
      conf_dt, dest_hu ORDER BY conf_tm IS NULL, conf_tm RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING),
   FIRST_VALUE(conf_tm) OVER (PARTITION BY CAST(client_id AS STRING), CAST(wh_id AS STRING), conf_dt, dest_hu ORDER BY
      conf_tm IS NULL, conf_tm RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING), SECOND), NULL) AS
 tm_on_lane_sec,
 IF((RANK() OVER (PARTITION BY CAST(client_id AS STRING), CAST(wh_id AS STRING), conf_dt, conf_hr, dest_strg_type
     ORDER BY conf_tm IS NULL DESC, conf_tm DESC, gr_proc_tm IS NULL DESC, gr_proc_tm DESC, wh_task_nr IS NULL,
       wh_task_nr)) = 1, SUM(receipt_fg) OVER (PARTITION BY CAST(client_id AS STRING), CAST(wh_id AS STRING), conf_dt,
     dest_strg_type ORDER BY conf_tm IS NULL, conf_tm ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW), NULL) AS
 cum_pallets_counted,
 IF((RANK() OVER (PARTITION BY CAST(client_id AS STRING), CAST(wh_id AS STRING), conf_dt, conf_hr, dest_strg_type
     ORDER BY conf_tm IS NULL DESC, conf_tm DESC, gr_proc_tm IS NULL DESC, gr_proc_tm DESC, wh_task_nr IS NULL,
       wh_task_nr)) = 1, SUM(putaway_fg) OVER (PARTITION BY CAST(client_id AS STRING), CAST(wh_id AS STRING), conf_dt,
     dest_strg_type ORDER BY conf_tm IS NULL, conf_tm, gr_proc_tm IS NULL, gr_proc_tm ROWS BETWEEN UNBOUNDED PRECEDING
   AND CURRENT ROW), NULL) AS cum_pallets_pickedup,
  IF((RANK() OVER (PARTITION BY CAST(client_id AS STRING), CAST(wh_id AS STRING), conf_dt, conf_hr, dest_strg_type
      ORDER BY conf_tm IS NULL DESC, conf_tm DESC, gr_proc_tm IS NULL DESC, gr_proc_tm DESC, wh_task_nr IS NULL,
        wh_task_nr)) = 1, SUM(receipt_fg) OVER (PARTITION BY CAST(client_id AS STRING), CAST(wh_id AS STRING), conf_dt,
      dest_strg_type ORDER BY conf_tm IS NULL, conf_tm ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW), NULL) - IF((RANK()
     OVER (PARTITION BY CAST(client_id AS STRING), CAST(wh_id AS STRING), conf_dt, conf_hr, dest_strg_type ORDER BY
        conf_tm IS NULL DESC, conf_tm DESC, gr_proc_tm IS NULL DESC, gr_proc_tm DESC, wh_task_nr IS NULL, wh_task_nr)) =
    1, SUM(putaway_fg) OVER (PARTITION BY CAST(client_id AS STRING), CAST(wh_id AS STRING), conf_dt, dest_strg_type
    ORDER BY conf_tm IS NULL, conf_tm, gr_proc_tm IS NULL, gr_proc_tm ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
   , NULL) AS cum_pallets_on_lane
FROM ldl_logop_fe_mstr_logop.v_sapewm_goodsin_stockonlane_add_1;