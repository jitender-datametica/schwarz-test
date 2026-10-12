--T_FACT_DEPOSIT_RETURN_PER_HOUR

ALTER SESSION SET TRANSACTION_ABORT_ON_ERROR = TRUE;
BEGIN;
SELECT CURRENT_TRANSACTION();


CREATE OR REPLACE TABLE ETL.deposit_return_per_hour_a_${LAND}   LIKE CORE.T_FACT_DEPOSIT_RETURN_PER_HOUR;
ALTER TABLE ETL.deposit_return_per_hour_a_${LAND}   ADD store_id VARCHAR(20) NULL;
ALTER TABLE ETL.deposit_return_per_hour_a_${LAND}   RENAME COLUMN RVM_SID to RVM_ID;

CREATE OR REPLACE TABLE ETL.DEPOSIT_RETURN_PER_HOUR_b_${LAND} LIKE CORE.T_FACT_DEPOSIT_RETURN_PER_HOUR;

copy into ETL.deposit_return_per_hour_a_${LAND}   from
 (select 
          $1:datastore_data:rvm_id
		  ,to_date(dateadd(microseconds, $1:datastore_data:cal_dt, '1970-01-01'))
		  ,$1:datastore_data:return_hour
		  ,$1:datastore_data:deposit_item_sub_cat_id
		  ,$1:datastore_data:deposit_item_cnt
		  ,CURRENT_TIMESTAMP
		  ,CURRENT_TIMESTAMP
		  ,$1:datastore_data:store

FROM '@DATASTORE.${stage}/${SYSTEMGROUP}/${LAND}/t_fact_deposit_return_per_hour/${YEAR}/${MONTH}/${DAY}/' src) 
pattern='.*t_fact_deposit_return_per_hour.*\.(avro)$'
file_format = (type = avro)
ON_ERROR = ABORT_STATEMENT;

INSERT INTO ETL.DEPOSIT_RETURN_PER_HOUR_b_${LAND}                             
 SELECT DISTINCT 	
		RVM_SID 
		,CAL_DT 
		,RETURN_HOUR
		,DEPOSIT_ITEM_SUB_CAT_ID
		,DEPOSIT_ITEM_CNT
		,DWH_CREATED_TMSP
		,DWH_UPDATED_TMSP
		                                  
 FROM (
    SELECT
		CAL_DT 
		,RETURN_HOUR
		,DEPOSIT_ITEM_SUB_CAT_ID
		,DEPOSIT_ITEM_CNT
		,DWH_CREATED_TMSP
		,DWH_UPDATED_TMSP
        ,rvm.rvm_sid,
        0 dwh_load_id  --load_id als Prozess-ID im Gegensatz zur context_load_id (falls vorhanden)
    FROM 
        ETL.deposit_return_per_hour_a_${LAND}   src
    LEFT OUTER JOIN ETL.RVM_KEYS rvm
        ON src.rvm_id = rvm.rvm_id
        AND src.store_id = rvm.store 
    WHERE 1=1
    AND rvm.rvm_sid IS NOT NULL) inner_sel
;

     
MERGE INTO  CORE.T_FACT_DEPOSIT_RETURN_PER_HOUR AS tgt
        USING (SELECT               RVM_SID 
                                   ,CAL_DT
                                   ,RETURN_HOUR
                                   ,DEPOSIT_ITEM_SUB_CAT_ID
                                   ,DEPOSIT_ITEM_CNT
                                   ,DWH_CREATED_TMSP
                                   ,DWH_UPDATED_TMSP
FROM ETL.DEPOSIT_RETURN_PER_HOUR_b_${LAND}  
WHERE RVM_SID IS NOT NULL
              ) AS src 
          ON    tgt.RVM_SID=src.RVM_SID
                AND tgt.CAL_DT = src.CAL_DT
                AND tgt.RETURN_HOUR=src.RETURN_HOUR
                AND tgt.DEPOSIT_ITEM_SUB_CAT_ID = src.DEPOSIT_ITEM_SUB_CAT_ID
                AND tgt.DEPOSIT_ITEM_CNT = src.DEPOSIT_ITEM_CNT
        WHEN MATCHED THEN UPDATE
            SET                     DEPOSIT_ITEM_CNT = src.DEPOSIT_ITEM_CNT
                                   ,DWH_UPDATED_TMSP = CURRENT_TIMESTAMP

        WHEN NOT MATCHED THEN INSERT
               (                    RVM_SID 
                                   ,CAL_DT
                                   ,RETURN_HOUR
                                   ,DEPOSIT_ITEM_SUB_CAT_ID
                                   ,DEPOSIT_ITEM_CNT
                                   ,DWH_CREATED_TMSP
                                   ,DWH_UPDATED_TMSP
               )
        VALUES (                src.RVM_SID
                                   ,src.CAL_DT
                                   ,src.RETURN_HOUR
                                   ,src.DEPOSIT_ITEM_SUB_CAT_ID
                                    ,src.DEPOSIT_ITEM_CNT
                                   ,src.DWH_CREATED_TMSP
                                   ,CURRENT_TIMESTAMP);
                                   
                                                         

COMMIT;



                                                             
