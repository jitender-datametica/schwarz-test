--T_FACT_RVM_PREV_ACTIONS

ALTER SESSION SET TRANSACTION_ABORT_ON_ERROR = TRUE;
BEGIN;
SELECT CURRENT_TRANSACTION();


CREATE OR REPLACE TABLE ETL.rvm_prev_actions_a_${LAND}   LIKE CORE.t_fact_rvm_prev_actions;
ALTER TABLE ETL.rvm_prev_actions_a_${LAND}   ADD store_id VARCHAR(20) NULL;
ALTER TABLE ETL.rvm_prev_actions_a_${LAND}   RENAME COLUMN RVM_SID to RVM_ID;

CREATE OR REPLACE TABLE ETL.RVM_PREV_ACTIONS_b_${LAND} LIKE CORE.t_fact_rvm_prev_actions;




copy into ETL.rvm_prev_actions_a_${LAND}   from
 (select   
          src.$1:datastore_data:rvm_id
          ,to_date(dateadd(microseconds, src.$1:datastore_data:prev_action_tm, '1970-01-01'))
          ,to_timestamp(dateadd(microseconds, src.$1:datastore_data:prev_action_tm, '1970-01-01'))
		  ,src.$1:datastore_data:rvm_prev_action_type_id
          ,CURRENT_TIMESTAMP
          ,CURRENT_TIMESTAMP
          ,src.$1:datastore_data:store_id	


FROM '@DATASTORE.${stage}/${SYSTEMGROUP}/${LAND}/t_fact_rvm_prev_actions/${YEAR}/${MONTH}/${DAY}/' src) 
pattern='.*rvm_prev_actions.*\.(avro)$'
file_format = (type = avro)
ON_ERROR = ABORT_STATEMENT;


INSERT INTO ETL.RVM_PREV_ACTIONS_b_${LAND}                             
 SELECT DISTINCT	
		RVM_SID 
        ,PREV_ACTION_DT
        ,PREV_ACTION_TM
        ,RVM_PREV_ACTION_TYPE_ID
        ,DWH_CREATED_TMSP
        ,DWH_UPDATED_TMSP
		                                  
 FROM (
    SELECT
        PREV_ACTION_DT
        ,PREV_ACTION_TM
        ,RVM_PREV_ACTION_TYPE_ID
        ,DWH_CREATED_TMSP
        ,DWH_UPDATED_TMSP
        ,rvm.rvm_sid,
        0 dwh_load_id  --load_id als Prozess-ID im Gegensatz zur context_load_id (falls vorhanden)
    FROM 
        ETL.rvm_prev_actions_a_${LAND}   src
    LEFT OUTER JOIN ETL.RVM_KEYS rvm
        ON src.rvm_id = rvm.rvm_id
        AND src.store_id = rvm.store 
    WHERE 1=1
    AND rvm.rvm_sid IS NOT NULL) inner_sel
;


MERGE INTO  CORE.t_fact_rvm_prev_actions AS tgt
        USING (SELECT       RVM_SID 
                            ,PREV_ACTION_DT
							,PREV_ACTION_TM
							,RVM_PREV_ACTION_TYPE_ID
							,DWH_CREATED_TMSP
							,DWH_UPDATED_TMSP
FROM ETL.RVM_PREV_ACTIONS_b_${LAND} 
WHERE RVM_SID IS NOT NULL
              ) AS src 
          ON    tgt.RVM_SID=src.RVM_SID
                AND tgt.PREV_ACTION_DT = src.PREV_ACTION_DT
                AND tgt.PREV_ACTION_TM = src.PREV_ACTION_TM
                AND tgt.RVM_PREV_ACTION_TYPE_ID = src.RVM_PREV_ACTION_TYPE_ID

        WHEN MATCHED THEN UPDATE
            SET                    DWH_UPDATED_TMSP = CURRENT_TIMESTAMP

        WHEN NOT MATCHED THEN INSERT
               (                    RVM_SID 
									,PREV_ACTION_DT
									,PREV_ACTION_TM
									,RVM_PREV_ACTION_TYPE_ID
									,DWH_CREATED_TMSP
									,DWH_UPDATED_TMSP
               )
        VALUES (                    src.RVM_SID 
                                    ,src.PREV_ACTION_DT
                                    ,src.PREV_ACTION_TM
                                    ,src.RVM_PREV_ACTION_TYPE_ID
                                    ,src.DWH_CREATED_TMSP
                                   ,CURRENT_TIMESTAMP);
                                                                                     



COMMIT;



                                                             
