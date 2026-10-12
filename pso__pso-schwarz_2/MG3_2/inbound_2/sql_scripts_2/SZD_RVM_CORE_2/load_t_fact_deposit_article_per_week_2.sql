--t_fact_deposit_reject_per_day_2

ALTER SESSION SET TRANSACTION_ABORT_ON_ERROR = TRUE;
BEGIN;
SELECT CURRENT_TRANSACTION();



CREATE OR REPLACE TABLE ETL.deposit_article_per_week_a_$_2{LAND_2}   LIKE CORE.t_fact_deposit_article_per_week_2;
CREATE OR REPLACE TABLE ETL.DEPOSIT_article_PER_WEEK_b_$_2{LAND_2} LIKE CORE.t_fact_deposit_article_per_WEEK_2;


copy into ETL.deposit_article_per_week_a_$_2{LAND_2} (ITEM_SID,RVM_SID,LOB_CD,ITEM_GTIN,CY_WEEK,REJECT_CNT,RETURN_CNT,ITEM_CONTAINER_TYPE_CD,COUNTRY_POL_CD,DWH_CREATED_TMSP,DWH_UPDATED_TMSP)  from 
 (select 
        src.$1:datastore_data:item_sid,
        src.$1:datastore_data:rvm_sid,
        src.$1:datastore_data:lob_cd,
        src.$1:datastore_data:item_gtin,
        src.$1:datastore_data:cy_week,
        src.$1:datastore_data:reject_cnt,
        src.$1:datastore_data:return_cnt,
        src.$1:datastore_data:item_container_type_cd,
        src.$1:datastore_data:country_pol_cd,
        CURRENT_TIMESTAMP,
	CURRENT_TIMESTAMP
        
FROM '@DATASTORE.${stage}/${SYSTEMGROUP}/${LAND_2}/t_fact_deposit_article_per_week_2/${YEAR}/${MONTH}/${DAY}/' src)  
pattern='.*_deposit_article_per_week.*\.(avro)$'
file_format = (type = avro)
ON_ERROR = ABORT_STATEMENT;


INSERT INTO ETL.DEPOSIT_ARTICLE_PER_WEEK_b_$_2{LAND_2} (ITEM_SID,RVM_SID,LOB_CD,ITEM_GTIN,CY_WEEK,REJECT_CNT,RETURN_CNT,ITEM_CONTAINER_TYPE_CD,COUNTRY_POL_CD,DWH_CREATED_TMSP,DWH_UPDATED_TMSP)                             
 SELECT 
        ITEM_SID
        ,RVM_SID
        ,LOB_CD
        ,ITEM_GTIN
        ,CY_WEEK
        ,REJECT_CNT
        ,RETURN_CNT
        ,ITEM_CONTAINER_TYPE_CD
        ,COUNTRY_POL_CD
        ,DWH_CREATED_TMSP
        ,DWH_UPDATED_TMSP

                                   
 FROM (
    SELECT
	ITEM_SID
        ,RVM_SID
        ,LOB_CD
        ,ITEM_GTIN
        ,CY_WEEK
        ,REJECT_CNT
        ,RETURN_CNT
        ,ITEM_CONTAINER_TYPE_CD
        ,COUNTRY_POL_CD
        ,DWH_CREATED_TMSP
        ,DWH_UPDATED_TMSP
        ,0 dwh_load_id  --load_id als Prozess-ID im Gegensatz zur context_load_id (falls vorhanden)
    FROM 
        ETL.deposit_article_per_week_a_$_2{LAND_2}   src
    WHERE 1=1
    AND RVM_SID IS NOT NULL) inner_sel
;


MERGE INTO CORE.T_FACT_DEPOSIT_ARTICLE_PER_week_2 AS tgt
        USING (SELECT 	ITEM_SID
                        ,RVM_SID
                        ,LOB_CD
                        ,ITEM_GTIN
                        ,CY_WEEK
                        ,REJECT_CNT
                        ,RETURN_CNT
                        ,ITEM_CONTAINER_TYPE_CD
                        ,COUNTRY_POL_CD
                        ,DWH_CREATED_TMSP
                        ,DWH_UPDATED_TMSP

FROM ETL.DEPOSIT_ARTICLE_PER_week_b_$_2{LAND_2}  
WHERE RVM_SID IS NOT NULL
QUALIFY ROW_NUMBER() OVER (PARTITION BY ITEM_SID, RVM_SID, LOB_CD, ITEM_GTIN,CY_WEEK,REJECT_CNT,RETURN_CNT,ITEM_CONTAINER_TYPE_CD,COUNTRY_POL_CD  ORDER BY  CY_WEEK DESC) = 1
              ) AS src 
                ON  tgt.ITEM_SID        = src.ITEM_SID
                AND tgt.RVM_SID         = src.RVM_SID
                AND tgt.LOB_CD          = src.LOB_CD
                AND tgt.ITEM_GTIN       = src.ITEM_GTIN   
                AND tgt.CY_WEEK         = src.CY_WEEK
                AND tgt.ITEM_CONTAINER_TYPE_CD = src.ITEM_CONTAINER_TYPE_CD
                AND tgt.COUNTRY_POL_CD  = src.COUNTRY_POL_CD


        WHEN MATCHED THEN UPDATE
            SET                     
                                   DWH_UPDATED_TMSP = CURRENT_TIMESTAMP
				  ,REJECT_CNT = src.REJECT_CNT
                                  ,RETURN_CNT = src.RETURN_CNT

        WHEN NOT MATCHED THEN INSERT
               (        ITEM_SID
                        ,RVM_SID
                        ,LOB_CD
                        ,ITEM_GTIN
                        ,CY_WEEK
                        ,REJECT_CNT
                        ,RETURN_CNT
                        ,ITEM_CONTAINER_TYPE_CD
                        ,COUNTRY_POL_CD
                        ,DWH_CREATED_TMSP
                        ,DWH_UPDATED_TMSP)

        VALUES (        src.ITEM_SID
                        ,src.RVM_SID
                        ,src.LOB_CD
                        ,src.ITEM_GTIN
                        ,src.CY_WEEK
                        ,src.REJECT_CNT
                        ,src.RETURN_CNT
                        ,src.ITEM_CONTAINER_TYPE_CD
                        ,src.COUNTRY_POL_CD
                        ,src.DWH_CREATED_TMSP
                        ,src.DWH_UPDATED_TMSP);

COMMIT;



                                                             
