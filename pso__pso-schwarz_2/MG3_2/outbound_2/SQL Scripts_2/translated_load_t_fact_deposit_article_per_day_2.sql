--t_fact_deposit_article_per_day_2

-- ALTER SESSION SET TRANSACTION_ABORT_ON_ERROR = TRUE;


BEGIN;


-- SELECT CURRENT_TRANSACTION();


CREATE OR REPLACE TABLE szd_production_etl.deposit_article_per_day_a_$_2{land_2} LIKE szd_production_core.t_fact_deposit_article_per_day_2;


ALTER TABLE szd_production_etl.deposit_article_per_day_a_$_2{land_2}
ADD COLUMN IF NOT EXISTS store_id STRING(20);


ALTER TABLE szd_production_etl.deposit_article_per_day_a_$_2{land_2}
RENAME COLUMN rvm_sid TO rvm_id;


CREATE OR REPLACE TABLE szd_production_etl.deposit_article_per_day_b_$_2{land_2} LIKE szd_production_core.t_fact_deposit_article_per_day_2;


/*
copy into SZD_PRODUCTION.ETL.deposit_article_per_day_a_$_2{land_2} (item_sid, rvm_id, lob_cd, item_gtin, return_dt, return_cnt, ITEM_CONTAINER_TYPE_CD, dwh_created_tmsp, dwh_updated_tmsp,country_pol_cd,store_id)
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


FROM '@DATASTORE.${stage}/${SYSTEMGROUP}/${land_2}/t_fact_deposit_article_per_day_2/${YEAR}/${MONTH}/${DAY}/' src) 
pattern='.*deposit_article_per_day.*\.(avro)$'
file_format = (type = avro)
ON_ERROR = ABORT_STATEMENT;
*/


INSERT INTO szd_production_etl.deposit_article_per_day_b_$_2{land_2} (item_sid, rvm_sid, lob_cd, country_pol_cd,
 item_gtin, return_dt, return_cnt, item_container_type_cd, dwh_created_tmsp, dwh_updated_tmsp)
(SELECT DISTINCT itm.item_sid,
  rvm.rvm_sid,
  src.lob_cd,
  src.country_pol_cd,
  src.item_gtin,
  src.return_dt,
  src.return_cnt,
  src.item_container_type_cd,
  src.dwh_created_tmsp,
  src.dwh_updated_tmsp
 FROM szd_production_etl.deposit_article_per_day_a_$_2{land_2} AS src
  LEFT JOIN szd_production_etl.rvm_keys_2 AS rvm ON src.rvm_id = rvm.rvm_id AND CAST(src.store_id AS FLOAT64) = rvm.store
  LEFT JOIN szd_production_etl.item_keys_2 AS itm ON src.item_gtin = itm.item_gtin AND src.lob_cd = itm.lob_cd AND src.country_pol_cd
     = itm.country_pol_cd
 WHERE rvm.rvm_sid IS NOT NULL
  AND itm.item_sid IS NOT NULL
 QUALIFY (ROW_NUMBER() OVER (PARTITION BY itm.item_sid, rvm.rvm_sid, src.lob_cd, src.item_gtin, src.return_dt, src.return_cnt
       , src.item_container_type_cd, src.country_pol_cd ORDER BY src.dwh_created_tmsp IS NULL DESC, src.dwh_created_tmsp
       DESC)) = 1);


MERGE INTO szd_production_core.t_fact_deposit_article_per_day_2 AS tgt
USING (SELECT item_sid,
  rvm_sid,
  lob_cd,
  item_gtin,
  return_dt,
  return_cnt,
  item_container_type_cd,
  dwh_created_tmsp,
  dwh_updated_tmsp,
  country_pol_cd
 FROM szd_production_etl.deposit_article_per_day_b_$_2{land_2}
 WHERE rvm_sid IS NOT NULL) AS src
ON tgt.item_sid = src.item_sid AND tgt.rvm_sid = src.rvm_sid AND tgt.lob_cd = src.lob_cd AND tgt.item_gtin = src.item_gtin
       AND tgt.return_dt = src.return_dt AND tgt.return_cnt = src.return_cnt AND tgt.item_container_type_cd = src.item_container_type_cd
    AND tgt.country_pol_cd = src.country_pol_cd
WHEN MATCHED THEN UPDATE SET
 dwh_updated_tmsp = CURRENT_TIMESTAMP()
WHEN NOT MATCHED THEN INSERT VALUES(src.item_sid, src.rvm_sid, src.lob_cd, src.country_pol_cd, src.item_gtin, src.return_dt
 , src.return_cnt, src.item_container_type_cd, src.dwh_created_tmsp, CURRENT_TIMESTAMP());


COMMIT TRANSACTION;