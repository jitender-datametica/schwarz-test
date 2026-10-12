--T_FACT_RVM_Configuration_update_2

-- ALTER SESSION SET TRANSACTION_ABORT_ON_ERROR = TRUE;


BEGIN;


-- SELECT CURRENT_TRANSACTION();


CREATE OR REPLACE TABLE szd_production_etl.rvm_downtime_statistics_a_$_2{land_2} LIKE szd_production_core.t_fact_rvm_downtime_statistics_2;


ALTER TABLE szd_production_etl.rvm_downtime_statistics_a_$_2{land_2}
ADD COLUMN IF NOT EXISTS store_id STRING(20);


ALTER TABLE szd_production_etl.rvm_downtime_statistics_a_$_2{land_2}
RENAME COLUMN rvm_sid TO rvm_id;


CREATE OR REPLACE TABLE szd_production_etl.rvm_downtime_statistics_b_$_2{land_2} LIKE szd_production_core.t_fact_rvm_downtime_statistics_2;


/*
copy into  SZD_PRODUCTION.ETL.rvm_downtime_statistics_a_$_2{land_2}   from
 (select
    src.$1:datastore_data:rvm_id,
    to_date(dateadd(microseconds, src.$1:datastore_data:cal_dt, '1970-01-01')),
    src.$1:datastore_data:total_downtime_sec_cnt,
    src.$1:datastore_data:downtime_no_electricity_sec_cnt,
    src.$1:datastore_data:downtime_other_rsn_sec_cnt,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP,
	src.$1:datastore_data:store_id		

FROM '@DATASTORE.${stage}/${SYSTEMGROUP}/${land_2}/t_fact_rvm_downtime_statistics_2/${YEAR}/${MONTH}/${DAY}/' src) 
pattern='.*rvm_downtime_statistics.*\.(avro)$'
file_format = (type = avro)
ON_ERROR = ABORT_STATEMENT;
*/


INSERT INTO szd_production_etl.rvm_downtime_statistics_b_$_2{land_2}
(SELECT t1.rvm_sid,
  t1.cal_dt,
  t1.total_downtime_sec_cnt,
  t1.downtime_no_electricity_sec_cnt,
  t1.downtime_other_rsn_sec_cnt,
  CURRENT_TIMESTAMP(),
  CURRENT_TIMESTAMP()
 FROM (SELECT DISTINCT rvm.rvm_sid,
    src.cal_dt,
    src.total_downtime_sec_cnt,
    src.downtime_no_electricity_sec_cnt,
    src.downtime_other_rsn_sec_cnt,
    CURRENT_TIMESTAMP(),
    CURRENT_TIMESTAMP()
   FROM szd_production_etl.rvm_downtime_statistics_a_$_2{land_2} AS src
    INNER JOIN szd_production_etl.rvm_keys_2 AS rvm ON src.rvm_id = rvm.rvm_id AND CAST(src.store_id AS FLOAT64) = rvm.store
      
   WHERE rvm.rvm_sid IS NOT NULL) AS t1_2);


MERGE INTO szd_production_core.t_fact_rvm_downtime_statistics_2 AS tgt
USING (SELECT rvm_sid,
  cal_dt,
  total_downtime_sec_cnt,
  downtime_no_electricity_sec_cnt,
  downtime_other_rsn_sec_cnt,
  dwh_created_tmsp,
  CURRENT_TIMESTAMP()
 FROM szd_production_etl.rvm_downtime_statistics_b_$_2{land_2}
 WHERE rvm_sid IS NOT NULL) AS src
ON tgt.rvm_sid = src.rvm_sid AND tgt.cal_dt = src.cal_dt AND tgt.total_downtime_sec_cnt = src.total_downtime_sec_cnt AND
   tgt.downtime_no_electricity_sec_cnt = src.downtime_no_electricity_sec_cnt AND tgt.downtime_other_rsn_sec_cnt = src.downtime_other_rsn_sec_cnt
  
WHEN MATCHED THEN UPDATE SET
 total_downtime_sec_cnt = src.total_downtime_sec_cnt,
 downtime_no_electricity_sec_cnt = src.downtime_no_electricity_sec_cnt,
 downtime_other_rsn_sec_cnt = src.downtime_other_rsn_sec_cnt,
 dwh_updated_tmsp = CURRENT_TIMESTAMP()
WHEN NOT MATCHED THEN INSERT VALUES(src.rvm_sid, src.cal_dt, src.total_downtime_sec_cnt, src.downtime_no_electricity_sec_cnt
 , src.downtime_other_rsn_sec_cnt, src.dwh_created_tmsp, CURRENT_TIMESTAMP());


COMMIT TRANSACTION;