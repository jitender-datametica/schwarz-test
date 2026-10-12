--T_FACT_RVM_Configuration_update_2

-- ALTER SESSION SET TRANSACTION_ABORT_ON_ERROR = TRUE;


BEGIN;


-- SELECT CURRENT_TRANSACTION();


CREATE OR REPLACE TABLE szd_production_etl.rvm_configuration_update_a_$_2{land_2} LIKE szd_production_core.t_fact_rvm_configuration_update_2;


ALTER TABLE szd_production_etl.rvm_configuration_update_a_$_2{land_2}
ADD COLUMN IF NOT EXISTS store_id STRING(20);


ALTER TABLE szd_production_etl.rvm_configuration_update_a_$_2{land_2}
RENAME COLUMN rvm_sid TO rvm_id;


CREATE OR REPLACE TABLE szd_production_etl.rvm_configuration_update_b_$_2{land_2} LIKE szd_production_core.t_fact_rvm_configuration_update_2;


/*
copy into  SZD_PRODUCTION.ETL.rvm_configuration_update_a_$_2{land_2}   from
 (select
    src.$1:datastore_data:rvm_id,  
    to_date(dateadd(microseconds, src.$1:datastore_data:cal_dt, '1970-01-01')), 
    to_date(dateadd(microseconds, src.$1:datastore_data:update_dt, '1970-01-01')), 
    to_timestamp(dateadd(microseconds, src.$1:datastore_data:update_tm, '1970-01-01')),
    src.$1:datastore_data:rvm_config_source_cd,
    src.$1:datastore_data:rec_cnt,
    to_number( src.$1:datastore_data:update_status_fg),
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP,
    src.$1:datastore_data:store_id	
	
FROM '@DATASTORE.${stage}/${SYSTEMGROUP}/${land_2}/t_fact_rvm_configuration_update_2/${YEAR}/${MONTH}/${DAY}/' src) 
pattern='.*rvm_configuration_update.*\.(avro)$'
file_format = (type = avro)
ON_ERROR = ABORT_STATEMENT;
*/


INSERT INTO szd_production_etl.rvm_configuration_update_b_$_2{land_2}
(SELECT t1.rvm_sid,
  t1.cal_dt,
  t1.update_dt,
  t1.update_tm,
  t1.rvm_config_source_cd,
  t1.rec_cnt,
  t1.update_status_fg,
  CURRENT_TIMESTAMP(),
  CURRENT_TIMESTAMP()
 FROM (SELECT DISTINCT rvm.rvm_sid,
    src.cal_dt,
    src.update_dt,
    src.update_tm,
    src.rvm_config_source_cd,
    src.rec_cnt,
    src.update_status_fg,
    CURRENT_TIMESTAMP(),
    CURRENT_TIMESTAMP()
   FROM szd_production_etl.rvm_configuration_update_a_$_2{land_2} AS src
    INNER JOIN szd_production_etl.rvm_keys_2 AS rvm ON src.rvm_id = rvm.rvm_id AND CAST(src.store_id AS FLOAT64) = rvm.store
      
   WHERE rvm.rvm_sid IS NOT NULL) AS t1_2);


MERGE INTO szd_production_core.t_fact_rvm_configuration_update_2 AS tgt
USING (SELECT rvm_sid,
  cal_dt,
  update_dt,
  update_tm,
  rvm_config_source_cd,
  rec_cnt,
  update_status_fg,
  dwh_created_tmsp,
  CURRENT_TIMESTAMP()
 FROM szd_production_etl.rvm_configuration_update_b_$_2{land_2}
 WHERE rvm_sid IS NOT NULL) AS src
ON tgt.rvm_sid = src.rvm_sid AND tgt.cal_dt = src.cal_dt AND tgt.update_dt = src.update_dt AND tgt.update_tm = src.update_tm
      AND tgt.rvm_config_source_cd = src.rvm_config_source_cd AND tgt.rec_cnt = src.rec_cnt AND tgt.update_status_fg =
  src.update_status_fg
WHEN MATCHED THEN UPDATE SET
 dwh_updated_tmsp = CURRENT_TIMESTAMP()
WHEN NOT MATCHED THEN INSERT VALUES(src.rvm_sid, src.cal_dt, src.update_dt, src.update_tm, src.rvm_config_source_cd, src
 .rec_cnt, src.update_status_fg, src.dwh_created_tmsp, CURRENT_TIMESTAMP());


COMMIT TRANSACTION;