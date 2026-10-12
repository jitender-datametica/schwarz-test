--t_fact_deposit_rejectlist

ALTER SESSION SET TRANSACTION_ABORT_ON_ERROR = TRUE;
BEGIN;
SELECT CURRENT_TRANSACTION();

CREATE OR REPLACE TABLE ETL.deposit_rejectlist_a_${LAND}   LIKE CORE.t_fact_deposit_rejectlist;
ALTER TABLE ETL.deposit_rejectlist_a_${LAND}   ADD store_id VARCHAR(20) NULL;
ALTER TABLE ETL.deposit_rejectlist_a_${LAND}   RENAME COLUMN RVM_SID to RVM_ID;

CREATE OR REPLACE TABLE ETL.DEPOSIT_REJECTLIST_b_${LAND} LIKE CORE.t_fact_deposit_rejectlist;

copy into ETL.deposit_rejectlist_a_${LAND}   from
 (select 
        src.$1:datastore_data:rvm_id,
        to_date(dateadd(microseconds, src.$1:datastore_data:reject_dt, '1970-01-01')),
        to_time(dateadd(microseconds, src.$1:datastore_data:reject_dt, '1970-01-01')),
		src.$1:datastore_data:rejection_reason_group_id,
		src.$1:datastore_data:deposit_item_cat_cd,
        src.$1:datastore_data:ean,
		CURRENT_TIMESTAMP,
		CURRENT_TIMESTAMP,
        src.$1:datastore_data:store_id
        
FROM '@DATASTORE.${stage}/${SYSTEMGROUP}/${LAND}/t_fact_deposit_rejectlist/${YEAR}/${MONTH}/${DAY}/' src) 
pattern='.*_deposit_rejectlist.*\.(avro)$'
file_format = (type = avro)
ON_ERROR = ABORT_STATEMENT;


INSERT INTO ETL.DEPOSIT_REJECTLIST_b_${LAND}                              
 SELECT 
        RVM_SID
		,REJECT_DT
        ,REJECT_TM
		,REJECT_REASON_GROUP_ID
		,DEPOSIT_ITEM_CAT_CD
        ,EAN
		,DWH_CREATED_TMSP
		,DWH_UPDATED_TMSP
                                   
 FROM (
    SELECT
		REJECT_DT
        ,REJECT_TM
        ,REJECT_REASON_GROUP_ID
		,DEPOSIT_ITEM_CAT_CD
		,EAN
		,DWH_CREATED_TMSP
		,DWH_UPDATED_TMSP
        ,rvm.rvm_sid,
        0 dwh_load_id  --load_id als Prozess-ID im Gegensatz zur context_load_id (falls vorhanden)
    FROM 
        ETL.deposit_rejectlist_a_${LAND}   src
    LEFT OUTER JOIN ETL.RVM_KEYS rvm
        ON src.rvm_id = rvm.rvm_id
        AND src.store_id = rvm.store 
    WHERE 1=1
    AND rvm.rvm_sid IS NOT NULL) inner_sel
;


MERGE INTO CORE.T_FACT_DEPOSIT_REJECTLIST AS tgt
        USING (SELECT 				RVM_SID 
                                   ,REJECT_DT
                                   ,REJECT_TM
                                   ,REJECT_REASON_GROUP_ID
                                   ,DEPOSIT_ITEM_CAT_CD
                                   ,EAN
                                   ,DWH_CREATED_TMSP
                                   ,DWH_UPDATED_TMSP
                                   
                                   
FROM ETL.DEPOSIT_REJECTLIST_b_${LAND}  
WHERE RVM_SID IS NOT NULL
QUALIFY ROW_NUMBER() OVER (PARTITION BY RVM_SID, REJECT_DT, REJECT_TM, REJECT_REASON_GROUP_ID, DEPOSIT_ITEM_CAT_CD, EAN ORDER BY  REJECT_DT, REJECT_TM DESC) = 1
              ) AS src 
          ON    tgt.RVM_SID=src.RVM_SID
                AND tgt.REJECT_DT = src.REJECT_DT
                AND tgt.REJECT_REASON_GROUP_ID=src.REJECT_REASON_GROUP_ID
                AND tgt.DEPOSIT_ITEM_CAT_CD = src.DEPOSIT_ITEM_CAT_CD
                AND tgt.EAN = src.EAN
                AND tgt.REJECT_TM = src.REJECT_TM
        WHEN MATCHED THEN UPDATE
            SET                     
                                   DWH_UPDATED_TMSP = CURRENT_TIMESTAMP

        WHEN NOT MATCHED THEN INSERT
               (RVM_SID 
                                   ,REJECT_DT
                                   ,REJECT_REASON_GROUP_ID
                                   ,DEPOSIT_ITEM_CAT_CD
                                   ,DWH_CREATED_TMSP
                                   ,DWH_UPDATED_TMSP
                                   ,EAN
                                   ,REJECT_TM)
        VALUES (                src.RVM_SID
                                   ,src.REJECT_DT
                                   ,src.REJECT_REASON_GROUP_ID
                                   ,src.DEPOSIT_ITEM_CAT_CD
                                   ,CURRENT_TIMESTAMP
                                   ,CURRENT_TIMESTAMP
                                   ,EAN
                                   ,REJECT_TM);




COMMIT;



                                                             
