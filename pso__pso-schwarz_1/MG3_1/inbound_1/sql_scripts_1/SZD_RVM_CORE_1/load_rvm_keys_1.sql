--etl.rvm_keys_1


ALTER SESSION SET TRANSACTION_ABORT_ON_ERROR = TRUE;
BEGIN;
SELECT CURRENT_TRANSACTION();

CREATE OR REPLACE TABLE ETL.rvm_keys_stage_a_$_1{LAND_1} LIKE ETL.rvm_keys_1;
CREATE OR REPLACE TABLE ETL.rvm_keys_stage_b_$_1{LAND_1} LIKE ETL.rvm_keys_1;

copy into ETL.rvm_keys_stage_a_$_1{LAND_1}   from
 (select
    src.$1:datastore_data:rvm_sid
    ,src.$1:datastore_data:store_nr
    ,src.$1:datastore_data:serial_nr

FROM '@DATASTORE.${stage}/${SYSTEMGROUP}/${LAND_1}/t_dim_rvm_hist_1/${YEAR}/${MONTH}/${DAY}/' src) 
pattern='.*rvm_hist.*\.(avro)$'
file_format = (type = avro)
ON_ERROR = ABORT_STATEMENT;

INSERT INTO ETL.rvm_keys_stage_b_$_1{LAND_1}
SELECT
    src.RVM_SID_NEW,
    src.STORE,
    src.RVM_ID
FROM 
    (select temp.*, max_seq + row_number() over(order by 1) as RVM_SID_NEW
        from (select distinct * from ETL.rvm_keys_stage_a_$_1{LAND_1}) as temp 
        cross join (SELECT MAX(RVM_SID) as max_seq FROM ETL.rvm_keys_1 as rvm_max_sid)
    where temp.rvm_sid is null) as src;  
          
MERGE INTO ETL.rvm_keys_1 AS tgt
        USING (SELECT           RVM_SID 
                                ,STORE
                                ,RVM_ID

FROM  ETL.rvm_keys_stage_b_$_1{LAND_1}
WHERE RVM_SID IS NOT NULL
              ) AS src  
          ON    tgt.STORE = src.STORE
                AND tgt.RVM_ID = src.RVM_ID

        WHEN NOT MATCHED THEN INSERT
               (                RVM_SID 
				                ,STORE
                                ,RVM_ID
               )
        VALUES (                src.RVM_SID 
                                ,src.STORE
                                ,src.RVM_ID);

COMMIT;




                                                             
