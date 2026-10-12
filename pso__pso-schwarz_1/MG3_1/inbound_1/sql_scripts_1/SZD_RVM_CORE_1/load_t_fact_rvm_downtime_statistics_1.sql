--T_FACT_RVM_Configuration_update_1

ALTER SESSION SET TRANSACTION_ABORT_ON_ERROR = TRUE;
BEGIN;
SELECT CURRENT_TRANSACTION();

CREATE OR REPLACE TABLE ETL.rvm_downtime_statistics_a_$_1{LAND_1}   LIKE CORE.t_fact_rvm_downtime_statistics_1;
ALTER TABLE ETL.rvm_downtime_statistics_a_$_1{LAND_1}   ADD store_id VARCHAR(20) NULL;
ALTER TABLE ETL.rvm_downtime_statistics_a_$_1{LAND_1}   RENAME COLUMN RVM_SID to RVM_ID;

CREATE OR REPLACE TABLE ETL.rvm_downtime_statistics_b_$_1{LAND_1}   LIKE CORE.t_fact_rvm_downtime_statistics_1;


copy into  ETL.rvm_downtime_statistics_a_$_1{LAND_1}   from
 (select
    src.$1:datastore_data:rvm_id,
    to_date(dateadd(microseconds, src.$1:datastore_data:cal_dt, '1970-01-01')),
    src.$1:datastore_data:total_downtime_sec_cnt,
    src.$1:datastore_data:downtime_no_electricity_sec_cnt,
    src.$1:datastore_data:downtime_other_rsn_sec_cnt,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP,
	src.$1:datastore_data:store_id		

FROM '@DATASTORE.${stage}/${SYSTEMGROUP}/${LAND_1}/t_fact_rvm_downtime_statistics_1/${YEAR}/${MONTH}/${DAY}/' src) 
pattern='.*rvm_downtime_statistics.*\.(avro)$'
file_format = (type = avro)
ON_ERROR = ABORT_STATEMENT;


INSERT INTO ETL.rvm_downtime_statistics_b_$_1{LAND_1}
SELECT DISTINCT
    rvm.RVM_SID,
    src.cal_dt,
    src.total_downtime_sec_cnt,
    src.downtime_no_electricity_sec_cnt,
    src.downtime_other_rsn_sec_cnt,

    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP	

FROM  ETL.rvm_downtime_statistics_a_$_1{LAND_1}   src
  INNER JOIN ETL.rvm_keys_1 rvm
          ON src.rvm_id = rvm.rvm_id     
          and src.store_id = rvm.store
WHERE rvm.RVM_SID IS NOT NULL
;

MERGE INTO  CORE.t_fact_rvm_downtime_statistics_1 AS tgt
        USING (SELECT           RVM_SID 
				,CAL_DT
                                ,TOTAL_DOWNTIME_SEC_CNT
				,DOWNTIME_NO_ELECTRICITY_SEC_CNT
				,DOWNTIME_OTHER_RSN_SEC_CNT
				,DWH_CREATED_TMSP
				,CURRENT_TIMESTAMP

FROM ETL.rvm_downtime_statistics_b_$_1{LAND_1} 
WHERE RVM_SID IS NOT NULL
              ) AS src 
          ON    tgt.RVM_SID=src.RVM_SID
                AND tgt.CAL_DT = src.CAL_DT
                AND tgt.TOTAL_DOWNTIME_SEC_CNT = src.TOTAL_DOWNTIME_SEC_CNT
                AND tgt.DOWNTIME_NO_ELECTRICITY_SEC_CNT = src.DOWNTIME_NO_ELECTRICITY_SEC_CNT
                AND tgt.DOWNTIME_OTHER_RSN_SEC_CNT = src.DOWNTIME_OTHER_RSN_SEC_CNT

        WHEN MATCHED THEN UPDATE
            SET                     TOTAL_DOWNTIME_SEC_CNT = src.TOTAL_DOWNTIME_SEC_CNT
                                   ,DOWNTIME_NO_ELECTRICITY_SEC_CNT = src. DOWNTIME_NO_ELECTRICITY_SEC_CNT
                                   ,DOWNTIME_OTHER_RSN_SEC_CNT = src.DOWNTIME_OTHER_RSN_SEC_CNT
                                   ,DWH_UPDATED_TMSP = CURRENT_TIMESTAMP

        WHEN NOT MATCHED THEN INSERT
               (                RVM_SID 
				,CAL_DT
                                ,TOTAL_DOWNTIME_SEC_CNT
				,DOWNTIME_NO_ELECTRICITY_SEC_CNT
				,DOWNTIME_OTHER_RSN_SEC_CNT
				,DWH_CREATED_TMSP
				,DWH_UPDATED_TMSP
               )
        VALUES (                src.RVM_SID 
                                ,src.CAL_DT
                                ,TOTAL_DOWNTIME_SEC_CNT
                                ,src.DOWNTIME_NO_ELECTRICITY_SEC_CNT
				,src.DOWNTIME_OTHER_RSN_SEC_CNT
				,src.DWH_CREATED_TMSP
                                ,CURRENT_TIMESTAMP);

COMMIT;



                                                             
