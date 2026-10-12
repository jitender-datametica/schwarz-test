-- ALTER SESSION SET TRANSACTION_ABORT_ON_ERROR = TRUE;


BEGIN;


-- SELECT CURRENT_TRANSACTION();


CREATE OR REPLACE TABLE szd_production_etl.deposit_receipt_a_${land} LIKE szd_production_core.t_fact_deposit_receipt;


ALTER TABLE szd_production_etl.deposit_receipt_a_${land}
ADD COLUMN IF NOT EXISTS store_id STRING(20);


ALTER TABLE szd_production_etl.deposit_receipt_a_${land}
RENAME COLUMN rvm_sid TO rvm_id;


CREATE OR REPLACE TABLE szd_production_etl.deposit_receipt_b_${land} LIKE szd_production_core.t_fact_deposit_receipt;


/*
copy into SZD_PRODUCTION.ETL.deposit_receipt_a_${land} from
 (select 
	to_date(dateadd(microseconds, $1:datastore_data:receipt_tm, '1970-01-01'))
	,dateadd(microseconds, src.$1:datastore_data:receipt_tm, '1970-01-01')
        ,substring(dateadd(microseconds, src.$1:datastore_data:receipt_tm, '1970-01-01'),12,2)
        ,$1:datastore_data:rvm_id
        ,$1:datastore_data:deposit_outpayment_type_cd
	,$1:datastore_data:receipt_nr
	,$1:datastore_data:receipt_gross_local_val
	,CURRENT_TIMESTAMP
        ,CURRENT_TIMESTAMP
        ,coalesce($1:datastore_data:receipt_barcode,'-1')
        ,$1:datastore_data:local_curr_cd
        ,$1:datastore_data:receipt_gross_global_val
        ,$1:datastore_data:global_curr_cd
	,$1:datastore_data:store_id
	
FROM '@DATASTORE.${stage}/${SYSTEMGROUP}/${land}/t_fact_deposit_receipt/${YEAR}/${MONTH}/${DAY}/' src) 
pattern='.*deposit_receipt.*\.(avro)$'
file_format = (type = avro)
ON_ERROR = ABORT_STATEMENT

*/


INSERT INTO szd_production_etl.deposit_receipt_b_${land}
(SELECT DISTINCT src.receipt_dt,
  src.receipt_tm,
  src.receipt_hr,
  rvm.rvm_sid,
  src.deposit_outpayment_type_cd,
  src.receipt_nr,
  src.receipt_gross_local_val,
  src.dwh_created_tmsp,
  src.dwh_updated_tmsp,
  src.receipt_barcode,
  src.local_curr_cd,
  src.receipt_gross_global_val,
  src.global_curr_cd
 FROM szd_production_etl.deposit_receipt_a_${land} AS src
  LEFT JOIN szd_production_etl.rvm_keys AS rvm ON src.rvm_id = rvm.rvm_id AND CAST(src.store_id AS FLOAT64) = rvm.store
 WHERE rvm.rvm_sid IS NOT NULL
 QUALIFY (ROW_NUMBER() OVER (PARTITION BY src.receipt_dt, src.receipt_tm, src.receipt_hr, rvm.rvm_sid, src.deposit_outpayment_type_cd
       , src.receipt_nr, CAST(src.receipt_gross_local_val AS STRING), src.receipt_barcode ORDER BY src.dwh_created_tmsp
       IS NULL DESC, src.dwh_created_tmsp DESC)) = 1);


MERGE INTO szd_production_core.t_fact_deposit_receipt AS tgt
USING (SELECT receipt_dt,
  receipt_tm,
  receipt_hr,
  rvm_sid,
  deposit_outpayment_type_cd,
  receipt_nr,
  receipt_gross_local_val,
  dwh_created_tmsp,
  dwh_updated_tmsp,
  receipt_barcode,
  local_curr_cd,
  receipt_gross_global_val,
  global_curr_cd
 FROM szd_production_etl.deposit_receipt_b_${land}
 WHERE rvm_sid IS NOT NULL) AS src
ON tgt.receipt_dt = src.receipt_dt AND tgt.receipt_tm = src.receipt_tm AND tgt.receipt_hr = src.receipt_hr AND tgt.rvm_sid
       = src.rvm_sid AND tgt.deposit_outpayment_type_cd = src.deposit_outpayment_type_cd AND tgt.receipt_nr = src.receipt_nr
     AND tgt.receipt_gross_local_val = src.receipt_gross_local_val AND tgt.receipt_barcode = src.receipt_barcode
WHEN MATCHED THEN UPDATE SET
 dwh_updated_tmsp = CURRENT_TIMESTAMP()
WHEN NOT MATCHED THEN INSERT VALUES(src.receipt_dt, src.receipt_tm, src.receipt_hr, src.rvm_sid, src.deposit_outpayment_type_cd
 , src.receipt_nr, src.receipt_gross_local_val, src.dwh_created_tmsp, CURRENT_TIMESTAMP(), src.receipt_barcode, src.local_curr_cd
 , src.receipt_gross_global_val, src.global_curr_cd);


COMMIT TRANSACTION;