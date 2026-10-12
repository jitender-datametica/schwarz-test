
-- '${LOAD_ID}', 


-- '${LOAD_ID}',  


MERGE INTO ldl_data_production_core_rel.t_write_off_reason_1 AS tgt
USING (SELECT DISTINCT r.c815_reason_id AS write_off_reason_id,
  r.c815_reason_desc_nat AS write_off_reason_descr,
   CASE
   WHEN r.wawi_instanz_kzl IN ('AT', 'DE', 'CH', 'LT', 'EE')
   THEN 'DE'
   WHEN r.wawi_instanz_kzl IN ('CS', 'ES')
   THEN 'ES'
   WHEN r.wawi_instanz_kzl IN ('NIE')
   THEN 'EN'
   WHEN r.wawi_instanz_kzl IN ('MT')
   THEN 'IT'
   ELSE c.official_lang_cd
   END AS lang_cd
 FROM hqwawiadm.t815_pcwo_reason_1 AS r
  LEFT JOIN ldl_data_production_core_rel.t_country_1 AS c ON r.wawi_instanz_kzl = c.iso_country_cd AND r.dwh_valid_fg
 WHERE r.delete_fg IS NULL
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