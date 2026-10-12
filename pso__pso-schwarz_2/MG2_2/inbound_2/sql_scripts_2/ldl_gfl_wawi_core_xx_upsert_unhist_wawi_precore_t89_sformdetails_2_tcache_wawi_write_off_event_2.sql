DELETE FROM ${TEMP_DB}.${TGT_TARGET_TABLE};

INSERT INTO ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
 (
  int_org_type_cd,    
  country_org_cd,  
  write_off_dt,
  bus_dt,
  curr_stat_fg,
  correction_seq,
  receipt_nr,
  receipt_line_nr,  
  write_off_event_type_id,
  write_off_reason_id,
  write_off_sales_unit_cnt,
  part_write_off_fg,
  write_off_qty,
  uom_cd,
  write_off_net_val,
  real_estate_key_type_cd,
  real_estate_nat_key,
  int_org_key_type_cd,
  int_org_nat_key,
  deliv_company_nat_key,
  deliv_company_key_type_cd,
  country_org_nat_key,
  country_org_key_type_cd,
  logistic_variant_nat_key,
  logistic_variant_key_type_cd,
  extraction_tmsp,
  source_system, 
  extraction_dt, 
  dwh_mapping_tmsp,  
  tf_error_fg, 
  deleted_fg, 
  record_id, 
  filename,
  dwh_node_cd, 
  dwh_load_id)
SELECT	  
  'STORE' AS int_org_type_cd,
  LEFT(ctrcode,2) AS country_org_cd,
  COALESCE(c89_tgdate,c89_moddate) AS write_off_dt,
  c89_formdate AS bus_dt,
  CASE WHEN event_rank = max_rank THEN TRUE 
       ELSE FALSE 
  END AS curr_stat_fg,
  c89_correct_flag AS correction_seq,
  c89_formcount AS receipt_nr,
  c89_row AS receipt_line_nr,
  c89_formtype AS write_off_event_type_id,
  COALESCE(c89_pcwo_reason,-1) AS write_off_reason_id,
  CASE WHEN c89_unittype = 0 THEN c89_unitqtytotal 
       ELSE NULL 
  END AS write_off_sales_unit_cnt,
  CASE WHEN C89_NEWPRICE > 0  AND  C89_ACTPRICE >0 THEN TRUE 
        ELSE FALSE 
  END AS PART_WRITE_OFF_FG,
  CASE WHEN c89_unittype =1 THEN c89_unitqtytotal  
       ELSE NULL 
  END AS write_off_qty,
  CASE WHEN c89_unittype = 0 THEN NULL
       WHEN c89_unittype = 1 AND CTRCODE <> 'US' THEN 'KG'
       WHEN c89_unittype = 1 AND CTRCODE = 'US' THEN 'LB' 
       ELSE NULL 
  END AS uom_cd,
  COALESCE(c89_value_net,c89_value,0) AS write_off_net_val,
  'RE_2' AS real_estate_key_type_cd,
  ctrcode || '|' || c89_storeno  AS real_estate_nat_key,
  'STORE' AS int_org_key_type_cd,
  ctrcode || '|' || c89_storeno AS int_org_nat_key,
  ctrcode || '|' || wh_nr AS deliv_company_nat_key,
  'COMPANY' AS deliv_company_key_type_cd,
  ctrcode AS country_org_nat_key,
  'COUNTRY_2' AS country_org_key_type_cd,
  COALESCE(src.ctrcode || '|' || item_no || '|' || case_size,'DUMMY_2') AS logistic_variant_nat_key,
  'LOG' AS logistic_variant_key_type_cd,
  extraction_tmsp,
  'WAWI' source_system,
  extraction_tmsp extraction_dt,
  extraction_tmsp dwh_mapping_tmsp,
  0 tf_error_fg,
  0 deleted_fg,
  0 record_id,
  '${SRC_INPUT_TABLE}' filename,
  'WAWI_HQ' dwh_node_cd,
  '${LOAD_ID}' dwh_load_id 
FROM
  (
     SELECT MAX(event_rank) OVER (PARTITION BY ctrcode,wh_nr,c89_formcount,c89_row,c89_storeno ) max_rank, 
            src.*
     FROM 
      (
         SELECT RANK() OVER (PARTITION BY ctrcode, wh_nr,c89_formcount,c89_row,C89_STORENO  ORDER BY extraction_tmsp ) as event_rank
           , scn
           , c89_value_net
           , ctrcode
           , wh_nr
           , c89_formcount
           , c89_storeno
           , c89_row
           , extraction_tmsp
           , c89_formtype
           , c89_correct_flag
           , c89_formdate
           , CAST(SUBSTR( c89_itemno,1,LENGTH(c89_itemno)-4) as INTEGER) as item_no
           , CAST(RIGHT(c89_itemno,4) as INTEGER) as case_size
           , c89_unittype
           , c89_unitqtycase
           , c89_unitqtytotal
           , c89_actprice
           , c89_listprice
           , c89_newprice
           , c89_value
           , c89_actpricegroup
           , c89_newpricegroup
           , c89_reason
           , c89_vatgroup
           , c89_tgdate
           , c89_tgstatus
           , c89_moddate
           , c89_dateuntil
           , c89_formno
           , c89_decimalcase
           , c89_actprice_org
           , c89_whnr
           , c89_chrg_id
           , c89_chrg_ev_id
           , c89_pcwo_reason           
         FROM  ${TEMP_DB}.t_${SRC_INPUT_TABLE} t
         WHERE c89_formtype IN (137,147) AND C89_TGSTATUS=2 AND C89_TGDATE IS NOT NULL --to follow lew_core(des) 2: Verarbeitet
      ) AS src
  ) AS src 
