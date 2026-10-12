INSERT INTO ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
item_description,
item_product,
item_national_additional_code,
item_commodity_code,
item_non_preferential_country_code,
item_preferential_country_code,
importer_eori,
dwh_src_file_name,
dwh_src_1_tmsp,
dwh_mapping_tmsp,
TF_ERROR_FG,
DELETED_FG,
RECORD_ID,
FILENAME
)

select item_description,
item_product,
item_national_additional_code,
item_commodity_code,
item_non_preferential_country_code,
item_preferential_country_code,
importer_eori,
dwh_src_file_name,
dwh_src_1_tmsp,
dwh_src_1_tmsp dwh_mapping_tmsp,
0 TF_ERROR_FG,
0 DELETED_FG,
0 RECORD_ID,
dwh_src_file_name FILENAME
from 
etl.t_cache_ceva
qualify row_number()  over (partition by item_product,item_national_additional_code,item_commodity_code,item_non_preferential_country_code,importer_eori
order by 1)=1
union  
select item_description,
item_product,
item_national_additional_code,
item_commodity_code,
item_non_preferential_country_code,
item_preferential_country_code,
importer_eori,
dwh_src_file_name,
dwh_src_1_tmsp,
dwh_src_1_tmsp dwh_mapping_tmsp,
0 TF_ERROR_FG,
0 DELETED_FG,
0 RECORD_ID,
dwh_src_file_name FILENAME
from 
etl.t_cache_maersk_lukt
qualify row_number()  over (partition by item_product,item_national_additional_code,item_commodity_code,item_non_preferential_country_code,importer_eori
order by 1)=1
union 
select item_description,
item_product,
item_national_additional_code,
item_commodity_code,
item_non_preferential_country_code,
item_preferential_country_code,
Importer_EORI,
dwh_src_file_name,
dwh_src_1_tmsp,
dwh_src_1_tmsp dwh_mapping_tmsp,
0 TF_ERROR_FG,
0 DELETED_FG,
0 RECORD_ID,
dwh_src_file_name FILENAME
from 
etl.t_cache_maersk_lgb
qualify row_number()  over (partition by item_product,item_national_additional_code,item_commodity_code,item_non_preferential_country_code,importer_eori
order by 1)=1;
