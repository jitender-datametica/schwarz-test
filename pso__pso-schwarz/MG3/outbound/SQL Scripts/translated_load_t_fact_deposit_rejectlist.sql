--t_fact_deposit_rejectlist

-- ALTER SESSION SET TRANSACTION_ABORT_ON_ERROR = TRUE;


BEGIN;


-- SELECT CURRENT_TRANSACTION();


CREATE OR REPLACE TABLE szd_production_etl.deposit_rejectlist_a_${land} LIKE szd_production_core.t_fact_deposit_rejectlist;


ALTER TABLE szd_production_etl.deposit_rejectlist_a_${land}
ADD COLUMN IF NOT EXISTS store_id STRING(20);


ALTER TABLE szd_production_etl.deposit_rejectlist_a_${land}
RENAME COLUMN rvm_sid TO rvm_id;


CREATE OR REPLACE TABLE szd_production_etl.deposit_rejectlist_b_${land} LIKE szd_production_core.t_fact_deposit_rejectlist;


/*
copy into SZD_PRODUCTION.ETL.deposit_rejectlist_a_${land}   from
 (select 
        src.$1:datastore_data:rvm_id,
        to_date(dateadd(microseconds, src.$1:datastore_data:reject_dt, '1970-01-01')),
        to_time(dateadd(microseconds, src.$1:datastore_data:reject_dt, '1970-01-01')),
		src.$1:datastore_data:rejection_reason_group_id,
		src.$1:datastore_data:deposit_item_cat_cd,
        src.$1:datastore_data:ean,
		CURRENT_TIMESTAMP,
		CURRENT_TIMESTAMP,
        src.$1:datastore_data:store_id
        
FROM '@DATASTORE.${stage}/${SYSTEMGROUP}/${land}/t_fact_deposit_rejectlist/${YEAR}/${MONTH}/${DAY}/' src) 
pattern='.*_deposit_rejectlist.*\.(avro)$'
file_format = (type = avro)
ON_ERROR = ABORT_STATEMENT;
*/


-- load_id als Prozess-ID im Gegensatz zur context_load_id (falls vorhanden)
 INSERT INTO szd_production_etl.deposit_rejectlist_b_${land}

(SELECT rvm.rvm_sid,
  src.reject_dt,
  src.reject_tm,
  src.reject_reason_group_id,
  src.deposit_item_cat_cd,
  src.ean,
  src.dwh_created_tmsp,
  src.dwh_updated_tmsp
 FROM szd_production_etl.deposit_rejectlist_a_${land} AS src
  LEFT JOIN szd_production_etl.rvm_keys AS rvm ON src.rvm_id = rvm.rvm_id AND CAST(src.store_id AS FLOAT64) = rvm.store
 WHERE rvm.rvm_sid IS NOT NULL);


MERGE INTO szd_production_core.t_fact_deposit_rejectlist AS tgt
USING (SELECT rvm_sid,
  reject_dt,
  reject_tm,
  reject_reason_group_id,
  deposit_item_cat_cd,
  ean,
  dwh_created_tmsp,
  dwh_updated_tmsp
 FROM szd_production_etl.deposit_rejectlist_b_${land}
 WHERE rvm_sid IS NOT NULL
 QUALIFY (ROW_NUMBER() OVER (PARTITION BY rvm_sid, reject_dt, reject_tm, reject_reason_group_id, deposit_item_cat_cd,
       ean ORDER BY reject_dt IS NULL, reject_dt, reject_tm IS NULL DESC, reject_tm DESC)) = 1) AS t1
ON tgt.rvm_sid = t1.rvm_sid AND tgt.reject_dt = t1.reject_dt AND tgt.reject_reason_group_id = t1.reject_reason_group_id
   AND tgt.deposit_item_cat_cd = t1.deposit_item_cat_cd AND tgt.ean = t1.ean AND tgt.reject_tm = t1.reject_tm
WHEN MATCHED THEN UPDATE SET
 dwh_updated_tmsp = CURRENT_TIMESTAMP()
WHEN NOT MATCHED THEN INSERT VALUES(t1.rvm_sid, t1.reject_dt, t1.reject_tm, t1.reject_reason_group_id, t1.deposit_item_cat_cd
 , t1.ean, CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP());


COMMIT TRANSACTION;