--t_fact_deposit_return_outpayment_2

-- ALTER SESSION SET TRANSACTION_ABORT_ON_ERROR = TRUE;


BEGIN;


-- SELECT CURRENT_TRANSACTION();


CREATE OR REPLACE TABLE szd_production_etl.deposit_return_outpayment_a_$_2{land_2} LIKE szd_production_core.t_fact_deposit_return_outpayment_2;


ALTER TABLE szd_production_etl.deposit_return_outpayment_a_$_2{land_2}
ADD COLUMN IF NOT EXISTS store_id STRING(20);


ALTER TABLE szd_production_etl.deposit_return_outpayment_a_$_2{land_2}
RENAME COLUMN rvm_sid TO rvm_id;


CREATE OR REPLACE TABLE szd_production_etl.deposit_return_outpayment_b_$_2{land_2} LIKE szd_production_core.t_fact_deposit_return_outpayment_2;


/*
copy into SZD_PRODUCTION.ETL.deposit_return_outpayment_a_$_2{land_2} (RVM_ID,CAL_DT,DEPOSIT_ITEM_SUB_CAT_ID,DEPOSIT_OUTPAYMENT_TYPE_CD,RECEIPT_CNT,RECEIPT_GROSS_LOCAL_VAL,DWH_CREATED_TMSP,DWH_UPDATED_TMSP,RECEIPT_GROSS_GLOBAL_VAL,GLOBAL_CURR_CD,LOCAL_CURR_CD,STORE_ID) from
 (select 
    $1:datastore_data:rvm_id
    ,to_date(dateadd(microseconds, $1:datastore_data:cal_dt, '1970-01-01'))
    ,$1:datastore_data:deposit_item_sub_cat_id
    ,$1:datastore_data:deposit_outpayment_type_cd
    ,$1:datastore_data:receipt_cnt
    ,$1:datastore_data:receipt_gross_local_val
    ,CURRENT_TIMESTAMP
    ,CURRENT_TIMESTAMP
    ,$1:datastore_data:receipt_gross_global_val
    ,$1:datastore_data:global_curr_cd
    ,$1:datastore_data:local_curr_cd 
    ,$1:datastore_data:store_id
FROM '@DATASTORE.${stage}/${SYSTEMGROUP}/${land_2}/t_fact_deposit_return_outpayment_2/${YEAR}/${MONTH}/${DAY}/' src) 
pattern='.*deposit_return_outpayment.*\.(avro)$'
file_format = (type = avro)
ON_ERROR = ABORT_STATEMENT

*/


INSERT INTO szd_production_etl.deposit_return_outpayment_b_$_2{land_2} (rvm_sid, cal_dt, deposit_item_sub_cat_id,
 deposit_outpayment_type_cd, receipt_cnt, receipt_gross_local_val, receipt_gross_global_val, global_curr_cd,
 local_curr_cd, dwh_created_tmsp, dwh_updated_tmsp)
(SELECT rvm.rvm_sid,
  src.cal_dt,
  src.deposit_item_sub_cat_id,
  src.deposit_outpayment_type_cd,
  src.receipt_cnt,
  src.receipt_gross_local_val,
  src.receipt_gross_global_val,
  src.global_curr_cd,
  src.local_curr_cd,
  src.dwh_created_tmsp,
  src.dwh_updated_tmsp
 FROM szd_production_etl.deposit_return_outpayment_a_$_2{land_2} AS src
  LEFT JOIN szd_production_etl.rvm_keys_2 AS rvm ON src.rvm_id = rvm.rvm_id AND CAST(src.store_id AS FLOAT64) = rvm.store
 WHERE rvm.rvm_sid IS NOT NULL
 QUALIFY (ROW_NUMBER() OVER (PARTITION BY src.rvm_id, src.store_id, src.cal_dt, src.deposit_item_sub_cat_id, src.deposit_outpayment_type_cd
       , src.receipt_cnt, CAST(src.receipt_gross_local_val AS STRING) ORDER BY src.dwh_created_tmsp IS NULL DESC, src.dwh_created_tmsp
       DESC)) = 1);


MERGE INTO szd_production_core.t_fact_deposit_return_outpayment_2 AS tgt
USING (SELECT rvm_sid,
  cal_dt,
  deposit_item_sub_cat_id,
  deposit_outpayment_type_cd,
  receipt_cnt,
  receipt_gross_local_val,
  dwh_created_tmsp,
  dwh_updated_tmsp,
  receipt_gross_global_val,
  global_curr_cd,
  local_curr_cd
 FROM szd_production_etl.deposit_return_outpayment_b_$_2{land_2}
 WHERE rvm_sid IS NOT NULL) AS src
ON tgt.rvm_sid = src.rvm_sid AND tgt.cal_dt = src.cal_dt AND tgt.deposit_item_sub_cat_id = src.deposit_item_sub_cat_id
   AND tgt.deposit_outpayment_type_cd = src.deposit_outpayment_type_cd AND tgt.receipt_cnt = src.receipt_cnt AND tgt.receipt_gross_local_val
   = src.receipt_gross_local_val
WHEN MATCHED THEN UPDATE SET
 dwh_updated_tmsp = CURRENT_TIMESTAMP()
WHEN NOT MATCHED THEN INSERT VALUES(src.rvm_sid, src.cal_dt, src.deposit_item_sub_cat_id, src.deposit_outpayment_type_cd
 , src.receipt_cnt, src.receipt_gross_local_val, src.receipt_gross_global_val, src.global_curr_cd, src.local_curr_cd,
 src.dwh_created_tmsp, CURRENT_TIMESTAMP());


COMMIT TRANSACTION;