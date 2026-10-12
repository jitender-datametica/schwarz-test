--etl.rvm_keys_1


-- ALTER SESSION SET TRANSACTION_ABORT_ON_ERROR = TRUE;


BEGIN;


-- SELECT CURRENT_TRANSACTION();


CREATE OR REPLACE TABLE szd_production_etl.rvm_keys_stage_a_$_1{land_1} LIKE szd_production_etl.rvm_keys_1;


CREATE OR REPLACE TABLE szd_production_etl.rvm_keys_stage_b_$_1{land_1} LIKE szd_production_etl.rvm_keys_1;


/*
copy into SZD_PRODUCTION.ETL.rvm_keys_stage_a_$_1{land_1}   from
 (select
    src.$1:datastore_data:rvm_sid
    ,src.$1:datastore_data:store_nr
    ,src.$1:datastore_data:serial_nr

FROM '@DATASTORE.${stage}/${SYSTEMGROUP}/${land_1}/t_dim_rvm_hist_1/${YEAR}/${MONTH}/${DAY}/' src) 
pattern='.*rvm_hist.*\.(avro)$'
file_format = (type = avro)
ON_ERROR = ABORT_STATEMENT;
*/


INSERT INTO szd_production_etl.rvm_keys_stage_b_$_1{land_1}
(SELECT t3.max_seq + (ROW_NUMBER() OVER (ORDER BY 1 IS NULL, 1)) AS rvm_sid_new,
  temp.store,
  temp.rvm_id
 FROM (SELECT DISTINCT *
   FROM szd_production_etl.rvm_keys_stage_a_$_1{land_1}) AS temp
  INNER JOIN (SELECT MAX(rvm_sid) AS max_seq
   FROM szd_production_etl.rvm_keys_1 AS rvm_max_sid) AS t3 ON TRUE
 WHERE temp.rvm_sid IS NULL);


MERGE INTO szd_production_etl.rvm_keys_1 AS tgt
USING (SELECT rvm_sid,
  store,
  rvm_id
 FROM szd_production_etl.rvm_keys_stage_b_$_1{land_1}
 WHERE rvm_sid IS NOT NULL) AS src
ON tgt.store = src.store AND tgt.rvm_id = src.rvm_id
WHEN NOT MATCHED THEN INSERT VALUES(src.rvm_sid, src.store, src.rvm_id);


COMMIT TRANSACTION;