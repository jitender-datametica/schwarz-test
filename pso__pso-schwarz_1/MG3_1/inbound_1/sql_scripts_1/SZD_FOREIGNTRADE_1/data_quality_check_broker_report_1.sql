DELETE FROM ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA};

INSERT INTO ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
mrn, 
trader_reference, 
item_sequence_number,
item_product,
filename, 
dwh_src_1_tmsp,
error_message
)
select mrn, trader_reference, trim(item_sequence_number), trim(item_product), 
SUBSTR( DWH_SRC_FILE_NAME, 151, 16) as filename,
dwh_src_1_tmsp,
'Duplicates_detected' as error_message
from etl.t_cache_ceva_1
where JOB_TYPE_CODE IN ('IMY', 'IMD', 'IMA')
group by mrn, trader_reference, trim(item_sequence_number), trim(item_product), DWH_SRC_FILE_NAME, dwh_src_1_tmsp 
having count(JOB_REF)>1
union all
select mrn, trader_reference,trim(item_sequence_number), 
case when charindex('_', item_product) > 0 then trim(substr(item_product, 1, charindex('_', item_product) - 1)) else trim(item_product) end as item_product, 
SUBSTR( DWH_SRC_FILE_NAME, 151, 16) as filename,
dwh_src_1_tmsp,
'Characters_detected' as error_message
from etl.t_cache_ceva_1
where JOB_TYPE_CODE IN ('IMY', 'IMD', 'IMA') and (lower(trim(item_product)) like '%article%' or
NOT RLIKE(case when charindex('_', item_product) > 0 then trim(substr(item_product, 1, charindex('_', item_product) - 1)) else trim(item_product) end,'^[0-9]*$')
or NOT RLIKE(trim(item_sequence_number),'^[0-9]*$'))
union all
select mrn, trader_reference, trim(item_sequence_number), trim(item_product), 
SUBSTR( DWH_SRC_FILE_NAME, 154, 19) as filename,
dwh_src_1_tmsp,
'Duplicates_detected' as error_message
from etl.t_cache_maersk_lgb_1
where JOB_TYPE_CODE IN ('IMY', 'IMD', 'IMA')
group by mrn, trader_reference, trim(item_sequence_number), trim(item_product), DWH_SRC_FILE_NAME, dwh_src_1_tmsp 
having count(JOB_REF)>1
union all
select mrn, trader_reference, trim(item_sequence_number),
case when charindex('_', item_product) > 0 then trim(substr(item_product, 1, charindex('_', item_product) - 1)) else trim(item_product) end as item_product, 
SUBSTR( DWH_SRC_FILE_NAME, 154, 19) as filename,
dwh_src_1_tmsp,
'Characters_detected' as error_message
from etl.t_cache_maersk_lgb_1
where JOB_TYPE_CODE IN ('IMY', 'IMD', 'IMA') and (lower(trim(item_product)) like '%article%' or 
NOT RLIKE(case when charindex('_', item_product) > 0 then trim(substr(item_product, 1, charindex('_', item_product) - 1)) else trim(item_product) end,'^[0-9]*$')
or NOT RLIKE(trim(item_sequence_number),'^[0-9]*$'))
union all
select mrn, trader_reference, trim(item_sequence_number), trim(item_product), 
SUBSTR( DWH_SRC_FILE_NAME, 155, 20) as filename,
dwh_src_1_tmsp,
'Duplicates_detected' as error_message
from etl.t_cache_maersk_lukt_1
where JOB_TYPE_CODE IN ('IMY', 'IMD', 'IMA')
group by mrn, trader_reference, trim(item_sequence_number), trim(item_product), DWH_SRC_FILE_NAME, dwh_src_1_tmsp 
having count(JOB_REF)>1
union all
select mrn, trader_reference, trim(item_sequence_number),
case when charindex('_', item_product) > 0 then trim(substr(item_product, 1, charindex('_', item_product) - 1)) else trim(item_product) end as item_product, 
SUBSTR( DWH_SRC_FILE_NAME, 155, 20) as filename,
dwh_src_1_tmsp,
'Characters_detected' as error_message
from etl.t_cache_maersk_lukt_1
where JOB_TYPE_CODE IN ('IMY', 'IMD', 'IMA') and (lower(trim(item_product)) like '%article%' or
NOT RLIKE(case when charindex('_', item_product) > 0 then trim(substr(item_product, 1, charindex('_', item_product) - 1)) else trim(item_product) end,'^[0-9]*$')
or NOT RLIKE(trim(item_sequence_number),'^[0-9]*$'));
