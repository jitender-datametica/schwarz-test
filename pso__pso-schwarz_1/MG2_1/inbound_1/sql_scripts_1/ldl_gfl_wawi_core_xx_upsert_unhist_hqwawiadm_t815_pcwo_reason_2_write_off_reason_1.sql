
MERGE INTO core_rel.t_write_off_reason_1 AS tgt
USING 
  (
   SELECT DISTINCT 
     c815_reason_id AS write_off_reason_id, 
	 c815_reason_desc_nat AS write_off_reason_descr,	 
	 CASE WHEN wawi_instanz_kzl in ('AT','DE','CH','LT','EE') THEN 'DE'
	   WHEN wawi_instanz_kzl in ('CS','ES') THEN 'ES' 
       WHEN wawi_instanz_kzl in ('NIE') THEN 'EN'
	   WHEN wawi_instanz_kzl in ('MT') THEN 'IT' 
	   ELSE c.official_lang_cd 
	 END AS lang_cd			         
   FROM ${SQL_INPUT_1}.hqwawiadm.t815_pcwo_reason_1 r
   LEFT JOIN core_rel.t_country_1 c ON c.iso_country_cd = r.wawi_instanz_kzl AND dwh_valid_fg
   WHERE delete_fg IS NULL
   QUALIFY ROW_NUMBER() OVER (PARTITION BY write_off_reason_id, lang_cd ORDER BY c815_reason_desc_nat ) = 1   
  ) AS src
ON (tgt.write_off_reason_id=src.write_off_reason_id AND tgt.lang_cd=src.lang_cd)
WHEN MATCHED
THEN UPDATE SET
  tgt.write_off_reason_descr = src.write_off_reason_descr,  
  tgt.dwh_updated_tmsp = CURRENT_TIMESTAMP, 
  tgt.dwh_load_id = 1, -- '${LOAD_ID}', 
  tgt.dwh_node_cd= 'WAWI'
WHEN NOT MATCHED
THEN INSERT 
  (
   write_off_reason_id, 
   lang_cd, 
   write_off_reason_descr, 
   dwh_created_tmsp, 
   dwh_updated_tmsp, 
   dwh_load_id, 
   dwh_node_cd
   )
VALUES 
  (
   src.write_off_reason_id, 
   src.lang_cd, 
   src.write_off_reason_descr, 
   CURRENT_TIMESTAMP, 
   CURRENT_TIMESTAMP, 
   1, -- '${LOAD_ID}',  
   'WAWI'
  )
;



