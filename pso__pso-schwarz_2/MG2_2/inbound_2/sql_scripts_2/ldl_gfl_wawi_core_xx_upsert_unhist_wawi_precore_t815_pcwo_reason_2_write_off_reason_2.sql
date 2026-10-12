
MERGE INTO core_rel.t_write_off_reason_2 AS tgt
USING 
  (
   SELECT DISTINCT 
     c815_reason_id AS write_off_reason_id, 
	 c815_reason_desc_nat AS write_off_reason_descr,	 
	 CASE WHEN ctrcode in ('AT','DE','CH','LT','EE') THEN 'DE'
	   WHEN ctrcode in ('CS','ES') THEN 'ES' 
       WHEN ctrcode in ('NIE') THEN 'EN'
	   WHEN ctrcode in ('MT') THEN 'IT' 
	   ELSE c.official_lang_cd 
	 END AS lang_cd			         
   FROM etl.t_wawi_precore_t815_pcwo_reason_2 r
   LEFT JOIN core_rel.t_country_2 c ON c.iso_country_cd = r.ctrcode AND dwh_valid_fg
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



