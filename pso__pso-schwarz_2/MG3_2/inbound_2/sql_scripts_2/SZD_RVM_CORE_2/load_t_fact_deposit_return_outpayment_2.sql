--t_fact_deposit_return_outpayment_2

ALTER SESSION SET TRANSACTION_ABORT_ON_ERROR = TRUE;
BEGIN;
SELECT CURRENT_TRANSACTION();





CREATE OR REPLACE TABLE ETL.deposit_return_outpayment_a_$_2{LAND_2}   LIKE CORE.T_FACT_DEPOSIT_RETURN_OUTPAYMENT_2;
ALTER TABLE ETL.deposit_return_outpayment_a_$_2{LAND_2}   ADD store_id VARCHAR(20) NULL;
ALTER TABLE ETL.deposit_return_outpayment_a_$_2{LAND_2}   RENAME COLUMN RVM_SID to RVM_ID;

CREATE OR REPLACE TABLE ETL.DEPOSIT_RETURN_OUTPAYMENT_b_$_2{LAND_2} LIKE CORE.T_FACT_DEPOSIT_RETURN_OUTPAYMENT_2;


copy into ETL.deposit_return_outpayment_a_$_2{LAND_2} (RVM_ID,CAL_DT,DEPOSIT_ITEM_SUB_CAT_ID,DEPOSIT_OUTPAYMENT_TYPE_CD,RECEIPT_CNT,RECEIPT_GROSS_LOCAL_VAL,DWH_CREATED_TMSP,DWH_UPDATED_TMSP,RECEIPT_GROSS_GLOBAL_VAL,GLOBAL_CURR_CD,LOCAL_CURR_CD,STORE_ID) from
 (select 
    $1:datastore_data:rvm_id
    ,to_date(dateadd(microseconds, $1:datastore_data:cal_dt, '1970-01-01'))
    ,$1:datastore_data:deposit_item_sub_cat_id
    ,$1:datastore_data:deposit_outpayment_type_cd
    ,$1:datastore_data:receipt_cnt
    ,$1:datastore_data:receipt_gross_local_val
    ,CURRENT_TIMESTAMP
    ,CURRENT_TIMESTAMP
    ,$1:datastore_data:receipt_gross_global_val
    ,$1:datastore_data:global_curr_cd
    ,$1:datastore_data:local_curr_cd 
    ,$1:datastore_data:store_id
FROM '@DATASTORE.${stage}/${SYSTEMGROUP}/${LAND_2}/t_fact_deposit_return_outpayment_2/${YEAR}/${MONTH}/${DAY}/' src) 
pattern='.*deposit_return_outpayment.*\.(avro)$'
file_format = (type = avro)
ON_ERROR = ABORT_STATEMENT
;


INSERT INTO ETL.DEPOSIT_RETURN_OUTPAYMENT_b_$_2{LAND_2} (RVM_SID,CAL_DT,DEPOSIT_ITEM_SUB_CAT_ID,DEPOSIT_OUTPAYMENT_TYPE_CD,RECEIPT_CNT,RECEIPT_GROSS_LOCAL_VAL,DWH_CREATED_TMSP,DWH_UPDATED_TMSP,RECEIPT_GROSS_GLOBAL_VAL,GLOBAL_CURR_CD,LOCAL_CURR_CD)
SELECT 				   RVM_SID 
                                   ,CAL_DT
                                   ,DEPOSIT_ITEM_SUB_CAT_ID
                                   ,DEPOSIT_OUTPAYMENT_TYPE_CD
                                   ,RECEIPT_CNT
                                   ,RECEIPT_GROSS_LOCAL_VAL
                                   ,DWH_CREATED_TMSP
                                   ,DWH_UPDATED_TMSP
                                   ,RECEIPT_GROSS_GLOBAL_VAL
                                   ,GLOBAL_CURR_CD
                                   ,LOCAL_CURR_CD
FROM (SELECT                                      src.*,
                                     rvm.rvm_sid,
                                     0 dwh_load_id FROM ETL.deposit_return_outpayment_a_$_2{LAND_2}   src
                              LEFT OUTER JOIN ETL.RVM_KEYS_2 rvm
                                        ON src.rvm_id = rvm.rvm_id
                                        AND src.store_id = rvm.store 
      WHERE RVM_SID is not null 
      QUALIFY ROW_NUMBER() over (PARTITION BY src.RVM_ID, src.STORE_ID, src.CAL_DT, src.deposit_item_sub_cat_id, src.deposit_outpayment_type_cd,src.RECEIPT_CNT,src.RECEIPT_GROSS_LOCAL_VAL ORDER BY src.DWH_CREATED_TMSP DESC) = 1);
	  
	  
MERGE INTO  CORE.T_FACT_DEPOSIT_RETURN_OUTPAYMENT_2 AS tgt
        USING (SELECT              RVM_SID
                                   ,CAL_DT  
                                   ,DEPOSIT_ITEM_SUB_CAT_ID
                                   ,DEPOSIT_OUTPAYMENT_TYPE_CD
                                   ,RECEIPT_CNT
                                   ,RECEIPT_GROSS_LOCAL_VAL
                                   ,DWH_CREATED_TMSP
                                   ,DWH_UPDATED_TMSP
                                   ,RECEIPT_GROSS_GLOBAL_VAL
                                   ,GLOBAL_CURR_CD
                                   ,LOCAL_CURR_CD
FROM ETL.DEPOSIT_RETURN_OUTPAYMENT_b_$_2{LAND_2}  
WHERE RVM_SID IS NOT NULL
              ) AS src 
          ON    tgt.RVM_SID=src.RVM_SID
                AND tgt.CAL_DT = src.CAL_DT
                AND tgt.deposit_item_sub_cat_id=src.deposit_item_sub_cat_id
                AND tgt.deposit_outpayment_type_cd = src.deposit_outpayment_type_cd
                and tgt.RECEIPT_CNT = src.RECEIPT_CNT
                AND tgt.RECEIPT_GROSS_LOCAL_VAL = src.RECEIPT_GROSS_LOCAL_VAL
        WHEN MATCHED THEN UPDATE
            SET                     DWH_UPDATED_TMSP = CURRENT_TIMESTAMP

        WHEN NOT MATCHED THEN INSERT
               (                   RVM_SID                    
                                   ,CAL_DT  
                                   ,DEPOSIT_ITEM_SUB_CAT_ID
                                   ,DEPOSIT_OUTPAYMENT_TYPE_CD
                                   ,RECEIPT_CNT
                                   ,RECEIPT_GROSS_LOCAL_VAL
                                   ,DWH_CREATED_TMSP
                                   ,DWH_UPDATED_TMSP
                                   ,RECEIPT_GROSS_GLOBAL_VAL
                                   ,GLOBAL_CURR_CD
                                   ,LOCAL_CURR_CD
               )
        VALUES (                    src.RVM_SID 
                                   ,src.CAL_DT 
                                   ,src.DEPOSIT_ITEM_SUB_CAT_ID
                                   ,src.DEPOSIT_OUTPAYMENT_TYPE_CD
                                   ,src.RECEIPT_CNT
                                   ,src.RECEIPT_GROSS_LOCAL_VAL
                                   ,src.DWH_CREATED_TMSP
                                   ,CURRENT_TIMESTAMP
                                   ,src.RECEIPT_GROSS_GLOBAL_VAL
                                   ,src.GLOBAL_CURR_CD
                                   ,src.LOCAL_CURR_CD);
COMMIT;



                                                             
