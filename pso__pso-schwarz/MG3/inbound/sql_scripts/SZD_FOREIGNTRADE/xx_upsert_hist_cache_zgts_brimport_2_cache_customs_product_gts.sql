INSERT INTO ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
CCNGN,
CUCOO,
PRTXT,
PAPTY,
prvsy,
EXCISE_DUTY_CODE,
dwh_src_file_name,
dwh_src_1_tmsp,
CTSMU1,
etd,
dwh_mapping_tmsp,
TF_ERROR_FG,
DELETED_FG,
RECORD_ID,
FILENAME
)
select 
CCNGN,
CUCOO,
PRTXT,
PAPTY,
prvsy,
EXCISE_DUTY_CODE,
dwh_src_file_name,
dwh_src_1_tmsp,
CTSMU1,
coalesce(ETD, ETATS)etd,
coalesce(ETD, ETATS),
0 TF_ERROR_FG,
0 DELETED_FG,
0 RECORD_ID,
dwh_src_file_name FILENAME
from etl.t_cache_zgts_brimport
qualify row_number() OVER(partition by CCNGN, PRVSY,CUCOO, PAPTY,coalesce(etd,etats) order by 1)=1
;
