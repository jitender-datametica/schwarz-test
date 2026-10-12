DELETE FROM ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA};

INSERT INTO ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
entry_identifier, 
trader_reference, 
item_number,
filename, 
dwh_src_1_tmsp,
error_message
)
select ENTRY_IDENTIFIER, Trader_Reference, Item_Number,  
SUBSTR( DWH_SRC_FILE_NAME, 147, 12) as filename,
dwh_src_1_tmsp,
'Duplicates_detected' as error_message
from etl.t_cache_cds_item_1
group by ENTRY_IDENTIFIER, Trader_Reference, Item_Number, DWH_SRC_FILE_NAME, dwh_src_1_tmsp 
having count(ITEM_NUMBER)>1
UNION ALL
select ENTRY_IDENTIFIER, Trader_Reference,  Item_Number,  
SUBSTR(DWH_SRC_FILE_NAME, 147, 12) as filename,
dwh_src_1_tmsp,
'Characters_detected' as error_message
from etl.t_cache_cds_item_1
where NOT RLIKE(trim(Item_Number),'^[0-9]*$')
UNION ALL
select ENTRY_IDENTIFIER, Declarant_Reference, null as Item_Number,  
SUBSTR( DWH_SRC_FILE_NAME, 161, 26) as filename,
dwh_src_1_tmsp,
'Duplicates_detected' as error_message
from etl.t_cache_cds_header_1
group by ENTRY_IDENTIFIER, Declarant_Reference, DWH_SRC_FILE_NAME, dwh_src_1_tmsp 
having count(ITEM_NUMBER)>1;
