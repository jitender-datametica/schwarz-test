--T_FACT_RVM_PREV_ACTIONS_1

-- ALTER SESSION SET TRANSACTION_ABORT_ON_ERROR = TRUE;


BEGIN;


-- SELECT CURRENT_TRANSACTION();


CREATE OR REPLACE TABLE szd_production_etl.rvm_prev_actions_a_$_1{land_1} LIKE szd_production_core.t_fact_rvm_prev_actions_1;


ALTER TABLE szd_production_etl.rvm_prev_actions_a_$_1{land_1}
ADD COLUMN IF NOT EXISTS store_id STRING(20);


ALTER TABLE szd_production_etl.rvm_prev_actions_a_$_1{land_1}
RENAME COLUMN rvm_sid TO rvm_id;


CREATE OR REPLACE TABLE szd_production_etl.rvm_prev_actions_b_$_1{land_1} LIKE szd_production_core.t_fact_rvm_prev_actions_1;


/*
copy into SZD_PRODUCTION.ETL.rvm_prev_actions_a_$_1{land_1}   from
 (select   
          src.$1:datastore_data:rvm_id
          ,to_date(dateadd(microseconds, src.$1:datastore_data:prev_action_tm, '1970-01-01'))
          ,to_timestamp(dateadd(microseconds, src.$1:datastore_data:prev_action_tm, '1970-01-01'))
		  ,src.$1:datastore_data:rvm_prev_action_type_id
          ,CURRENT_TIMESTAMP
          ,CURRENT_TIMESTAMP
          ,src.$1:datastore_data:store_id	


FROM '@DATASTORE.${stage}/${SYSTEMGROUP}/${land_1}/t_fact_rvm_prev_actions_1/${YEAR}/${MONTH}/${DAY}/' src) 
pattern='.*rvm_prev_actions.*\.(avro)$'
file_format = (type = avro)
ON_ERROR = ABORT_STATEMENT;
*/


-- load_id als Prozess-ID im Gegensatz zur context_load_id (falls vorhanden)
 INSERT INTO szd_production_etl.rvm_prev_actions_b_$_1{land_1}

(SELECT DISTINCT rvm.rvm_sid,
  src.prev_action_dt,
  src.prev_action_tm,
  src.rvm_prev_action_type_id,
  src.dwh_created_tmsp,
  src.dwh_updated_tmsp
 FROM szd_production_etl.rvm_prev_actions_a_$_1{land_1} AS src
  LEFT JOIN szd_production_etl.rvm_keys_1 AS rvm ON src.rvm_id = rvm.rvm_id AND CAST(src.store_id AS FLOAT64) = rvm.store
 WHERE rvm.rvm_sid IS NOT NULL);


MERGE INTO szd_production_core.t_fact_rvm_prev_actions_1 AS tgt
USING (SELECT rvm_sid,
  prev_action_dt,
  prev_action_tm,
  rvm_prev_action_type_id,
  dwh_created_tmsp,
  dwh_updated_tmsp
 FROM szd_production_etl.rvm_prev_actions_b_$_1{land_1}
 WHERE rvm_sid IS NOT NULL) AS src
ON tgt.rvm_sid = src.rvm_sid AND tgt.prev_action_dt = src.prev_action_dt AND tgt.prev_action_tm = src.prev_action_tm AND
  tgt.rvm_prev_action_type_id = src.rvm_prev_action_type_id
WHEN MATCHED THEN UPDATE SET
 dwh_updated_tmsp = CURRENT_TIMESTAMP()
WHEN NOT MATCHED THEN INSERT VALUES(src.rvm_sid, src.prev_action_dt, src.prev_action_tm, src.rvm_prev_action_type_id,
 CURRENT_TIMESTAMP(), src.dwh_created_tmsp);


COMMIT TRANSACTION;