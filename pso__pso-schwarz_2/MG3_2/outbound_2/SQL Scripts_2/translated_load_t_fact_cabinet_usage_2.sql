CREATE OR REPLACE TABLE szd_production_etl.cabinet_usage_a_$_2{land_2} LIKE szd_production_core.t_fact_cabinet_usage_2;


ALTER TABLE szd_production_etl.cabinet_usage_a_$_2{land_2}
ADD COLUMN IF NOT EXISTS store_id STRING(20);


ALTER TABLE szd_production_etl.cabinet_usage_a_$_2{land_2}
RENAME COLUMN rvm_sid TO rvm_id;


CREATE OR REPLACE TABLE szd_production_etl.cabinet_usage_b_$_2{land_2} LIKE szd_production_core.t_fact_cabinet_usage_2;


/*
copy into SZD_PRODUCTION.ETL.cabinet_usage_a_$_2{land_2}  
            (RVM_ID
             ,CAL_DT
             ,CABINET_ID
             ,COMPACTOR_ID
             ,COMPACTED_BOTTLES_CNT
             ,DWH_CREATED_TMSP
             ,DWH_UPDATED_TMSP
             ,STORE_ID)
from
 (select
    src.$1:datastore_data:rvm_id
    ,to_date(dateadd(microseconds, src.$1:datastore_data:cal_dt, '1970-01-01'))
    ,src.$1:datastore_data:cabinet_id
    ,coalesce(src.$1:datastore_data:compactor_id,'-1')
    ,src.$1:datastore_data:compacted_bottles_cnt
    ,CURRENT_TIMESTAMP
    ,CURRENT_TIMESTAMP
    ,src.$1:datastore_data:store_id
FROM '@DATASTORE.${stage}/${SYSTEMGROUP}/${land_2}/t_fact_cabinet_usage_2/${YEAR}/${MONTH}/${DAY}/' src) 
pattern='.*cabinet_usage.*\.(avro)$'
file_format = (type = avro)
ON_ERROR = ABORT_STATEMENT;
*/


INSERT INTO szd_production_etl.cabinet_usage_b_$_2{land_2} (rvm_sid, cal_dt, compactor_id, compacted_bottles_cnt,
 dwh_created_tmsp, dwh_updated_tmsp, cabinet_id)
(SELECT DISTINCT rvm.rvm_sid,
  src.cal_dt,
  src.compactor_id,
  src.compacted_bottles_cnt,
  src.dwh_created_tmsp,
  src.dwh_updated_tmsp,
  src.cabinet_id
 FROM szd_production_etl.cabinet_usage_a_$_2{land_2} AS src
  INNER JOIN szd_production_etl.rvm_keys_2 AS rvm ON src.rvm_id = rvm.rvm_id AND CAST(src.store_id AS FLOAT64) = rvm.store
    
 WHERE rvm.rvm_sid IS NOT NULL);


MERGE INTO szd_production_core.t_fact_cabinet_usage_2 AS tgt
USING (SELECT rvm_sid,
  cal_dt,
  cabinet_id,
  compactor_id,
  compacted_bottles_cnt,
  dwh_created_tmsp,
  CURRENT_TIMESTAMP()
 FROM szd_production_etl.cabinet_usage_b_$_2{land_2}
 WHERE rvm_sid IS NOT NULL
 QUALIFY (ROW_NUMBER() OVER (PARTITION BY rvm_sid, cal_dt, cabinet_id ORDER BY dwh_created_tmsp IS NULL DESC,
       dwh_created_tmsp DESC)) = 1) AS t1_2
ON tgt.rvm_sid = t1.rvm_sid AND tgt.cal_dt = t1.cal_dt AND tgt.cabinet_id = t1.cabinet_id
WHEN MATCHED THEN UPDATE SET
 compacted_bottles_cnt = t1.compacted_bottles_cnt,
 dwh_updated_tmsp = CURRENT_TIMESTAMP()
WHEN NOT MATCHED THEN INSERT VALUES(t1.rvm_sid, t1.cal_dt, t1.compactor_id, t1.compacted_bottles_cnt, t1.dwh_created_tmsp
 , CURRENT_TIMESTAMP(), t1.cabinet_id);


COMMIT TRANSACTION;