--t_fact_deposit_reject_per_day_1

-- ALTER SESSION SET TRANSACTION_ABORT_ON_ERROR = TRUE;


BEGIN;


-- SELECT CURRENT_TRANSACTION();


CREATE OR REPLACE TABLE szd_production_etl.deposit_reject_per_day_a_$_1{land_1} LIKE szd_production_core.t_fact_deposit_reject_per_day_1;


ALTER TABLE szd_production_etl.deposit_reject_per_day_a_$_1{land_1}
ADD COLUMN IF NOT EXISTS store_id STRING(20);


ALTER TABLE szd_production_etl.deposit_reject_per_day_a_$_1{land_1}
RENAME COLUMN rvm_sid TO rvm_id;


CREATE OR REPLACE TABLE szd_production_etl.deposit_reject_per_day_b_$_1{land_1} LIKE szd_production_core.t_fact_deposit_reject_per_day_1;


/*
copy into SZD_PRODUCTION.ETL.deposit_reject_per_day_a_$_1{land_1}   from 
 (select 
        src.$1:datastore_data:rvm_id,
        to_date(dateadd(microseconds, src.$1:datastore_data:reject_dt, '1970-01-01')),
		src.$1:datastore_data:deposit_item_cat_cd,
		src.$1:datastore_data:reject_cnt,
		CURRENT_TIMESTAMP,
		CURRENT_TIMESTAMP,
        src.$1:datastore_data:store_id
        
FROM '@DATASTORE.${stage}/${SYSTEMGROUP}/${land_1}/t_fact_deposit_reject_per_day_1/${YEAR}/${MONTH}/${DAY}/' src)  
pattern='.*_deposit_reject_per_day.*\.(avro)$'
file_format = (type = avro)
ON_ERROR = ABORT_STATEMENT;
*/


-- load_id als Prozess-ID im Gegensatz zur context_load_id (falls vorhanden)
 INSERT INTO szd_production_etl.deposit_reject_per_day_b_$_1{land_1}

(SELECT rvm.rvm_sid,
  src.reject_dt,
  src.deposit_item_cat_cd,
  src.reject_cnt,
  src.dwh_created_tmsp,
  src.dwh_updated_tmsp
 FROM szd_production_etl.deposit_reject_per_day_a_$_1{land_1} AS src
  LEFT JOIN szd_production_etl.rvm_keys_1 AS rvm ON src.rvm_id = rvm.rvm_id AND CAST(src.store_id AS FLOAT64) = rvm.store
 WHERE rvm.rvm_sid IS NOT NULL);


MERGE INTO szd_production_core.t_fact_deposit_reject_per_day_1 AS tgt
USING (SELECT rvm_sid,
  reject_dt,
  deposit_item_cat_cd,
  reject_cnt,
  dwh_created_tmsp,
  dwh_updated_tmsp
 FROM szd_production_etl.deposit_reject_per_day_b_$_1{land_1}
 WHERE rvm_sid IS NOT NULL
 QUALIFY (ROW_NUMBER() OVER (PARTITION BY rvm_sid, reject_dt, deposit_item_cat_cd ORDER BY reject_dt IS NULL, reject_dt
       , reject_cnt IS NULL DESC, reject_cnt DESC)) = 1) AS t1_1
ON tgt.rvm_sid = t1.rvm_sid AND tgt.reject_dt = t1.reject_dt AND tgt.deposit_item_cat_cd = t1.deposit_item_cat_cd
WHEN MATCHED THEN UPDATE SET
 dwh_updated_tmsp = CURRENT_TIMESTAMP(),
 reject_cnt = t1.reject_cnt
WHEN NOT MATCHED THEN INSERT VALUES(t1.rvm_sid, t1.reject_dt, t1.deposit_item_cat_cd, t1.reject_cnt, CURRENT_TIMESTAMP()
 , CURRENT_TIMESTAMP());


COMMIT TRANSACTION;