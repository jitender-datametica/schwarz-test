ALTER SESSION SET TRANSACTION_ABORT_ON_ERROR = TRUE;
BEGIN;
SELECT CURRENT_TRANSACTION();

CREATE OR REPLACE TABLE ETL.deposit_receipt_a_${LAND} LIKE CORE.T_FACT_DEPOSIT_RECEIPT;
ALTER TABLE ETL.deposit_receipt_a_${LAND} ADD store_id VARCHAR(20) NULL;
ALTER TABLE ETL.deposit_receipt_a_${LAND} RENAME COLUMN RVM_SID to RVM_ID;

CREATE OR REPLACE TABLE ETL.DEPOSIT_RECEIPT_b_${LAND} LIKE CORE.T_FACT_DEPOSIT_RECEIPT;
 

copy into ETL.deposit_receipt_a_${LAND} from
 (select 
	to_date(dateadd(microseconds, $1:datastore_data:receipt_tm, '1970-01-01'))
	,dateadd(microseconds, src.$1:datastore_data:receipt_tm, '1970-01-01')
        ,substring(dateadd(microseconds, src.$1:datastore_data:receipt_tm, '1970-01-01'),12,2)
        ,$1:datastore_data:rvm_id
        ,$1:datastore_data:deposit_outpayment_type_cd
	,$1:datastore_data:receipt_nr
	,$1:datastore_data:receipt_gross_local_val
	,CURRENT_TIMESTAMP
        ,CURRENT_TIMESTAMP
        ,coalesce($1:datastore_data:receipt_barcode,'-1')
        ,$1:datastore_data:local_curr_cd
        ,$1:datastore_data:receipt_gross_global_val
        ,$1:datastore_data:global_curr_cd
	,$1:datastore_data:store_id
	
FROM '@DATASTORE.${stage}/${SYSTEMGROUP}/${LAND}/t_fact_deposit_receipt/${YEAR}/${MONTH}/${DAY}/' src) 
pattern='.*deposit_receipt.*\.(avro)$'
file_format = (type = avro)
ON_ERROR = ABORT_STATEMENT
;


INSERT INTO ETL.DEPOSIT_RECEIPT_b_${LAND}
SELECT DISTINCT		        RECEIPT_DT 
				,RECEIPT_TM
                                ,RECEIPT_HR
                                ,RVM_SID 
				,DEPOSIT_OUTPAYMENT_TYPE_CD
				,RECEIPT_NR
				,RECEIPT_GROSS_LOCAL_VAL
				,DWH_CREATED_TMSP
				,DWH_UPDATED_TMSP
                                ,RECEIPT_BARCODE
                                ,LOCAL_CURR_CD
                                ,RECEIPT_GROSS_GLOBAL_VAL
                                ,GLOBAL_CURR_CD
FROM (SELECT                    
                                src.*
                                ,rvm.rvm_sid
                                ,0 dwh_load_id 
	FROM ETL.deposit_receipt_a_${LAND} src
        LEFT OUTER JOIN ETL.RVM_KEYS rvm
            ON src.rvm_id = rvm.rvm_id
            AND src.store_id = rvm.store 
        WHERE 1=1
        AND rvm.rvm_sid IS NOT NULL) inner_sel
QUALIFY ROW_NUMBER() OVER (PARTITION BY RECEIPT_DT, RECEIPT_TM, RECEIPT_HR, RVM_SID, DEPOSIT_OUTPAYMENT_TYPE_CD, RECEIPT_NR, RECEIPT_GROSS_LOCAL_VAL, RECEIPT_BARCODE ORDER BY  DWH_CREATED_TMSP DESC) = 1
;


MERGE INTO  CORE.T_FACT_DEPOSIT_RECEIPT AS tgt
        USING (SELECT       RECEIPT_DT
                            ,RECEIPT_TM
                            ,RECEIPT_HR
                            ,RVM_SID
                            ,DEPOSIT_OUTPAYMENT_TYPE_CD
                            ,RECEIPT_NR
                            ,RECEIPT_GROSS_LOCAL_VAL
                            ,DWH_CREATED_TMSP
                            ,DWH_UPDATED_TMSP
                            ,RECEIPT_BARCODE
                            ,LOCAL_CURR_CD
                            ,RECEIPT_GROSS_GLOBAL_VAL
                            ,GLOBAL_CURR_CD

FROM ETL.DEPOSIT_RECEIPT_b_${LAND}  
WHERE RVM_SID IS NOT NULL
              ) AS src 
                ON  tgt.RECEIPT_DT=src.RECEIPT_DT
                AND tgt.RECEIPT_TM = src.RECEIPT_TM
                AND tgt.RECEIPT_HR = src.RECEIPT_HR
                AND tgt.RVM_SID = src.RVM_SID
                AND tgt.DEPOSIT_OUTPAYMENT_TYPE_CD = src.DEPOSIT_OUTPAYMENT_TYPE_CD
                AND tgt.RECEIPT_NR = src.RECEIPT_NR
                AND tgt.RECEIPT_GROSS_LOCAL_VAL = src.RECEIPT_GROSS_LOCAL_VAL
                AND tgt.RECEIPT_BARCODE = src.RECEIPT_BARCODE

        WHEN MATCHED THEN UPDATE
            SET                    DWH_UPDATED_TMSP = CURRENT_TIMESTAMP

        WHEN NOT MATCHED THEN INSERT
               (                    RECEIPT_DT
                                    ,RECEIPT_TM
                                    ,RECEIPT_HR
                                    ,RVM_SID
                                    ,DEPOSIT_OUTPAYMENT_TYPE_CD
                                    ,RECEIPT_NR
                                    ,RECEIPT_GROSS_LOCAL_VAL
                                    ,DWH_CREATED_TMSP
                                    ,DWH_UPDATED_TMSP
                                    ,RECEIPT_BARCODE
                                    ,LOCAL_CURR_CD
                                    ,RECEIPT_GROSS_GLOBAL_VAL
                                    ,GLOBAL_CURR_CD
               )
        VALUES (                    src.RECEIPT_DT
                                    ,src.RECEIPT_TM
                                    ,src.RECEIPT_HR
                                    ,src.RVM_SID
                                    ,src.DEPOSIT_OUTPAYMENT_TYPE_CD
                                    ,src.RECEIPT_NR
                                    ,src.RECEIPT_GROSS_LOCAL_VAL
                                    ,src.DWH_CREATED_TMSP
                                    ,current_timestamp
                                    ,src.RECEIPT_BARCODE
                                    ,src.LOCAL_CURR_CD
                                    ,src.RECEIPT_GROSS_GLOBAL_VAL
                                    ,src.GLOBAL_CURR_CD);
                                                                                     


COMMIT;

