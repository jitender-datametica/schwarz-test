/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB view			|	v_sapewm_goodsin_stockonlane_kpi
Description		|	SAP EWM Goods In - view with final KPIs for FE
====================================================================================================
*/


CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_sapewm_goodsin_stockonlane_kpi (client_id
OPTIONS(description='Client id (PK)'), lidl_ctry OPTIONS(description='Country code'), wh_id
OPTIONS(description='Warehouse ID (PK)'), wh_task_nr OPTIONS(description='Warehouse Task (PK)'), wh_task_item
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
OPTIONS(description='Putaway flag for picked up palltes'), tm_on_lane_sec
OPTIONS(description='Time of pallets on lane between receipt and putaway in seconds for average and median time'),
cum_pallets_counted
OPTIONS(description='Amount of pallets in receipts cumulated per group of client, warehouse, day, hour and destination storage type'),
cum_pallets_pickedup
OPTIONS(description='Amount of pallets in putaways cumulated per group of client, warehouse, day, hour and destination storage type'),
cum_pallets_on_lane
OPTIONS(description='Amount of pallets on lane cumulated per group of client, warehouse, day, hour and destination storage type'))
AS SELECT *
FROM ldl_logop_fe_mstr_logop.v_sapewm_goodsin_stockonlane_agg;