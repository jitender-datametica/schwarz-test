--etl.rvm_keys_2


-- ALTER SESSION SET TRANSACTION_ABORT_ON_ERROR = TRUE;


BEGIN;


-- SELECT CURRENT_TRANSACTION();


CREATE OR REPLACE TABLE szd_production_etl.rvm_keys_stage_a_$_2{land_2} LIKE szd_production_etl.rvm_keys_2;


CREATE OR REPLACE TABLE szd_production_etl.rvm_keys_stage_b_$_2{land_2} LIKE szd_production_etl.rvm_keys_2;


/*
copy into SZD_PRODUCTION.ETL.rvm_keys_stage_a_$_2{land_2}   from
 (select
    src.$1:datastore_data:rvm_sid
    ,src.$1:datastore_data:store_nr
    ,src.$1:datastore_data:serial_nr

FROM '@DATASTORE.${stage}/${SYSTEMGROUP}/${land_2}/t_dim_rvm_hist_2/${YEAR}/${MONTH}/${DAY}/' src) 
pattern='.*rvm_hist.*\.(avro)$'
file_format = (type = avro)
ON_ERROR = ABORT_STATEMENT;
*/


INSERT INTO szd_production_etl.rvm_keys_stage_b_$_2{land_2}
(SELECT t3.max_seq + (ROW_NUMBER() OVER (ORDER BY 1 IS NULL, 1)) AS rvm_sid_new,
  temp.store,
  temp.rvm_id
 FROM (SELECT DISTINCT *
   FROM szd_production_etl.rvm_keys_stage_a_$_2{land_2}) AS temp
  INNER JOIN (SELECT MAX(rvm_sid) AS max_seq
   FROM szd_production_etl.rvm_keys_2 AS rvm_max_sid) AS t3 ON TRUE
 WHERE temp.rvm_sid IS NULL);


MERGE INTO szd_production_etl.rvm_keys_2 AS tgt
USING (SELECT rvm_sid,
  store,
  rvm_id
 FROM szd_production_etl.rvm_keys_stage_b_$_2{land_2}
 WHERE rvm_sid IS NOT NULL) AS src
ON tgt.store = src.store AND tgt.rvm_id = src.rvm_id
WHEN NOT MATCHED THEN INSERT VALUES(src.rvm_sid, src.store, src.rvm_id);


COMMIT TRANSACTION;