;


/*  Disabled (temporarily) as of V1.3

Olex "mapping is in  CORE_REL folder T_WRITE_OFF_EVENT_2/WAWI-STORE-WRITE-OFF.  v1.3 . 
There is also job which implements mapping WAWI_WH_WRITE_OFF it should be deactivated as 
we do not want to load these data at the moment."


UNION ALL
SELECT	  
  'COMPANY' AS int_org_type_cd,
  LEFT(ctrcode,2) AS country_org_cd,
  COALESCE(c89_tgdate,c89_moddate) AS write_off_dt,
  c89_formdate AS bus_dt,
  CASE WHEN event_rank = max_rank THEN TRUE 
       ELSE FALSE 
  END AS curr_stat_fg,
  c89_correct_flag AS correction_seq,
  c89_formcount AS receipt_nr,
  c89_row AS receipt_line_nr,
  c89_formtype AS write_off_event_type_id,
  COALESCE(c89_pcwo_reason,-1) AS write_off_reason_id,
  CASE WHEN c89_unittype = 0 THEN c89_unitqtytotal 
       ELSE NULL 
  END AS write_off_cnt,
  CASE WHEN c89_unittype =1 THEN c89_unitqtytotal  
       ELSE NULL 
  END AS write_off_qty,
  CASE WHEN c89_unittype = 0 THEN NULL
       WHEN c89_unittype = 1 AND CTRCODE <> 'US' THEN 'KG'
       WHEN c89_unittype = 1 AND CTRCODE = 'US' THEN 'LB' 
       ELSE NULL 
  END AS uom_cd,
  COALESCE(c89_value_net,c89_value,0) AS write_off_net_val,

  'RE_2' AS real_estate_key_type_cd,
  ctrcode || '|' || c89_storeno  AS real_estate_nat_key,
  'COMPANY' AS int_org_key_type_cd,
  ctrcode || '|' || wh_nr AS int_org_nat_key,
  ctrcode || '|' || wh_nr AS deliv_company_nat_key,
  'COMPANY' AS deliv_company_key_type_cd,
  ctrcode AS country_org_nat_key,
  'COUNTRY_2' AS country_org_key_type_cd,
  src.ctrcode || '|' || item_no || '|' || case_size  AS prod_variant_nat_key,
  'LOG' AS prod_variant_key_type_cd,
  extraction_tmsp,

  'WAWI' source_system,
  extraction_tmsp extraction_dt,
  extraction_tmsp dwh_mapping_tmsp,
  0 tf_error_fg,
  0 deleted_fg,
  0 record_id,
  '${SRC_INPUT_TABLE}' filename,
  'WAWI_HQ' dwh_node_cd,
  '${LOAD_ID}' dwh_load_id 
FROM
  (
     SELECT MAX(event_rank) OVER (PARTITION BY ctrcode,wh_nr,c89_formcount,c89_row,c89_storeno ) max_rank, 
            src.*
     FROM 
      (
         SELECT RANK() OVER (PARTITION BY ctrcode, wh_nr,c89_formcount,c89_row,C89_STORENO  ORDER BY extraction_tmsp ) as event_rank
           , scn
           , c89_value_net
           , ctrcode
           , wh_nr
           , c89_formcount
           , c89_storeno
           , c89_row
           , extraction_tmsp
           , c89_formtype
           , c89_correct_flag
           , c89_formdate
           , CAST(SUBSTR( c89_itemno,1,LENGTH(c89_itemno)-4) as INTEGER) as item_no
           , CAST(RIGHT(c89_itemno,4) as INTEGER) as case_size
           , c89_unittype
           , c89_unitqtycase
           , c89_unitqtytotal
           , c89_actprice
           , c89_listprice
           , c89_newprice
           , c89_value
           , c89_actpricegroup
           , c89_newpricegroup
           , c89_reason
           , c89_vatgroup
           , c89_tgdate
           , c89_tgstatus
           , c89_moddate
           , c89_dateuntil
           , c89_formno
           , c89_decimalcase
           , c89_actprice_org
           , c89_whnr
           , c89_chrg_id
           , c89_chrg_ev_id
           , c89_pcwo_reason           
         FROM  ${TEMP_DB}.t_${SRC_INPUT_TABLE} t
         WHERE c89_formtype in (181,182,191,192)
      ) AS src
  ) AS src 
;

*/
