--T_FACT_DEPOSIT_RVM_CLEANING
-- ALTER SESSION SET TRANSACTION_ABORT_ON_ERROR = TRUE;


BEGIN;


-- SELECT CURRENT_TRANSACTION();


CREATE OR REPLACE TABLE szd_production_etl.rvm_cleaning_a_$_1{land_1} LIKE szd_production_core.t_fact_rvm_cleaning_1;


ALTER TABLE szd_production_etl.rvm_cleaning_a_$_1{land_1}
ADD COLUMN IF NOT EXISTS store_id STRING(20);


ALTER TABLE szd_production_etl.rvm_cleaning_a_$_1{land_1}
RENAME COLUMN rvm_sid TO rvm_id;


CREATE OR REPLACE TABLE szd_production_etl.rvm_cleaning_b_$_1{land_1} LIKE szd_production_core.t_fact_rvm_cleaning_1;


/*
copy into "ETL"."rvm_cleaning_a_$_1{land_1}" from
 (select   
          src.$1:datastore_data:rvm_id
          ,to_date(dateadd(microseconds, src.$1:datastore_data:begin_of_cleaning_dt, '1970-01-01'))
          ,to_timestamp(dateadd(microseconds, src.$1:datastore_data:begin_of_cleaning_tm, '1970-01-01'))
          ,src.$1:datastore_data:cleaning_type_cd
          ,src.$1:datastore_data:cleaning_status_cd
          ,to_date(dateadd(microseconds, src.$1:datastore_data:end_of_cleaning_dt, '1970-01-01'))
          ,to_timestamp(dateadd(microseconds, src.$1:datastore_data:end_of_cleaning_dt, '1970-01-01'))
          ,src.$1:datastore_data:cleaning_dur_sec_cnt
          ,CURRENT_TIMESTAMP
          ,CURRENT_TIMESTAMP
          ,src.$1:datastore_data:store_id	


FROM '@DATASTORE.${stage}/${SYSTEMGROUP}/${land_1}/t_fact_rvm_cleaning_1/${YEAR}/${MONTH}/${DAY}/' src) 
pattern='.*rvm_cleaning.*\.(avro)$'
file_format = (type = avro)
ON_ERROR = ABORT_STATEMENT;
*/


-- load_id als Prozess-ID im Gegensatz zur context_load_id (falls vorhanden)
 INSERT INTO szd_production_etl.rvm_cleaning_b_$_1{land_1}

(SELECT DISTINCT rvm.rvm_sid,
  src.begin_of_cleaning_dt,
  src.begin_of_cleaning_tm,
  src.cleaning_type_cd,
  src.cleaning_status_cd,
  src.end_of_cleaning_dt,
  src.end_of_cleaning_tm,
  src.cleaning_dur_sec_cnt,
  src.dwh_created_tmsp,
  src.dwh_updated_tmsp
 FROM szd_production_etl.rvm_cleaning_a_$_1{land_1} AS src
  LEFT JOIN szd_production_etl.rvm_keys_1 AS rvm ON src.rvm_id = rvm.rvm_id AND CAST(src.store_id AS FLOAT64) = rvm.store
 WHERE rvm.rvm_sid IS NOT NULL);


MERGE INTO szd_production_core.t_fact_rvm_cleaning_1 AS tgt
USING (SELECT rvm_sid,
  begin_of_cleaning_dt,
  begin_of_cleaning_tm,
  cleaning_type_cd,
  cleaning_status_cd,
  end_of_cleaning_dt,
  end_of_cleaning_tm,
  cleaning_dur_sec_cnt,
  dwh_created_tmsp,
  dwh_updated_tmsp
 FROM szd_production_etl.rvm_cleaning_b_$_1{land_1}
 WHERE rvm_sid IS NOT NULL) AS src
ON tgt.rvm_sid = src.rvm_sid AND tgt.begin_of_cleaning_dt = src.begin_of_cleaning_dt AND tgt.begin_of_cleaning_tm = src
      .begin_of_cleaning_tm AND tgt.cleaning_type_cd = src.cleaning_type_cd AND tgt.end_of_cleaning_dt = src.end_of_cleaning_dt
     AND tgt.end_of_cleaning_tm = src.end_of_cleaning_tm AND tgt.cleaning_dur_sec_cnt = src.cleaning_dur_sec_cnt
WHEN MATCHED THEN UPDATE SET
 dwh_updated_tmsp = CURRENT_TIMESTAMP()
WHEN NOT MATCHED THEN INSERT VALUES(src.rvm_sid, src.begin_of_cleaning_dt, src.begin_of_cleaning_tm, src.cleaning_type_cd
 , src.cleaning_status_cd, src.end_of_cleaning_dt, src.end_of_cleaning_tm, src.cleaning_dur_sec_cnt, src.dwh_created_tmsp
 , CURRENT_TIMESTAMP());


COMMIT TRANSACTION;