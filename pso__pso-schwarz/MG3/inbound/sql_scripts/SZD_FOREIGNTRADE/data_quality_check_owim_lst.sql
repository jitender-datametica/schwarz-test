DELETE FROM ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA};

INSERT INTO ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
article_number, 
filename, 
dwh_src_1_tmsp,
error_message
)
/*select article_number, 
SUBSTR( DWH_SRC_FILE_NAME, 160, 29) as filename, 
dwh_src_1_tmsp,
'Duplicates_detected' as error_message
from (select case when charindex('_', trim(to_char(article_number))) > 0
                   then substr(trim(to_char(article_number)), 1, charindex('_', trim(to_char(article_number))) - 1)
                   else trim(to_char(article_number))
               end as article_number,
CUSTOMS_TARIFF_NUMBER,      
DWH_SRC_FILE_NAME, 
dwh_src_1_tmsp      
from etl.t_cache_owim)
group by article_number, DWH_SRC_FILE_NAME, dwh_src_1_tmsp 
having count(CUSTOMS_TARIFF_NUMBER)>1       
union all*/
select case when charindex('_', trim(to_char(article_number))) > 0
                   then substr(trim(to_char(article_number)), 1, charindex('_', trim(to_char(article_number))) - 1)
                   else trim(to_char(article_number))
               end as article_number, 
SUBSTR( DWH_SRC_FILE_NAME, 164, 29) as filename, 
dwh_src_1_tmsp,
'Characters_detected' as error_message
from etl.t_cache_owim
where NOT RLIKE(case when charindex('_', trim(to_char(article_number))) > 0
                   then substr(trim(to_char(article_number)), 1, charindex('_', trim(to_char(article_number))) - 1)
                   else trim(to_char(article_number))
               end,'^[0-9]*$')
UNION ALL
/*select article_number, 
SUBSTR( DWH_SRC_FILE_NAME, 148, 17) as filename,
dwh_src_1_tmsp,
'Duplicates_detected' as error_message
from (select case when charindex('_', trim(to_char(article_number))) > 0
                   then substr(trim(to_char(article_number)), 1, charindex('_', trim(to_char(article_number))) - 1)
                   else trim(to_char(article_number))
               end as article_number,
CUSTOMS_TARIFF_NUMBER,      
DWH_SRC_FILE_NAME, 
dwh_src_1_tmsp      
from etl.t_cache_list)
group by article_number, DWH_SRC_FILE_NAME, dwh_src_1_tmsp 
having count(CUSTOMS_TARIFF_NUMBER)>1         
union all*/
select case when charindex('_', trim(to_char(article_number))) > 0
                   then substr(trim(to_char(article_number)), 1, charindex('_', trim(to_char(article_number))) - 1)
                   else trim(to_char(article_number))
               end as article_number, 
SUBSTR( DWH_SRC_FILE_NAME, 152, 17) as filename, 
dwh_src_1_tmsp,
'Characters_detected' as error_message
from etl.t_cache_list
where NOT RLIKE(case when charindex('_', trim(to_char(article_number))) > 0
                   then substr(trim(to_char(article_number)), 1, charindex('_', trim(to_char(article_number))) - 1)
                   else trim(to_char(article_number))
               end,'^[0-9]*$');


