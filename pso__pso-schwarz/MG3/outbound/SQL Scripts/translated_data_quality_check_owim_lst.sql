
TRUNCATE TABLE ${temp_db}.${src2tgt_temp_table1}_${src_context_area};


/* select article_number, 
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
from SZD_PRODUCTION.etl.t_cache_list)
group by article_number, DWH_SRC_FILE_NAME, dwh_src_1_tmsp 
having count(CUSTOMS_TARIFF_NUMBER)>1         
union all */

INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} 
(article_number, 
dwh_src_1_tmsp, 
filename, 
error_message)
(SELECT article_number,
  dwh_src_1_tmsp,
  filename,
  error_message
 FROM (SELECT CASE
      WHEN STRPOS(TRIM(CAST(article_number AS STRING)), '_') > 0
      THEN SUBSTR(TRIM(CAST(article_number AS STRING)), 1, STRPOS(TRIM(CAST(article_number AS STRING)), '_') - 1)
      ELSE TRIM(CAST(article_number AS STRING))
      END AS article_number,
     SUBSTR(dwh_src_file_name, 164, 29) AS filename,
     dwh_src_1_tmsp,
     'Characters_detected' AS error_message
    FROM szd_production_etl.t_cache_owim
    WHERE NOT REGEXP_CONTAINS(CASE
       WHEN STRPOS(TRIM(CAST(article_number AS STRING)), '_') > 0
       THEN SUBSTR(TRIM(CAST(article_number AS STRING)), 1, STRPOS(TRIM(CAST(article_number AS STRING)), '_') - 1)
       ELSE TRIM(CAST(article_number AS STRING))
       END , r'^[0-9]*$')
    UNION ALL
	
/* select article_number, 
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
from SZD_PRODUCTION.etl.t_cache_owim)
group by article_number, DWH_SRC_FILE_NAME, dwh_src_1_tmsp 
having count(CUSTOMS_TARIFF_NUMBER)>1       
union all */

    SELECT CASE
      WHEN STRPOS(TRIM(CAST(article_number AS STRING)), '_') > 0
      THEN SUBSTR(TRIM(CAST(article_number AS STRING)), 1, STRPOS(TRIM(CAST(article_number AS STRING)), '_') - 1)
      ELSE TRIM(CAST(article_number AS STRING))
      END AS article_number,
     SUBSTR(dwh_src_file_name, 152, 17) AS filename,
     dwh_src_1_tmsp,
     'Characters_detected' AS error_message
    FROM szd_production_etl.t_cache_list
    WHERE NOT REGEXP_CONTAINS(CASE
       WHEN STRPOS(TRIM(CAST(article_number AS STRING)), '_') > 0
       THEN SUBSTR(TRIM(CAST(article_number AS STRING)), 1, STRPOS(TRIM(CAST(article_number AS STRING)), '_') - 1)
       ELSE TRIM(CAST(article_number AS STRING))
       END , r'^[0-9]*$')) AS t3);