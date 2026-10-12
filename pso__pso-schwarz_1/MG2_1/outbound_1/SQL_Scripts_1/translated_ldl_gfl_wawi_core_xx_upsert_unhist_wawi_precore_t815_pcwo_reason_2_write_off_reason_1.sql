-- '${LOAD_ID}', 


-- '${LOAD_ID}',  


MERGE INTO ldl_data_production_core_rel.t_write_off_reason_1 AS tgt
USING (SELECT DISTINCT r.c815_reason_id AS write_off_reason_id,
  r.c815_reason_desc_nat AS write_off_reason_descr,
   CASE
   WHEN r.ctrcode IN ('AT', 'DE', 'CH', 'LT', 'EE')
   THEN 'DE'
   WHEN r.ctrcode IN ('CS', 'ES')
   THEN 'ES'
   WHEN r.ctrcode IN ('NIE')
   THEN 'EN'
   WHEN r.ctrcode IN ('MT')
   THEN 'IT'
   ELSE c.official_lang_cd
   END AS lang_cd
 FROM ldl_data_production_etl.t_wawi_precore_t815_pcwo_reason_1 AS r
  LEFT JOIN ldl_data_production_core_rel.t_country_1 AS c ON r.ctrcode = c.iso_country_cd AND c.dwh_valid_fg
 QUALIFY (ROW_NUMBER() OVER (PARTITION BY write_off_reason_id, lang_cd ORDER BY r.c815_reason_desc_nat IS NULL, r.c815_reason_desc_nat
       )) = 1) AS src
ON tgt.write_off_reason_id = src.write_off_reason_id AND tgt.lang_cd = src.lang_cd
WHEN MATCHED THEN UPDATE SET
 write_off_reason_descr = src.write_off_reason_descr,
 dwh_updated_tmsp = CURRENT_TIMESTAMP(),
 dwh_load_id = 1,
 dwh_node_cd = 'WAWI'
WHEN NOT MATCHED THEN INSERT VALUES(CAST(src.write_off_reason_id AS BIGNUMERIC), src.lang_cd, src.write_off_reason_descr
 , CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP(), 1, 'WAWI');