CREATE OR REPLACE TABLE ETL.cabinet_usage_a_${LAND} LIKE CORE.t_fact_cabinet_usage;
ALTER TABLE ETL.cabinet_usage_a_${LAND}  ADD store_id VARCHAR(20) NULL;
ALTER TABLE ETL.cabinet_usage_a_${LAND} RENAME COLUMN RVM_SID to RVM_ID;

CREATE OR REPLACE TABLE ETL.cabinet_usage_b_${LAND} LIKE CORE.t_fact_cabinet_usage;

copy into ETL.cabinet_usage_a_${LAND}  
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
FROM '@DATASTORE.${stage}/${SYSTEMGROUP}/${LAND}/t_fact_cabinet_usage/${YEAR}/${MONTH}/${DAY}/' src) 
pattern='.*cabinet_usage.*\.(avro)$'
file_format = (type = avro)
ON_ERROR = ABORT_STATEMENT;


INSERT INTO ETL.cabinet_usage_b_${LAND}
            (RVM_SID
             ,CAL_DT
             ,CABINET_ID
             ,COMPACTOR_ID
             ,COMPACTED_BOTTLES_CNT
             ,DWH_CREATED_TMSP
             ,DWH_UPDATED_TMSP)
SELECT DISTINCT
    rvm.RVM_SID,
    src.CAL_DT,
    src.CABINET_ID,
    src.COMPACTOR_ID,
    src.COMPACTED_BOTTLES_CNT,
    src.DWH_CREATED_TMSP,
    src.DWH_UPDATED_TMSP 
FROM ETL.cabinet_usage_a_${LAND} src
  INNER JOIN ETL.rvm_keys rvm
          ON src.rvm_id = rvm.rvm_id     
          and src.store_id = rvm.store
where rvm.RVM_SID is not null
        ;  

MERGE INTO CORE.t_fact_cabinet_usage AS tgt
        USING (SELECT           RVM_SID 
                                ,CAL_DT
                                ,CABINET_ID
                                ,COMPACTOR_ID
				,COMPACTED_BOTTLES_CNT
				,DWH_CREATED_TMSP
				,CURRENT_TIMESTAMP

FROM  ETL.cabinet_usage_b_${LAND}  
WHERE RVM_SID IS NOT NULL
QUALIFY ROW_NUMBER() OVER (PARTITION BY RVM_SID, CAL_DT, CABINET_ID  ORDER BY  DWH_CREATED_TMSP DESC) = 1
              ) AS src 
          ON    tgt.RVM_SID=src.RVM_SID
                AND tgt.CAL_DT = src.CAL_DT
		AND tgt.CABINET_ID = src.CABINET_ID

        WHEN MATCHED THEN UPDATE
            SET                     COMPACTED_BOTTLES_CNT = src.COMPACTED_BOTTLES_CNT
                                   ,DWH_UPDATED_TMSP = CURRENT_TIMESTAMP

        WHEN NOT MATCHED THEN INSERT
               (                RVM_SID 
				,CAL_DT
                                ,CABINET_ID
                                ,COMPACTOR_ID
				,COMPACTED_BOTTLES_CNT
				,DWH_CREATED_TMSP
				,DWH_UPDATED_TMSP
               )
        VALUES (                src.RVM_SID 
                                ,src.CAL_DT
                                ,CABINET_ID
                                ,COMPACTOR_ID
                                ,src.COMPACTED_BOTTLES_CNT
				,src.DWH_CREATED_TMSP
                                ,CURRENT_TIMESTAMP);


commit;                
