--t_fact_deposit_reject_per_day

--ALTER SESSION SET TRANSACTION_ABORT_ON_ERROR = TRUE;



BEGIN;


--SELECT CURRENT_TRANSACTION();


CREATE OR REPLACE TABLE szd_production_etl.deposit_article_per_week_a_${land} LIKE szd_production_core.t_fact_deposit_article_per_week;


CREATE OR REPLACE TABLE szd_production_etl.deposit_article_per_week_b_${land} LIKE szd_production_core.t_fact_deposit_article_per_week;


/*
copy into ETL.deposit_article_per_week_a_${LAND} (ITEM_SID,RVM_SID,LOB_CD,ITEM_GTIN,CY_WEEK,REJECT_CNT,RETURN_CNT,ITEM_CONTAINER_TYPE_CD,COUNTRY_POL_CD,DWH_CREATED_TMSP,DWH_UPDATED_TMSP)  from 
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
        
FROM '@DATASTORE.${stage}/${SYSTEMGROUP}/${LAND}/t_fact_deposit_article_per_week/${YEAR}/${MONTH}/${DAY}/' src)  
pattern='.*_deposit_article_per_week.*\.(avro)$'
file_format = (type = avro)
ON_ERROR = ABORT_STATEMENT;
*/


--load_id als Prozess-ID im Gegensatz zur context_load_id (falls vorhanden)


INSERT INTO szd_production_etl.deposit_article_per_week_b_${land} (item_sid, rvm_sid, lob_cd, country_pol_cd,
 item_gtin, cy_week, reject_cnt, return_cnt, item_container_type_cd, dwh_created_tmsp, dwh_updated_tmsp)
(SELECT *
 FROM szd_production_etl.deposit_article_per_week_a_${land} AS src
 WHERE rvm_sid IS NOT NULL);


MERGE INTO szd_production_core.t_fact_deposit_article_per_week AS tgt
USING (SELECT item_sid,
  rvm_sid,
  lob_cd,
  item_gtin,
  cy_week,
  reject_cnt,
  return_cnt,
  item_container_type_cd,
  country_pol_cd,
  dwh_created_tmsp,
  dwh_updated_tmsp
 FROM szd_production_etl.deposit_article_per_week_b_${land}
 WHERE rvm_sid IS NOT NULL
 QUALIFY (ROW_NUMBER() OVER (PARTITION BY item_sid, rvm_sid, lob_cd, item_gtin, cy_week, reject_cnt, return_cnt,
       item_container_type_cd, country_pol_cd ORDER BY cy_week IS NULL DESC, cy_week DESC)) = 1) AS t1
ON tgt.item_sid = t1.item_sid AND tgt.rvm_sid = t1.rvm_sid AND tgt.lob_cd = t1.lob_cd AND tgt.item_gtin = t1.item_gtin
   AND tgt.cy_week = t1.cy_week AND tgt.item_container_type_cd = t1.item_container_type_cd AND tgt.country_pol_cd = t1.country_pol_cd
  
WHEN MATCHED THEN UPDATE SET
 dwh_updated_tmsp = CURRENT_TIMESTAMP(),
 reject_cnt = t1.reject_cnt,
 return_cnt = t1.return_cnt
WHEN NOT MATCHED THEN INSERT VALUES(t1.item_sid, t1.rvm_sid, t1.lob_cd, t1.country_pol_cd, t1.item_gtin, t1.cy_week, t1
 .reject_cnt, t1.return_cnt, t1.item_container_type_cd, t1.dwh_created_tmsp, t1.dwh_updated_tmsp);


COMMIT;