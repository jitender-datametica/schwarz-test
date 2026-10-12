INSERT INTO ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
article_number,
article,
customs_tariff_number,
country_of_origin,
preferential_origin,
allocation,
tax_code,
quantity_in_uom,
unit_of_measure,
dwh_src_1_tmsp,
dwh_src_file_name,
dwh_mapping_tmsp,
dwh_valid_fg,
TF_ERROR_FG,
DELETED_FG,
RECORD_ID,
FILENAME
)
-- products from gs upload for lidl stiftung
select 
distinct 
        article_number,
        article,
        customs_tariff_number,
        country_of_origin,
        preferential_origin,
        allocation,
        tax_code,
        quantity_in_uom,
        unit_of_measure,
        dwh_src_1_tmsp,
        dwh_src_file_name,
        dwh_src_1_tmsp dwh_mapping_tmsp,
        1 dwh_valid_fg,
        0 TF_ERROR_FG,
        0 DELETED_FG,
        0 RECORD_ID,
        dwh_src_file_name FILENAME
from etl.t_cache_list_2 
qualify row_number()  over (partition by article_number,customs_tariff_number,country_of_origin,allocation order by 1)=1
union all
-- products from gs upload for owim
select 
distinct
        article_number,
        article,
        customs_tariff_number,
        country_of_origin,
        preferential_origin,
        allocation,
        tax_code,
        quantity_in_uom,
        unit_of_measure,
        dwh_src_1_tmsp,
        dwh_src_file_name,
        dwh_src_1_tmsp dwh_mapping_tmsp,
        1 dwh_valid_fg,
        0 TF_ERROR_FG,
        0 DELETED_FG,
        0 RECORD_ID,
        dwh_src_file_name FILENAME
from etl.t_cache_owim_2
qualify row_number()  over (partition by article_number,customs_tariff_number,country_of_origin,allocation order by 1)=1;
