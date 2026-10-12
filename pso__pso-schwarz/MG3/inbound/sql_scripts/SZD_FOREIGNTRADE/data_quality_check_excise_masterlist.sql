DELETE FROM ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA};

INSERT INTO ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
single_article_no,
DWH_VALID_FROM_TMSP, 
filename, 
dwh_src_1_tmsp,
error_message
)
select TRIM(single_article_no),DWH_VALID_FROM_TMSP, 
SUBSTR( DWH_SRC_FILE_NAME, 161, 26) as filename, 
dwh_src_1_tmsp,
'Duplicates_detected' as error_message
from etl.t_cache_excise_masterlist
group by TRIM(single_article_no),DWH_VALID_FROM_TMSP, DWH_SRC_FILE_NAME, dwh_src_1_tmsp 
having count(ITEM_SHORTDESC)>1     
union all
select TRIM(single_article_no),DWH_VALID_FROM_TMSP, 
SUBSTR( DWH_SRC_FILE_NAME, 161, 26) as filename, 
dwh_src_1_tmsp,
'Characters_detected' as error_message
from etl.t_cache_excise_masterlist
where NOT RLIKE(TRIM(single_article_no),'^[0-9]*$')
and date(DWH_VALID_FROM_TMSP)!=date('1900-01-01');
