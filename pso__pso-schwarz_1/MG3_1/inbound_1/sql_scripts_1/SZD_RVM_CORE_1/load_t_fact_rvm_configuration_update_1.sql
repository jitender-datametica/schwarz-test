--T_FACT_RVM_Configuration_update_1

ALTER SESSION SET TRANSACTION_ABORT_ON_ERROR = TRUE;
BEGIN;
SELECT CURRENT_TRANSACTION();


CREATE OR REPLACE TABLE ETL.rvm_configuration_update_a_$_1{LAND_1}   LIKE CORE.t_fact_rvm_configuration_update_1;
ALTER TABLE ETL.rvm_configuration_update_a_$_1{LAND_1}   ADD store_id VARCHAR(20) NULL;
ALTER TABLE ETL.rvm_configuration_update_a_$_1{LAND_1}   RENAME COLUMN RVM_SID to RVM_ID;

CREATE OR REPLACE TABLE ETL.rvm_configuration_update_b_$_1{LAND_1}   LIKE CORE.t_fact_rvm_configuration_update_1;



copy into  ETL.rvm_configuration_update_a_$_1{LAND_1}   from
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
	
FROM '@DATASTORE.${stage}/${SYSTEMGROUP}/${LAND_1}/t_fact_rvm_configuration_update_1/${YEAR}/${MONTH}/${DAY}/' src) 
pattern='.*rvm_configuration_update.*\.(avro)$'
file_format = (type = avro)
ON_ERROR = ABORT_STATEMENT;


INSERT INTO ETL.rvm_configuration_update_b_$_1{LAND_1}
SELECT DISTINCT
    rvm.RVM_SID,
    src.cal_dt,
    src.update_dt,
    src.update_tm,
    src.rvm_config_source_cd,
    src.rec_cnt,
    src.update_status_fg,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP	

FROM  ETL.rvm_configuration_update_a_$_1{LAND_1}   src
  INNER JOIN ETL.rvm_keys_1 rvm
          ON src.rvm_id = rvm.rvm_id     
          and src.store_id = rvm.store
WHERE rvm.RVM_SID IS NOT NULL
;

MERGE INTO  CORE.t_fact_rvm_configuration_update_1 AS tgt
        USING (SELECT           RVM_SID 
				,CAL_DT
                                ,UPDATE_DT
				,UPDATE_TM
				,RVM_CONFIG_SOURCE_CD
				,REC_CNT
				,UPDATE_STATUS_FG
				,DWH_CREATED_TMSP
				,CURRENT_TIMESTAMP

FROM ETL.rvm_configuration_update_b_$_1{LAND_1}  
WHERE RVM_SID IS NOT NULL
              ) AS src 
          ON    tgt.RVM_SID=src.RVM_SID
                AND tgt.CAL_DT = src.CAL_DT
		AND tgt.UPDATE_DT = src.UPDATE_DT
		AND tgt.UPDATE_TM = src.UPDATE_TM
                AND tgt.RVM_CONFIG_SOURCE_CD = src.RVM_CONFIG_SOURCE_CD
                AND tgt.REC_CNT = src.REC_CNT
                AND tgt.UPDATE_STATUS_FG = src.UPDATE_STATUS_FG

        WHEN MATCHED THEN UPDATE
            SET                     DWH_UPDATED_TMSP = CURRENT_TIMESTAMP

        WHEN NOT MATCHED THEN INSERT
               (                RVM_SID 
				,CAL_DT
                                ,UPDATE_DT
				,UPDATE_TM
				,RVM_CONFIG_SOURCE_CD
				,REC_CNT
				,UPDATE_STATUS_FG
				,DWH_CREATED_TMSP
				,DWH_UPDATED_TMSP
               )
        VALUES (                src.RVM_SID 
                                ,src.CAL_DT
                                ,UPDATE_DT
                                ,src.UPDATE_TM
				,src.RVM_CONFIG_SOURCE_CD
				,src.REC_CNT
				,src.UPDATE_STATUS_FG
				,src.DWH_CREATED_TMSP
                                ,CURRENT_TIMESTAMP);



COMMIT;



                                                             
