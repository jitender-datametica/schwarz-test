INSERT INTO ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
  movement_ref_number,
  trader_reference,
  item_position,
  resource_item_sid ,
	DWH_SRC_FILE_NAME,
	DWH_SRC_1_TMSP,
	DWH_MAPPING_TMSP,
	TF_ERROR_FG,
	DELETED_FG,
	RECORD_ID,
DWH_VALID_FG,
	FILENAME 
)
SELECT 
src.Entry_identifier movement_ref_number,
hd.declarant_reference,
src.Item_number item_position,
COALESCE(ri.RESOURCE_ITEM_SID,-1) resource_item_sid  ,
    src.DWH_SRC_FILE_NAME,
	src.DWH_SRC_1_TMSP,
	src.DWH_SRC_1_TMSP DWH_MAPPING_TMSP,
	0 TF_ERROR_FG,
	0 DELETED_FG,
	0 RECORD_ID,
1 DWH_VALID_FG,
	src.DWH_SRC_FILE_NAME FILENAME 
FROM (SELECT 
Entry_identifier,
clearance_date,
Item_number,
trim(son.value) as document_code,
ca.DWH_SRC_FILE_NAME,
ca.DWH_SRC_1_TMSP,
son.value AS val
FROM etl.T_CACHE_CDS_ITEM_2 ca, LATERAL SPLIT_TO_TABLE(ca.all_items_document_codes, ',') AS son
where Entry_identifier!='NULL' and Item_number!='NULL') src

join etl.T_CACHE_cds_header_2 hd
    on src.Entry_identifier = hd.entry_identifier
   and case when substring(trim(hd.clearance_date),3,1)='/' then 
                  to_date(substring(hd.clearance_date,1,10), 'DD/MM_2/YYYY')
                  else to_date(substring(hd.clearance_date,1,10), 'YYYY-MM_2-DD') end = case when substring(trim(src.clearance_date),3,1)='/' then 
                  to_date(substring(src.clearance_date,1,10), 'DD/MM_2/YYYY')
                  else to_date(substring(src.clearance_date,1,10), 'YYYY-MM_2-DD') end
  join meta.t_resource_item_key_2 rk
    on 'GB|' || src.document_code = rk.resource_item_nat_key_nr
   and rk.resource_item_key_type_cd = 'CUSTOMS_DOCUMENT' 


LEFT JOIN 
meta.t_resource_item_key_2 RI
ON ri.RESOURCE_ITEM_KEY_TYPE_CD ='CUSTOMS_DOCUMENT'
AND ri.RESOURCE_ITEM_NAT_KEY_NR =UPPER('GB'||'|'||src.val)
where hd.declarant_reference is not null;


                          
