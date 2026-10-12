--T_FACT_DEPOSIT_RVM_CLEANING
ALTER SESSION SET TRANSACTION_ABORT_ON_ERROR = TRUE;
BEGIN;
SELECT CURRENT_TRANSACTION();

CREATE OR REPLACE TABLE ETL.rvm_cleaning_a_$_1{LAND_1}   LIKE "CORE"."t_fact_rvm_cleaning_1";
ALTER TABLE ETL.rvm_cleaning_a_$_1{LAND_1}   ADD store_id VARCHAR(20) NULL;
ALTER TABLE ETL.rvm_cleaning_a_$_1{LAND_1}   RENAME COLUMN RVM_SID to RVM_ID;

CREATE OR REPLACE TABLE ETL.RVM_CLEANING_b_$_1{LAND_1} LIKE "CORE"."t_fact_rvm_cleaning_1";

copy into "ETL"."rvm_cleaning_a_$_1{LAND_1}" from
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


FROM '@DATASTORE.${stage}/${SYSTEMGROUP}/${LAND_1}/t_fact_rvm_cleaning_1/${YEAR}/${MONTH}/${DAY}/' src) 
pattern='.*rvm_cleaning.*\.(avro)$'
file_format = (type = avro)
ON_ERROR = ABORT_STATEMENT;


INSERT INTO ETL.RVM_CLEANING_b_$_1{LAND_1}                             
 SELECT DISTINCT	
		RVM_SID 
        ,BEGIN_OF_CLEANING_DT
        ,BEGIN_OF_CLEANING_TM
        ,CLEANING_TYPE_CD
        ,CLEANING_STATUS_CD
        ,END_OF_CLEANING_DT
        ,END_OF_CLEANING_TM
        ,CLEANING_DUR_SEC_CNT
        ,DWH_CREATED_TMSP
        ,DWH_UPDATED_TMSP
		                                  
 FROM (
    SELECT
        BEGIN_OF_CLEANING_DT
        ,BEGIN_OF_CLEANING_TM
        ,CLEANING_TYPE_CD
        ,CLEANING_STATUS_CD
        ,END_OF_CLEANING_DT
        ,END_OF_CLEANING_TM
        ,CLEANING_DUR_SEC_CNT
        ,DWH_CREATED_TMSP
        ,DWH_UPDATED_TMSP
        ,rvm.rvm_sid,
        0 dwh_load_id  --load_id als Prozess-ID im Gegensatz zur context_load_id (falls vorhanden)
    FROM 
        ETL.rvm_cleaning_a_$_1{LAND_1}   src
    LEFT OUTER JOIN ETL.RVM_KEYS_1 rvm
        ON src.rvm_id = rvm.rvm_id
        AND src.store_id = rvm.store 
    WHERE 1=1
    AND rvm.rvm_sid IS NOT NULL) inner_sel
;


MERGE INTO  "CORE"."t_fact_rvm_cleaning_1" AS tgt
        USING (SELECT       RVM_SID 
                            ,BEGIN_OF_CLEANING_DT
                            ,BEGIN_OF_CLEANING_TM
                            ,CLEANING_TYPE_CD
                            ,CLEANING_STATUS_CD
                            ,END_OF_CLEANING_DT
                            ,END_OF_CLEANING_TM
                            ,CLEANING_DUR_SEC_CNT
                            ,DWH_CREATED_TMSP
                            ,DWH_UPDATED_TMSP
FROM "ETL"."RVM_CLEANING_b_$_1{LAND_1}"  
WHERE RVM_SID IS NOT NULL
              ) AS src 
          ON    tgt.RVM_SID=src.RVM_SID
                AND tgt.BEGIN_OF_CLEANING_DT = src.BEGIN_OF_CLEANING_DT
                AND tgt.BEGIN_OF_CLEANING_TM = src.BEGIN_OF_CLEANING_TM
                AND tgt.CLEANING_TYPE_CD = src.CLEANING_TYPE_CD
                AND tgt.END_OF_CLEANING_DT = src.END_OF_CLEANING_DT
                AND tgt.END_OF_CLEANING_TM = src.END_OF_CLEANING_TM
                AND tgt.CLEANING_DUR_SEC_CNT = src.CLEANING_DUR_SEC_CNT

        WHEN MATCHED THEN UPDATE
            SET                    DWH_UPDATED_TMSP = CURRENT_TIMESTAMP

        WHEN NOT MATCHED THEN INSERT
               (                    RVM_SID 
                                    ,BEGIN_OF_CLEANING_DT
                                    ,BEGIN_OF_CLEANING_TM
                                    ,CLEANING_TYPE_CD
                                    ,CLEANING_STATUS_CD
                                    ,END_OF_CLEANING_DT
                                    ,END_OF_CLEANING_TM
                                    ,CLEANING_DUR_SEC_CNT
                                    ,DWH_CREATED_TMSP
                                    ,DWH_UPDATED_TMSP
               )
        VALUES (                    src.RVM_SID 
                                    ,src.BEGIN_OF_CLEANING_DT
                                    ,src.BEGIN_OF_CLEANING_TM
                                    ,src.CLEANING_TYPE_CD
                                    ,src.CLEANING_STATUS_CD
                                    ,src.END_OF_CLEANING_DT
                                    ,src.END_OF_CLEANING_TM
                                    ,src.CLEANING_DUR_SEC_CNT
                                    ,src.DWH_CREATED_TMSP
                                   ,CURRENT_TIMESTAMP);
                                                                                     


COMMIT;

                                                                                     
