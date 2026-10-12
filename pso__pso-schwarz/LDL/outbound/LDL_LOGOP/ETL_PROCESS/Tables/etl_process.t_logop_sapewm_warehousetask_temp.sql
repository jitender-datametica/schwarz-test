/*
====================================================================================================
Division:           Lidl
Solution:           Operational Logistics (LOGOP)
DB schema:          etl_process
DB table/view:      t_logop_sapewm_warehousetask_temp
====================================================================================================
Change history:     version, date, developer, comment
    1.0     2021-11-03      Fikri Tekin             Initial version
====================================================================================================
*/


/*
----------------------------------------------------------------------------------------------------
    Table t_logop_sapewm_warehousetask_temp for SAP EWM warehouse tasks
----------------------------------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_logop_etl_process.t_logop_sapewm_warehousetask_temp (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Client id - calculated based on the country code'),
lidl_country STRING(3) NOT NULL OPTIONS(description='Country code. Original field name bic_zmlila'),
source_system STRING(30) NOT NULL OPTIONS(description='Source system'),
wh_nr STRING(5) NOT NULL
OPTIONS(description='Warehouse Number/Warehouse Complex - Technical name: LGNUM - Component Type: /SCWM/LGNUM'),
wh_task_nr BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Warehouse Task - Technical name: TANUM - Component Type: /SCWM/TANUM'),
wh_task_item BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Warehouse Task Item - Technical name: TAPOS - Component Type: /SCWM/TAPOS'),
hu_flg BOOL
OPTIONS(description='Handling Unit Warehouse Task - Technical name: FLGHUTO - Component Type: /SCWM/FLGHUTO'),
wh_process_type STRING(4)
OPTIONS(description='Warehouse Process Type - Technical name: PROCTY - Component Type: /SCWM/DE_PROCTY'),
wh_process_cat STRING(1)
OPTIONS(description='Warehouse Process Category - Technical name: TRART - Component Type: /SCWM/LVS_TRART'),
activity_type STRING(4) OPTIONS(description='Activity - Technical name: ACT_TYPE - Component Type: /SCWM/DE_ACTTY'),
product_nr STRING(40) OPTIONS(description='Product - Technical name: MATNR - Component Type: /SCWM/DE_MATNR'),
prod_desc STRING(40)
OPTIONS(description='Product Short Description - Technical name: MAKTX - Component Type: /SCWM/DE_UI_MAKTX'),
crtd_by STRING(12) OPTIONS(description='Created By - Technical name: CREATED_BY - Component Type: /SCWM/DE_CREATOR'),
crtd_on_dt DATE OPTIONS(description='Created On - Technical name: CREATED_DATE - Component Type: /SCWM/DE_CREATED_DATE'),
crtd_at_tm TIME OPTIONS(description='Created At - Technical name: CREATED_TIME - Component Type: /SCWM/DE_CREATED_TIME'),
confirmed_by STRING(12)
OPTIONS(description='Confirmed by - Technical name: CONFIRMED_BY - Component Type: /SCWM/DE_CONFIRMEDBY'),
confirmed_dt DATE
OPTIONS(description='Confirmation Date - Technical name: CONFIRMED_DATE - Component Type: /SCWM/DE_CONFIRMED_DATE'),
confirmed_tm TIME
OPTIONS(description='Confirmation Time - Technical name: CONFIRMED_TIME - Component Type: /SCWM/DE_CONFIRMED_TIME'),
wh_task_stat STRING(1)
OPTIONS(description='Warehouse Task Status - Technical name: TOSTAT - Component Type: /SCWM/DE_TOSTAT'),
who_nr BIGNUMERIC(38,0)
OPTIONS(description='Warehouse Order Number - Technical name: WHO - Component Type: /SCWM/DE_WHO'),
queue STRING(10) OPTIONS(description='Queue - Technical name: QUEUE - Component Type: /SCWM/DE_QUEUE'),
src_tgt_qnty_buom BIGNUMERIC(38,3)
OPTIONS(description='Source Target Quantity in Base Unit of Measure - Technical name: VSOLM - Component Type: /SCWM/DE_UI_VSOLM'),
dest_diff_qnty_buom BIGNUMERIC(38,3)
OPTIONS(description='Destination Difference Quantity in Base Unit of Measure - Technical name: DMENG - Component Type: /SCWM/DE_UI_NDIFM'),
buom STRING(12) OPTIONS(description='Base Unit of Measure - Technical name: MEINS - Component Type: MEINS'),
src_tgt_qnty_auom BIGNUMERIC(38,3)
OPTIONS(description='Source Target Quantity in Alternate Unit of Measure - Technical name: VSOLA - Component Type: /SCWM/DE_UI_VSOLA'),
act_dest_qnty_auom BIGNUMERIC(38,3)
OPTIONS(description='Actual Destination Quantity in Alternative Unit - Technical name: NISTA - Component Type: /SCWM/DE_UI_NISTA'),
dest_diff_qnty_auom BIGNUMERIC(38,3)
OPTIONS(description='Destination Difference Qty in Alternative Unit - Technical name: DMENA - Component Type: /SCWM/DE_UI_NDIFA'),
exception_cd STRING(4)
OPTIONS(description='Exception Code - Technical name: EXCCODE - Component Type: /SCWM/DE_EXCCODE'),
src_strg_bin STRING(18)
OPTIONS(description='Source Storage Bin - Technical name: VLPLA - Component Type: /SCWM/LTAP_VLPLA'),
src_rsrc STRING(18)
OPTIONS(description='Source Resource (Means of Transport or User) - Technical name: SRSRC - Component Type: /SCWM/DE_SRSRC'),
src_hu STRING(20) OPTIONS(description='Source Handling Unit - Technical name: VLENR - Component Type: /SCWM/LTAP_VLENR'),
dest_strg_type STRING(4)
OPTIONS(description='Destination Storage Type - Technical name: NLTYP - Component Type: /SCWM/LTAP_NLTYP'),
dest_strg_bin STRING(18)
OPTIONS(description='Destination Storage Bin - Technical name: NLPLA - Component Type: /SCWM/LTAP_NLPLA'),
dest_rsrc STRING(18)
OPTIONS(description='Destination Resource (Means of Transport or User) - Technical name: DRSRC - Component Type: /SCWM/DE_DRSRC'),
dest_hu STRING(20)
OPTIONS(description='Destination Handling Unit - Technical name: NLENR - Component Type: /SCWM/LTAP_NLENR'),
src_strg_type STRING(4)
OPTIONS(description='Source Storage Type - Technical name: VLTYP - Component Type: /SCWM/LTAP_VLTYP'),
ext_strg_procs_step STRING(4)
OPTIONS(description='External Storage Process Step - Technical name: PROCS - Component Type: /SCWM/DE_PROCS'),
wave BIGNUMERIC(38,0) OPTIONS(description='Wave - Technical name: WAVE - Component Type: /SCWM/DE_WAVE'),
start_dt DATE OPTIONS(description='Start Date - Technical name: STARTED_DATE - Component Type: /SCWM/DE_STARTED_DATE'),
start_tm TIME OPTIONS(description='Start Time - Technical name: STARTED_TIME - Component Type: /SCWM/DE_STARTED_TIME'),
owner_id STRING(10) OPTIONS(description='Owner - Technical name: OWNER - Component Type: /SCWM/DE_OWNER'),
doc_nr STRING(35) OPTIONS(description='Document - Technical name: DOCNO - Component Type: /SCWM/SP_DOCNO_INT'),
activity_area STRING(4) OPTIONS(description='Activity Area - Technical name: AAREA - Component Type: /SCWM/DE_AAREA'),
who_seq BIGNUMERIC(38,6)
OPTIONS(description='Internal Sequence of Warehouse Order - Technical name: WHOSEQ - Component Type: /SCWM/DE_WHOSEQ_UI'),
hu_type STRING(4) OPTIONS(description='Handling Unit Type - Technical name: LETYP - Component Type: /SCWM/DE_HUTYP'),
shelf_life_exp_dt DATE
OPTIONS(description='Shelf Life Expiration Date - Technical name: VFDAT - Component Type: /SCWM/SLED'),
goods_recpt_dt DATE
OPTIONS(description='Goods Receipt Date - Technical name: GRDATE - Component Type: /SCWM/DE_GR_DATE'),
goods_recpt_procs_tm TIME
OPTIONS(description='Goods Receipt Processing Time - Technical name: GRTIME - Component Type: /SCWM/DE_GR_TIME'),
load_volume BIGNUMERIC(38,3)
OPTIONS(description='Loading or Net Volume - Technical name: VOLUM - Component Type: /SCWM/DE_NVOLUME'),
vol_unit STRING(3) OPTIONS(description='Volume Unit - Technical name: UNIT_V - Component Type: /SCWM/DE_VOL_UOM'),
load_weight BIGNUMERIC(38,3)
OPTIONS(description='Loading or Net Weight - Technical name: WEIGHT - Component Type: /SCWM/DE_NWEIGHT'),
weight_unit STRING(3) OPTIONS(description='Weight Unit - Technical name: UNIT_W - Component Type: /SCWM/DE_WGT_UOM'),
auom STRING(3)
OPTIONS(description='Alternative Unit of Measure for Stockkeeping Unit - Technical name: ALTME - Component Type: /SCWM/DE_AUNIT'),
act_qty_dest_buom BIGNUMERIC(38,3)
OPTIONS(description='Destination Actual Quantity in Stockkeeping Unit - Technical name: NISTM - Component Type: /SCWM/DE_UI_NISTM'),
doc_cat STRING(3)
OPTIONS(description='Document Category for Document-Related Stocks - Technical name: QDOCCAT - Component Type: /SCWM/DE_UI_QDOCCAT'),
doc_nr_stock_ref STRING(35)
OPTIONS(description='Document Number for Stock Reference - Technical name: QDOCNO - Component Type: /SCWM/DE_QDOCNO_MON'),
extraction_ts DATETIME NOT NULL OPTIONS(description='Extraction timestamp'),
extraction_dt DATE NOT NULL OPTIONS(description='Extraction date'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Load id'),
update_mode STRING(2) NOT NULL OPTIONS(description='update_mode'),
avro_file_name STRING(1000) NOT NULL OPTIONS(description='Name of avro file'),
dwh_created DATETIME NOT NULL OPTIONS(description='Record created at'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Record updated at'),
PRIMARY KEY (wh_nr, wh_task_nr, wh_task_item) NOT ENFORCED
) OPTIONS(description='Warehouse tasks for the BI Reporting');