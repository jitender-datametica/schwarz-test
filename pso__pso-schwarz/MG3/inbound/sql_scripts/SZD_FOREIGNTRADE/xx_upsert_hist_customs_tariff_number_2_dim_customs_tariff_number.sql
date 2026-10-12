INSERT INTO ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
customs_classification_scheme_cd,
customs_tariff_number_cd,
customs_tariff_number_descr,
food_nonfood_type_cd,
food_nonfood_type_name,
alcoholic_beverage_type_cd,
alcoholic_beverage_type_name,
dwh_mapping_tmsp,
dwh_src_file_name,
dwh_src_1_tmsp,
tf_error_fg,
dwh_load_id,
record_id,
filename,
deleted_fg
)
SELECT 
'CTC_GB' customs_classification_scheme_cd,
ctc.customs_tariff_code_cd customs_tariff_number_cd, 
ctc.customs_tariff_code_descr customs_tariff_number_descr,
COALESCE(MAX(food.customs_tariff_code_type_cd), '-1'),
COALESCE(MAX(food.customs_tariff_code_type_name), 'N/A'),
COALESCE(MAX(abv.customs_tariff_code_type_cd), '-1'),
COALESCE(MAX(abv.customs_tariff_code_type_name), 'N/A'),
ctc.dwh_src_1_tmsp dwh_mapping_tmsp,
ctc.dwh_src_file_name,
ctc.dwh_src_1_tmsp,
0 tf_error_fg,
0 dwh_load_id,
0 record_id,
ctc.dwh_src_file_name filename,
0 deleted_fg
--SELECT * 
from
core_rel.t_customs_tariff_code ctc
  left
  join core_rel.t_customs_tariff_code_type_rel rel
    on ctc.customs_tariff_code_cd = rel.customs_tariff_code_cd
  left
  join core_rel.t_customs_tariff_code_type food
    on rel.customs_tariff_code_type_cd = food.customs_tariff_code_type_cd
   and rel.customs_tariff_category_cd = food.customs_tariff_category_cd 
   and food.customs_tariff_category_cd = 'F/NF' 
  left
  join core_rel.t_customs_tariff_code_type abv
    on rel.customs_tariff_code_type_cd = abv.customs_tariff_code_type_cd
   and rel.customs_tariff_category_cd = abv.customs_tariff_category_cd 
   and abv.customs_tariff_category_cd = 'ABV'
  GROUP BY 2,3,8,9,10,13;
