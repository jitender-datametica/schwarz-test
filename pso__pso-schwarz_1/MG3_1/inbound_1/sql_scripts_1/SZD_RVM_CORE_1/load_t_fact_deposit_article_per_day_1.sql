--t_fact_deposit_article_per_day_1

ALTER SESSION SET TRANSACTION_ABORT_ON_ERROR = TRUE;
BEGIN;
SELECT CURRENT_TRANSACTION();


CREATE OR REPLACE TABLE ETL.deposit_article_per_day_a_$_1{LAND_1}   LIKE CORE.t_fact_deposit_article_per_day_1;
ALTER TABLE ETL.deposit_article_per_day_a_$_1{LAND_1}   ADD store_id VARCHAR(20) NULL;
ALTER TABLE ETL.deposit_article_per_day_a_$_1{LAND_1}   RENAME COLUMN RVM_SID to RVM_ID;

CREATE OR REPLACE TABLE ETL.deposit_article_per_day_b_$_1{LAND_1} LIKE CORE.t_fact_deposit_article_per_day_1;


copy into ETL.deposit_article_per_day_a_$_1{LAND_1} (item_sid, rvm_id, lob_cd, item_gtin, return_dt, return_cnt, ITEM_CONTAINER_TYPE_CD, dwh_created_tmsp, dwh_updated_tmsp,country_pol_cd,store_id)
   from
 (select   
          src.$1:datastore_data:item_sid
          ,src.$1:datastore_data:rvm_id
          ,src.$1:datastore_data:lob_cd
          ,src.$1:datastore_data:item_gtin
          ,to_date(dateadd(microseconds, src.$1:datastore_data:return_dt, '1970-01-01'))
          ,src.$1:datastore_data:return_cnt
          ,src.$1:datastore_data:item_container_type_cd
          ,CURRENT_TIMESTAMP
          ,CURRENT_TIMESTAMP
          ,src.$1:datastore_data:country_pol_cd
          ,src.$1:datastore_data:store_id	


FROM '@DATASTORE.${stage}/${SYSTEMGROUP}/${LAND_1}/t_fact_deposit_article_per_day_1/${YEAR}/${MONTH}/${DAY}/' src) 
pattern='.*deposit_article_per_day.*\.(avro)$'
file_format = (type = avro)
ON_ERROR = ABORT_STATEMENT;


INSERT INTO ETL.deposit_article_per_day_b_$_1{LAND_1} (ITEM_SID,RVM_SID,LOB_CD,ITEM_GTIN,RETURN_DT,RETURN_CNT,ITEM_CONTAINER_TYPE_CD,DWH_CREATED_TMSP,DWH_UPDATED_TMSP,COUNTRY_POL_CD)                            
 SELECT DISTINCT	
	ITEM_SID 
        ,RVM_SID
        ,LOB_CD
        ,ITEM_GTIN
        ,RETURN_DT
        ,RETURN_CNT
        ,ITEM_CONTAINER_TYPE_CD
        ,DWH_CREATED_TMSP
        ,DWH_UPDATED_TMSP
        ,COUNTRY_POL_CD
		                                  
 FROM (
    SELECT
        itm.ITEM_SID 
        ,rvm.RVM_SID
        ,src.LOB_CD
        ,src.ITEM_GTIN
        ,src.RETURN_DT
        ,src.RETURN_CNT
        ,src.ITEM_CONTAINER_TYPE_CD
        ,src.DWH_CREATED_TMSP
        ,src.DWH_UPDATED_TMSP
        ,src.COUNTRY_POL_CD
    FROM 
        ETL.deposit_article_per_day_a_$_1{LAND_1}   src
    LEFT OUTER JOIN ETL.RVM_KEYS_1 rvm
        ON src.rvm_id = rvm.rvm_id
        AND src.store_id = rvm.store
    LEFT OUTER JOIN ETL.ITEM_KEYS_1 itm
        ON src.ITEM_GTIN = itm.ITEM_GTIN
        AND src.LOB_CD = itm.LOB_CD
        AND src.COUNTRY_POL_CD = itm.COUNTRY_POL_CD
    WHERE 1=1
    AND rvm.RVM_SID IS NOT NULL
    AND itm.ITEM_SID IS NOT NULL) inner_sel
    QUALIFY ROW_NUMBER() OVER (PARTITION BY ITEM_SID, RVM_SID, LOB_CD, ITEM_GTIN, RETURN_DT, RETURN_CNT, ITEM_CONTAINER_TYPE_CD,COUNTRY_POL_CD ORDER BY  DWH_CREATED_TMSP DESC) = 1;
;


MERGE INTO  CORE.t_fact_deposit_article_per_day_1 AS tgt
        USING (SELECT       	ITEM_SID 
                                ,RVM_SID
                                ,LOB_CD
                                ,ITEM_GTIN
                                ,RETURN_DT
                                ,RETURN_CNT
                                ,ITEM_CONTAINER_TYPE_CD
                                ,DWH_CREATED_TMSP
                                ,DWH_UPDATED_TMSP
                                ,COUNTRY_POL_CD
		         
FROM ETL.deposit_article_per_day_b_$_1{LAND_1} 
WHERE RVM_SID IS NOT NULL
              ) AS src 
                ON  tgt.ITEM_SID        = src.ITEM_SID
                AND tgt.RVM_SID         = src.RVM_SID
                AND tgt.LOB_CD          = src.LOB_CD
                AND tgt.ITEM_GTIN       = src.ITEM_GTIN
                AND tgt.RETURN_DT       = src.RETURN_DT
                AND tgt.RETURN_CNT      = src.RETURN_CNT
                AND tgt.ITEM_CONTAINER_TYPE_CD = src.ITEM_CONTAINER_TYPE_CD
                AND tgt.COUNTRY_POL_CD = src.COUNTRY_POL_CD



        WHEN MATCHED THEN UPDATE
            SET                    DWH_UPDATED_TMSP = CURRENT_TIMESTAMP

        WHEN NOT MATCHED THEN INSERT
               (                ITEM_SID 
                                ,RVM_SID
                                ,LOB_CD
                                ,ITEM_GTIN
                                ,RETURN_DT
                                ,RETURN_CNT
                                ,ITEM_CONTAINER_TYPE_CD
                                ,DWH_CREATED_TMSP
                                ,DWH_UPDATED_TMSP
                                ,COUNTRY_POL_CD
               )
        VALUES (                ITEM_SID 
                                ,RVM_SID
                                ,LOB_CD
                                ,ITEM_GTIN
                                ,RETURN_DT
                                ,RETURN_CNT
                                ,ITEM_CONTAINER_TYPE_CD
                                ,DWH_CREATED_TMSP
                                ,CURRENT_TIMESTAMP
                                ,COUNTRY_POL_CD);
                                                                                     



COMMIT;



                                                             
