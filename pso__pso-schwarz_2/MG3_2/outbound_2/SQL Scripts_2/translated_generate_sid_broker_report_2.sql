INSERT INTO szd_production_meta.t_party_key_2 (party_sid, party_key_type_cd, dwh_valid_from_tmsp, dwh_valid_to_tmsp,
 dwh_valid_fg, party_nat_key_nr, dwh_created_tmsp, dwh_updated_tmsp)
(SELECT t12.max_sid + (ROW_NUMBER() OVER (PARTITION BY 'CONSIGNOR' ORDER BY 'CONSIGNOR' IS NULL, 'CONSIGNOR')) AS
  party_sid,
  'CONSIGNOR' AS party_key_type_cd,
  CURRENT_TIMESTAMP() AS dwh_valid_from_tmsp,
  CAST(PARSE_DATETIME('%F %H:%M:%S', '9999-12-31 23:59:59.000') AS TIMESTAMP) AS dwh_valid_to_tmsp
  ,
  CAST('true' AS BOOL) AS dwh_valid_fg,
  load.consignor_name AS party_nat_key_nr,
  CURRENT_TIMESTAMP() AS dwh_cretaed,
  CURRENT_TIMESTAMP() AS dwh_updated
 FROM ((SELECT DISTINCT TRIM(UPPER(consignor_name)) AS consignor_name
     FROM szd_production_etl.t_cache_ceva_2
     WHERE consignor_name <> 'NULL'
     UNION DISTINCT
     SELECT DISTINCT TRIM(UPPER(consignor_name)) AS consignor_name
     FROM szd_production_etl.t_cache_maersk_lgb_2
     WHERE consignor_name <> 'NULL')
    UNION DISTINCT
    SELECT DISTINCT TRIM(UPPER(consignor_name)) AS consignor_name
    FROM szd_production_etl.t_cache_maersk_lukt_2
    WHERE consignor_name <> 'NULL') AS load
  LEFT JOIN (SELECT party_nat_key_nr
   FROM szd_production_meta.t_party_key_2
   WHERE party_key_type_cd = 'CONSIGNOR') AS core ON load.consignor_name = core.party_nat_key_nr
  INNER JOIN (SELECT COALESCE(MAX(party_sid), 0) AS max_sid
   FROM szd_production_meta.t_party_key_2) AS t12 ON TRUE
 WHERE core.party_nat_key_nr IS NULL);