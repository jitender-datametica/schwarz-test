INSERT INTO meta.t_party_key_1
  (PARTY_SID, PARTY_KEY_TYPE_CD, DWH_VALID_FROM_TMSP, DWH_VALID_TO_TMSP,DWH_VALID_FG, PARTY_NAT_KEY_NR, DWH_CREATED_TMSP, DWH_UPDATED_TMSP)

SELECT  max_sid+row_num as PARTY_SID, PARTY_KEY_TYPE_CD, current_timestamp as DWH_VALID_FROM_TMSP, to_timestamp('9999-12-31 23:59:59.000') as DWH_VALID_TO_TMSP,
'TRUE' as DWH_VALID_FG, PARTY_NAT_KEY_NR , current_timestamp as dwh_cretaed, current_timestamp as dwh_updated
FROM (      
SELECT 'CONSIGNOR' AS PARTY_KEY_TYPE_CD, consignor_name AS PARTY_NAT_KEY_NR , max_sid, 
  ROW_NUMBER() OVER (PARTITION BY PARTY_KEY_TYPE_CD ORDER BY PARTY_KEY_TYPE_CD) AS row_num
FROM 
(SELECT DISTINCT TRIM(UPPER(consignor_name)) consignor_name from etl.t_cache_ceva_1
     WHERE consignor_name IS NOT NULL and consignor_name!='NULL'
  union 
  SELECT DISTINCT TRIM(UPPER(consignor_name)) from etl.t_cache_maersk_lgb_1
     WHERE consignor_name IS NOT NULL and consignor_name!='NULL'
  union
  SELECT DISTINCT TRIM(UPPER(consignor_name)) from etl.t_cache_maersk_lukt_1
     WHERE consignor_name IS NOT NULL and consignor_name!='NULL') load 
LEFT JOIN
  (
   SELECT   PARTY_NAT_KEY_NR
     FROM meta.t_party_key_1     
  where PARTY_KEY_TYPE_CD='CONSIGNOR') core
ON load.consignor_name = core.PARTY_NAT_KEY_NR
CROSS JOIN (SELECT COALESCE(MAX(PARTY_SID),0) AS max_sid FROM meta.t_party_key_1)
WHERE core.PARTY_NAT_KEY_NR IS NULL);
