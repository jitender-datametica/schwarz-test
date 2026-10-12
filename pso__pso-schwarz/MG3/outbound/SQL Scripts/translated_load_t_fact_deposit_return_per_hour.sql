--T_FACT_DEPOSIT_RETURN_PER_HOUR

-- ALTER SESSION SET TRANSACTION_ABORT_ON_ERROR = TRUE;


BEGIN;


-- SELECT CURRENT_TRANSACTION();


CREATE OR REPLACE TABLE szd_production_etl.deposit_return_per_hour_a_${land} LIKE szd_production_core.t_fact_deposit_return_per_hour;


ALTER TABLE szd_production_etl.deposit_return_per_hour_a_${land}
ADD COLUMN IF NOT EXISTS store_id STRING(20);


ALTER TABLE szd_production_etl.deposit_return_per_hour_a_${land}
RENAME COLUMN rvm_sid TO rvm_id;


CREATE OR REPLACE TABLE szd_production_etl.deposit_return_per_hour_b_${land} LIKE szd_production_core.t_fact_deposit_return_per_hour;


/*
copy into SZD_PRODUCTION.ETL.deposit_return_per_hour_a_${land}   from
 (select 
          $1:datastore_data:rvm_id
		  ,to_date(dateadd(microseconds, $1:datastore_data:cal_dt, '1970-01-01'))
		  ,$1:datastore_data:return_hour
		  ,$1:datastore_data:deposit_item_sub_cat_id
		  ,$1:datastore_data:deposit_item_cnt
		  ,CURRENT_TIMESTAMP
		  ,CURRENT_TIMESTAMP
		  ,$1:datastore_data:store

FROM '@DATASTORE.${stage}/${SYSTEMGROUP}/${land}/t_fact_deposit_return_per_hour/${YEAR}/${MONTH}/${DAY}/' src) 
pattern='.*t_fact_deposit_return_per_hour.*\.(avro)$'
file_format = (type = avro)
ON_ERROR = ABORT_STATEMENT;
*/


-- load_id als Prozess-ID im Gegensatz zur context_load_id (falls vorhanden)
 INSERT INTO szd_production_etl.deposit_return_per_hour_b_${land}

(SELECT DISTINCT rvm.rvm_sid,
  src.cal_dt,
  src.return_hour,
  src.deposit_item_sub_cat_id,
  src.deposit_item_cnt,
  src.dwh_created_tmsp,
  src.dwh_updated_tmsp
 FROM szd_production_etl.deposit_return_per_hour_a_${land} AS src
  LEFT JOIN szd_production_etl.rvm_keys AS rvm ON src.rvm_id = rvm.rvm_id AND CAST(src.store_id AS FLOAT64) = rvm.store
 WHERE rvm.rvm_sid IS NOT NULL);


MERGE INTO szd_production_core.t_fact_deposit_return_per_hour AS tgt
USING (SELECT rvm_sid,
  cal_dt,
  return_hour,
  deposit_item_sub_cat_id,
  deposit_item_cnt,
  dwh_created_tmsp,
  dwh_updated_tmsp
 FROM szd_production_etl.deposit_return_per_hour_b_${land}
 WHERE rvm_sid IS NOT NULL) AS src
ON tgt.rvm_sid = src.rvm_sid AND tgt.cal_dt = src.cal_dt AND tgt.return_hour = src.return_hour AND tgt.deposit_item_sub_cat_id
    = src.deposit_item_sub_cat_id AND tgt.deposit_item_cnt = src.deposit_item_cnt
WHEN MATCHED THEN UPDATE SET
 deposit_item_cnt = src.deposit_item_cnt,
 dwh_updated_tmsp = CURRENT_TIMESTAMP()
WHEN NOT MATCHED THEN INSERT VALUES(src.rvm_sid, src.cal_dt, src.return_hour, src.deposit_item_sub_cat_id, src.deposit_item_cnt
 , src.dwh_created_tmsp, CURRENT_TIMESTAMP());


COMMIT TRANSACTION;