-- !SET exit_on_error=True;


MERGE INTO ldl_data_production_meta.t_user_2 AS tgt
USING (SELECT k.party_nat_key_nr AS user_name,
  k.party_sid AS emp_sid,
  'CDWH' AS sys_name,
  'OSO' AS dwh_node_cd
 FROM (SELECT LOWER(mail) AS party_nat_key_nr
   FROM ldl_data_production_etl.t_tcache_oso_employees_2
   WHERE mail LIKE '%@%.%'
   QUALIFY (ROW_NUMBER() OVER (PARTITION BY LOWER(mail) ORDER BY extraction_timestamp IS NULL DESC, extraction_timestamp
         DESC)) = 1) AS empl
  INNER JOIN ldl_data_production_meta.t_party_key_2 AS k ON empl.party_nat_key_nr = k.party_nat_key_nr
 WHERE k.party_key_type_cd = 'PERSON'
  AND k.dwh_valid_fg) AS SRC
ON tgt.sys_name = SRC.sys_name AND tgt.user_name = SRC.user_name
WHEN MATCHED AND tgt.emp_sid <> SRC.emp_sid THEN UPDATE SET
 emp_sid = SRC.emp_sid,
 dwh_updated_tmsp = CURRENT_TIMESTAMP(),
 dwh_load_id = CAST('${LOAD_ID}' AS INTEGER),
 dwh_node_cd = SRC.dwh_node_cd
WHEN NOT MATCHED THEN INSERT VALUES(SRC.user_name, SRC.emp_sid, CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP(), CAST('${LOAD_ID}' AS INTEGER)
 , SRC.dwh_node_cd, SRC.sys_name);